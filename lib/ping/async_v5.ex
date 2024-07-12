defmodule Ping.AsyncV5 do
  @spec ping([Ping.url()]) :: Enumerable.t(Ping.t())
  def ping(urls) do
    urls
    |> Task.async_stream(Ping, :ping, [], timeout: :infinity)
    |> Stream.map(fn {:ok, value} -> value
                     _ -> nil
  end)

  end
end
