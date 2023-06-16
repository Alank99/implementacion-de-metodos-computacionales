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

//Adds the value to the end of the list.
void	addlastCircular(t_circular *lst, int value)
{
	t_dlist	*new;

	new = (t_dlist *)malloc(sizeof(t_dlist));
	if (new == NULL)
	{
		printf("%sError while allocating memory for node%s\n", RED, END);
		return;
	}

	printf("%sThe value%s %s%d%s %shas been added to the end of the circular list.%s\n\n", BAK, END, CYN, value, END, BAK, END);
	new->value = value;
	
	if (emptyCircular(lst) == 1)
		lst->first = new;
	else
		lst->last->next = new;

	lst->last = new;
	lst->last->next = lst->first;
	lst->first->past = lst->last;
}

//Function 2 add multiple consecutive nodes
void    addMultipleCircular(t_circular *lst){
    short int counter, value, i,select;
    printf("\n%sHow many nodes you want to add? %s", BLU, END);
    scanf("%hd",&counter);
	printf("\n%sWhere do you want to put the nodes:%s \n%s1) Start%s \n%s2) Middle%s \n%s3) End%s\n", BLU, END, MAG, END, YEL, END, CYN, END);
	scanf("%hd",&select);
    for (i = 0; i < counter; ++i)
    {
        printf("%sWhat is the value of the node %hd: %s", BAK, i+1, END);
        scanf("%hd",&value);
        if(select == 1)
			addfirstCircular(lst,value);
		else if(select == 2)
			addMiddleCircular(lst,value);
		else if(select == 3)
			addlastCircular(lst,value);
		else
		{
			printf("%sThe number you have chosen is not in the options\n\n%s", RED, END);
			break;
		}
	}   
}

//Function 3 delete a node
//Deletes the first time a specific value is found in the list.
void	delCircular(t_circular *lst, int value)
{
	t_dlist	*index;
	t_dlist	*past;
	short int pos = 0;

	index = lst->first;
	past = NULL;
	do
	{
		if (index->value == value)
		{
			if (past)
			{
				past->next = index->next;
				index->next->past = past;
				if (index == lst->last)
					lst->last = past;
			}
			else
			{
				lst->first = index->next;
				lst->first->past = lst->last;
				lst->last->next = lst->first;
			}
			printf("%sThe node[%s%s%hd%s%s] was deleted, with value%s %s%d%s\n\n", BAK, END, CYN, pos+1, END, BAK, END, CYN, index->value, END);
			free(index);
			return;
		}
		past = index;
		index = index->next;
		pos++;
	} while(index != lst->first);
}

//Function 4 a delete multiple nodes
//Deletes all the times a specific value is found in the list.
void	delallCircular(t_circular *lst, int value)
{
	t_dlist	*index;
	t_dlist	*past;
	t_dlist	*cpy;
	short int pos = 0;

	index = lst->first;
	past = NULL;
	do
	{
		if (index->value == value)
		{
			if (past)
			{
				past->next = index->next;
				index->next->past = past;
				if (index == lst->last)
					lst->last = past;
			}
			else
			{
				lst->first = index->next;
				lst->first->past = lst->last;
				lst->last->next = lst->first;
			}
			cpy = index;
			index = index->next;
			
			printf("%sThe node[%s%s%hd%s%s] was deleted, with value%s %s%d%s\n\n", BAK, END, CYN, pos+1, END, BAK, END, CYN, index->value, END);
			free(cpy);
		}
		else
		{
			past = index;
			index = index->next;
			pos++;
		}
	} while(index != lst->first);
}

