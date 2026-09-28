/*
 * Parallel & GPU Computing Laboratory
 * Experiment: OpenMP Matrix Multiplication
 * Author: Shreya U.
 */

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define N 4000

int main(void) {
    const size_t total = (size_t)N * N;
    double *A = (double *)malloc(total * sizeof(double));
    double *B = (double *)malloc(total * sizeof(double));
    double *C = (double *)calloc(total, sizeof(double));

    if (!A || !B || !C) {
        fprintf(stderr, "Memory allocation failed.\n");
        free(A); free(B); free(C);
        return 1;
    }

    int threads = omp_get_max_threads();

    printf("Initializing %d x %d matrices...\n\n", N, N);

    #pragma omp parallel for
    for (size_t i = 0; i < total; ++i) {
        A[i] = 1.0;
        B[i] = 1.0;
    }

    double start = omp_get_wtime();

    #pragma omp parallel for schedule(static)
    for (int i = 0; i < N; ++i) {
        for (int k = 0; k < N; ++k) {
            const double aik = A[(size_t)i * N + k];
            for (int j = 0; j < N; ++j) {
                C[(size_t)i * N + j] += aik * B[(size_t)k * N + j];
            }
        }
    }

    double end = omp_get_wtime();

    printf("OpenMP Matrix Multiplication Completed\n");
    printf("Matrix Size = %d x %d\n", N, N);
    printf("Number of Threads Used = %d\n", threads);
    printf("Execution Time = %.6f seconds\n", end - start);
    printf("Verification C[0][0] = %.2f\n", C[0]);

    free(A);
    free(B);
    free(C);
    return 0;
}
