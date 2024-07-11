defmodule Ping.AsyncV2 do
  @spec ping([Ping.url()]) :: Enumerable.t(Ping.t())
  def ping(urls) do
    me = self()
    for url <- urls do
      spawn(fn -> send(me, Ping.ping(url)) end)
    end
    Stream.unfold(urls, &receiver/1)
  end

  @spec receiver([Ping.url()]) :: nil | {Ping.t(), [Ping.url()]}
  defp receiver([]), do: nil
  defp receiver(urls) do
    receive do
      %Ping{} = p -> {p, urls -- [p.url]}
    end
  end
end
