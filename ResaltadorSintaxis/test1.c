#include <stdio.h>

//This is a comment
int main() {
    t_dlist	*new;

    if (new == NULL)
	{
		printf("%sError while allocating memory for node%s\n", RED, END);
		return;
	}
    printf("Hello World!");
    return 0;
}