# Swift

## Why `Swift`?

很多人对 `Swift` 态度一直都是观望，或者不看好前景。我也是从14年 WWDC 就开始关注，做了初步的研究，但并没有深入学习。原因主要是因为项目大多数还是 Objective-C 来写的，切换成本以及混编成本都不小，而且最近几年主要都在开发 SDK，`Swift` 还会因为额外的『运行库』导致包大小增加。

说实话，`Swift` 开源后，对于跨平台的应用以及使用 `Swift` 来开发后端，都是很有想象力的。我也期待在这方面会有不断的进展。

为什么我又来写 `Swift` 相关的内容？

**`Swift` 本身优势**  
> *Safe*, *Fast*, *Expressive*  
> [About Swift](https://swift.org/about/)

融合了各语言的优势，说实话这让人无法抗拒。

**`Swift` 关注度不断提高**  
[3月编程语言排行：Swift 首次进 Top10](http://mp.weixin.qq.com/s?__biz=MzAxMzE2Mjc2Ng==&mid=2652155994&idx=1&sn=3bee0683508b9f9f119a12e56a4f6354&chksm=8046d03bb731592df2a0b7cdb9b026fed033923b925932050219eaf5629e7475e5a893190423&scene=0#rd) 这是个明显的信号，至少在『苹果大家庭』，拥抱 `Swift` 是「明智」的选择。

**`Swift` 不断稳定**  
3年来，`Swift` 不断完善，也有了很多相关的学习资料以及踩坑记录，可以入手啦。  
另外一方面，去年期待的 ABI（Application Binary Interface）稳定也会于今年秋在 `Swift 4` 与大家见面。

所以，是时候开工啦~
    
## How？ 

-   官方介绍了解特性
-   `Xcode Playground`
-   [入门教程](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.html#//apple_ref/doc/uid/TP40014097-CH2-ID1)
-   [完整的这本书： The Swift Programming Language (Swift 3.1)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309)
-   [CodeWars](https://www.codewars.com) 这个平台有各种级别的算法题，可以来这练，支持 `Swift` 哦~


## 和其它语言差异

### 省略了各种括号，同时 `Int` 不能转化为 `if` 的 `statement`

```
let indivdualScores = [75, 43, 103, 87, 12];
var teamScore = 0
for score in indivdualScores {
    if score > 50 {
//    if score {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)
```

如果使用 `if score {` 的话，就会报这个错

```
Playground execution failed: error: Swift_Playground.playground:19:8: error: 'Int' is not convertible to 'Bool'
    if score {
       ^~~~~

```

这是 **Safe** 的表现哇~

### `switch` 差异说明

-   switch 必要要有 `default` 语句，否则报 `Switch must be exhaustive, consider adding a default clause` 错
-   switch 语句不需要 `break`, 一旦条件符合 执行 自动跳出 switch 语句块
-   switch support any kind of data and a wide variety of comparison operations, switch 支持任何数据类型 和 各种各样的比较操作




