#include <stdio.h>

#define MAX_SIZE 100

typedef struct {
    int x;
    int y;
} Point;

enum Color {
    RED,
    GREEN,
    BLUE
};

int add(int a, int b) {
    return a + b;
}

int main() {
    int num1 = 5;
    int num2 = 10;
    int result = add(num1, num2);

    if (result > 15) {
        printf("El resultado es mayor a 15\n");
    } else {
        printf("El resultado es menor o igual a 15\n");
    }

    for (int i = 0; i < 5; i++) {
        printf("Iteración %d\n", i);
    }

    while (num1 > 0) {
        printf("%d\n", num1);
        num1--;
    }

    Point p;
    p.x = 2;
    p.y = 3;

    switch (p.x) {
        case 1:
            printf("El valor de x es 1\n");
            break;
        case 2:
            printf("El valor de x es 2\n");
            break;
        default:
            printf("El valor de x no es ni 1 ni 2\n");
    }

    char str[MAX_SIZE] = "Hola, mundo!";
    printf("%s\n", str);

    return 0;
}
