//
//  FileReader.swift
//  Dodo
//
//  Created by Brent Fitzgerald on 9/25/14.
//
//

import Foundation

public typealias SplitFunc = ((String) -> (String, String?))

public class FileReader : SequenceType {
    
    var filePath : String
    var splitFunc : SplitFunc
    var bufferSize : Int
    
    public init(filePath : String, bufferSize : Int = 128, splitFunc : SplitFunc) {
        self.filePath = filePath
        self.bufferSize = bufferSize
        self.splitFunc = splitFunc
    }
    
    public func generate() -> FileReaderGenerator {
        return FileReaderGenerator(filePath: filePath, bufferSize: bufferSize, splitFunc)
    }
}

public class FileReaderGenerator : GeneratorType {
    
    var stream : NSInputStream
    var byteBufferSize : Int
    var byteBuffer : UnsafeMutablePointer<UInt8>
    var stringBuffer : NSString
    var splitFn : SplitFunc
    
    init(filePath : String, bufferSize : Int, splitFn : SplitFunc) {
        self.stream = NSInputStream.inputStreamWithFileAtPath(filePath)
        self.byteBufferSize = bufferSize + 1
        self.splitFn = splitFn
        
        byteBuffer = UnsafeMutablePointer<UInt8>.alloc(byteBufferSize)
        stringBuffer = ""
        stream.open()
    }
    
    deinit {
        stream.close()
    }
    
    public func next() -> String? {
        
        if stream.streamStatus != .Open || byteBufferSize <= 1 {
            return nil
        }
        
        while true {
            
            let (s1, s2) : (String, String?) = splitFn(stringBuffer)
            if (s2 != nil) {
                stringBuffer = s2!
                return s1
            }
            
            var bytesRead = stream.read(byteBuffer, maxLength: byteBufferSize - 1)
            if bytesRead < 0 {
                stream.close()
                return nil
            }
            if bytesRead == 0 {
                break
            }
            var charBuffer = UnsafeMutablePointer<CChar>(byteBuffer)
            charBuffer[bytesRead] = 0 // null terminate the c-string
            if let utf8String = String.fromCString(charBuffer) {
                stringBuffer = stringBuffer + utf8String
            } else {
                return nil
            }
        }
        stream.close()
        return stringBuffer
    }
}
