#include "structures.h"

//Fuction 1 add node
//Adds the value to the start of the list.
void	addfirstCircular(t_circular *lst, int value)
{
	t_dlist	*new;

	new = (t_dlist *)malloc(sizeof(t_dlist));
	if (new == NULL)
	{
		printf("%sError while allocating memory for node%s\n", RED, END);
		return;
	}
	printf("%sThe value%s %s%d%s %shas been added to the top of the circular list.%s\n\n", BAK, END, CYN, value, END, BAK, END);
	new->value = value;

	if (emptyCircular(lst) == 1)
		lst->last = new;
	else
		lst->first->past = new;

	new->next = lst->first;
	lst->first = new;
	lst->last->next = lst->first;
	lst->first->past = lst->last;
	
}