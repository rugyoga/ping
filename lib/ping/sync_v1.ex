defmodule Ping.SyncV1 do
  @spec ping([Ping.url()]) :: [Ping.t()]
  def ping(urls), do: urls |> Enum.map(&Ping.ping/1)
end
