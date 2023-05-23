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
//Adds value in middle of the list
void	addMiddleCircular(t_circular *lst, int value)
{
	short int counter = sizeCircular(lst);
	if(counter == 0)
	{
		addfirstCircular(lst, value);
		return;
			
	}
	else if( counter == 1)
	{
		addlastCircular(lst,value);
		return;
	}
	
	t_dlist	*new;
	t_dlist *index = lst->first;
	t_dlist *inext = index->next;
	
	short int i = 1;

	new = (t_dlist *)malloc(sizeof(t_dlist)); 

	if (new == NULL)
	{
		printf("%sError while allocating memory for node%s\n", RED, END);
		return;
	}
	printf("%sThe value%s %s%d%s %shas been added in the middle of the circular list.%s\n\n", BAK, END, CYN, value, END, BAK, END);
	new->value = value;

		while(index->next != lst->last && i < (counter/2))
		{
			index = index->next;
			inext = inext->next;
			i++;
		}
		index->next = new;
		new->past = index;
		inext->past = new;
		new->next = inext;  
}
