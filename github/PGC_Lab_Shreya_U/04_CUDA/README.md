# CUDA Matrix Multiplication

**Author:** Shreya U.

This implementation performs matrix multiplication on an NVIDIA GPU using CUDA threads and blocks.

## Requirements

- NVIDIA GPU
- CUDA Toolkit
- `nvcc`

## Compile

```bash
nvcc -O2 matrix_cuda.cu -o matrix_cuda
```

## Run

```bash
./matrix_cuda
```

## CUDA model used

Each CUDA thread computes one output element. Threads are grouped into **16 × 16 blocks**.

The program reports:

- Matrix size
- Block size
- GPU kernel execution time
- Result verification

## Important hardware note

CUDA requires an NVIDIA CUDA-capable GPU. If the machine has a non-NVIDIA GPU, keep the CUDA source in the repository but execute it on an NVIDIA-enabled system.

## Evidence

Place the genuine CUDA terminal screenshot in:

`../evidence/cuda_execution.png`

The repository does not create a fake CUDA benchmark screenshot.
