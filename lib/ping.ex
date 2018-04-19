defmodule Ping do
  def start(pid, msg) do
    time0 = NaiveDateTime.utc_now
    start_internal(pid, 0, msg)
    NaiveDateTime.diff(NaiveDateTime.utc_now, time0, :milliseconds)
  end

  defp start_internal(_pid, 1000, _msg) do
    IO.puts "finished"
  end

  defp start_internal(pid, msg_id, msg) do
    send pid, {self(), msg_id, msg}
    receive do
      {:ok, ^msg_id} -> nil
    end
    start_internal(pid, msg_id + 1, msg)
  end
end
