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

### Optional

拆包，可在 `if` 的 statement 中直接拆，也可以使用 `??` 来增加默认值

```
//var optionalName: String? = "John"
var optionalName: String? = nil
var defaultNmae = "Eric"
var greeting = "Hello!"
print("Hello, \(optionalName ?? defaultNmae)")

if let name = optionalName {
    greeting = "Hello, \(name)"
} else {
    greeting = "Hello, everybody!"
}
print(greeting);

// result:
Hello, Eric
Hello, everybody!
```

### Control Flow

#### 省略了各种括号，同时 `Int` 不能转化为 `if` 的 `statement`

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

#### `switch` 差异说明

-   switch 必要要有 `default` 语句，否则报 `Switch must be exhaustive, consider adding a default clause` 错
-   switch 语句不需要 `break`, 一旦条件符合 执行 自动跳出 switch 语句块
-   switch support any kind of data and a wide variety of comparison operations, switch 支持任何数据类型 和 各种各样的比较操作

#### loop
`for-in` => `for (kind, numbers) in interestingNumbers {`
`for-in` => `for i in 0..<4 { &for i in 0...4 {`  
这个 `for-in` 很实用， `..<` 不包含4， `...` 是包含的。  
`while` 和 `repeat` 跟其它语言的 `while` 和 `do while` 没啥区别


### Function

>   **Functions are a first-class type**

*所谓"第一等公民"（first class），指的是函数与其他数据类型一样，处于平等地位，可以赋值给其他变量，也可以作为参数，传入另一个函数，或者作为别的函数的返回值。* 


定义跟 `Objective-C` 类似，不过升级了一下，支持对参数名称的省略和 label 支持。
```
func greet(_ person: String, on day:String) -> String {
//func greet(man person: String, on day:String) -> String {
//func greet(person: String, day:String) -> String {
    return "Hello \(person), today is \(day)"
}
greet("asdf", on: "Monday")
//greet(man: "asdf", on: "Monday")
//greet(person: "asdf", day: "Monday")
```
#### 多返回值
`tuple` 多返回值支持

```
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum:Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}

let statistic = calculateStatistics(scores: [5, 8, 100, 1, 99, 10])
print(statistic)
print(statistic.min)
print(statistic.2)
```

#### 可接收可变参数并转化为数组

```
func averageOf(_ numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    if numbers.count > 0 {
        return sum / numbers.count
    } else {
        return 0
    }
}

averageOf()
averageOf(42, 1234, 55)
```

#### 可嵌套

```
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()
```

如果在 playground 中遇到 crash，直接去 控制台的 REPL 中去玩吧~

#### 返回一个函数

``` swift
func makeIncrement() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return number + 1
    }
    return addOne
}

var increment = makeIncrement()
increment(7)
```

#### 一个函数接受另一个函数作为参数

``` swift
//func hasAnyMatch(numbers: [Int], condition:((Int)-> Bool)) -> Bool {
func hasAnyMatch(numbers: Int..., condition:((Int)-> Bool)) -> Bool {
    for item in numbers {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(_ number: Int) -> Bool {
//    return number < 10
    return number > 100
}

//hasAnyMatch(numbers: [22, 5, 3, 2, 55], condition: lessThanTen)
hasAnyMatch(numbers: 22, 25, 3, 2, 55, condition: lessThanTen)
```

### Closures
就是 `Objective-C` 中的 `block`，只不过写法变了样，有了很多简便的写法，需要适应一下。熟练后能方便不少：

``` swift
let numbers = [22, 33, 44, 55, -2]
//let mapedNumbers = numbers.map({ (number: Int) -> Int in
//    if number < 0 {
//        return 0
//    } else {
//        let result = 2 * number
//        return result
//    }
//})
//let mapedNumbers = numbers.map({ number in 2 * number })
let mapedNumbers = numbers.map { number in 2 * number }
let sortedNumbers = numbers.sorted { $0 < $1 }
print(numbers)
print(mapedNumbers)
print(sortedNumbers)
```

## Refs
-   类型推断拆包：<http://stackoverflow.com/questions/24877098/value-of-optional-type-int-not-unwrapped-did-you-mean-to-use-or>
-   [函数式编程_百度百科](http://baike.baidu.com/link?url=z5EJyTm0t-tfb-NkEXCss8Pvihg5PPEM5v63em6IR1eus7neS6FSqwA1IQS8GzgqiTNRVMep310xtFjWEPnmEASHLPMJBW2Lw6ls_0irtmiL1aagHNwT7onirR1rp-B7rvap9UHfPgdzK4oW-BLgkq)
-   [函数式编程扫盲篇](http://www.cnblogs.com/kym/archive/2011/03/07/1976519.html)



