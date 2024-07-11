defmodule Ping.Util do
  @spec urls() :: [Ping.url()]
  def urls do
    ~w(amazon cnn facebook google instagram netflix reddit yahoo youtube x)
    |> Enum.map(&"www.#{&1}.com")
  end

  @spec report(Enumerable.t(Ping.t())) :: [atom()]
  def report(pings) do
    for ping <- pings do
      IO.puts Ping.to_string(ping)
    end
  end

  @spec count(Enumerable.t(Ping.t())) :: non_neg_integer()
  def count(results), do: Enum.count(results, &Ping.responded?/1)
end
