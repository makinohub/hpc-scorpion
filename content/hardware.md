+++
title = "Hardware"
menu = "main"
weight = 10
+++

## System

Head node
: HPC5000-XCL224R2S x 1

Compute node
: HPC5000-XCL224R1S x 1


## Computer

| Node    | Hostname     | CPU                    | GHz  | FLOPS  | Cores | RAM  |
| ------- | ------------ | ---------------------- | ---- | ------ | ----- | ---- |
| head    | `scorpion`   | Intel Xeon Silver 4208 | 2.10 |        | 2x8   | 96GB |
| compute | `scorpion01` | Intel Xeon Silver 4216 | 2.10 |        | 2x16  | 96GB |


## Storage

| Type | Mount   | Size  | Drive | Array            |
| ---- | ------- | ----- | ----- | ---------------- |
| OS   | `/`     | 480GB | SSD   | RAID 1 (2x480GB) |
| data | `/home` | 2TB   | HDD   | RAID 1 (2x2TB)   |
