#function to practice recursion in elixir
#based on the proposats by ariel 
#
#alan hernandez 

defmodule Hw.Ariel2 do
    @doc """
    Insert an element into an ready sorted list
    """
    
    def insert(list,n), do: do_insert(n,list,[])
    

    defp do_insert(n,[],res), do: Enum.reverse([n | res])
    defp do_insert(n,[head | tail],res) when n <= head,
        do: Enum.reverse([n | res]) ++ [head | tail] 
    defp do_insert(n,[head | tail], res), do: do_insert(n,tail,[head | res])

    @doc """
    sort a list using insert sort
    """
    def insertion_sort(list), do: do_insertion_sort(list,[])
    defp do_insertion_sort([],sorted), do: sorted
    defp do_insertion_sort([head | tail],sorted), 
        do: do_insertion_sort(tail, insert(sorted , head))


    
    @doc """
    rotate a list n times to the left
    """
    def rotate_left(list, n), do: do_rotate_left(list, n, [])
    
    defp do_rotate_left([],n, res), do: []
    defp do_rotate_left(list, 0, res), do: list ++ Enum.reverse(res)
    defp do_rotate_left(list, n, res) when n < 0,
        do: do_rotate_left(list, n+length(list), res)
    defp do_rotate_left(list, n, res) when n > length(list), 
        do: do_rotate_left(list, n - length(list), res)
    defp do_rotate_left([head | tail], n, res), do: do_rotate_left(tail, n-1, [head | res]) 


    @doc """
    Prime factorization of a number
    """


    def prime_factors(n), do: do_prime_factors(n,2,[])
    defp do_prime_factors(1,factor,res), do: Enum.reverse(res)
    defp do_prime_factors(n,factor,res) when rem(n,factor) == 0, 
        do: do_prime_factors(div(n,factor), factor, [factor | res])
    defp do_prime_factors(n,factor,res), 
        do: do_prime_factors(n, factor + 1 , res)

    
    @doc """
    GCD of two numbers
    """
    def gcd(a,b), do: do_gcd(a,b)

    defp do_gcd(a,0), do: a
    defp do_gcd(0,b), do: b
    defp do_gcd(a,b), do: do_gcd(b, rem(a,b))

end
 