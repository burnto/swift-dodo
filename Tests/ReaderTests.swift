//
//  FileReaderTests.swift
//  Dodo
//
//  Created by Brent Fitzgerald on 9/25/14.
//
//
import XCTest

import Dodo

class ReaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEmptyForNonPostiveBufferSize() {
        let filePath = pathForFile("haiku", type: "txt")
        let result = Array(FileReader(filePath: filePath, bufferSize: 0, splitFunc: splitLines))
        XCTAssert(result.isEmpty)
    }
    
    func testReadParagraphs() {
        let filePath = pathForFile("twinkle", type: "txt")
        let actual = Array(readParagraphs(filePath))
        let expected = [
            "twinkle twinkle little star",
            "how I wonder what you are.",
        ]
        XCTAssertEqual(actual, expected)
    }
    
    func testReadLines() {
        let filePath = pathForFile("haiku", type: "txt")
        
        let actual = Array(readLines(filePath))
        
        let expected = [
            "The wren",
            "Earns his living",
            "Noiselessly",
            "    - Issa",
        ]
        
        XCTAssertEqual(actual, expected)
    }
    
    func testReadWords() {
        let filePath = pathForFile("twinkle", type: "txt")
        
        let actual = Array(readWords(filePath))
        
        let expected = ["twinkle", "twinkle", "little", "star", "how", "I", "wonder", "what", "you", "are."]
        
        XCTAssertEqual(actual, expected)
    }
    
    // Helpers
    
    func pathForFile(fileName : String, type : String) -> String {
        return NSBundle(forClass: self.dynamicType).pathForResource(fileName, ofType: type)!
    }
    
}
