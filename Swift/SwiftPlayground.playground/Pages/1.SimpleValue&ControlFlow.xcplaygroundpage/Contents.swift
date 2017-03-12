//: Playground - noun: a place where people can play

// A Swift Tour : https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.html#//apple_ref/doc/uid/TP40014097-CH2-ID1
import UIKit

var str = "Hello, playground"

var intTest:Int! = Int("5");
print("test:\(intTest)");

print("Hello")

let implicitInteger = 70
let implicitDouble = 7.0
let explicitDouble: Double = 7

print(explicitDouble)

print("This is a explicit Double Value: \(explicitDouble)")

var aArray = ["asdf"]
aArray = []

// Control Flow
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

// Optional
var optionalString: String? = "asdf"
print(optionalString == nil)

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

// Switch
let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}

// for-in
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    var kindLargest = 0
    for number in numbers {
        if number > largest {
            largest = number
        }
        
        if number > kindLargest {
            kindLargest = number
        }
    }
    print("kind: \(kind) largest: \(kindLargest)")
}
print(largest)

// while
var n = 2
while n < 100 {
    n = n*2
}
print(n)

var m = 2
repeat {
    m = m * 2
} while m < 100
print(m)

// ... & ..<
var total = 0
for i in 0..<4 {
//for i in 0...4 {
    total += i
}
print(total)
