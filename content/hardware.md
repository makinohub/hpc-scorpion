+++
title = "Hardware"
menu = "main"
weight = 10
+++

## System

Head node
: HPC5000-XCL224R2S x 1

Compute node
: HPC5000-XCL224R1S x 2

Switching hub
: NETGEAR JGS516-300JPS (GbE 16ports)

Storage
: QNAP [TS-1283XU-RP](https://www.qnap.com/en-us/product/ts-1283xu-rp)
  - QNAP PCIe NVMe SSD expansion card
    [QM2-2P-344](https://www.qnap.com/en-us/product/qm2-2p-344)
    - 2 x 1TB M.2 SSD Crucial P5
      [CT1000P5SSD8JP](https://www.crucial.jp/products/ssd/crucial-p5-ssd)
  - 12 x 16TB HDD Seagate IronWolf Pro
    [ST16000NE000](https://www.cfd.co.jp/biz/product/detail/st16000ne000.html)

## Computer

| Node    | Hostname     | CPU                    | GHz  | FLOPS  | Cores | RAM   |
| ------- | ------------ | ---------------------- | ---- | ------ | ----- | ----- |
| head    | `scorpion`   | Intel Xeon Silver 4208 | 2.10 |        | 2x8   |  96GB |
| compute | `scorpion01` | Intel Xeon Silver 4216 | 2.10 |        | 2x16  |  96GB |
| compute | `scorpion02` | Intel Xeon Gold 6242R  | 3.10 |        | 2x20  | 384GB |
| NAS     | `planaria`   | Intel Xeon E-2124      | 3.30 |        | 4     |   8GB |


## Storage

| Type | Mount   | Size  | Drive | Array            |
| ---- | ------- | ----- | ----- | ---------------- |
| OS   | `/`     | 480GB | SSD   | RAID 1 (2x480GB) |
| data | `/home` | 36TB  | HDD   | RAID 6 (6x10TB)  |
| data | `/misc/planaria` | 140TB  | HDD + SSD cache | RAID 6 (12x16TB)  |
