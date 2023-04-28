#listas 

defmodule Teclist do

    def len(lst) do
        if lst == [] do
            0
        else
            1 + len(lt(lst))
        end
    end

    def add_lst([]), do: 0
    def add_lst(lst), do: hd(lst) + add_lst(tl(lst))

    def add_lst2([]), do: 0
    def add_lst2([head | tail]), do: head + add_lst(tail)

    def add_lst(lst) do
        [head | tail]=lst
        head + add_lst(tail)
    
    def add_lst3(lst), do: do_add_lst3(lst,0)
    defp do_add_lst3([],res), do: res
    defp do_add_lst3([head | tail], res), do:

    def sqrt_list(list), do:do_sqrt_list(list,[])

    def do_sqrt_list([],res), do: Enum.reverse(res)
    defp do_sqrt_list([head | tail], res), do:do_sqrt_list(tail, [:math.sqrt(head) | res])
end