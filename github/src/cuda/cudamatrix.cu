#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>

#define N 4000
#define BLOCK 16

__global__ void matmul(const float *A, const float *B, float *C, int n) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    if (row < n && col < n) {
        float sum = 0.0f;
        for (int k = 0; k < n; ++k)
            sum += A[(size_t)row*n+k] * B[(size_t)k*n+col];
        C[(size_t)row*n+col] = sum;
    }
}

int main(void) {
    size_t bytes = (size_t)N * N * sizeof(float);
    float *hA = malloc(bytes), *hB = malloc(bytes), *hC = malloc(bytes);
    float *dA, *dB, *dC;

    if (!hA || !hB || !hC) return 1;
    for (size_t i = 0; i < (size_t)N*N; ++i) {
        hA[i] = 1.0f; hB[i] = 1.0f; hC[i] = 0.0f;
    }

    cudaMalloc(&dA, bytes);
    cudaMalloc(&dB, bytes);
    cudaMalloc(&dC, bytes);

    cudaMemcpy(dA, hA, bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(dB, hB, bytes, cudaMemcpyHostToDevice);

    dim3 block(BLOCK, BLOCK);
    dim3 grid((N + BLOCK - 1) / BLOCK, (N + BLOCK - 1) / BLOCK);

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);

    matmul<<<grid, block>>>(dA, dB, dC, N);
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    cudaMemcpy(hC, dC, bytes, cudaMemcpyDeviceToHost);

    float ms = 0.0f;
    cudaEventElapsedTime(&ms, start, stop);

    printf("CUDA Matrix Multiplication Completed\n");
    printf("Matrix Size = %d x %d\n", N, N);
    printf("Grid = %d x %d blocks\n", grid.x, grid.y);
    printf("Block = %d x %d threads\n", block.x, block.y);
    printf("Kernel Execution Time = %.3f ms\n", ms);
    printf("Verification C[0][0] = %.2f\n", hC[0]);

    cudaEventDestroy(start); cudaEventDestroy(stop);
    cudaFree(dA); cudaFree(dB); cudaFree(dC);
    free(hA); free(hB); free(hC);
    return 0;
}
