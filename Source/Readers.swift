//
//  Readers.swift
//  Dodo
//
//  Created by Brent Fitzgerald on 9/25/14.
//
//

import Foundation

func simpleRegExScanFn(pattern : String) -> SplitFunc {
    return { (s : String) -> (String, String?) in
        let ns = NSString(string: s)
        let range = ns.rangeOfString(pattern, options: .RegularExpressionSearch)
        if range.location == NSNotFound {
            return (s, nil)
        }
        let s1 = ns.substringToIndex(range.location)
        let s2 = ns.substringFromIndex(range.location + range.length)
        if s2.isEmpty {
            return (s, nil)
        } else {
            return (s1, s2)
        }
    }
}

public let splitParagraphs = simpleRegExScanFn("(\r\n?|\n)(\r\n?|\n)+")
public let splitLines = simpleRegExScanFn("\r\n?|\n")
public let splitWords = simpleRegExScanFn("\\s+")

public let readParagraphs = { (filePath : String) -> FileReader in
    return FileReader(filePath: filePath, bufferSize: 128, splitFunc: splitParagraphs)
}

public let readLines = { (filePath : String) -> FileReader in
    return FileReader(filePath: filePath, bufferSize: 128, splitFunc: splitLines)
}

public let readWords = { (filePath : String) -> FileReader in
    return FileReader(filePath: filePath, bufferSize: 128, splitFunc: splitWords)
}
