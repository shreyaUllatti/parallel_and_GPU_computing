# Parallel-and-GPU-Computing

## Experiments
## Matrix Multiplication using Sequential Processing, OpenMP and MPI

## INTRODUCTION :
This project demonstrates different approaches for performing large-scale matrix multiplication using parallel and distributed computing techniques.

The same matrix multiplication problem is implemented using:

Sequential C programming
OpenMP for shared-memory parallel processing
MPI for distributed-memory processing

The purpose of the project is to understand how parallel and distributed computing can improve the execution of computationally intensive problems.

## AIM:
To implement matrix multiplication using sequential processing, OpenMP and MPI, and study the difference in execution and parallel processing between these approaches.

## PROBLEM STATEMENT :

Matrix multiplication is a computationally intensive operation, especially when the matrix size is large.
For two matrices A and B, the resulting matrix C is calculated as:
C = A × B

- Matrix A: 4000 × 4000
- Matrix B: 4000 × 4000
  
Each element of the result matrix is calculated as:

C[i][j] = Σ A[i][k] × B[k][j]

For this project, matrices of size:
4000 × 4000 are used.

All elements of matrices A and B are initialized to:
1.0

Therefore, every element of the resulting matrix should be:
4000.00

For verification:
C[0][0] = 4000.00

### 1. Sequential Matrix Multiplication

A baseline matrix multiplication implementation using sequential CPU
execution.

[View Sequential Experiment](./Sequential.md)

The sequential version uses three nested loops for matrix multiplication.
The general logic is:

for each row i
    for each column j
        for each k
            C[i][j] = C[i][j] + A[i][k] × B[k][j]

Since there is no parallel processing, the operations are executed sequentially by the CPU.
Compilation
gcc sequential.c -o sequential
Execution
./sequential
Verification

The result is verified using:C[0][0] = 4000.00
The sequential execution time is used as the baseline for comparison with the parallel implementations.

### 2. OpenMP Matrix Multiplication

A shared-memory parallel implementation using OpenMP and multiple CPU
threads.

[View OpenMP Experiment](./OpenMP.md)

OpenMP is used to parallelize the matrix multiplication on the CPU.

The outer loop is parallelized so that different threads can work on different rows of the matrix.
The OpenMP implementation uses:
#pragma omp parallel for
Compilation
gcc -fopenmp openmp.c -o openmp
Set Number of Threads
 to use 8 threads:
export OMP_NUM_THREADS=8
Execute
./openmp
Verify Number of Threads
echo $OMP_NUM_THREADS
Verification

The result should still be:C[0][0] = 4000.00
The main purpose of OpenMP is to reduce the execution time by allowing multiple CPU threads to perform calculations simultaneously.

### 3. MPI Matrix Multiplication

A distributed-memory implementation using MPI across multiple processes and virtual machines.

[View MPI Experiment](./MPI.md) 

MPI is used for distributed-memory parallel processing.
The project uses multiple virtual machines in a Master-Worker configuration.
The general structure is:

             Master
             Rank 0
                |
       ----------|----------
       |         |         |
       ↓         ↓         ↓
    Worker 1  Worker 2  Worker 3
     Rank 1    Rank 2    Rank 3


The MPI implementation demonstrates how a computational problem can be distributed among multiple processes and machines.

### 4. CUDA Matrix Multiplication

A GPU-based implementation using CUDA for parallel matrix multiplication.

[View CUDA Experiment](./CUDA.md)

## Performance Analysis

The main purpose of the experiment is to observe how execution changes when parallel processing is introduced.

The sequential implementation provides the baseline.

OpenMP uses multiple CPU threads, while MPI distributes work between multiple processes and machines.

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




