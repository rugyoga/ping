defmodule Ping do
  defstruct [:host, :ms, :ip]

  @doc """
  Pings the given host using the system `ping` utility.
  ## Examples

      iex> Ping.ping("www.amazon.com")
      %Ping{host: "www.amazon.com", ms: "25.404", ip: "18.164.107.218"}

  Pinging Netflix times out:

      iex> Ping.ping("www.netflix.com")
      %Ping{host: "www.netflix.com", ms: nil, ip: nil}
  """
  @spec ping(String.t()) :: %Ping{}
  def ping(host) do
    System.cmd("ping", ["-c", "1", host])
    |> elem(0)
    |> parse(host)
  end

  defp parse(response, host) do
    captures = Regex.named_captures(~r/from (?<ip>.*):.*time=(?<time>.*) ms\n\n/s, response)
    %Ping{host: host, ms: captures["time"], ip: captures["ip"]}
  end
end
