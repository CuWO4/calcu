# CALCU

a command line based lightweight calculator

---

## PLAY

```shell
make
echo "sin(0.9) ^ [1 + 2.3! * e]
1 + 2" | debug/calcu
```

## COMPILE

```shell
make
```

Output binary will be generated in `debug/` directory.

environment:

- Ubuntu clang version 13.0.1-2ubuntu2.2
- flex 2.6.4
- bison (GNU Bison) 3.8.2

## USAGE

```shell
calcu [-h] [-p PRECISION]
```

Evaluates each input line. Default output format is %lg when no precision is specified.

## SUPPORTED OPERATION

### ​Basic Operations

`+`, `-`, `*`, `/`, `^`.

### Constants

`pi` (π ≈ 3.141592653589793), `e` (e ≈ 2.718281828459045).

### Functions

- Exponential and Logarithms
  `exp(x)`, `ln(x)` (e-based), `lg(x)` (10-based), `log(x, y)` (computes logₓ(y)).

- Trigonometric
  `sin(x)`, `cos(x)`, `tan(x)`, `csc(x)`, `sec(x)`, `cot(x)`, `asin(x)`, `acos(x)`, `atan(x)`.

- Hyperbolic
  `sinh(x)`, `cosh(x)`, `tanh(x)`, `asinh(x)`, `acosh(x)`, `atanh(x)`.

- Other
  `max(x, y)`, `min(x, y)`, `sqrt(x)`.

### ​Special Operations

- `|x|` Absolute value
- `x!` factorial, Gamma(x + 1) implementation
- `[x]` Gaussian rounding 
