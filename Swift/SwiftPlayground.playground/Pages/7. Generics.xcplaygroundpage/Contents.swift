//: [Previous](@previous)

import Foundation

var str = "Hello, Generics"

//: [Next](@next)

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