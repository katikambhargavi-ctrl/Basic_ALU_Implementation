# 32-bit ALU Implementation

## Overview

This project implements a **32-bit Arithmetic Logic Unit (ALU)** in Verilog HDL. The ALU performs four basic operations based on a 2-bit control signal and generates status flags for arithmetic results.

## Operations Supported

| ALU Control | Operation             |
| ----------- | --------------------- |
| `00`        | Addition (`A + B`)    |
| `01`        | Subtraction (`A - B`) |
| `10`        | Bitwise AND (`A & B`) |
| `11`        | Bitwise OR (`A \| B`) |

## Status Flags

* **Carry Flag** – Indicates carry during arithmetic operations.
* **Zero Flag** – Set when the result is zero.
* **Sign Flag** – Indicates the sign of the result (MSB).
* **Overflow Flag** – Detects signed overflow during addition and subtraction.

## Files

* `alu_4_op.v` – Verilog source code for the 32-bit ALU.
* `README.md` – Project documentation.

## Tools Used

* Verilog HDL
*  Vivado

## Internship

This project was developed as part of the **CodTech Internship** to demonstrate the design and implementation of a 32-bit ALU using Verilog HDL.
