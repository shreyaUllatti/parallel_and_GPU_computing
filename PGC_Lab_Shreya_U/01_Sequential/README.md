# Sequential Matrix Multiplication

**Author:** Shreya U.

This is the serial baseline used to compare shared-memory, distributed-memory and GPU implementations.

## Compile

```bash
gcc -O2 sequential_matrix.c -o sequential_matrix
```

## Run

```bash
./sequential_matrix
```

## Recorded execution

The repository contains the terminal evidence in:

`../evidence/sequential_execution.png`

The recorded run uses a **4000 × 4000** matrix and reports the measured execution time directly from the terminal.
