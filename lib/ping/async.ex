defmodule Ping.Async do
  def ping(urls) do
    me = self()
    for url <- urls do
      spawn(fn -> send(me, Ping.ping(url)) end)
    end
    urls
    |> Stream.unfold(&receiver/1)
    |> Stream.flat_map(&List.wrap/1)
  end

  defp receiver([]), do: nil
  defp receiver(urls) do
    receive do
      %Ping{} = p -> {p, urls -- [p.url]}
    after
      1_000 -> {Enum.map(urls, &dead_ping/1), []}
    end
  end

  def dead_ping(url), do: %Ping{url: url, ping: nil}
end
