# Performance Analysis

**Author:** Shreya U.

## Current recorded measurements

The first two measurements below are taken from the genuine terminal screenshots supplied for this repository.

| Implementation | Matrix | Parallel units | Execution time |
|---|---:|---:|---:|
| Sequential | 4000 × 4000 | 1 process | **581.154139 s** |
| OpenMP | 4000 × 4000 | 8 threads | **349.409567 s** |
| MPI | 4000 × 4000 | To be measured | To be measured |
| CUDA | 1024 × 1024 | GPU blocks/threads | To be measured |

### Speedup of OpenMP over Sequential

```text
Speedup = Sequential Time / OpenMP Time
        = 581.154139 / 349.409567
        ≈ 1.66×
```

### Interpretation

The recorded OpenMP run is approximately **1.66× faster** than the recorded sequential run for the same 4000 × 4000 workload.

MPI and CUDA values should be added only after genuine execution on the target environment. This avoids presenting copied or fabricated benchmark numbers as personal measurements.

## Expected comparison

| Method | Memory model | Main parallel resource | Typical strength |
|---|---|---|---|
| Sequential | Shared memory | One CPU execution stream | Baseline / simple |
| OpenMP | Shared memory | CPU threads | Easy CPU parallelism |
| MPI | Distributed memory | Multiple processes/nodes | Cluster-scale workloads |
| CUDA | GPU memory | GPU threads/blocks | Highly parallel GPU workloads |

