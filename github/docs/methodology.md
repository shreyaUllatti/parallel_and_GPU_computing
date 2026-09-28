# Methodology

## 1. Common workload

All four implementations use the same conceptual workload:

- `N = 4000`
- `A = 1.0`
- `B = 1.0`
- `C = A × B`
- correctness check: `C[0][0] = 4000.00`

## 2. Execution models

### Sequential
Three nested loops run on one CPU execution stream.

### OpenMP
The outer row loop is distributed using `#pragma omp parallel for`. Threads share A, B and C in one memory space.

### MPI
Rows of A are distributed using `MPI_Scatter`; B is replicated with `MPI_Bcast`; computed C rows are returned with `MPI_Gather`.

### CUDA
A GPU kernel maps one thread to one output cell. A 16×16 block is used and the grid dimensions are calculated from N.

## 3. Performance interpretation

The measured sequential and OpenMP times in the README are from the project execution. MPI and CUDA should be reported only after actual execution in the required environment.

CPU and GPU runtimes should not be treated as perfectly controlled comparisons when hardware differs.
