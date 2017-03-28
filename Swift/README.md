# Swift

## Why Swift?

很多人对 Swift 态度一直都是观望，或者不看好前景。我也是从14年 WWDC 就开始关注，做了初步的研究，但并没有深入学习。原因主要是因为项目大多数还是 Objective-C 来写的，切换成本以及混编成本都不小，而且最近几年主要都在开发 SDK，Swift 还会因为额外的『运行库』导致包大小增加。

说实话，Swift 开源后，对于跨平台的应用以及使用 Swift 来开发后端，都是很有想象力的。我也期待在这方面会有不断的进展。

为什么我又来写 Swift 相关的内容？

**Swift 本身优势**  
> *Safe*, *Fast*, *Expressive*  
> [About Swift](https://swift.org/about/)

融合了各语言的优势，说实话这让人无法抗拒。

**Swift 关注度不断提高**  
[3月编程语言排行：Swift 首次进 Top10](http://mp.weixin.qq.com/s?__biz=MzAxMzE2Mjc2Ng==&mid=2652155994&idx=1&sn=3bee0683508b9f9f119a12e56a4f6354&chksm=8046d03bb731592df2a0b7cdb9b026fed033923b925932050219eaf5629e7475e5a893190423&scene=0#rd) 这是个明显的信号，至少在『苹果大家庭』，拥抱 Swift 是「明智」的选择。

**Swift 不断稳定**  
3年来，Swift 不断完善，也有了很多相关的学习资料以及踩坑记录，可以入手啦。  
另外一方面，去年期待的 ABI（Application Binary Interface）稳定也会于今年秋在 Swift 4 与大家见面。

所以，是时候开工啦~

## How？

-   官方介绍了解特性
-   `Xcode Playground`
-   [入门教程](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.html#//apple_ref/doc/uid/TP40014097-CH2-ID1)
-   [完整的这本书： The Swift Programming Language (Swift 3.1)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309)
-   [CodeWars](https://www.codewars.com) 这个平台有各种级别的算法题，可以来这练，支持 Swift 哦~

## Full Contents

-   [Using the Package Manager](UsingthePackageManager.md)
-   [与 C API 通信相关](CompileWithC.md)
-   [Swift API Design Guidelines](APIDesignGuide.md)

## A Quick Tour

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

### Objects & Classes

常用的都在这儿了，比较好理解。 `willSet` 以及 `didSet` 是在 `init` 外部调用才会调用。这块后续还要再看下原理了解一下实现细节。

``` swift
class Shape {
    var numberOfSides = 0
    var name: String
    let constantValue = 1;

    init(name: String) {
        self.name = name
    }

    deinit {

    }

    func simpleDesc() -> String {
        return "A \(name) shape with \(numberOfSides) sides"
    }
    func _print(number: Int) {
        print(number)
    }
}

var shape = Shape(name: "asdf")
shape.simpleDesc()
shape.numberOfSides = 7
shape.simpleDesc()
shape._print(number: 4)

// Subclass
class Square: Shape {
    var sideLength: Double = 0.0
    var perimeter: Double {
//        get {
//            return sideLength * 2
//        }
//        set {
//            sideLength = newValue / 2
//        }
        willSet {
            print(newValue)
        }
        didSet {
            print(oldValue)
        }
    }

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        self.perimeter = sideLength / 2
        super.init(name: name)
        numberOfSides = 4
    }

    func area() -> Double {
        return sideLength * sideLength
    }

    override func simpleDesc() -> String {
        return "A square with sides of length \(sideLength)"
    }
}

var aSquare = Square(sideLength: 4, name: "Eric")
print(aSquare.area())
aSquare.simpleDesc()
aSquare.sideLength = 3
//aSquare.perimeter = 4
//aSquare.simpleDesc()
```

### Enumerations & Structures

#### `enum`

可支持 `func`，并且可指定不同类型的 `rawValue`，示例中使用 `Int`，也可以使用 `float` 和 `String`

``` swift
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king

    func desc() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"

        default:
            return String(self.rawValue)
        }
    }

    func isEqualtoRank(_ rank : Rank) -> Bool {
        return rank.rawValue == self.rawValue
    }
}

let ace = Rank.ace;
print(ace)
ace.rawValue
print(Rank.king.rawValue)
Rank.king.desc()

ace.isEqualtoRank(Rank.king)
ace.isEqualtoRank(Rank.two)
ace.isEqualtoRank(Rank.ace)
```

##### 构造方法
`init?(rawValue:)`

``` swift
//if let threeDesc = Rank.init(rawValue: 23) {
if let threeDesc = Rank.init(rawValue: 3) {
    print(threeDesc.desc())
} else {
    print("unknown")
}
```

##### 高级用法

待研究实现细节

``` swift
enum ServerResponse {
    case result(String, String)
    case failure(String)
    case unknown(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")
let unknown = ServerResponse.unknown("unknowned")

switch unknown {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure...  \(message)")
case let .unknown(message):
    print("asdf: \(message)")
}
```

#### `struct`

基本上与 `class` 类似，也支持成员变量、方法等。但 `struct` 在传值时是值传递，而且 `class` 是址传递。


### Protocols & Extensions

类似 `Objective-C`，不过可以对一些基础类型进行扩展，比如 `Double`。 使用更加方便，整体思路类似的。

``` swift
protocol ExampleProtocal {
    var desc: String { get }
    mutating func adjust()
}


extension Double : ExampleProtocal{
    var desc: String {
        return String(self)
    }

    func absoluteValue() -> Int {
        return Int(self)
    }

    mutating func adjust() {
        self += 0.5
    }
}
var doubleTest = 7.6
doubleTest.adjust()
doubleTest.absoluteValue()

let protocalValue: ExampleProtocal = doubleTest
print(protocalValue.desc)
```

### Error Handling

感觉比 `Objective-C` 的 `NSError` 方便多了，很便于理解。而且增加的 `defer` 功能也在很多场景下便于实现逻辑。见实际代码吧：

``` swift
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

var printingStatus = false;

func send(job: Int, toPrinter printerName: String) throws -> String {
    print("start with status \(printingStatus)")
    printingStatus = true;
    defer {
        print("defer with status \(printingStatus)")
        printingStatus = false;
    }

    if printerName == "Never has toner" {
        throw PrinterError.noToner
    } else {
//        throw PrinterError.onFire
    }

    defer {
        print("another defer with status \(printingStatus)")
        printingStatus = false;
    }

    return "Job sent"
}

do {
//    let response = try send(job: 2, toPrinter: "Never has toner")
    let response = try send(job: 2, toPrinter: "asdf")
    print(response)
} catch PrinterError.onFire {
    print("on fire")
} catch let printerError as PrinterError {
    print("printer error: \(printerError)")
} catch {
    print(error)
}


let responseNew = try? send(job: 3, toPrinter: "Never has toner")
print(responseNew ?? "")
```

注意 `defer` 的执行时机。

### Generics

泛型，对不同类型的统一支持，后续详细研究。

``` swift
func swapTwo<T>(_ a: inout T, _ b : inout T) {
    let tmp = a
    a = b
    b = tmp
}

var hi = "Hello"
var name = "asdf;"
swapTwo(&name, &hi)
print("\(name) \(hi)")


var a = 5
var b = 7
swapTwo(&a, &b)
print("a \(a) b \(b)")
```

注意这里的 `inout` 代表列参可修改，其实就是 `C` 里的传引用。

## Refs
-   [The Swift Programming Language (Swift 3.1)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.html#//apple_ref/doc/uid/TP40014097-CH2-ID1)
-   类型推断拆包：<http://stackoverflow.com/questions/24877098/value-of-optional-type-int-not-unwrapped-did-you-mean-to-use-or>
-   [函数式编程_百度百科](http://baike.baidu.com/link?url=z5EJyTm0t-tfb-NkEXCss8Pvihg5PPEM5v63em6IR1eus7neS6FSqwA1IQS8GzgqiTNRVMep310xtFjWEPnmEASHLPMJBW2Lw6ls_0irtmiL1aagHNwT7onirR1rp-B7rvap9UHfPgdzK4oW-BLgkq)
-   [函数式编程扫盲篇](http://www.cnblogs.com/kym/archive/2011/03/07/1976519.html)
-   [Swift 学习之泛型](http://www.jianshu.com/p/6624f5365745)
-   [Swift3.0学习笔记-Functions](http://blog.csdn.net/brycegao321/article/details/53114940)
-   [行走于 Swift 的世界中](https://onevcat.com/2014/06/walk-in-swift/)
-   [Swift 性能探索和优化分析](https://onevcat.com/2016/02/swift-performance/)
