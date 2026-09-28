# Part B - OpenMP Matrix Multiplication

## 1. Aim

To implement matrix multiplication using OpenMP parallel processing and measure the execution time using multiple CPU threads.

---

## 2. Objective

The objective of this experiment is to:

- Implement matrix multiplication using C and OpenMP.
- Execute the computation in parallel on the CPU.
- Use multiple OpenMP threads.
- Measure the execution time.
- Verify the correctness of the result.
- Compare the OpenMP implementation with the sequential implementation.

---

## 3. Problem Statement

Matrix multiplication is a computationally intensive operation.

For two matrices A and B:

\[
C = A \times B
\]

Each element of matrix C is calculated as:

\[
C[i][j] = \sum_{k=0}^{N-1} A[i][k] \times B[k][j]
\]

For this experiment:

- Matrix A = 4000 × 4000
- Matrix B = 4000 × 4000
- Matrix C = 4000 × 4000
- All elements of A = 1.0
- All elements of B = 1.0
- Number of OpenMP threads = 8

Therefore:

\[
C[i][j] = 4000
\]

Hence, the expected verification value is:

`C[0][0] = 4000.00`

---

## 4. Environment

| Component | Configuration |
|---|---|
| Operating System | Ubuntu on WSL2 |
| Compiler | GCC |
| GCC Version | 15.2.0 |
| Language | C |
| Parallel Framework | OpenMP |
| Matrix Size | 4000 × 4000 |
| Number of Threads | 8 |
| Optimization | `-O2` |

### CPU Configuration

The number of available CPU processors was checked using:

```bash
nproc
