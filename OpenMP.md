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

## 5. Source Code

The OpenMP matrix multiplication program was implemented using C.

The OpenMP library was included using:
```c
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define N 4000

int main()
{
    int i, j, k;
    double *A, *B, *C;
    double start, end;

    A = (double *)malloc(N * N * sizeof(double));
    B = (double *)malloc(N * N * sizeof(double));
    C = (double *)malloc(N * N * sizeof(double));

    if (A == NULL || B == NULL || C == NULL)
    {
        printf("Memory allocation failed\n");
        return 1;
    }

    printf("Initializing %d x %d matrices...\n", N, N);

    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            A[i * N + j] = 1.0;
            B[i * N + j] = 1.0;
            C[i * N + j] = 0.0;
        }
    }

    start = omp_get_wtime();

    #pragma omp parallel for private(j, k)
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            for (k = 0; k < N; k++)
            {
                C[i * N + j] +=
                    A[i * N + k] *
                    B[k * N + j];
            }
        }
    }

    end = omp_get_wtime();

    printf("\nOpenMP Matrix Multiplication Completed\n");
    printf("Matrix Size = %d x %d\n", N, N);
    printf("Number of Threads Used = %d\n", omp_get_max_threads());
    printf("Execution Time = %f seconds\n", end - start);
    printf("Verification C[0][0] = %.2f\n", C[0]);

    free(A);
    free(B);
    free(C);

    return 0;
}
```
### Source Code Screenshot – Part 1

![Source Code Part 1](screenshots/openmp/04_openmp_source_code_1.png)

### Source Code Screenshot – Part 2

![Source Code Part 2](screenshots/openmp/05_openmp_source_code_2.png)

---

## 6. Creating the Experiment Directory

The experiment was performed inside:

~/parallel_lab/openmp

The directory was created using:

mkdir -p ~/parallel_lab/openmp

Then the directory was opened using:

cd ~/parallel_lab/openmp

The working directory was verified using:

pwd

Output:

/home/shreya/parallel_lab/openmp

### Directory Creation Screenshot

![Directory Creation](screenshots/openmp/03_openmp_directory.png)

---

## 7. Checking GCC

The GCC compiler version was checked using:

gcc --version

The installed compiler was:

gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0

### GCC Version Screenshot

![GCC Version](screenshots/openmp/01_nproc.png)

---

## 8. Compilation

The OpenMP program was compiled using GCC with optimization level -O2 and OpenMP support:

gcc -O2 -fopenmp matrix_openmp.c -o matrix_openmp

Here:

- gcc is the GNU C compiler.
- -O2 enables compiler optimization.
- -fopenmp enables OpenMP support.
- matrix_openmp.c is the source file.
- -o matrix_openmp creates the executable.

No compilation errors were reported.

### Compilation Screenshot

![OpenMP Compilation](screenshots/openmp/06_openmp_result.png)


---

## 9. Checking the Executable

The generated executable was verified using:

ls -l

The directory contained:

matrix_openmp
matrix_openmp.c

This confirmed that the program was compiled successfully.


## 10. Execution

The program was executed using:

./matrix_openmp

The program initialized two 4000 × 4000 matrices and performed matrix multiplication using OpenMP parallel processing.

The computation was distributed among 8 OpenMP threads.

### OpenMP Threads Screenshot

![OpenMP Threads](screenshots/openmp/02_omp_threads.png)

---

## 11. Result

The execution produced:

Initializing 4000 x 4000 matrices...

OpenMP Matrix Multiplication Completed
Matrix Size = 4000 x 4000
Number of Threads Used = 8
Execution Time = 55.536384 seconds
Verification C[0][0] = 4000.00

### Final Execution Result Screenshot

![OpenMP Final Result](screenshots/openmp/06_openmp_result.png)

### Result Table

| Parameter | Result |
|---|---:|
| Matrix Size | 4000 × 4000 |
| Execution Model | OpenMP Parallel CPU |
| Number of Threads | **8** |
| Execution Time | **55.536384 seconds** |
| Verification | **4000.00** |
| Status | Successful |

---

## 12. Verification

Since every element of matrices A and B is initialized to 1.0:

C[i][j] = 1 + 1 + 1 + ... + 1

There are 4000 terms, therefore:

C[i][j] = 4000

The program produced:

Verification C[0][0] = 4000.00

Therefore, the matrix multiplication result is correct.

---

## 13. Complexity

For an N × N matrix multiplication, the OpenMP algorithm uses three nested loops.

Therefore, the time complexity is:

O(N^3)

For N = 4000, a very large number of multiplication and addition operations are required.

OpenMP does not change the algorithmic complexity. Instead, it improves the practical execution time by executing independent loop iterations in parallel.

---

## 14. Observation

The OpenMP implementation executes matrix multiplication using multiple CPU threads.

The parallel for directive distributes the iterations of the outer loop among the available OpenMP threads.

For the 4000 × 4000 matrix:

- Number of OpenMP threads = **8**
- OpenMP execution time = **55.536384 seconds**
- Verification value = **4000.00**

The OpenMP implementation required less execution time than the sequential implementation.

The sequential implementation took **97.230285 seconds**, while the OpenMP implementation took **55.536384 seconds**.

---

## 15. Comparison with Sequential Execution

The sequential implementation took:

**97.230285 seconds**

The OpenMP implementation took:

**55.536384 seconds**

The speedup is calculated as:

Speedup = Sequential Time / OpenMP Time

Speedup = 97.230285 / 55.536384

Speedup ≈ 1.75

Therefore, the OpenMP implementation achieved approximately **1.75× speedup** compared with the sequential implementation.

### Comparison Table

| Implementation | Threads | Execution Time |
|---|---:|---:|
| Sequential CPU | 1 | 97.230285 seconds |
| OpenMP | 8 | 55.536384 seconds |

---

## 16. Conclusion

The OpenMP matrix multiplication program was successfully implemented and executed using C, GCC and OpenMP on Ubuntu through WSL2.

For a 4000 × 4000 matrix, the OpenMP implementation used 8 threads and achieved an execution time of:

**55.536384 seconds**

The result was verified successfully with:

**C[0][0] = 4000.00**

Compared with the sequential execution time of **97.230285 seconds**, OpenMP achieved an approximate speedup of **1.75×**.

Therefore, parallel processing using OpenMP improves the execution performance of large matrix multiplication compared with sequential CPU execution.

The experiment was completed successfully with the expected verification value.
---


