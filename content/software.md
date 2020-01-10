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
    - gcc **7.4.0**, 8.3.0
    - python 2.7.17
    - python3 **3.6.9**, 3.8.0
    - R 3.6.2
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

- gcc 5.5 (unlinked)
- clang 8.0
- python 3.7
- boost 1.72
- eigen 3.3.7
- gsl 2.6

### General tools

- tmux 3.0
- cmake 3.16
- git 2.24
- emacs 26.3
- nano 4.7

### Bioinformatics tools

- bedtools 2.29
- blast 2.9.0
- bowtie2 2.3.5
- bwa 0.7.17
- gatk 4.1.4
- hisat2 2.1.0
- htslib 1.10
- libsequence
- mafft 7.429
- MEME 5.1.0
- paml 4.9i
- RAxML 8.2.12
- RepeatMasker 4.0.7
- samtools 1.10
- SeqKit 0.11
- stringtie 1.3.6
- varscan 2.4.3
- velvet 1.2.10

`/home/local/bin`

- [ms](http://home.uchicago.edu/~rhudson1/source/mksamples.html)


### Python packages

`/home/linuxbrew/.linuxbrew/lib/python3.7/site-packages/`

- numpy
- scipy
- pandas
- scikit-learn
- matplotlib
- seaborn
- biopython
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
