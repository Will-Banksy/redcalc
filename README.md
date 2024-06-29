# redcalc

A CLI calculator REPL written in Red, utilising the parse dialect (DSL) for expression parsing.

It should work, but has not been extensively tested.

## Usage

To run the script, run `make`, supplying the path to the `red` interpreter executable, e.g.:

```bash
make RED=../tools/red
```

This will start the redcalc REPL.

## Docs

Calculations are expressions that are formed of numbers, operators and functions. Syntax should be fairly intuitive.

Note that redcalc is not capable of displaying fine-grained syntax errors - Currently, it only knows there was a syntax error, not why or where it originated.

```
>>> 12*-(2/3)
= -8.0
>>> -sin(21e3)/2
= -0.49985711969854346
>>> 15 * 3! / (2 - 8)
= -15.0
>>> 2 ^ -8
= 0.00390625
>>> 4 + 8 / 2
= 8.0
```

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

Precedence follows usual rules - Postfix/prefix operators have the highest precedence, followed by the infix operators in order: ^, then */, then +-. Brackets can override precedence, as well as grouping expressions.

Infix operators:

| Operator | Description    |
| -------- | -------------- |
| `+`      | Addition       |
| `-`      | Subtraction    |
| `*`      | Multiplication |
| `/`      | Division       |
| `^`      | Exponentiation |

Postfix operators:

| Operator | Description |
| -------- | ----------- |
| `!`      | Factorial   |

Prefix operators:

| Operator | Description |
| -------- | ----------- |
| `-`      | Negation    |

### Functions

Functions currently can only have 1 argument, that is enclosed in brackets, e.g. `sin(0)`.

Trigonometric functions assume radians are used.

Supported functions:

| Function | Description       |
| -------- | ----------------- |
| `sin`    | Sine              |
| `cos`    | Cosine            |
| `tan`    | Tangent           |
| `abs`    | Absolute value    |

Additional functions can easily be added in src/eval.red/eval-func.