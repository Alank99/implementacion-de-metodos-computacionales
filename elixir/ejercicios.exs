
defmodule Ejer do

    def merge_sort(list), do: do_merge_sort(list, length(list), [])

    def merge_list(list1, list2), do: do_merge_list(list1,list2,[])

    def do_merge_list([], list2, res), do: Enum.reverse(res) ++ list2
    def do_merge_list(list1, [], res), do: Enum.reverse(res) ++ list1
    def do_merge_list([head1 | tail1], [head2 | tail2], res) when head1 < head 2,
        do: do_merge_list(tail1, [head2 | tail2], [head1 | res])
    def do_merge_list([head1 | tail1]) 
    

end