---
title: The Odin Programming Language Specification
warning: true
---

## Introduction

This is a reference manual for the Odin programming language.

Odin is a general-purpose language designed for systems programming. It is a strongly typed language with manual memory management. Programs are constructed from _packages_.


## Notation

The syntax is specified using Extended Backus-Naur Form (EBNF):

```
Production  = production_name "=" [ Expression ] "." .
Expression  = Alternative { "|" Alternative } .
Alternative = Term { Term } .
Term        = production_name | token [ "…" token ] | Group | Option | Repetition .
Group       = "(" Expression ")" .
Option      = "[" Expression "]" .
Repetition  = "{" Expression "}" .
```

Productions are expressions constructed from terms and the following operators, in increasing precedence:
```
|   alternation
()  grouping
[]  option (0 or 1 times)
{}  repetition (0 to n times)
```

## Source code representation

Source code is Unicode text encoded in UTF-8. The text is not canonicalized, so a single accented code point is distinct from the same character constructed from combining an accent and a letter; those are treated as two separate code points. In this document, the term _character_ will be used to refer to a Unicode code point in the source text.

Each code point is distinct; there is case sensitivity.

Implementation restriction: A compile _must_ disallow the NUL character (U+0000) in the source text.
Implementation restriction: A compile _may_ ignore a UTF-8-encoded byte order mark (U+FEFF) if it is the first Unicode code point in the source text. A byte order mark _must_ be disallowed anywhere else in the source text.


### Characters

The following terms are used to denote specific Unicode character classes:

```
newline        = /* the Unicode code point U+000A */
unicode_char   = /* an arbitrary Unicode code point except newline */
unicode_letter = /* a Unicode code point classified as "Letter" */
unicode_digit  = /* a Unicode code point classified as "Number, decimal digit" */
```

