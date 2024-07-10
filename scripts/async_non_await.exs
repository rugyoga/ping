# This script demonstrates concurrent/async code that does not await a response:
# all hosts are pinged simultaneously.
#
# To run:
# mix run scripts/async_non_await.exs
#
# You'll notice that the script completes immediately -- the spawned processes
# are not given time to complete!  You can, however, paste this code into
# an iex session -- because the iex session stays open, the spawned processes
# will also complete.

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

hosts
|> Enum.each(fn host ->
    spawn(fn ->
      result = Ping.ping(host)
      IO.inspect(result, label: host)
    end)
end)

IO.puts(DateTime.utc_now())
