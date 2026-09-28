# Parallel & GPU Computing — Matrix Multiplication

A comparative implementation of dense matrix multiplication using four execution models:

- **Sequential CPU** — single-threaded baseline
- **OpenMP** — shared-memory CPU parallelism
- **MPI** — distributed-memory process parallelism
- **CUDA** — GPU/SIMT parallelism

## Workload

- Matrix size: **4000 × 4000**
- `A[i][j] = 1.0`
- `B[i][j] = 1.0`
- Expected result: **`C[0][0] = 4000.00`**
- Algorithmic complexity: **O(N³)**

## My measured CPU results

These are the execution results already obtained for this project:

| Implementation | Resources | Execution Time | Verification |
|---|---:|---:|---:|
| Sequential | 1 CPU execution stream | **97.230285 s** | 4000.00 |
| OpenMP | 8 CPU threads | **55.536384 s** | 4000.00 |

OpenMP speedup over the sequential result:

**97.230285 / 55.536384 ≈ 1.75×**

> MPI and CUDA source code is included for the corresponding lab experiments. Their performance values should be filled from your own execution screenshots rather than copied from another machine.

## Repository Structure

```text
parallel_and_GPU_computing/
├── README.md
├── src/
│   ├── sequential/
│   │   └── seqmatrix.c
│   ├── openmp/
│   │   └── openmpmatrix.c
│   ├── mpi/
│   │   └── mpimatrix.c
│   └── cuda/
│       └── cudamatrix.cu
├── results/
│   ├── sequential/
│   │   └── execution/
│   ├── openmp/
│   │   └── execution/
│   ├── mpi/
│   │   ├── execution/
│   │   └── communication/
│   ├── cuda/
│   │   └── execution/
│   └── performance/
│       ├── execution_time.png
│       ├── speedup.png
│       └── architecture_overview.png
├── docs/
│   └── methodology.md
└── scripts/
    └── chart.py
```

## How to Run

### Sequential

```bash
cd src/sequential
gcc -O2 seqmatrix.c -o seqmatrix
./seqmatrix
```

### OpenMP

```bash
cd src/openmp
export OMP_NUM_THREADS=8
gcc -O2 -fopenmp openmpmatrix.c -o openmpmatrix
./openmpmatrix
```

### MPI

Install Open MPI/MPICH first, then:

```bash
cd src/mpi
mpicc -O2 mpimatrix.c -o mpimatrix
mpirun -np 4 ./mpimatrix
```

For a multi-node setup, use an appropriate hostfile and SSH configuration.

### CUDA

CUDA requires an **NVIDIA CUDA-capable GPU** and a compatible CUDA toolkit:

```bash
cd src/cuda
nvcc -O2 cudamatrix.cu -o cudamatrix
./cudamatrix
```

## Important Hardware Note

CUDA execution is hardware-specific. An NVIDIA GPU is required to run the CUDA program. Do not report a CUDA runtime as an actual measurement unless the program was executed on an NVIDIA CUDA device.

## Architecture

**Sequential:** one execution stream performs the triple loop.

**OpenMP:** the outer matrix loop is divided among multiple CPU threads sharing the same address space.

**MPI:** matrix rows are divided among processes; the input matrix `B` is broadcast and output rows are gathered.

**CUDA:** a 2-D grid of GPU threads computes output matrix elements in parallel.

## Validation

For every implementation, the deterministic correctness check is:

```text
C[0][0] = 4000.00
```

because each output cell is the sum of 4000 products of `1.0 × 1.0`.

## Images

The `results/performance` folder contains project-specific architecture and performance visualizations. Terminal screenshots should be replaced/added using screenshots from the actual machine used for the experiment.
