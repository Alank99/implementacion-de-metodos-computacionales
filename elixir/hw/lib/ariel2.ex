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

    defp do_rotate_left([],_n, _res), do: []
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
    defp do_prime_factors(1,_factor,res), do: Enum.reverse(res)
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


    @doc """
    8. pack returns a list that groups all the consecutive equal elements of a list
    """
    def pack(list), do: do_pack(list, [], [])

    defp do_pack([], [], []), do: []
    defp do_pack([], new_list, curr), do: Enum.reverse(new_list) ++ [curr]
    defp do_pack([head | tail], new_list, []), do:
      do_pack(tail, new_list, [head])
    defp do_pack([head | tail], new_list, curr) when is_list(curr) do
      cond do
        List.first(curr) == head -> do_pack(tail, new_list, [head | curr])
        true -> do_pack([head | tail], [curr | new_list], [])
      end
    end
    defp do_pack([head | tail], new_list, curr) do
      cond do
        curr == head -> do_pack(tail, new_list, [head | curr])
        true -> do_pack(tail, [[curr] | new_list], head)
      end
    end

    @doc """
    9. compress returns a list that only takes the different values in a sequence
    """
    def compress(list), do: do_compress(list, [], [])

    defp do_compress([], [], []), do: []
    defp do_compress([], new_list, curr), do: Enum.reverse([curr | new_list])
    defp do_compress([head | tail], new_list, []), do: do_compress(tail, new_list, head)
    defp do_compress([head | tail], new_list, curr) when head == curr, do:
      do_compress(tail, new_list, curr)
    defp do_compress([head | tail], new_list, curr), do:
      do_compress(tail, [curr | new_list], head)


    @doc """
    10. encode counts the number of times a value is repeated in a list,
    and returns a list of tuples with the quantity of each different value
    """
    def encode(list), do: do_encode(list, [], [], 0)

    defp do_encode([], [], [], 0), do: []
    defp do_encode([], new_list, curr, count), do: Enum.reverse(new_list) ++ [{count, curr}]
    defp do_encode([head | tail], new_list, [], 0), do: do_encode(tail, new_list, head, 1)
    defp do_encode([head | tail], new_list, curr, count) when head == curr, do:
      do_encode(tail, new_list, curr, count + 1)
    defp do_encode([head | tail], new_list, curr, count), do:
      do_encode(tail, [{count, curr} | new_list], head, 1)

    @doc """
    11. encode-modified counts the number of times a value is repeated in a list,
    and returns a list of tuples with the quantity of each different value,
    except if the quantity is 1, then its just the value
    """
    def encode_modified(list), do: do_encodem(list, [], [], 0)

    defp do_encodem([], [], [], 0), do: []
    defp do_encodem([], new_list, curr, 1), do: Enum.reverse(new_list) ++ [curr]
    defp do_encodem([], new_list, curr, count), do: Enum.reverse(new_list) ++ [{count, curr}]
    defp do_encodem([head | tail], new_list, [], 0), do: do_encodem(tail, new_list, head, 1)
    defp do_encodem([head | tail], new_list, curr, count) when head == curr, do:
      do_encodem(tail, new_list, curr, count + 1)
    defp do_encodem([head | tail], new_list, curr, 1), do:
      do_encodem(tail, [curr | new_list], head, 1)
    defp do_encodem([head | tail], new_list, curr, count), do:
      do_encodem(tail, [{count, curr} | new_list], head, 1)

end
