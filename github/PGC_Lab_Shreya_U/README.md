# ⚡ Parallel & GPU Computing Laboratory

### Sequential • OpenMP • MPI • CUDA

**Author:** Shreya U.

A complete Parallel & GPU Computing laboratory repository focused on **matrix multiplication**, moving from a serial CPU baseline to shared-memory CPU parallelism, distributed-memory parallelism and GPU acceleration.

---

## 🎯 Objective

The objective is to implement and study matrix multiplication using four computing models:

1. **Sequential CPU**
2. **OpenMP**
3. **MPI**
4. **CUDA**

The implementations are organized separately so that the algorithms, compilation commands and execution evidence are easy to evaluate.

---

## 🧠 Computing Models

| Model | Architecture | Parallelism |
|---|---|---|
| Sequential | Single CPU execution stream | None |
| OpenMP | Shared-memory CPU | Threads |
| MPI | Distributed-memory | Processes |
| CUDA | NVIDIA GPU | Threads / blocks |

---

## 📂 Repository Structure

```text
PGC_Lab_Shreya_U/
│
├── 01_Sequential/
│   ├── sequential_matrix.c
│   └── README.md
│
├── 02_OpenMP/
│   ├── matrix_openmp.c
│   └── README.md
│
├── 03_MPI/
│   ├── matrix_mpi.c
│   └── README.md
│
├── 04_CUDA/
│   ├── matrix_cuda.cu
│   └── README.md
│
├── 05_Performance_Analysis/
│   ├── comparison.md
│   └── README.md
│
├── evidence/
│   ├── sequential_execution.png
│   └── openmp_execution.png
│
└── docs/
```

---

# 1️⃣ Sequential Matrix Multiplication

The sequential version provides the baseline against which parallel implementations are compared.

### Compile

```bash
cd 01_Sequential
gcc -O2 sequential_matrix.c -o sequential_matrix
```

### Run

```bash
./sequential_matrix
```

### Recorded result

**4000 × 4000 matrix**

**Execution time: 581.154139 seconds**

The original terminal evidence is available in:

`evidence/sequential_execution.png`

---

# 2️⃣ OpenMP Matrix Multiplication

OpenMP uses multiple CPU threads to divide the matrix computation.

### Compile

```bash
cd 02_OpenMP
gcc -O2 -fopenmp matrix_openmp.c -o matrix_openmp
```

### Configure threads

```bash
export OMP_NUM_THREADS=8
echo $OMP_NUM_THREADS
```

### Run

```bash
./matrix_openmp
```

### Recorded result

**4000 × 4000 matrix**

**8 threads**

**Execution time: 349.409567 seconds**

The original terminal evidence is available in:

`evidence/openmp_execution.png`

### Speedup

```text
Speedup = 581.154139 / 349.409567
        ≈ 1.66×
```

---

# 3️⃣ MPI Matrix Multiplication

MPI uses multiple processes and supports distributed-memory execution.

### Install OpenMPI

```bash
sudo apt update
sudo apt install openmpi-bin libopenmpi-dev -y
```

### Compile

```bash
cd 03_MPI
mpicc -O2 matrix_mpi.c -o matrix_mpi
```

### Run

```bash
mpirun -np 4 ./matrix_mpi
```

If running as root inside a controlled environment:

```bash
mpirun --allow-run-as-root -np 4 ./matrix_mpi
```

### MPI workflow

```text
             Rank 0
               │
        Initialize A and B
               │
        Broadcast B
               │
        Scatter rows of A
               │
       ┌───────┼───────┐
       ▼       ▼       ▼
    Rank 0   Rank 1   Rank 2 ... Rank N
       │       │       │
       └───────┼───────┘
               │
          Gather C
               │
            Result
```

---

# 4️⃣ CUDA Matrix Multiplication

CUDA maps matrix multiplication to GPU threads.

### Compile

```bash
cd 04_CUDA
nvcc -O2 matrix_cuda.cu -o matrix_cuda
```

### Run

```bash
./matrix_cuda
```

The implementation uses:

- CUDA kernel
- 16 × 16 thread blocks
- GPU global memory
- CUDA events for kernel timing
- Result verification

> CUDA execution requires an NVIDIA CUDA-capable GPU. The CUDA source is included as a complete implementation, but a benchmark should only be reported after genuine execution on an NVIDIA system.

---

# 📊 Performance Comparison

## Verified measurements

| Implementation | Matrix Size | Parallel Units | Time |
|---|---:|---:|---:|
| Sequential | 4000 × 4000 | 1 | **581.154139 s** |
| OpenMP | 4000 × 4000 | 8 threads | **349.409567 s** |
| MPI | 4000 × 4000 | 4 processes | Run required |
| CUDA | 1024 × 1024 | GPU threads | Run required |

### Current observation

OpenMP achieved approximately **1.66× speedup** over the sequential implementation in the recorded 4000 × 4000 experiment.

MPI and CUDA results should be added after execution rather than copied from another machine, because execution time depends strongly on CPU, RAM, process count, GPU model and software environment.

---

# 🧪 Correctness Verification

For matrices initialized with all elements equal to `1.0`:

```text
C[0][0] = 4000
```

for the 4000 × 4000 implementations.

The verification value provides a simple correctness check before comparing performance.

---

# 🛠️ Technologies

- C
- OpenMP
- MPI / OpenMPI
- CUDA C
- GCC
- NVCC
- Ubuntu / WSL
- Linux command line

---

# 📈 What This Lab Demonstrates

### Sequential

Simple baseline implementation.

### OpenMP

Demonstrates **shared-memory parallelism** using CPU threads.

### MPI

Demonstrates **distributed-memory parallelism** using independent processes and explicit communication.

### CUDA

Demonstrates **GPU parallelism** using thousands of lightweight threads organized into blocks and grids.

---

# 🏁 Conclusion

The experiment demonstrates how the same matrix multiplication problem can be mapped onto different parallel computing models.

The measured results already show that OpenMP can reduce execution time significantly compared with the sequential baseline for a large matrix workload. MPI extends the model to distributed processes, while CUDA targets massive GPU parallelism.

The repository keeps each implementation independent, reproducible and easy to compile.

---

## 👩‍💻 Author

**Shreya U.**

Parallel & GPU Computing Laboratory

