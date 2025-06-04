# QuadraticOutputSystems.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://Jonas-Nicodemus.github.io/QuadraticOutputSystems.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://Jonas-Nicodemus.github.io/QuadraticOutputSystems.jl/dev/)
[![Build Status](https://github.com/Jonas-Nicodemus/QuadraticOutputSystems.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Jonas-Nicodemus/QuadraticOutputSystems.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![codecov](https://codecov.io/gh/Jonas-Nicodemus/QuadraticOutputSystems.jl/graph/badge.svg?token=qB5KL7XBfY)](https://codecov.io/gh/Jonas-Nicodemus/QuadraticOutputSystems.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

A package for linear control systems with quadratic output in Julia.

The considered systems are of the form

```math
    \Sigma\quad\left\{\quad\begin{aligned}
		\dot{x}(t) &= Ax(t) + Bu(t),\\
		y(t) &= Cx(t) + 
        \left[
        \begin{array}{c}
            x(t)^\top M_1 x(t)\\
            \vdots \\ 
            x(t)^\top M_p x(t)
        \end{array}
        \right]
	\end{aligned}\right..
```
The output can be written as
```math
    y(t) = Cx(t) + M(x(t)\otimes x(t)), \quad \text{with} \quad
    M:= 
    \left[\begin{array}{c}
        \mathrm{vec}(M_1)^\top\\
        \vdots\\
        \mathrm{vec}(M_p)^\top
    \end{array}\right]
    \in \mathbb{R}^{p \times n^2}.
```

This package is based and inspired by [ControlSystems.jl](https://github.com/JuliaControl/ControlSystems.jl) and implements some of the results from the paper [Gramians, Energy Functionals, and Balanced Truncation for Linear Dynamical Systems With Quadratic Outputs](https://ieeexplore.ieee.org/abstract/document/9446632).

## Installation

To install, in the Julia REPL:

```julia
using Pkg; Pkg.add(url="https://github.com/Jonas-Nicodemus/QuadraticOutputSystems.jl")
```
## Documentation

Some of the available commands are:
##### Constructing systems
`qoss`
##### Analysis
`norm, h2norm, h2inner, gram`
##### Time response
`lsim`

### Example

```julia
using QuadraticOutputSystems, ControlSystems

A = [-2 1; -1 -1]
B = [6; 0]
C = [6 0]
M = 1//2*vec([1 0; 0 1])'

Σ = qoss(A, B, C, M)
# This generates the system:
# QuadraticOutputStateSpace{Rational{Int64}}
# A = 
#  -2//1   1//1
#  -1//1  -1//1
# B = 
#  6//1
#  0//1
# C = 
#  6//1  0//1
# M = 
#  1//2  0//1  0//1  1//2

# Compute the Gramians of the system
gram(Σ, :c)
gram(Σ, :o)

# Compute the H2-norm of the system
h2norm(Σ) # 17.521415467935235

# Given a second system Σr, we can compute the H2-inner product and the H2-error
Σr = qoss(A[1,1], B[1], C[1], M[1])

h2inner(Σ, Σr) # 318.2485207100592
h2norm(Σ - Σr)^2 # 14.75295857988162
h2norm(Σ)^2 + h2norm(Σr)^2 - 2*h2inner(Σ, Σr) # 14.75295857988162
```
