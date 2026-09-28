#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#define N 4000

int main(int argc, char **argv) {
    int rank, size;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (N % size != 0) {
        if (rank == 0)
            fprintf(stderr, "N must be divisible by the number of MPI processes.\n");
        MPI_Finalize();
        return 1;
    }

    int rows = N / size;
    size_t local_cells = (size_t)rows * N;
    size_t full_cells = (size_t)N * N;

    double *A = NULL, *C = NULL, *B = malloc(full_cells * sizeof(double));
    double *local_A = malloc(local_cells * sizeof(double));
    double *local_C = calloc(local_cells, sizeof(double));

    if (rank == 0) {
        A = malloc(full_cells * sizeof(double));
        C = calloc(full_cells, sizeof(double));
        if (A) for (size_t i = 0; i < full_cells; ++i) A[i] = 1.0;
        if (B) for (size_t i = 0; i < full_cells; ++i) B[i] = 1.0;
    } else {
        for (size_t i = 0; i < full_cells; ++i) B[i] = 1.0;
    }

    MPI_Barrier(MPI_COMM_WORLD);
    double start = MPI_Wtime();

    MPI_Scatter(A, (int)local_cells, MPI_DOUBLE,
                local_A, (int)local_cells, MPI_DOUBLE, 0, MPI_COMM_WORLD);
    MPI_Bcast(B, (int)full_cells, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    for (int i = 0; i < rows; ++i)
        for (int j = 0; j < N; ++j) {
            double sum = 0.0;
            for (int k = 0; k < N; ++k)
                sum += local_A[(size_t)i*N+k] * B[(size_t)k*N+j];
            local_C[(size_t)i*N+j] = sum;
        }

    MPI_Gather(local_C, (int)local_cells, MPI_DOUBLE,
               C, (int)local_cells, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    double end = MPI_Wtime();

    if (rank == 0) {
        printf("MPI Matrix Multiplication Completed\n");
        printf("Matrix Size = %d x %d\n", N, N);
        printf("MPI Processes = %d\n", size);
        printf("Execution Time = %.6f seconds\n", end - start);
        printf("Verification C[0][0] = %.2f\n", C[0]);
    }

    free(A); free(B); free(C); free(local_A); free(local_C);
    MPI_Finalize();
    return 0;
}
