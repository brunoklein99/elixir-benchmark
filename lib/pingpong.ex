defmodule PingPong do

  def start_all do
    tests = get_tests()
    start_all(tests)
  end

  def start_all([]) do
  end

  def start_all([h|t]) do
    start(h)
    start_all(t)
  end

  def start(size \\ 1) do
    name = System.get_env("NODE_NAME")
    IO.puts "Starting node #{name} for size #{size}"

    name_atom = String.to_atom(name)

    connect_status = Node.connect(name_atom)

    IO.inspect(connect_status, label: "connect_status")

    pid = Node.spawn(name_atom, fn -> Pong.start end)

    IO.inspect(pid, label: "remote pid")

    msg = build_message(size)
    elapsed = start_internal(pid, msg, 0, 0)

    IO.puts "Elapsed #{elapsed}ms for size #{size}"
  end

  def get_tests do
    [10, 100, 1000, 10000, 100000, 250000, 500000, 1000000]
  end

  def start_internal(_pid, _msg, acc, 10) do
    acc / 10
  end

  def start_internal(pid, msg, acc, count) do
    time1 = Task.async(fn -> Ping.start(pid, msg) end)
      |> Task.await(:infinity)
    start_internal(pid, msg, acc + time1, count + 1)
end

  def build_message(0) do
    <<>>
  end

  def build_message(size) do
    <<Enum.random(0..255)>> <> build_message(size - 1)
  end

end
