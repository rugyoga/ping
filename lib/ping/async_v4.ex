defmodule Ping.AsyncV4 do
  @spec ping([Ping.url()]) :: Enumerable.t(Ping.t())
  def ping(urls) do
    urls
    |> Enum.map(fn url -> Task.async(Ping, :ping, [url]) end)
    |> Task.await_many(:infinity)
  end
end
