# MPI Matrix Multiplication

## 1. MPI Cluster Setup

The MPI experiment uses one Master VM and three Worker VMs.

The Master acts as Rank 0, while Worker1, Worker2, and Worker3 participate as Rank 1, Rank 2, and Rank 3.

## 2. Network Connectivity

The Master VM was used to verify communication with all Worker VMs using `ping`.

The connectivity test was successful with **0% packet loss** for all three workers.

<img width="616" height="543" alt="mpi_ping" src="https://github.com/user-attachments/assets/fbd17b6d-d17d-46fe-b6df-42bf823289b1" />

## 3. SSH Configuration

OpenSSH was configured on the Worker VMs to allow remote access from the Master.

The SSH service was verified to be active and running on Worker1, Worker2, and Worker3.

<img width="701" height="528" alt="sshworker1_mpi" src="https://github.com/user-attachments/assets/dd4bc6c0-cbac-4560-a347-a4ce607e8107" />

<img width="693" height="534" alt="sshworker2_mpi" src="https://github.com/user-attachments/assets/186d252c-896a-4644-8514-c96fa2672829" />

<img width="735" height="513" alt="sshworker3_mpi" src="https://github.com/user-attachments/assets/8674cd35-41a1-411a-a521-f9fce359064b" />

## 4. SSH Communication Test

The Master successfully connected to Worker1, Worker2 and Worker3 using SSH.

The `hostname` command confirmed that the connection was established with the correct worker node.

<img width="851" height="404" alt="worker1_mpi" src="https://github.com/user-attachments/assets/136b8087-8bfb-46ec-8eb9-eabf7778544e" />
<img width="736" height="401" alt="worker2_mpi" src="https://github.com/user-attachments/assets/8cf25177-f7b4-44c8-a82c-b324709ab4df" />
<img width="694" height="668" alt="WhatsApp Image 2026-09-25 at 9 20 28 AM" src="https://github.com/user-attachments/assets/23646b97-841d-41d9-9db1-493a6bfa8767" />