//Function 5 delete the entire circular list
//Prints all the elements in the list with a tab between them
void	freeCircular(t_circular *lst)
{
	t_dlist	*index, *temp;

	index = lst->first;
	do
	{
		temp = index;
		index = index->next;
		free(temp);
	} while (index != lst->first);
	printf("%s\nThe list is empty%s\n\n", GRN, END);
	free(lst);
	lst = NULL;
}
//Function 6 search for a node 
//Prints all the times a specific value is found and its position, and returns the number.
int		searchCircular(t_circular *lst, int value)
{
	t_dlist	*index;
	short int		times;
	short int		pos;

	times = 0;
	pos = 0;
	index = lst->first;
	do
	{
		if (index->value == value)
		{
			times++;
			printf("%sFound %s%s%d%s %son position%s %s%hd%s\n", CYN, END, BAK, index->value, END, CYN, END, BAK, pos, END);
		}
		index = index->next;
		pos++;
	} while (index != lst->first);
	return (times);
}

//Fuction 7 circular list is empty
//Returns 1 if the list is empty, 0 if not.
int		emptyCircular(t_circular *lst)
{
	if (lst->first == NULL)
		return 1;
	return 0;
}
//Function 8 find the number of nodes
//Returns the size of the list.
int		sizeCircular(t_circular *lst)
{
	if(emptyCircular(lst) == 1)
		return 0;
	t_dlist	*index;
	short int size = 0;

	index = lst->first;
	do
	{
		size++;
		index = index->next;
	} while (index != lst->first);
	return size;
}

//Initiates a new circular list.
t_circular	*initCircular(void)
{
	t_circular *new;

	new = (t_circular *)malloc(sizeof(t_circular));
	new->first = NULL;
	new->last = NULL;
	return (new);
}

//Returns the average of the values in the list.
void	avgCircular(t_circular *lst)
{
	t_dlist	*index;
	double	avg;
	double	count;

	avg = 0;
	count = 0;
	index = lst->first;
	do
	{
		avg += index->value;
		count++;
		index = index->next;
	} while (index != lst->first);
	printf("%sThe average of the circular list is:%s %s%5.2f%s \n", BAK, END, CYN, (avg/count), END);
}

//Prints all the elements in the list with a tab between them
void	printCircular(t_circular *lst)
{
	t_dlist	*index;

	index = lst->first;
	do
	{
		printf("%s<-%s%s%d%s%s->%s\t", RED, END, CYN, index->value, END, MAG, END);
		index = index->next;
	} while (index != lst->first);
	printf("\n");
}

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

//Adds the value to the end of the list.
void	addlastCircular(t_circular *lst, int value)
{
	t_dlist	*new;

	new = (t_dlist *)malloc(sizeof(t_dlist));
	if (new == NULL)
	{
		printf("%sError while allocating memory for node%s\n", RED, END);
		return;
	}

	printf("%sThe value%s %s%d%s %shas been added to the end of the circular list.%s\n\n", BAK, END, CYN, value, END, BAK, END);
	new->value = value;
	
	if (emptyCircular(lst) == 1)
		lst->first = new;
	else
		lst->last->next = new;

	lst->last = new;
	lst->last->next = lst->first;
	lst->first->past = lst->last;
}

//Function 2 add multiple consecutive nodes
void    addMultipleCircular(t_circular *lst){
    short int counter, value, i,select;
    printf("\n%sHow many nodes you want to add? %s", BLU, END);
    scanf("%hd",&counter);
	printf("\n%sWhere do you want to put the nodes:%s \n%s1) Start%s \n%s2) Middle%s \n%s3) End%s\n", BLU, END, MAG, END, YEL, END, CYN, END);
	scanf("%hd",&select);
    for (i = 0; i < counter; ++i)
    {
        printf("%sWhat is the value of the node %hd: %s", BAK, i+1, END);
        scanf("%hd",&value);
        if(select == 1)
			addfirstCircular(lst,value);
		else if(select == 2)
			addMiddleCircular(lst,value);
		else if(select == 3)
			addlastCircular(lst,value);
		else
		{
			printf("%sThe number you have chosen is not in the options\n\n%s", RED, END);
			break;
		}
	}   
}

