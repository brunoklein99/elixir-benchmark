defmodule Pong do
  def start do
    receive do
      {pid, msg_id, _msg} ->
        send pid, {:ok, pid, msg_id}
        start()
    end
  end
end
