# Dodo

Read files easily. Quick example usage:

```obj-c
for line in readLines("path/to/file.txt") {
    println("Line! " + line)
}
```

This is a Swift Sequence wrapper around a buffered NSInputStream that offers a pretty easy and efficient way to iterate through large files line-by-line, word-by-word, or however you want.

See [Tests/ReaderTests.swift] for a little more usage.

I wrote this because I did not immediately find a readymade stupidly simple Swift or Objective-C line reader when I needed one. The design is loosely inspired by golang's [bufio.Scanner](http://golang.org/pkg/bufio/#Scanner), only dumber.


         _   
    \. _(9>  
     \==_)   
      -'=    



