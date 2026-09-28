# MPI Matrix Multiplication

**Author:** Shreya U.

MPI uses distributed-memory parallelism. Matrix rows are divided among MPI processes. Matrix `B` is broadcast and each process computes its assigned rows of `C`.

## Install MPI on Ubuntu/WSL

```bash
sudo apt update
sudo apt install openmpi-bin libopenmpi-dev -y
```

## Compile

```bash
mpicc -O2 matrix_mpi.c -o matrix_mpi
```

## Run with 4 processes

```bash
mpirun --allow-run-as-root -np 4 ./matrix_mpi
```

For a normal non-root Ubuntu user, `--allow-run-as-root` is not required.

## Implementation

- `MPI_Bcast` distributes matrix B.
- `MPI_Scatterv` distributes variable-sized row blocks of A.
- Each rank performs local matrix multiplication.
- `MPI_Gatherv` collects the result at rank 0.
- The result is verified using `C[0][0]`.

## Evidence

Place the MPI terminal screenshot in:

`../evidence/mpi_execution.png`

This repository intentionally does **not** fabricate an MPI execution screenshot. The source and instructions are ready for a genuine run on the target machine.
