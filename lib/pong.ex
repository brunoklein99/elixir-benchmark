defmodule Pong do
  def start do
    spawn fn -> start_internal() end
  end

  defp start_internal do
    receive do
      {pid, msg_id, _msg} ->
        send pid, {:ok, msg_id}
        start_internal()
    end
  end
end
