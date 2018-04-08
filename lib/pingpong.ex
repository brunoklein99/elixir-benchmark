defmodule PingPong do

  def start(size \\ 1) do

    connect_status = Node.connect(:"note@192.168.25.17")
    IO.inspect(connect_status, label: "connect_status")

    pongfunc = fn -> Pong.start end

    pid = Node.spawn(:"note@192.168.25.17", pongfunc)

    #Process.sleep(5000)
    #alive = Process.alive?(pid)
    # IO.inspect(alive, label: "remote alive?")

    IO.inspect(pid, label: "remote pid")

    time0 = NaiveDateTime.utc_now
    Task.async(fn -> Ping.start(pid, size) end)
    |> Task.await(:infinity)
    time1 = NaiveDateTime.diff(NaiveDateTime.utc_now, time0, :seconds)
    IO.puts "Elapsed #{time1}s"
  end

end
