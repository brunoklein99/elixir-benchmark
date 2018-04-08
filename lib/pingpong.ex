defmodule PingPong do

  def start(size) do

    true = Node.connect(:"note@192.168.25.60")

    #pid = Pong.start
    pongfunc = fn -> Pong.start end

    pid = Node.spawn(:"note@192.168.25.60", pongfunc)

    IO.inspect "Pong started with pid #{pid}"
    time0 = NaiveDateTime.utc_now
    Task.async(fn -> Ping.start(pid, size) end)
    |> Task.await(:infinity)
    time1 = NaiveDateTime.diff(NaiveDateTime.utc_now, time0, :seconds)
    IO.puts "Elapsed #{time1}s"
  end

end
