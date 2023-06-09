# Using tasks to implement the sum of primes
#
# Mario y Alan
# 09/06/2023

defmodule Hw.Primes do

  defp is_prime(1), do: false
  defp is_prime(2), do: true
  defp is_prime(num) when rem(num, 2) == 0, do: false
  defp is_prime(num) when num < 2, do: false
  defp is_prime(num) do
    for i <- 3..round(:math.sqrt(num)), do: if rem(num, i) == 0, do: false
    true
  end

  defp sum_range({start, finish}) do
    Enum.reduce(start..finish, 0, fn num, acc -> if is_prime(num), do: acc + num, else: acc end)
  end

  defp add_tuple(size, final, start, finish, []), do: add_tuple(size, final, finish + 1, finish + size, [{round(start), round(finish)}])
  defp add_tuple(_size, final, start, finish, list) when finish > final,  do: [{round(start), round(finish)} | list]
  defp add_tuple(size, final, start, finish, list), do: add_tuple(size, final, finish + 1, finish + size, [{round(start), round(finish)} | list])

  defp make_ranges(start, finish, cores) do
    size = (finish - start) / cores
    add_tuple(size, finish, start, start + size, [])
  end

  def sum_primes_parallel(finish, cores) do
    make_ranges(2, finish, cores)
    |> Enum.map(&Task.async(fn -> sum_range(&1) end))
    |> Enum.map(&Task.await(&1))
    |> Enum.sum()
  end

  def sum_primes_parallel(start, finish, cores) do
    make_ranges(start, finish, cores)
    |> Enum.map(&Task.async(fn -> sum_range(&1) end))
    |> Enum.map(&Task.await(&1))
    |> Enum.sum()
  end

  def sum_primes(finish), do: sum_range({2, finish})

end
