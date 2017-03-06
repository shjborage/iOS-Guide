/*
 * four ways to swap two number
 */
#include <stdio.h>

void swap(int *a, int *b) {
    ////方法一：
    //int tmp = 0;
    //tmp = *b;
    //*b = *a;
    //*a = tmp;
    ////方法二：
    //*a = *a+*b;
    //*b = *a-*b;
    //*a = *a-*b;
    //方法三:
    //异或也叫半加运算，其运算法则相当于不带进位的二进制加法：二进制下用1表示真，0表示假，则异或的运算法则为：0⊕0=0，1⊕0=1，0⊕1=1，1⊕1=0（同为0，异为1），这些法则与加法是相同的，只是不带进位。
    // 下面这两种写法，是同一个意思
    //*a ^= *b ^= *a ^= *b;
    *a = *a ^ *b;
    *b = *b ^ *a;
    *a = *a ^ *b;

    //方法四：
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
