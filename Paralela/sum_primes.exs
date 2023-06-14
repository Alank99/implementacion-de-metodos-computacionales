# Using tasks to implement the sum of primes
#
# Mario y Alan
# 09/06/2023

defmodule Hw.Primes do
  defp is_prime(2), do: true
  defp is_prime(num) when num < 2, do: false
  defp is_prime(num) when rem(num, 2) == 0, do: false
  defp is_prime(num) do
    do_prime(num, round(:math.sqrt(num)))
  end

  defp do_prime(num, max) when num > max, do: true
  defp do_prime(num, max) when rem(max, num) == 0, do: false
  defp do_prime(num, max), do: do_prime(num + 1, max)

  defp sum_range({start, finish}) do
    Enum.reduce(start..finish, 0, fn num, acc ->
      if is_prime(num), do: acc + num, else: acc
    end)
  end

  defp make_ranges(start, finish, cores) do
    size = div(finish - start + 1, cores)
    add_tuple(start, start + size - 1, size, finish, [])
  end

  defp add_tuple(start, finish, _size, _final, acc) when start > finish, do: acc
  defp add_tuple(start, finish, size, final, acc) do
    new_start = start + size
    new_finish = if new_start + size - 1 > final, do: final, else: new_start + size - 1
    add_tuple(new_start, new_finish, size, final, [{start, finish} | acc])
  end

  def sum_primes_parallel(finish, cores) do
    ranges = make_ranges(2, finish, cores)
    ranges
    |> Enum.map(fn {start, finish} ->
      Task.async(fn -> sum_range({start, finish}) end)
    end)
    |> Enum.map(fn task ->
      Task.await(task, :infinity)
    end)
    |> Enum.sum()
  end

  def sum_primes_parallel(start, finish, cores) do
    ranges = make_ranges(start, finish, cores)
    ranges
    |> Enum.map(fn {start, finish} ->
      Task.async(fn -> sum_range({start, finish}) end)
    end)
    |> Enum.map(fn task ->
      Task.await(task, :infinity)
    end)
    |> Enum.sum()
  end

  def sum_primes(finish), do: sum_range({2, finish})
end