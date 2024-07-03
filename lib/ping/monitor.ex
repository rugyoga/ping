defmodule Ping.Monitor do
  def sites do
    ~w(apple cnn google microsoft nvidia spacex tesla yahoo)
    |> Enum.map(&"www.#{&1}.com")
  end

  def report(results) do
    for result <- results do
      case result do
        %Ping{} = p ->
          if Ping.responded?(p) do
            IO.puts "#{p.url} (#{p.ip}) responded in #{p.ping} ms"
          else
            IO.puts "#{p.url} timed out"
          end
      end
    end
  end

  def count(results), do: Enum.count(results, &Ping.responded?/1)
end
