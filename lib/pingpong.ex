defmodule PingPong do

  def start(size \\ 1) do

    connect_status = Node.connect(:"note@192.168.25.60")

    IO.inspect(connect_status, label: "connect_status")

    pid = Node.spawn(:"note@192.168.25.60", fn -> Pong.start end)

    IO.inspect(pid, label: "remote pid")

    msg = build_message(size)
    time0 = NaiveDateTime.utc_now
    Task.async(fn -> Ping.start(pid, msg) end)
    |> Task.await(:infinity)
    time1 = NaiveDateTime.diff(NaiveDateTime.utc_now, time0, :milliseconds)

    IO.puts "Elapsed #{time1}s"
  end

  def build_message(0) do
    <<>>
  end

  def build_message(size) do
    <<Enum.random(0..255)>> <> build_message(size - 1)
  end

end
