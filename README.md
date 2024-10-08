# Lean for Functional Programmers

This is the accompanying code for "Lean for Functional Programmers", a
tutorial presented at *Mødegruppen for F#unktionelle Københavnere* by
David Thrane Christiansen on 2024-08-27 and 2024-09-24.

The code from the second presentation is available [in another
repository](https://github.com/david-christiansen/lean-fkbh-24-2).

## Overview

This tutorial has two parts: an introduction to programming and
proving in Lean, and a demonstration of using Lean to embed a small
imperative language and reason about its semantics. This repository
contains code for the first of the two.

This tutorial is aimed at introducing Lean to functional programmers
who have no background in formal verification. I'll do this in two
stages:
 1. Basics of Lean - this quick overview will demonstrate how pattern
    matching, recursion, datatypes, and other common features of
    functional languages look in Lean's syntax, as well as how to
    interact with Lean
 2. Two verified implementations of a JSON filter, one using linked
    lists and the other using efficient arrays
 
The JSON filter is a command-line tool that applies a query to a
sequence of JSON values read from standard input, writing those that
satisfy the query to standard output. As is common in high-assurance
systems, we'll be verifying the core algorithm, but not the user
interface. We'll start by verifying a version that works on linked
lists, and then proceed to one that uses packed arrays.

We won't have time to explain everything in complete detail, but we
hope that the overview we provide is a good starting point for
learning to use Lean. Please see [the documentation
section](https://lean-lang.org/documentation/) of the Lean website for
further resources. The [Lean Zulip](https://leanprover.zulipchat.com/)
is a friendly and helpful place to ask questions for both beginners
and experts.

## Preparing for the Tutorial

To prepare for the tutorial, please do the following prior to BobKonf:

1. [Install Lean](https://lean-lang.org/lean4/doc/quickstart.html)
2. Clone this repository
3. Ensure that you can build the code by running `lake build` from the
   command line
4. Ensure that your editor is correctly connected to Lean by opening
   one of the files, introducing an error, and checking that there is
   feedback

## Repository Structure

This repository is an ordinary Lean project. To get started, first
[install Lean](https://lean-lang.org/lean4/doc/quickstart.html). Then,
open the repository in a terminal and run
```
$ lake build
```
to compile it, or
```
$ lake exe jsonfilter
```
to run the executable.

### Branches

The repository contains the following branches, each a refinement of the prior one:

 - **This branch,** [`main`](https://github.com/david-christiansen/lean-fkbh-24/tree/main):
   the initial state of the example code, in which the program is only
   a stub and the tests do not pass.
 - [`step1`](https://github.com/david-christiansen/lean-fkbh-24/tree/step1):
   the code after writing the initial example programs, but before
   doing any verification. The program can pass the tests at this
   stage, though it's using linked lists where an array would be more
   appropriate.
 - [`step2`](https://github.com/david-christiansen/lean-fkbh-24/tree/step2):
   the implementation used in `step1` is proven correct
 - [`step3`](https://github.com/david-christiansen/lean-fkbh-24/tree/step3):
   the implementation is replaced with one that uses packed arrays
   instead of linked lists
 - [`step4`](https://github.com/david-christiansen/lean-fkbh-24/tree/step4):
   the array implementation is proven correct

### Code Structure

 - `Main.lean` contains the executable
 - `Filter.lean` is a library wrapper that imports (and thus implicitly re-exports) the modules:
   - `Filter/Intro.lean` - the introduction to programming in Lean
   - `Filter/List.lean` - the implementation using linked lists
   - `Filter/Array.lean` - the implementation using packed arrays
   - `Filter/Query.lean` - the query language, including its JSON syntax
     and matching queries against values (not a part of the tutorial
     _per se_, but it might be fun to read)

## Running the Tests

When the program seems to work, it can be tested using `run.sh` in the
[`tests` directory](./tests/). Please see [tests/README.md](tests/README.md) for
more information.

## Acknowledgments

This content is based on a tutorial presented at
[BobKonf](https://bobkonf.de/2024/en/) on 2024-03-15 in Berlin by
Joachim Breitner and David Thrane Christiansen, as well as a tutorial
presented at [SSFT24](https://fm.csl.sri.com/SSFT24/) by David Thrane
Christiansen.
