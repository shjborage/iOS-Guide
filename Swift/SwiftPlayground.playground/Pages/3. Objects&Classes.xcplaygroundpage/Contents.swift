//: [Previous](@previous)

import Foundation

var str = "Hello, Objects and Classes"

//: [Next](@next)

// Class

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

