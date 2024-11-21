# Design-and-Testing-of-Pipelined-and-Unpipelined-MAC-Unit
Design, implement, and test a Multiply-Accumulate (MAC) unit for half-precision floating-point numbers based on the IEEE 754 standard
## Overview
This project focuses on the design, implementation, and testing of Multiply-Accumulate (MAC) units for half-precision floating-point numbers adhering to the IEEE 754 standard. The MAC unit is a critical component in applications like machine learning, digital signal processing (DSP), and embedded systems.

The project explores two design approaches:

1. Unpipelined MAC: A simple, low-latency implementation.
2. Pipelined MAC: A high-performance, six-stage pipelined design optimized for throughput.

## Key Features
1. Half-Precision Floating-Point Arithmetic:
* Utilizes a 16-bit format with 1 sign bit, 5 exponent bits, and 10 mantissa bits.
* Supports a balance of precision and memory efficiency.
  
2. Unpipelined MAC:
* Performs one MAC operation per clock cycle.
* Combines a floating-point multiplier and adder into a single stage.

3. Pipelined MAC:
* Implements a six-stage pipeline for parallel processing.
* Increases throughput by producing results on every clock cycle once the pipeline is filled.

4. Parameterizable Design:
* Supports n-bit floating-point formats via Verilog's parameterization.
## Design Details
1. Unpipelined MAC:
* Multiplier: Multiplies mantissas, adjusts exponents, normalizes the result, and handles overflow/underflow.
* Adder: Aligns exponents, adds/subtracts mantissas, normalizes results, and handles edge cases.

2. Pipelined MAC:
* Pipeline Stages:
  - Extract input components and multiply mantissas.
  - Compute intermediate exponent results.
  - Normalize multiplication output.
  - Align exponents for addition.
  - Add/subtract mantissas.
  - Normalize and round final result.
## Test Cases
1. Inputs and Operations:
  0.25 + 1.125
  150 - 250
  -2.5 × -7.25
  0.0001 + 0.00000001
  1024 - 8075
  2014 × 3.75

2. Results:
* Verified correct functionality for all test cases using Vivado simulations.
* Unpipelined MAC produced results in a single clock cycle.
* Pipelined MAC achieved high throughput with results generated every clock cycle after initial latency.

## Challenges
1. Unpipelined MAC:
* Ensured proper normalization, exponent alignment, and rounding.

2. Pipelined MAC:
* Managed intermediate data across pipeline stages.
* Addressed edge cases for overflow, underflow, and denormalized numbers.
* Optimized latency and throughput.

## Comparison: Unpipelined vs. Pipelined MAC

| **Feature**    | **Unpipelined MAC**         | **Pipelined MAC**          |
|-----------------|-----------------------------|-----------------------------|
| **Latency**     | High (sequential operations) | Low (after pipeline is filled) |
| **Throughput**  | One operation per multiple cycles | One result per cycle        |
| **Complexity**  | Simple                      | Higher (multi-stage design)  |
| **Use Case**    | Low-volume or infrequent operations | High-performance and real-time tasks |


## Tools and Resources
* Hardware Description: Verilog
* Simulation and Testing: Xilinx Vivado
* Assistance: ChatGPT and other LLMs for debugging, syntax help, and optimization insights.

## Acknowledgments
Special thanks to the guidance of professors at San Jose State University and the tools provided by Xilinx. The implementation of MAC units serves as a foundation for advanced designs in signal processing and AI applications.
  
