import XCTest
@testable import ExamplePackage

class ExamplePackageTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(ExamplePackage().text, "Hello, World!")
    }


    static var allTests : [(String, (ExamplePackageTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
