/*
 * Parallel & GPU Computing Laboratory
 * Experiment: CUDA Matrix Multiplication
 * Author: Shreya U.
 *
 * NVIDIA CUDA implementation.
 * Requires an NVIDIA GPU and CUDA Toolkit.
 */

#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>

#define N 1024
#define BLOCK_SIZE 16

__global__ void matMulKernel(const float *A, const float *B, float *C, int n) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    if (row < n && col < n) {
        float sum = 0.0f;
        for (int k = 0; k < n; ++k) {
            sum += A[row * n + k] * B[k * n + col];
        }
        C[row * n + col] = sum;
    }
}

static void checkCuda(cudaError_t err, const char *where) {
    if (err != cudaSuccess) {
        fprintf(stderr, "CUDA error at %s: %s\n", where, cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
}

int main(void) {
    size_t bytes = (size_t)N * N * sizeof(float);

    float *h_A = (float *)malloc(bytes);
    float *h_B = (float *)malloc(bytes);
    float *h_C = (float *)malloc(bytes);

    if (!h_A || !h_B || !h_C) {
        fprintf(stderr, "Host allocation failed.\n");
        return 1;
    }

    for (size_t i = 0; i < (size_t)N * N; ++i) {
        h_A[i] = 1.0f;
        h_B[i] = 1.0f;
    }

    float *d_A, *d_B, *d_C;
    checkCuda(cudaMalloc(&d_A, bytes), "cudaMalloc A");
    checkCuda(cudaMalloc(&d_B, bytes), "cudaMalloc B");
    checkCuda(cudaMalloc(&d_C, bytes), "cudaMalloc C");

    checkCuda(cudaMemcpy(d_A, h_A, bytes, cudaMemcpyHostToDevice), "copy A");
    checkCuda(cudaMemcpy(d_B, h_B, bytes, cudaMemcpyHostToDevice), "copy B");

    dim3 block(BLOCK_SIZE, BLOCK_SIZE);
    dim3 grid((N + BLOCK_SIZE - 1) / BLOCK_SIZE,
              (N + BLOCK_SIZE - 1) / BLOCK_SIZE);

    cudaEvent_t start, stop;
    checkCuda(cudaEventCreate(&start), "event create start");
    checkCuda(cudaEventCreate(&stop), "event create stop");

    checkCuda(cudaEventRecord(start), "event record start");

    matMulKernel<<<grid, block>>>(d_A, d_B, d_C, N);
    checkCuda(cudaGetLastError(), "kernel launch");
    checkCuda(cudaEventRecord(stop), "event record stop");
    checkCuda(cudaEventSynchronize(stop), "event synchronize");

    float milliseconds = 0.0f;
    checkCuda(cudaEventElapsedTime(&milliseconds, start, stop), "elapsed time");

    checkCuda(cudaMemcpy(h_C, d_C, bytes, cudaMemcpyDeviceToHost), "copy C");

    printf("CUDA Matrix Multiplication Completed\n");
    printf("Matrix Size = %d x %d\n", N, N);
    printf("Block Size = %d x %d\n", BLOCK_SIZE, BLOCK_SIZE);
    printf("Kernel Execution Time = %.3f ms\n", milliseconds);
    printf("Verification C[0][0] = %.2f\n", h_C[0]);

    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    free(h_A);
    free(h_B);
    free(h_C);

    return 0;
}
