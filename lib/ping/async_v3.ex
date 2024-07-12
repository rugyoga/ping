defmodule Ping.AsyncV3 do
  @spec ping([Ping.url()]) :: Enumerable.t(Ping.t())
  def ping(urls) do
    urls
    |> Enum.map(fn url -> Task.async(Ping, :ping, [url]) end)
    |> Stream.map(&Task.await(&1, :infinity))
  end
end
