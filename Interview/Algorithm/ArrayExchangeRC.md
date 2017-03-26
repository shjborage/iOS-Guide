# 将二维数据做行列切换
使用 `C` 语言实现

## Solution


## [Entire Code](erray_exchange_rc.c)

``` C
void convert(int array[][g_length]) {
    int i = 0;
    int j = 0;

    for (i=0; i<g_length; i++) {
        for (j=0; j<g_length; j++) {
            int tmp = array[i][j];
            array[i][j] = array[j][i];
            array[j][i] = tmp;
        }
    }
}
```

## Refs
-   [C语言对矩阵的转制 二维数组行列互换](http://blog.csdn.net/u012260740/article/details/21709207)
