# This script demonstrates sequential code: one host is pinged after the other.
#
# To run:
# mix run scripts/sequential.exs

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

Enum.each(hosts, fn host ->
  IO.inspect(Ping.ping(host))
end)

IO.puts(DateTime.utc_now())
