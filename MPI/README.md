# MPI Matrix Multiplication

This folder contains an MPI distributed-memory matrix multiplication implementation based on the same 4000 x 4000 workload used in the reference project.

## Files
- `mpimatrix.c` - distributed matrix multiplication
- `sendandreceive.c` - MPI point-to-point communication test

## Compile
```bash
mpicc -O2 mpimatrix.c -o mpimatrix
mpicc -O2 sendandreceive.c -o sendandreceive
```

## Run with 4 processes
```bash
mpirun -np 4 ./mpimatrix
```

For a multi-VM cluster, use an Open MPI hostfile:
```bash
mpirun -np 4 --hostfile hosts ./mpimatrix
```

Expected verification:
`C[0][0] = 4000.00`

The implementation uses MPI_Scatter for rows of A, MPI_Bcast for B, and MPI_Gather for the result.
