+++
title = "Software"
menu = "main"
weight = 20
+++

## OS

Ubuntu 18.04 LTS (Bionic Beaver)

### System Library

`/usr/bin`, `/bin`

- Shells
    - bash 4.4.20
    - zsh 5.4.2
- Editors
    - emacs 25.2.2
    - vi 8.0
    - nano 2.9.3
- Compilers and interpreters
    - gcc **7.5.0**, 8.4.0
    - clang 8.0
    - python 2.7.17
    - python3 **3.6.9**, 3.8.0
    - R 3.6.3
- Other tools
    - git 2.17.1
    - cmake 3.10.2

Some tools are available in newer version. See below.

### Job Management System

`/opt/pbs`

[PBS Professional](https://pbspro.org/) 19.1.2


## Additional Tools

Additional tools are installed with [Homebrew](https://docs.brew.sh/)
to `/home/linuxbrew/.linuxbrew/` if available.
Otherwise, they are manually installed to `/home/local/`.
The environment variable `PATH` for their `bin`s is preset for all users.

### Compilers, Interpreters, and Libraries

- gcc 11.2
- python 3.10
- r 4.1
- boost 1.76
- eigen 3.4.0
- gsl 2.7

### General tools

- tmux 3.2
- cmake 3.22
- git 2.35
- emacs 27.2
- nano 6.1

### Bioinformatics tools

- bcftools 1.14
- bedtools 2.30
- blast 2.12
- blat 36
- bowtie2 2.4.4
- bwa 0.7.17
- fastp 0.20
- gatk 4.2.0
- hisat2 2.2.1
- hmmer 3.3
- htslib 1.14
- kent-tools 401
- lastz 1.04
- libsequence 1.9.8
- mafft 7.490
- MEME 5.1.0
- multiz 20191003
- paml 4.9j
- PLINK v1.90b5
- PHAST v1.6
- RAxML 8.2.12
- RepeatMasker 4.0.7
- samtools 1.14
- SeqKit 2.1
- SnpEff 4.3
- sratoolkit 2.11
- STAR 2.7.5
- stringtie 2.1.4
- Trinity 2.11
- varscan 2.4.4
- velvet 1.2.10

`/home/local/bin`

- [ms](http://home.uchicago.edu/~rhudson1/source/mksamples.html)
- RSEM 1.3.3
- signalp 5.0b
- tmhmm 2.0c


### Python packages

`/home/linuxbrew/.linuxbrew/lib/python3.9/site-packages/`

- arviz
- biopython
- matplotlib
- numpy
- pandas
- psutil
- pydataset
- pystan
- scikit-learn
- scipy
- seaborn
- statsmodels
- tqdm
- Pillow

### R packages

`/home/local/lib/R/library`

- ape
- BioConductor (Biostrings, GenomicRanges, *etc.*)
- cowplot
- igraph
- Rcpp
- rgl
- rstan
- tidyverse (ggplot2, dplyr, tidyr, *etc.*)
