# `swap` 两个数解法
使用 `C` 语言实现

## Solution
### 1 定义额外变量，记录一个临时值

比较常见的解决办法，容易理解，但需要一个额外的变量。

```
void swap(int *a, int *b) {   
    int tmp = 0;
    tmp = *b;
    *b = *a;  
    *a = tmp;
}
```

### 2 先将两个数相加，保存起来，再用这个和去减，达到替换效果

确实也可以做到交换，而且不需要额外变量，但相加是有可能会越界的。

```
void swap(int *a, int *b) {   
    *a = *a+*b;   
    *b = *a-*b;   
    *a = *a-*b;
}
```

### 3 使用异或运算，将两个数做异或，再对异或结果与一个数异或得到另外一个数的值

不会越界，也不用新的变量，只是对于异或运算不太了解的，可能看不太懂。
>   异或也叫半加运算，其运算法则相当于不带进位的二进制加法：二进制下用1表示真，0表示假，则异或的运算法则为：0⊕0=0，1⊕0=1，0⊕1=1，1⊕1=0（同为0，异为1），这些法则与加法是相同的，只是不带进位。
>   异或略称为XOR、EOR、EX-OR

```
void swap(int *a, int *b) {   
    // 下面这两种写法，是同一个意思，拆开写好理解一些。
    //*a ^= *b ^= *a ^= *b;
    *a = *a ^ *b;
    *b = *b ^ *a;
    *a = *a ^ *b;
}

```

### 4 类似方法2，不过代码写起来巧秒

```
void swap(int *a, int *b) {  
    //*a = *a+*b-(*b=*a);   
}
```

## [Entire Code](swap.c)

```
/*
 * four ways to swap two number
 */
#include <stdio.h>

void swap(int *a, int *b) {
    //方法一：   
    //int tmp = 0;
    //tmp = *b;
    //*b = *a;  
    //*a = tmp;  

    //方法二：   
    //*a = *a+*b;   
    //*b = *a-*b;   
    //*a = *a-*b;  

    //方法三:
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

```

## Refs
-   [异或-百度百科](http://baike.baidu.com/link?url=qo1LCE4H_IEl7NA2lpZTjiQot5G_HIhNHN1oTJzFbXiiNqfBzqprUzphHXCGnjkdKabXq-ayrDxNL3W7uo47SwfOpj18h3eIfkxPRKrG1qW)
-   [c语言swap(a,b)值交换的4种实现方法](http://www.jb51.net/article/34240.htm)
