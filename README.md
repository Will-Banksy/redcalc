# redcalc

A badly coded CLI calculator written in Red, utilising the parse dialect (DSL) for parsing.

It mostly works but will break in some cases.

## Usage

To run the script, run `make`, supplying the path to the `red` interpreter executable, e.g.:

```bash
make RED=../tools/red
```

This will start the redcalc REPL.

## Docs

Calculations are expressions that are formed of numbers, operators and functions. Syntax should be fairly intuitive.

### Numbers

Numbers are 64-bit floating point, and can be expressed in scientific notation.

```
>>> 2
= 2.0
>>> 7.0154e10
= 70154000000.0
```

### Operators

Operators are either infix (`x + y`), postfix (`x!`) or prefix (`-x`).

Infix operators:

| Operator | Description    |
| -------- | -------------- |
| `+`      | Addition       |
| `-`      | Subtraction    |
| `*`      | Multiplication |
| `/`      | Division       |
| `^`      | Exponentiation |

Postfix operators:

| Operator | Description                              |
| -------- | ---------------------------------------- |
| `!`      | Factorial (currently unimplemented)      |

Prefix operators:

| Operator | Description |
| -------- | ----------- |
| `-`      | Negation    |

### Functions

Functions currently can only have 1 argument, that is enclosed in brackets, e.g. `sin(0)`

Supported functions:

| Function | Description |
| -------- | ----------- |
| `sin`    | Sine        |
| `cos`    | Cosine      |
| `tan`    | Tangent     |