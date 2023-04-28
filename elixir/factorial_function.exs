# First functions in Elixir
# Using recursion to find the factorial
#
# Gilberto Echeverria
# 2023-04-18

defmodule Recur do

  # Normaly syntax for functions with an if for the base case
  def fact(n) do
    if n <= 0 do
      1
    else
      n * fact(n - 1)
    end   # End the if
  end   # End the def

  # Using pattern matching
  def fact_pat(0), do: 1
  def fact_pat(n), do: n * fact_pat(n - 1)

  # Using 'guards'
  def fact_guar(n) when n <= 0, do: 1
  def fact_guar(n), do: n * fact_guar(n - 1)

  def fact_tail(n), do: do_fact_tail(n, 1)

  # Define a private function that can only be called from within this module
  defp do_fact_tail(n, r) do
    if n == 0, do: r, else: do_fact_tail(n - 1, r * n)
  end

  def diploma(grade) when grade >= 90, do: :distinction
  def diploma(grade) when grade >= 70, do: :pass
  def diploma(_grade), do: :fail

  # Fibonacci function using regular recursion
  # This check will avoid infinite recursion, but makes the function
  # inconsistent in its return value
  def fibo(n) when n < 0, do: :error
  def fibo(0), do: 0
  def fibo(1), do: 1
  def fibo(n), do: fibo(n - 1) + fibo(n - 2)

  @doc """
  Fibonacci function using tail recursion
  """
  def fibo_tail(n) when n < 0, do: {:error, :negative}
  def fibo_tail(0), do: {:ok, 0}
  def fibo_tail(1), do: {:ok, 1}
  def fibo_tail(n), do: {:ok, do_fibo_tail(0, 1, n - 1)}

  defp do_fibo_tail(_a, b, 0), do: b
  defp do_fibo_tail(a, b, n), do: do_fibo_tail(b, a + b, n - 1)

  def sumo_fibos(star,finish), do do_sumo_fibos(star, finish, 0)
  defp sumo_fibos(finish,finish,res), do: res
  defp do_sumo_fibos(star,finish,res),

end   # End the defmodule