defmodule Ping.Sync do
  def ping(urls), do: urls |> Stream.map(&Ping.ping/1)
end
