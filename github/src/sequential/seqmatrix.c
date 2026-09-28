#include <stdio.h>
#include <stdlib.h>
#include <time.h>

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

    clock_t start = clock();

    for (int i = 0; i < N; ++i)
        for (int j = 0; j < N; ++j)
            for (int k = 0; k < N; ++k)
                C[(size_t)i*N+j] += A[(size_t)i*N+k] * B[(size_t)k*N+j];

    clock_t end = clock();
    double seconds = (double)(end - start) / CLOCKS_PER_SEC;

    printf("Sequential Matrix Multiplication Completed\n");
    printf("Matrix Size = %d x %d\n", N, N);
    printf("Execution Time = %.6f seconds\n", seconds);
    printf("Verification C[0][0] = %.2f\n", C[0]);

    free(A); free(B); free(C);
    return 0;
}
