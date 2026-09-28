#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define N 4000

int main(void) {
    size_t total = (size_t)N * N;
    double *A = malloc(total * sizeof(double));
    double *B = malloc(total * sizeof(double));
    double *C = calloc(total, sizeof(double));

    if (!A || !B || !C) {
        fprintf(stderr, "Memory allocation failed\n");
        free(A); free(B); free(C);
        return 1;
    }

    for (size_t i = 0; i < total; ++i) {
        A[i] = 1.0;
        B[i] = 1.0;
    }

    omp_set_num_threads(8);
    double start = omp_get_wtime();

    #pragma omp parallel for
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            double sum = 0.0;
            for (int k = 0; k < N; ++k)
                sum += A[(size_t)i*N+k] * B[(size_t)k*N+j];
            C[(size_t)i*N+j] = sum;
        }
    }

    double end = omp_get_wtime();

    printf("OpenMP Matrix Multiplication Completed\n");
    printf("Matrix Size = %d x %d\n", N, N);
    printf("Number of Threads = %d\n", omp_get_max_threads());
    printf("Execution Time = %.6f seconds\n", end - start);
    printf("Verification C[0][0] = %.2f\n", C[0]);

    free(A); free(B); free(C);
    return 0;
}
