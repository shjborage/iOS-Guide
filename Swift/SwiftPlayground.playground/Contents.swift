//: Playground - noun: a place where people can play

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
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
} else {
    greeting = "Hello, everybody!"
}
print(greeting);
