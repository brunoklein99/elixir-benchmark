defmodule Ping do
  def start(pid, size) do
    msg = build_message(size)
    start_internal(pid, 0, msg)
  end

  defp start_internal(_pid, 1000, _msg) do
    IO.puts "finished"
  end

  defp start_internal(pid, msg_id, msg) do
    send pid, {self(), msg_id, msg}
    receive do
      {:ok, ^msg_id} -> IO.puts "ack #{msg_id}"
    end
    start_internal(pid, msg_id + 1, msg)
  end

  def build_message(0) do
    <<>>
  end

  def build_message(size) do
    <<Enum.random(0..255)>> <> build_message(size - 1)
  end

end
