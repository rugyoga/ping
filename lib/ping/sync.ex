defmodule Ping.Sync do
  def ping(urls), do: urls |> Stream.map(&Ping.ping/1)

  def bad_ping(urls), do: urls |> Enum.map(&Ping.ping/1)
end
