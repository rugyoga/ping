defmodule Ping.SyncV2 do
  @spec ping([Ping.url()]) :: Enumerable.t(Ping.t())
  def ping(urls), do: urls |> Stream.map(&Ping.ping/1)
end
