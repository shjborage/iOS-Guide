/*
 * four ways to swap two number
 */
#include <stdio.h>

void swap(int *a, int *b) {
    //// 方法一：
    //int tmp = 0;
    //tmp = *b;
    //*b = *a;
    //*a = tmp;
    //// 方法二：
    //*a = *a+*b;
    //*b = *a-*b;
    //*a = *a-*b;
    // 方法三：
    // 下面这两种写法，是同一个意思
    //*a ^= *b ^= *a ^= *b;
    *a = *a ^ *b;
    *b = *b ^ *a;
    *a = *a ^ *b;

    // 方法四：
    //*a = *a+*b-(*b=*a);
}

int main(void) {
    int a = 5;
    int b = 4;

    printf("before swap: a = %d, b = %d\n", a, b);
    swap(&a, &b);
    printf("after swap: a = %d, b = %d\n", a, b);

    return 0;
}
