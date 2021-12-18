import XCTest
@testable import CSVGeneratorSwift

final class CSVGeneratorSwiftTests: XCTestCase {
    
    let defaultGenerator = CSVGeneratorSwift()
    let compactJSONGenerator: CSVGeneratorSwift = {
        let g = CSVGeneratorSwift()
        g.jsonWritingOptions = .fragmentsAllowed
        return g
    }()
    
    func testComplexTextArray() {
        XCTAssertEqual(defaultGenerator.getCSVString(from: quotes), CSVString_quotes)
    }
    
    func testComplexTextDictionnary() {
        XCTAssertEqual(defaultGenerator.getCSVString(from: quotesDictionary), CSVString_quotesDictionnary)
    }
    
    func testComplexJson() {
        XCTAssertEqual(defaultGenerator.getCSVString(from: trucks), CSVString_trucks)
    }
    
    func testDateFormatting() {
        let myDate = Date(timeIntervalSinceReferenceDate: 267682629)
        let generator = CSVGeneratorSwift()
        XCTAssertEqual(generator.getCSVExportableValue(myDate), "2009-06-26 04:17:09 +0000")
        generator.dateFormat = "dd-MM-YYYY"
        XCTAssertEqual(generator.getCSVExportableValue(myDate), "26-06-2009")
        generator.dateFormat = "HH:mm:ss"
        XCTAssertEqual(generator.getCSVExportableValue(myDate), "06:17:09")
    }
    
    func testArrayCell() {
        XCTAssertEqual(compactJSONGenerator.getCSVExportableValue(cars[0].dimensions), "[4684,1923,1624]")
    }
    
    func testDictionaryCell() {
        XCTAssertEqual(compactJSONGenerator.getCSVExportableValue(dict), CSVString_dict)
    }
    
    func testUnderCSVExportable() {
        XCTAssertEqual(compactJSONGenerator.getCSVString(from: cars), CSVString_cars)
    }
    
    func testArrayOfUnderCSVExportable() {
        XCTAssertEqual(compactJSONGenerator.getCSVString(from: users), CSVString_users)
    }

    static var allTests = [
        ("testComplexTextArray", testComplexTextArray),
        ("testComplexTextDictionnary", testComplexTextDictionnary),
        ("testComplexJson", testComplexJson),
        ("testDateFormatting", testDateFormatting),
        ("testArrayCell", testArrayCell),
        ("testDictionaryCell", testDictionaryCell),
        ("testUnderCSVExportable", testUnderCSVExportable),
        ("testArrayOfUnderCSVExportable", testArrayOfUnderCSVExportable)
    ]
}
