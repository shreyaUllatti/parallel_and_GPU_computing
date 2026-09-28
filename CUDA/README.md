# CUDA Matrix Multiplication

This folder contains a CUDA matrix multiplication implementation using the same 4000 x 4000 workload and 16 x 16 thread blocks as the reference project.

## Files
- `cudamatrix.cu` - CUDA matrix multiplication kernel and benchmark

## Compile
```bash
nvcc -O2 cudamatrix.cu -o cudamatrix
```

For an NVIDIA GPU architecture supported by your CUDA installation, you may specify an architecture, for example:
```bash
nvcc -O2 -arch=sm_86 cudamatrix.cu -o cudamatrix
```

## Run
```bash
./cudamatrix
```

Expected verification:
`C[0][0] = 4000.00`

The kernel uses a 16 x 16 block and one CUDA thread computes one output matrix element.
