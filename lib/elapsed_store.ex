defmodule ElapsedStore do
  use Agent

  def start_link() do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def put(elapsed) do
    Agent.update(__MODULE__, fn(s) -> s ++ [elapsed] end)
  end

  def clear do
    Agent.update(__MODULE__, fn(s) -> [] end)
  end

  def mean do
    Agent.get(__MODULE__, fn(s) -> compute_mean(s, 0, 0) end)
  end

  def count do
    Agent.get(__MODULE__, fn(s) -> length(s) end)
  end

  def samples do
    Agent.get(__MODULE__, fn(s) -> s end)
  end

  defp compute_mean([h|t], acc, count) do
    compute_mean(t, acc + h, count + 1)
  end

  defp compute_mean([], _acc, 0) do
    0
  end

  defp compute_mean([], acc, count) do
    acc / count
  end
end
