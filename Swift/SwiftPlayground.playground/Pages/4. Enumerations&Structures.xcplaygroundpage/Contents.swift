//: [Previous](@previous)

import Foundation

var str = "Hi, Enumerations and Structures"

//: [Next](@next)

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

//if let threeDesc = Rank.init(rawValue: 23) {
if let threeDesc = Rank.init(rawValue: 3) {
    print(threeDesc.desc())
} else {
    print("unknown")
}

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
