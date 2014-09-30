# Dodo

Read dumb text files in Swift.

```obj-c
for line in readLines("path/to/file.txt") {
    println("Line! " + line)
}
```

This is a Swift `SequenceType` implementation around a buffered `NSInputStream`, offering a pretty easy and efficient way to iterate through large files line-by-line, word-by-word, or [however you want](Source/Readers.swift).

See [the tests](Tests/ReaderTests.swift) for more sample usage.

## Installation

1. Download, clone, or add this repo as a submodule in your project.
2. Add Dodo.xcodeproj project to your project's workspace.
3. In your Build Settings, add Dodo as a Target Dependency.

## Why?

I did not immediately find a readymade ultra-simple Swift or Objective-C line reader when I needed one. The design is mostly inspired by golang's [bufio.Scanner](http://golang.org/pkg/bufio/#Scanner), only dumber.


         _   
    \. _(9>  
     \==_)   
      -'=    



