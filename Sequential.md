# Sequential Matrix Multiplication

## 1. Aim

To implement matrix multiplication using sequential CPU processing and measure the execution time for a large matrix.

---

## 2. Objective

The objective of this experiment is to:

- Implement matrix multiplication using C.
- Execute the computation sequentially on the CPU.
- Measure the execution time.
- Verify the correctness of the result.
- Use the sequential implementation as the baseline for comparison with OpenMP, MPI and CUDA.

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
| Matrix Size | 4000 × 4000 |
| Optimization | `-O2` |

### WSL Status

The experiment was performed using Ubuntu on WSL2.

![WSL Status](screenshots/01_wsl_status.png.png)

---

## 5. Source Code

The sequential matrix multiplication program was implemented using C.

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 4000

int main()
{
    int i, j, k;
    double *A, *B, *C;
    clock_t start, end;

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

    start = clock();

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

    end = clock();

    printf("\nSequential Matrix Multiplication Completed\n");
    printf("Matrix Size = %d x %d\n", N, N);
    printf("Execution Time = %f seconds\n",
           (double)(end - start) / CLOCKS_PER_SEC);
    printf("Verification C[0][0] = %.2f\n", C[0]);

    free(A);
    free(B);
    free(C);

    return 0;
}
```

### Source Code Screenshot 1

![Source Code Part 1](screenshots/04_source_code_1.png.png)

### Source Code Screenshot 2

![Source Code Part 2](screenshots/05_source_code_2.png.png)

---

## 6. Creating the Experiment Directory

The experiment was performed inside:

```bash
~/parallel_lab/sequential
```

The directory was created using:

```bash
mkdir -p ~/parallel_lab/sequential
```

Then:

```bash
cd ~/parallel_lab/sequential
```

The working directory was verified using:

```bash
pwd
```

Output:

```text
/home/shreya/parallel_lab/sequential
```

### Directory Creation Screenshot

![Directory Creation](screenshots/02_create_directory.png.png)

---

## 7. Checking GCC

The GCC compiler version was checked using:

```bash
gcc --version
```

The installed compiler was:

```text
gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0
```

### GCC Version Screenshot

![GCC Version](screenshots/03_gcc_version.png.png)

---

## 8. Compilation

The C program was compiled using GCC with optimization level `-O2`:

```bash
gcc -O2 matrix_sequential.c -o matrix_sequential
```

No compilation errors were reported.

### Compilation Screenshot

![Compilation](screenshots/06_compile.png.png)

---

## 9. Checking the Executable

The generated executable was verified using:

```bash
ls -l
```

The directory contained:

```text
matrix_sequential
matrix_sequential.c
```

### Executable Screenshot

![Executable](screenshots/07_executable.png.png)

---

## 10. Execution

The program was executed using:

```bash
./matrix_sequential
```

The program initialized two 4000 × 4000 matrices and performed sequential matrix multiplication.

---

## 11. Result

The execution produced:

```text
Initializing 4000 x 4000 matrices...

Sequential Matrix Multiplication Completed
Matrix Size = 4000 x 4000
Execution Time = 97.230285 seconds
Verification C[0][0] = 4000.00
```

### Final Execution Result

![Final Result](screenshots/08_result.png.png)

### Result Table

| Parameter | Result |
|---|---:|
| Matrix Size | 4000 × 4000 |
| Execution Model | Sequential CPU |
| Execution Time | **97.230285 seconds** |
| Verification | **4000.00** |
| Status | Successful |

---

## 12. Verification

Since every element of matrices A and B is initialized to `1.0`:

\[
C[i][j] = 1+1+1+\cdots+1
\]

There are 4000 terms, therefore:

\[
C[i][j] = 4000
\]

The program produced:

```text
Verification C[0][0] = 4000.00
```

Therefore, the matrix multiplication result is correct.

---

## 13. Complexity

For an N × N matrix multiplication, the sequential algorithm uses three nested loops.

Therefore, the time complexity is:

\[
O(N^3)
\]

For N = 4000, a very large number of multiplication and addition operations are required.

---

## 14. Observation

The sequential implementation executes all matrix multiplication operations using the CPU without parallel processing.

Therefore, it requires significant execution time for a large matrix.

The measured execution time was:

**97.230285 seconds**

This value will be used as the baseline for calculating the speedup of OpenMP, MPI and CUDA implementations.

---

## 15. Conclusion

The sequential matrix multiplication program was successfully implemented and executed using C and GCC on Ubuntu through WSL2.

For a 4000 × 4000 matrix, the execution time was:

**97.230285 seconds**

The result was verified successfully with:

**C[0][0] = 4000.00**

This sequential implementation provides the baseline for comparing the performance of parallel approaches such as OpenMP, MPI and CUDA.

The experiment was completed successfully with the expected verification value.
