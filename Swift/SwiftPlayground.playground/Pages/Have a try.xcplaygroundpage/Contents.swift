//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

do {
//    var content = try String(contentsOfFile:"asdf")
    var content = try String(contentsOfFile:"asdf", encoding:.utf8)
} catch {
    print(error)
}


struct RegexHelper {
    let regex: NSRegularExpression;
    
    init(_ pattern: String) throws {
        regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    func match(input: String) -> [NSTextCheckingResult] {
        let matches = regex.matches(in: input, options: [], range: NSMakeRange(0, input.characters.count))
        return matches
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

do {
    let input = "<image>http://asdfsdf.baidu.com<image/>"
    let regex = try NSRegularExpression(pattern: "<image>(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?<image/>", options: .caseInsensitive)
    let result = regex.matches(in: input, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, input.characters.count))
    if result.count > 0 {
        for checkingRes in result {
            print("Location:\(checkingRes.range.location), length:\(checkingRes.range.length)")
            print(input.substring(with: checkingRes.range.location..<checkingRes.range.location+checkingRes.range.length))
        }
    }else{
        print("未查找到")
    }
    
} catch  {
    print(error)
}

" asdf \n\r  ".trim()