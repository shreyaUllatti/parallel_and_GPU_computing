# CUDA Matrix Multiplication

This folder contains a CUDA matrix multiplication implementation using the same 4000 x 4000 workload and 16 x 16 thread blocks as the reference project.

## Aim

To implement and analyze parallel matrix multiplication using CUDA by utilizing the GPU's massive parallelism, where each CUDA thread computes one element of the output matrix.

## Objectives

1.To understand the fundamentals of CUDA programming and GPU-based parallel computing.

2.To implement 4000 × 4000 matrix multiplication using a CUDA kernel.

3.To configure CUDA execution using 16 × 16 thread blocks.

4.To assign one CUDA thread to compute each output matrix element.

5.To compile and execute the CUDA program using the NVIDIA CUDA compiler (nvcc).

6.To verify the correctness of the matrix multiplication using the expected result C[0][0] = 4000.00.

7.To measure the GPU kernel execution time and evaluate the performance of CUDA-based computation.

8.To compare CUDA performance with Sequential, OpenMP, and MPI implementations.

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

### Conclusion

The CUDA-based matrix multiplication was successfully implemented for a 4000 × 4000 matrix using 16 × 16 thread blocks. The computation was distributed across thousands of GPU threads, with each thread responsible for calculating one element of the output matrix. The result was verified using C[0][0] = 4000.00, confirming the correctness of the implementation.

The experiment demonstrates that GPU-based parallelism can significantly accelerate computationally intensive matrix operations compared with sequential CPU execution. CUDA therefore provides an effective approach for large-scale numerical computations by exploiting the high degree of parallelism available on GPUs.


