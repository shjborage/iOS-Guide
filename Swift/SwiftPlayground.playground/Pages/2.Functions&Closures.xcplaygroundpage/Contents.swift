//: [Previous](@previous)

import Foundation

var str = "Hello, Functions and Closures"

//: [Next](@next)

// Function
func greet(_ person: String, on day:String) -> String {
//func greet(man person: String, on day:String) -> String {
//func greet(person: String, day:String) -> String {
    return "Hello \(person), today is \(day)"
}
greet("asdf", on: "Monday")
//greet(man: "asdf", on: "Monday")
//greet(person: "asdf", day: "Monday")

// tuple
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

// 方法可接受动态参数并转化为 Array
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

/* 在 playground 有问题，直接去 Terminal 的 REPL 中解决问题~~~
// Nested
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

// Return a Func
func makeIncrement() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return number + 1
    }
    return addOne
}

var increment = makeIncrement()
increment(7)
*/

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
