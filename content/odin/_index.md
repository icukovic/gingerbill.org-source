---
title: Odin Programming Language
hide_title: true
---
<center>
<a href="//odin-lang.org">
<div style="width: 20em"><img alt="Odin Programming Language" src="/images/odin/logo-slim.png"></div>
</a>
</center>

# The Odin Programming Language

The Odin programming language is fast, concise, readable, pragmatic and open sourced. It is designed with the intent of replacing C with the following goals:

* simplicity
* high performance
* built for modern systems
* joy of programming

<br>

Website: <https://odin.handmade.network/><br>
GitHub:  <https://github.com/odin-lang/Odin>


## Documentation

* [Tutorial](https://odin.handmade.network/wiki/3329-odin_tutorial)
* [Frequently Asked Questions](https://github.com/odin-lang/Odin/wiki/Frequently-Asked-Questions-(FAQ))
* [Work-in-Progress Language Specification](/odin/spec/)

## User Libraries

* [Odin Libs](https://github.com/odin-lang/odin-libs)

## Example

```odin
package main

import "core:fmt"

main :: proc() {
	program := "+ + * 😃 - /";
	accumulator := 0;

	for token in program {
		switch token {
		case '+': accumulator += 1;
		case '-': accumulator -= 1;
		case '*': accumulator *= 2;
		case '/': accumulator /= 2;
		case '😃': accumulator *= accumulator;
		case: // Ignore everything else
		}
	}

	fmt.printf("The program \"%s\" calculates the value %d\n",
	           program, accumulator);
}
```

## Demonstrations
* First Talk & Demo
	- [Talk](https://youtu.be/TMCkT-uASaE?t=338)
	- [Demo](https://youtu.be/TMCkT-uASaE?t=1800)
	- [Q&A](https://youtu.be/TMCkT-uASaE?t=5749)
* [Composition & Refactorability](https://www.youtube.com/watch?v=n1wemZfcbXM)
* [Introspection, Modules, and Record Layout](https://www.youtube.com/watch?v=UFq8rhWhx4s)
* [push_allocator & Minimal Dependency Building](https://www.youtube.com/watch?v=f_LGVOAMb78)
* [when, for & procedure overloading](https://www.youtube.com/watch?v=OzeOekzyZK8)
* [Context Types, Unexported Entities, Labelled Branches](https://www.youtube.com/watch?v=CkHVwT1Qk-g)
* [Bit Fields, i128 & u128, Syntax Changes](https://www.youtube.com/watch?v=NlTutcLyF64)
* [Default and Named Arguments; Explicit Parametric Polymorphism](https://www.youtube.com/watch?v=-XQZE6S6zUU)
* [Loadsachanges](https://www.youtube.com/watch?v=ar0vFMoMtrI)
* [Packages, Bit Sets, cstring](https://youtu.be/b8bJbjiXZrQ)
	- [Q&A](https://youtu.be/5jmxyIfyyTk)
