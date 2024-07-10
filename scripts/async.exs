# This script demonstrates concurrent/async code with communication back
# to the caller. All hosts are pinged simultaneously.
#
# To run:
# mix run scripts/async.exs

hosts = ~w(
www.amazon.com
www.cnn.com
www.facebook.com
www.google.com
www.instagram.com
www.netflix.com
www.reddit.com
www.yahoo.com
www.youtube.com
www.x.com
)

IO.puts(DateTime.utc_now())

caller = self()

hosts
# convert each host to a {pid, host} tuple (we need to reference the host later)
|> Enum.map(fn host ->
  pid =
    spawn(fn ->
      result = Ping.ping(host)
      send(caller, {self(), result})
    end)

  {pid, host}
end)
# pattern match on the pid to receive the corresponding result
|> Enum.map(fn {pid, host} ->
  # Receive the response from this pid
  receive do
    {^pid, result} -> result
  after
    1_000 -> "No response from #{host}"
  end
end)
|> IO.inspect()

IO.puts(DateTime.utc_now())
