#First funtions in elixir
#Using recursion ti find the factorial

defmodule Recur do
  #create a new function. All function names must start with lowercase

  #Using pattern matching
  def factp(0), do: 1
  def factp(n), do: n * factp(n - 1)

  def fact(n) do
    if n == 0, do: 1, else: n * fact(n-1)
  end

  def fact_tail(n), do: do_fact_tail(n,1)

  defp do_fact_tail(n,r) do #defp to define a private function
    if n == 0, do: r, else: do_fact_tail(n - 1,r * n)
  end

  def fibo(n) do
    if n < 2, do: n, else: (fibo(n - 1) + fibo(n - 2))
  end


  def fibo_tail(0), do: 0
  def fibo_tail(1), do: 1
  def fibo_tail(n), do: do_fibo_tail(0,1,n)

  defp do_fibo_tail(a,b,0), do: b
  defp do_fibo_tail(a,b,c), do: do_fibo_tail(b,a+b,n-1)
end
