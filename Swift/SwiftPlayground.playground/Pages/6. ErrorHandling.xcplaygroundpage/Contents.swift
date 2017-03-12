//: [Previous](@previous)

import Foundation

var str = "Hello, Error Handling"

//: [Next](@next)

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
