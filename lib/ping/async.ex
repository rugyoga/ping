defmodule Ping.Async do
  def ping(urls) do
    me = self()
    for url <- urls do
      spawn(fn -> send(me, Ping.ping(url)) end)
    end
    urls
    |> Stream.unfold(&receiver/1)
    |> Stream.flat_map(
      fn %Ping{} = p -> [p]
         [_] = dead_ps -> Enum.map(dead_ps, &Ping.timed_out/1)
      end)
  end

  defp receiver([]), do: nil
  defp receiver(urls) do
    receive do
      %Ping{} = p -> {p, urls -- [p.url]}
    after
      1_000 -> {urls, nil}
    end
  end
end
