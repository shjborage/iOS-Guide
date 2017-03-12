//: [Previous](@previous)

import Foundation

var str = "Hello, Protocols and Extensions"

//: [Next](@next)

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