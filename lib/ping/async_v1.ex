defmodule Ping.AsyncV1 do
  @spec ping([Ping.url()]) :: Enumerable.t(Ping.t())
  def ping(urls) do
    me = self()
    for url <- urls do
      spawn(fn -> send(me, Ping.ping(url)) end)
    end
    receiver(urls)
  end

  @spec receiver([Ping.url()]) :: [Ping.t()]
  defp receiver([]), do: []
  defp receiver([url | urls]) do
    receive do
      %Ping{} = p when p.url == url  -> [p | receiver(urls)]
    end
  end
end