//Function 3 delete a node
//Deletes the first time a specific value is found in the list.
void	delCircular(t_circular *lst, int value)
{
	t_dlist	*index;
	t_dlist	*past;
	short int pos = 0;

	index = lst->first;
	past = NULL;
	do
	{
		if (index->value == value)
		{
			if (past)
			{
				past->next = index->next;
				index->next->past = past;
				if (index == lst->last)
					lst->last = past;
			}
			else
			{
				lst->first = index->next;
				lst->first->past = lst->last;
				lst->last->next = lst->first;
			}
			printf("%sThe node[%s%s%hd%s%s] was deleted, with value%s %s%d%s\n\n", BAK, END, CYN, pos+1, END, BAK, END, CYN, index->value, END);
			free(index);
			return;
		}
		past = index;
		index = index->next;
		pos++;
	} while(index != lst->first);
}

//Function 4 a delete multiple nodes
//Deletes all the times a specific value is found in the list.
void	delallCircular(t_circular *lst, int value)
{
	t_dlist	*index;
	t_dlist	*past;
	t_dlist	*cpy;
	short int pos = 0;

	index = lst->first;
	past = NULL;
	do
	{
		if (index->value == value)
		{
			if (past)
			{
				past->next = index->next;
				index->next->past = past;
				if (index == lst->last)
					lst->last = past;
			}
			else
			{
				lst->first = index->next;
				lst->first->past = lst->last;
				lst->last->next = lst->first;
			}
			cpy = index;
			index = index->next;
			
			printf("%sThe node[%s%s%hd%s%s] was deleted, with value%s %s%d%s\n\n", BAK, END, CYN, pos+1, END, BAK, END, CYN, index->value, END);
			free(cpy);
		}
		else
		{
			past = index;
			index = index->next;
			pos++;
		}
	} while(index != lst->first);
}

//Function 5 delete the entire circular list
//Prints all the elements in the list with a tab between them
void	freeCircular(t_circular *lst)
{
	t_dlist	*index, *temp;

	index = lst->first;
	do
	{
		temp = index;
		index = index->next;
		free(temp);
	} while (index != lst->first);
	printf("%s\nThe list is empty%s\n\n", GRN, END);
	free(lst);
	lst = NULL;
}
//Function 6 search for a node 
//Prints all the times a specific value is found and its position, and returns the number.
int		searchCircular(t_circular *lst, int value)
{
	t_dlist	*index;
	short int		times;
	short int		pos;

	times = 0;
	pos = 0;
	index = lst->first;
	do
	{
		if (index->value == value)
		{
			times++;
			printf("%sFound %s%s%d%s %son position%s %s%hd%s\n", CYN, END, BAK, index->value, END, CYN, END, BAK, pos, END);
		}
		index = index->next;
		pos++;
	} while (index != lst->first);
	return (times);
}

//Fuction 7 circular list is empty
//Returns 1 if the list is empty, 0 if not.
int		emptyCircular(t_circular *lst)
{
	if (lst->first == NULL)
		return 1;
	return 0;
}
//Function 8 find the number of nodes
//Returns the size of the list.
int		sizeCircular(t_circular *lst)
{
	if(emptyCircular(lst) == 1)
		return 0;
	t_dlist	*index;
	short int size = 0;

	index = lst->first;
	do
	{
		size++;
		index = index->next;
	} while (index != lst->first);
	return size;
}

//Initiates a new circular list.
t_circular	*initCircular(void)
{
	t_circular *new;

	new = (t_circular *)malloc(sizeof(t_circular));
	new->first = NULL;
	new->last = NULL;
	return (new);
}

//Returns the average of the values in the list.
void	avgCircular(t_circular *lst)
{
	t_dlist	*index;
	double	avg;
	double	count;

	avg = 0;
	count = 0;
	index = lst->first;
	do
	{
		avg += index->value;
		count++;
		index = index->next;
	} while (index != lst->first);
	printf("%sThe average of the circular list is:%s %s%5.2f%s \n", BAK, END, CYN, (avg/count), END);
}

//Prints all the elements in the list with a tab between them
void	printCircular(t_circular *lst)
{
	t_dlist	*index;

	index = lst->first;
	do
	{
		printf("%s<-%s%s%d%s%s->%s\t", RED, END, CYN, index->value, END, MAG, END);
		index = index->next;
	} while (index != lst->first);
	printf("\n");
}