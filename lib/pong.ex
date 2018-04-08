defmodule Pong do
  def start do
    spawn fn -> start_internal() end
  end

  defp start_internal do
    receive do
      {pid, msg_id, _msg} ->
        IO.puts "received #{msg_id}"
        send pid, {:ok, msg_id}
        IO.puts "sent #{msg_id}"
        start_internal()
    end
  end
end
