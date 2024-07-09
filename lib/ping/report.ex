defmodule Ping.Report do
  def sites do
    ~w(amazon cnn facebook google instagram netflix reddit yahoo youtube x)
    |> Enum.map(&"www.#{&1}.com")
  end

  def report(pings) do
    for ping <- pings do
      IO.puts Ping.to_string(ping)
    end
  end

  def count(results), do: Enum.count(results, &Ping.responded?/1)
end
