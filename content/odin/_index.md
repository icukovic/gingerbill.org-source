---
title: Odin Programming Language
hide_title: true
---
<center>
<a href="//odin-lang.org">
	<div style="width: 20em"><img alt="Odin Programming Language" src="/images/odin/logo-slim.png"></div>
</a>

<p>A fast, concise, readable, pragmatic and open sourced programming language.</p>
<br>
<p>
	<a class="github-button" href="https://github.com/odin-lang" aria-label="Follow @odin-lang on GitHub">Follow @odin-lang</a>
	<a class="github-button" href="https://github.com/odin-lang/Odin" data-size="small" aria-label="Star odin-lang/Odin on GitHub">Star</a>
	<a class="github-button" href="https://github.com/odin-lang/Odin/subscription" aria-label="Watch odin-lang/Odin on GitHub">Watch</a>
</p>
<p>
	<a href="https://github.com/odin-lang/odin/releases/latest">
		<img src="https://img.shields.io/github/release/odin-lang/odin.svg">
	</a>
	<a href="https://github.com/odin-lang/odin/releases/latest">
		<img src="https://img.shields.io/badge/platforms-Windows%20|%20Linux%20|%20macOS-green.svg">
	</a>
	<a href="https://github.com/odin-lang/odin/blob/master/LICENSE">
		<img src="https://img.shields.io/github/license/odin-lang/odin.svg">
	</a>
</p>
</center>

# The Odin Programming Language


The Odin programming language is fast, concise, readable, pragmatic and open sourced. It is designed with the intent of replacing C with the following goals:

* simplicity
* high performance
* built for modern systems
* joy of programming

<br>

<table>
<tbody>
<tr><td>Website:</td><td><a href="https://odin-lang.org">https://odin-lang.org</a></td></tr>
<tr><td>GitHub:</td> <td><a href="https://github.com/odin-lang/Odin">https://github.com/odin-lang/Odin</a></td></tr>
<tr><td>Discord:</td><td><a href="https://discord.gg/sVBPHEv">Discord Server</a></td></tr>
</tbody>
</table>

</table>

## Documentation

* [Documentation](/odin/docs/)
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


<script async defer src="/js/github-buttons.js"></script>
