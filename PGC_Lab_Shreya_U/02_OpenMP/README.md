# OpenMP Matrix Multiplication

**Author:** Shreya U.

OpenMP parallelizes the outer matrix rows using multiple CPU threads.

## Compile

```bash
gcc -O2 -fopenmp matrix_openmp.c -o matrix_openmp
```

## Select the number of threads

```bash
export OMP_NUM_THREADS=8
echo $OMP_NUM_THREADS
```

## Run

```bash
./matrix_openmp
```

## Recorded execution

The terminal evidence is available at:

`../evidence/openmp_execution.png`

The recorded run uses **8 OpenMP threads** and a **4000 × 4000** matrix.
