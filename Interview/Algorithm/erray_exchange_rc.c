/*
 * 二维数据行列互换
 */
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

void swap(int *a, int *b) {
    //*a ^= *b ^= *a ^= *b;
    *a = *a ^ *b;
    *b = *b ^ *a;
    *a = *a ^ *b;
    //int tmp = *a;
    //*a = *b;
    //*b = tmp;
}

/*
 * 要取得[a,b)的随机整数，使用(rand() % (b-a))+ a;
 * 要取得[a,b]的随机整数，使用(rand() % (b-a+1))+ a;
 * 要取得(a,b]的随机整数，使用(rand() % (b-a))+ a + 1;
 * 通用公式:a + rand() % n；其中的a是起始值，n是整数的范围。
 * 要取得a到b之间的随机整数，另一种表示：a + (int)b * rand() / (RAND_MAX + 1)。
 * 要取得0～1之间的浮点数，可以使用rand() / double(RAND_MAX)。
 */
void init_random_system() {
    srand((unsigned)time(NULL));
}
int get_random_number() {
    return rand()%10;
}

const int g_length = 5;

void print_array(int array[][g_length]) {
    int i;
    for (i=0; i<g_length*g_length; i++) {
        printf("%d " , *(array[0]+i));
        if ((i+1)%g_length == 0) {
            printf("\n");
        }
    }
}

void convert(int array[][g_length]) {
    int i = 0;
    int j = 0;

    for (i=0; i<g_length; i++) {
        for (j=0; j<g_length; j++) {
            int tmp = array[i][j];
            array[i][j] = array[j][i];
            array[j][i] = tmp;
            //if (i != j) {
            //    swap(&array[i][j], &array[j][i]);
            //} else {
            //    // continue
            //}
        }
    }
}

int main(void) {
    // Test swap
    //int a = 5;
    //int b = 5;

    //printf("before swap: a = %d, b = %d\n", a, b);
    //swap(&a, &b);
    //printf("after swap: a = %d, b = %d\n", a, b);

    int array[g_length][g_length]; //malloc(sizeof(int)*g_length*g_length);
    int i = 0;
    int j = 0;

    // input
    init_random_system();
    for (i=0; i<g_length; i++) {
        for (j=0; j<g_length; j++) {
            array[i][j] = get_random_number();
        }
    }

    printf("origin:\n");
    print_array(array);

    convert(array);

    printf("\nconverted:\n");
    print_array(array);

    return 0;
}
