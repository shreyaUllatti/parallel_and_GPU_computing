import matplotlib.pyplot as plt

sequential = 97.230285
openmp = 55.536384

plt.figure(figsize=(8, 5))
plt.bar(["Sequential", "OpenMP (8 threads)"], [sequential, openmp])
plt.ylabel("Execution Time (seconds)")
plt.title("Matrix Multiplication Execution Time")
plt.grid(axis="y", alpha=0.25)
plt.tight_layout()
plt.savefig("../results/performance/execution_time.png", dpi=150)
plt.close()

speedup = sequential / openmp
plt.figure(figsize=(8, 5))
plt.bar(["Sequential", "OpenMP"], [1.0, speedup])
plt.ylabel("Speedup (×)")
plt.title("Speedup Relative to Sequential")
plt.grid(axis="y", alpha=0.25)
plt.tight_layout()
plt.savefig("../results/performance/speedup.png", dpi=150)
plt.close()
