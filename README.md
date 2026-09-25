# Parallel-and-GPU-Computing

## Experiments

### 1. Sequential Matrix Multiplication

A baseline matrix multiplication implementation using sequential CPU
execution.

[View Sequential Experiment](./Sequential.md)

### 2. OpenMP Matrix Multiplication

A shared-memory parallel implementation using OpenMP and multiple CPU
threads.

[View OpenMP Experiment](./OpenMP.md)

### 3. MPI Matrix Multiplication

A distributed-memory implementation using MPI across multiple processes and virtual machines.

[View MPI Experiment](./MPI.md)

### 4. CUDA Matrix Multiplication

A GPU-based implementation using CUDA for parallel matrix multiplication.

[View CUDA Experiment](./CUDA.md)

## Problem Definition

The matrix multiplication experiment uses:

- Matrix A: 4000 × 4000
- Matrix B: 4000 × 4000
- Matrix C: A × B
- Matrix elements: 1.0
- Expected verification: C[0][0] = 4000.00

## Technologies Used

- C
- GCC
- Ubuntu
- WSL2
- OpenMP
- MPI
- CUDA

## Repository Structure

```text
Parallel-and-GPU-Computing/
│
├── README.md
├── Sequential.md
├── OpenMP.md
├── MPI.md
└── CUDA.md

