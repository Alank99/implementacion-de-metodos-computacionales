defmodule Invert do

    def inver_pairs(list), do: do_inver_pairs(list,[])

    defp do_inver_pairs([],res), do: Enum.reverse(res)
    defp do_inver_pairs([{a, b} | tail], res), 
        do: do_inver_pairs(tail, [{b, a} | res])
    
end