In [The Unicode Standard 8.0](https://www.unicode.org/versions/Unicode8.0.0/), Section 4.5 "General Category" defines a set of character categories. Odin treats all characters in any of the Letter categories Lu, Ll, Lt, Lm, or Lo as Unicode letters, and those in the Number category Nd as Unicode digits.

### Letters and digits

The underscore character `_` (U+005F) is considered a letter.

```
letter        = unicode_letter | "_" .
binary_digit  = "0" … "1" .
octal_digit   = "0" … "7" .
decimal_digit = "0" … "9" .
dozenal_digit = "0" … "9" | "A" … "B" | "a" … "b" .
hex_digit     = "0" … "9" | "A" … "F" | "a" … "f" .

binary_char  = binary_digit  | "_" .
octal_char   = octal_digit   | "_" .
decimal_char = decimal_digit | "_" .
dozenal_char = dozenal_digit | "_" .
hex_char     = hex_digit     | "_" .
```


## Lexical elements

### Comments

Comments serve as program documentation. There are three forms:

1. _Line comments_ start with the character sequence `//` and stop at the end of the line
2. _General comments_ start with the character sequence `/*` and stop with a pairing character sequence `*/` to allow for nested general comments
3. _Hash-bang comments_ start with the character sequence `#!` and stop at the end of the line

A comment cannot start inside a _rune_ or _string_ literal, or inside a line or hash-bang comment.

### Tokens

Tokens form the vocabulary of the Odin language. There four classes: _identifiers_, _keywords_, _operators_ and _punctuation_, and _literals_. _White space_, formed from spaces (U+0020), horizontal tabs (U+0009), carriage returns (U+000D), and new lines (U+000A), is ignored except as it separates tokens that would otherwise combine into a single token

### Semicolons

The formal grammar uses semicolons `;` as terminators. Odin programs may omit these semicolons under the following rules:

1. followed by one of the operators and punctuation on the same line: `}`, `)`
2. followed by one of the keywords on the same line: `else`
3. preceded by one of the statements: block, if, when, for, switch
4. preceded by one of the declarations: package, import, foreign import, foreign block
5. the last expression in a constant value declaration is one of the expressions followed by a new line: procedure literal
6. the last expression in a constant value declaration is one of the types followed by a new line: helper type of [6], pointer type of [6], struct type, union type, enum type, bit field type


### Identifiers

Identifiers name program entities such as variables and types. An identifier is a sequence of one or more letters and digits. The first character in an identifier must be a letter.

```
identifier = letter { letter | unicode_digit } .
```

Some identifiers are predeclared.

### Keywords

The following keywords are reserved and may not be used as identifiers
```
align_of     case        defer       enum           import    no_inline    proc       transmute    when
auto_cast    cast        distinct    fallthrough    in        notin        return     type_of
bit_field    const       do          for            inline    offset_of    size_of    typeid
bit_set      context     dynamic     foreign        macro     opaque       struct     union
break        continue    else        if             map       package      switch     using
```

Some keywords are currently not used by the language but are just reserved for future use.

### Operators and punctuation

The following character sequences represent operators (including assignment operators) and punctuation:

```
+     &     +=     &=     &&     ==    !=    (    )    #    ->
-     |     -=     |=     ||     <     <=    [    ]    @    <-
*     ~     *=     ~=     &&=    >     >=    {    }    $    =>
/     <<    /=     <<=    ||=    =     ..    ,    ;    ?    ---
%     >>    %=     >>=           !           .    :
%%    &~    %%=    &~=
```

Implementation option: A compiler may allow the following character sequences as aliases for other operators, punctuation, and keywords:

```
'≠' (U+2260) alias for '!='
'≤' (U+2260) alias for '<='
'≥' (U+2260) alias for '>='
'∈' (U+2260) alias for 'in'
'∉' (U+2260) alias for 'notin'
```

### Integer literals

An integer literal is a sequence of digits representing an integer constant. An optional prefix sets a specific radix: `0b` for binary, `0o` for octal, `0d` for decimal, `0z` for dozenal, or `0x` for hexadecimal. In dozenal literals, letters `a-b` and `A-B` represents values ten through eleven. In hexadecimal literals, letters `a-f` and `A-F` represents values ten through fifteen.

Integer literals may contain any amount of the underscore character `_` (U+005F) within the literal after the first character.

```
int_lit = binary_lit | octal_lit | decimal_lit | dozenal_lit | hex_lit
binary_lit      = "0b"   binary_digit  { binary_char } .
octal_lit       = "0o"   octal_digit   { octal_char } .
decimal_lit     = ["0d"] decimal_digit { decimal_char } .
dozenal_lit     = "0z"   dozenal_digit { dozenal_char } .
hexadecimal_lit = "0x"   hex_digit     { hex_char } .
```

```
42
042 // == 42
0b1001011
0o712
0d42
0z19b3
0xDeadBeef
210206826754181103207028761697008013415622289
210_206_826_754_181_103_207_028_761_697_008_013_415_622_289
```

### Floating-point literals

A floating-point literal is a textual representation of a floating-point constant. There are two forms of floating-point literals decimal and hexadecimal. Hexadecimal floating-point literals represent the internal integer representation of the floating-point number for that platform.


```
float_lit = decimal_float_lit | hexadecimal_float32_lit | hexadecimal_float64_lit .
decimal_float_lit = decimals "." [decimals] [exponent] |
                    decimals exponent |
                    "." decimals [exponent] .
decimals = decimal_digit { decimal_char } .
exponent = ( "e" | "E" ) [ "+" | "-" ] decimals .

hexadecimal_float32_lit = "0h" hex_digit hex_char hex_char hex_char
                          hex_char hex_char hex_char hex_char .
hexadecimal_float64_lit = "0h" hex_digit hex_char hex_char hex_char
                          hex_char hex_char hex_char hex_char
                          hex_char hex_char hex_char hex_char
                          hex_char hex_char hex_char hex_char .
```

```
0.
0.0
42.36
042.36  // == 42.36
6.28318530718
1.e+0
1.054571800e-34
1.054_571_800e-34
1E9
.125
.12345e+5
```

### Imaginary literals

An imaginary literal is a decimal representation of the imaginary part of a complex constant. It consists of a floating-point literal or a decimal integer followed by the lower-case letter `i`.

```
imaginary_lit = (decimals | float_lit) "i" .
```
```
0.i
0.0i
42.36i
042.36i  // == 42.36i
6.28318530718i
1.e+0i
1.054571800e-34i
1.054_571_800e-34i
1E9i
.125i
.12345e+5i
```

### Rune literals

A rune literal represents a rune constant, an integer value identifying a Unicode code point. A rune literal is expressed as one or more characters enclosed in single quotes, such as `'b'` or `'\t'`.

TODO:


```
\a   U+0007 alert or bell
\b   U+0008 backspace
\e   U+001b escape
\f   U+000C form feed
\n   U+000A newline or line feed
\r   U+000D carriage return
\t   U+0009 horizontal tab
\v   U+000b vertical tab
\\   U+005c backslash
\'   U+0027 single quote  (valid escape only within rune literals)
\"   U+0022 double quote  (valid escape only within string literals)
```

```
rune_lit         = "'" ( unicode_value | byte_value ) "'" .
unicode_value    = unicode_char | little_u_value | big_u_value | escaped_char .
byte_value       = octal_byte_value | hex_byte_value .
octal_byte_value = `\` octal_digit octal_digit octal_digit .
hex_byte_value   = `\` "x" hex_digit hex_digit .
little_u_value   = `\` "u" hex_digit hex_digit hex_digit hex_digit .
big_u_value      = `\` "U" hex_digit hex_digit hex_digit hex_digit
                           hex_digit hex_digit hex_digit hex_digit .
escaped_char     = `\` ( "a" | "b" | "e" | f" | "n" | "r" | "t" | "v" | `\` | "'" | `"` ) .
```

### String literals

TODO:

```
string_lit             = raw_string_lit | interpreted_string_lit .
raw_string_lit         = "`" { unicode_char | newline } "`" .
interpreted_string_lit = `"` { unicode_value | byte_value } `"` .
```

## Constants

## Variables

## Types

A type determines a set of values together with operations specific to those values. A type may be denoted by a _type name_, if it has one, or a specified using a _type literal_, which composing a type from other existing types.

```
Type       = TypeName | TypeLit | "(" Type ")" | HelperType .
TypeName   = identifier | QualifiedIdent .
TypeLit    = ArrayType | SliceType | DynamicArrayType | StructType | UnionType |
             PointerType | ProcedureType | MapType | EnumType |
             BitSetType | BitFieldType | OpaqueType | HelperType
```


### Boolean types

A boolean type represents the set of boolean truth values denoted by the predeclared constants `true` and `false`. The predeclared architecture-independent boolean types are:

```
bool    1 byte boolean type

b8      8-bit  boolean type
b16     16-bit boolean type
b32     32-bit boolean type
b64     64-bit boolean type
```

### Numeric types

A numeric type represents sets of integer, floating-point, or rune values. The predeclared architecture-independent numeric types are:

```
u8          the set of all unsigned  8-bit integers (0 to 255)
u16         the set of all unsigned 16-bit integers (0 to 65535)
u32         the set of all unsigned 32-bit integers (0 to 4294967295)
u64         the set of all unsigned 64-bit integers (0 to 18446744073709551615)

i8          the set of all signed  8-bit integers (-128 to 127)
i16         the set of all signed 16-bit integers (-32768 to 32767)
i32         the set of all signed 32-bit integers (-2147483648 to 2147483647)
i64         the set of all signed 64-bit integers (-9223372036854775808 to 9223372036854775807)

f32         the set of all IEEE-754 32-bit floating-point numbers
f64         the set of all IEEE-754 64-bit floating-point numbers

complex64   the set of all complex numbers with float32 real and imaginary parts
complex128  the set of all complex numbers with float64 real and imaginary parts

byte        alias for u8
rune        the set of all Unicode code points represented by a 32-bit integer (-2147483648 to 2147483647)
```

The value of an n-bit integer is n bits wide and represented using two's complement arithmetic.

There is also a set of architecture-independent numeric types with a specified endianess:
```
u16le       little endian representation of the set of all unsigned 16-bit integers (0 to 65535)
u32le       little endian representation of the set of all unsigned 32-bit integers (0 to 4294967295)
u64le       little endian representation of the set of all unsigned 64-bit integers (0 to 18446744073709551615)

i16le       little endian representation of the set of all signed 16-bit integers (-32768 to 32767)
i32le       little endian representation of the set of all signed 32-bit integers (-2147483648 to 2147483647)
i64le       little endian representation of the set of all signed 64-bit integers (-9223372036854775808 to 9223372036854775807)

u16be       big endian representation of the set of all unsigned 16-bit integers (0 to 65535)
u32be       big endian representation of the set of all unsigned 32-bit integers (0 to 4294967295)
u64be       big endian representation of the set of all unsigned 64-bit integers (0 to 18446744073709551615)

i16be       big endian representation of the set of all signed 16-bit integers (-32768 to 32767)
i32be       big endian representation of the set of all signed 32-bit integers (-2147483648 to 2147483647)
i64be       big endian representation of the set of all signed 64-bit integers (-9223372036854775808 to 9223372036854775807)
```


There is also a set of predeclared numeric types with implementation-specific sizes:
```
uintptr     an unsigned integer large enough to store the uninterpreted bits of a pointer value
uint        same size as uintptr
int         same size as uint
```

To avoid portability issues for all numeric types are defined types and thus distinct, except `byte` which is an alias for `u8`. Explicit conversions are required when different numeric types are mixed in an expression or assignment. For instance, `i64` and `int` are not the same type even though they may have the same size on a particular machine.


### String types

A _string_ type represents the set of string values. A string value is a (possibly empty) sequence of bytes. The number of bytes is called the length of the string and is a non-negative integer.

The predeclared strings types are:
```
string
cstring
```

The length of a string `s` can be determined using the built-in procedure `len`. The length is a compile-time constant if the string is a constant. A string's bytes can only be accessed, for string types not derived from `cstring`, by integer indices 0 through `len(s)-1`.

### Array types

An array is a numbered sequence of elements of a single type, called the element type. The number of element is a called the length of the array and is a non-negative integer.

```
ArrayType   = "[" ArrayLength "]" ElementType .
ArrayLength = Expression .
ElementType = Type .
```

The length is part of the array's type; it must evaluate to a non-negative constant representable by a value of type `int`. The length of array `a` be determined using the built-in procedure `len`. The elements can be address by indices 0 through `len(a)-1`. Array types are always one-dimensional but may be composed to form multi-dimensional types.

```
[32]byte
[2*N]union{int, string}
[42]^f32
[2][3]int
[3][3][3]f64 // same as [3]([3]([3]f64))
```

### Slice types
### Dynamic array types
### Struct types
### Union types
### Pointer types
TODO: `rawptr`
### Procedure types
### Map types
### Enum types
### Bit set types
### Bit field types
### Opaque types
### Helper types
### Any type
### Typeid
### Other
#### SIMD types

## Properties of types and values

### Type identity
### Assignability
### Representability


## Blocks

A _block_ is a possibly empty sequence of declarations and statements within matching brace brackets.

```
Block = "{" StatementList "}" .
StatementList = { Statement ";" } .
```

In addition to explicit blocks in the source text, there are implicit blocks:

1. The _universal block_ encompasses all Odin source text.
2. Each package has a _package block_ containing all Odin source text for that package.
3. Each file has a _file block_ containing all Odin source text in that file.
4. Each "if", "for", "switch" statement is considered to be in its own implicit block.

Blocks nest and influence scoping.

## Declarations and scope

### Label scopes

Labels are declared by labeled statements and used in the "break" and "continue" statements. In contrast to other identifiers, labels are not block scoped. The scope of the label is the body of the procedure in which it is declared and excludes the body of any nested procedure.

### Blank identifier

### Predeclared identifiers

```
Types:
	bool b8 b16 b32 b64
	byte complex64 complex128
	f32 f64
	int i8 i16 i32 i64
	i16le i32le i64le i16be i32be i64be

	uint uintptr u8 u16 u32 u64
	u16le u32le u64le u16be u32be u64be

	any rawptr

	rune string cstring

Constants:
	true false

Zero value:
	nil

Procedures:
	len cap
	complex real imag conj
	swizzle expand_to_tuple
	min max abs clamp

```

## Attributes

## Expressions

### Operands
### Qualified identifiers
### Composite literals
### Procedure literals
### Selectors
#### Implicit selector
### Index expressions
### Slice expressions
### Type assertions
### Calls
### Passing argument to variadic parameters
### Operators

### Operators
#### Operator precedence

Unary operators have the highest precedence.

There are eight precedence levels for binary operators.

```
Precedence     Operator
    8              & / % %% << >> & &~
    7              + - | ~
    6              'in' 'notin'
    5              == != < <= > >=
    4              &&
    3              ||
    2              .. // If allowed
    1              ? // Ternary expression
```

Binary operators of the same precedence associate from left to right. For instance, `x / y * z` is the same as `(x / y) * z`.

### Arithmetic operators

```
+    sum                    integers, floats, complex values, constant strings values
-    difference             integers, floats, complex values
*    product                integers, floats, complex values
/    quotient               integers, floats, complex values
%    modulo dividend        integers
%%   modulo divisor         integers

&    bitwise AND            integers
|    bitwise OR             integers
~    bitwise XOR            integers
&~   bit clear (AND NOT)    integers

<<   left shift             integer << unsigned integer
>>   right shift            integer >> unsigned integer
```

Arithmetic operators also work on fixed-length arrays of numeric types.


#### Integer operators:
For two integer values `x` and `y`, the integer quotient `q = x / y` and remainder `r = x % y` satisfy the following relationships:

```
x = q*y + r    and    |r| < |y|
```

with `x / y` truncated towards zero ("[truncated division](https://wikipedia.org/wiki/Modulo_operation)").

### Logical operators
### Address operators
### Conversion
A conversion changes the type of an expression to the type specified by the conversion. A conversion may appear literally in the source, or it may be implied by the context in which an expression appears.

An _explicit_ conversion is an expression of the form `T(x)` or `cast(T)x` where `T` is a type and `x` is an expression that can be converted to type `T`.
```
Conversion = CallConversion | CastConversion .
CallConversion = Type "(" Expression [ ", "] ")" .
CastConversion = "cast" "(" Type ")" Expression .
```

#### Transmute

### Constant expressions
### Order of evaluation

## Statements
### Labelled statements
### Expression statements
### Assignments
### If statements
### Switch statements
### For statements
### Return statements
### Break statements
### Continue statements
### Fallthrough statements
### Defer statements

## Built-in procedures
### Length and capacity
### Manipulating complex numbers
### Numeric bounds
### Directive based
### Other

## Packages
### Source file organization
### Package clause
### Import declaration

## Foreign system

## Implicit context system

## Parametric polymorphism

## Initialization and execution

## System considerations
