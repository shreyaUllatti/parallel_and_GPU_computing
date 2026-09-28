#include <stdio.h>
#include <mpi.h>

int main(int argc, char *argv[])
{
    int rank, size;
    int value = 10;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (size < 2)
    {
        if (rank == 0)
            printf("Run this test with at least 2 MPI processes.\n");
        MPI_Finalize();
        return 0;
    }

    if (rank == 0)
    {
        MPI_Send(&value, 1, MPI_INT, 1, 0, MPI_COMM_WORLD);
        printf("Rank 0 sent value %d to Rank 1\n", value);
    }
    else if (rank == 1)
    {
        int received = 0;
        MPI_Recv(&received, 1, MPI_INT, 0, 0,
                 MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        printf("Rank 1 received value %d from Rank 0\n", received);
    }

    MPI_Finalize();
    return 0;
}
