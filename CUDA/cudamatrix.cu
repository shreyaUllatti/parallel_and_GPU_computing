#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>

#define N 4000

__global__ void matMulKernel(const float *A, const float *B, float *C, int n)
{
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    if (row < n && col < n)
    {
        float sum = 0.0f;
        for (int k = 0; k < n; k++)
            sum += A[row * n + k] * B[k * n + col];

        C[row * n + col] = sum;
    }
}

int main(void)
{
    size_t bytes = (size_t)N * N * sizeof(float);

    float *h_A = malloc(bytes);
    float *h_B = malloc(bytes);
    float *h_C = malloc(bytes);
    float *d_A = NULL, *d_B = NULL, *d_C = NULL;

    if (!h_A || !h_B || !h_C)
    {
        printf("Host memory allocation failed\n");
        return 1;
    }

    for (size_t i = 0; i < (size_t)N * N; i++)
    {
        h_A[i] = 1.0f;
        h_B[i] = 1.0f;
        h_C[i] = 0.0f;
    }

    cudaMalloc((void **)&d_A, bytes);
    cudaMalloc((void **)&d_B, bytes);
    cudaMalloc((void **)&d_C, bytes);

    cudaEvent_t totalStart, totalStop, kernelStart, kernelStop;
    cudaEventCreate(&totalStart);
    cudaEventCreate(&totalStop);
    cudaEventCreate(&kernelStart);
    cudaEventCreate(&kernelStop);

    dim3 block(16, 16);
    dim3 grid((N + block.x - 1) / block.x,
              (N + block.y - 1) / block.y);

    cudaEventRecord(totalStart);

    cudaMemcpy(d_A, h_A, bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, bytes, cudaMemcpyHostToDevice);

    cudaEventRecord(kernelStart);
    matMulKernel<<<grid, block>>>(d_A, d_B, d_C, N);
    cudaEventRecord(kernelStop);
    cudaEventSynchronize(kernelStop);

    cudaMemcpy(h_C, d_C, bytes, cudaMemcpyDeviceToHost);

    cudaEventRecord(totalStop);
    cudaEventSynchronize(totalStop);

    float kernelMs = 0.0f, totalMs = 0.0f;
    cudaEventElapsedTime(&kernelMs, kernelStart, kernelStop);
    cudaEventElapsedTime(&totalMs, totalStart, totalStop);

    printf("CUDA Matrix Multiplication Completed\n");
    printf("Matrix Size = %d x %d\n", N, N);
    printf("Grid Size = %d x %d blocks\n", grid.x, grid.y);
    printf("Block Size = %d x %d threads\n", block.x, block.y);
    printf("Kernel Execution Time = %.6f seconds\n", kernelMs / 1000.0f);
    printf("Total CUDA Phase Time = %.6f seconds\n", totalMs / 1000.0f);
    printf("Verification C[0][0] = %.2f\n", h_C[0]);

    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    free(h_A);
    free(h_B);
    free(h_C);

    cudaEventDestroy(totalStart);
    cudaEventDestroy(totalStop);
    cudaEventDestroy(kernelStart);
    cudaEventDestroy(kernelStop);

    return 0;
}
