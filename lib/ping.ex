defmodule Ping do
  defstruct [:url, :ping, :ip]

  def timed_out(url), do: %Ping{url: url, ping: nil, ip: nil}

  def timed_out?(%Ping{ping: ping}), do: is_nil(ping)
  def timed_out?(_), do: true

  def responded?(ping), do: !timed_out?(ping)

  @spec ping(String.t()) :: %Ping{}
  def ping(url) do
    System.cmd("ping", ["-c", "1", url])
    |> parse()
    |> then(fn parsed -> %Ping{url: url, ping: parsed["ping"], ip: parsed["ip"]} end)
  end

  @spec to_string(%Ping{}) :: String.t()
  def to_string(%Ping{} = p) do
    if Ping.responded?(p) do
      "#{p.url} (#{p.ip}) responded in #{p.ping} ms"
    else
      "#{p.url} timed out"
    end
  end

  defp parse({response, _}) do
    Regex.named_captures(~r/from (?<ip>.*):.*time=(?<ping>.*) ms\n\n/s, response)
  end
end
