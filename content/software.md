+++
title = "Software"
menu = "main"
weight = 20
+++

## OS

Ubuntu 20.04 LTS (Focal Fossa)

### System Library

`/usr/bin`, `/bin`

- Shells
    - bash 5.0.17
    - zsh 5.8
- Editors
    - emacs 26.3
    - vi 8.1
    - nano 4.8
- Compilers and interpreters
    - gcc 9.4.0
    - clang 10.0
    - python 2.7.18
    - python3 3.8.10
    - ruby 2.7.0
    - R 3.6.3
- Other tools
    - git 2.25.1
    - cmake 3.16.3

Some tools are available in newer version. See below.

### Job Management System

`/opt/pbs`

[OpenPBS](https://github.com/openpbs/openpbs) 22.0


## Additional Tools

Additional tools are installed with [Homebrew](https://docs.brew.sh/)
to `/home/linuxbrew/.linuxbrew/` if available.
Otherwise, they are manually installed to `/home/local/`.
The environment variable `PATH` for their `bin`s is preset for all users.

### Compilers, Interpreters, and Libraries

- gcc 12.2
- python 3.10
- r 4.1
- boost 1.79
- eigen 3.4.0
- gsl 2.7

### General tools

- tmux 3.3
- cmake 3.24
- git 2.37
- emacs 28.1
- nano 6.4

### Bioinformatics tools

- bcftools 1.16
- bedtools 2.30
- blast 2.13
- blat 36
- bowtie2 2.4.5
- bwa 0.7.17
- fastp 0.23.2
- gatk 4.2.0
- hisat2 2.2.1
- hmmer 3.3
- htslib 1.16
- kent-tools 401
- lastz 1.04.22
- libsequence 1.9.8
- mafft 7.490
- MEME 5.1.0
- multiz 20191003
- paml 4.9j
- PLINK v1.90b5
- PHAST v1.6
- RAxML 8.2.12
- RepeatMasker 4.0.7
- samtools 1.16
- SeqKit 2.3
- SnpEff 4.3
- sratoolkit 3.0
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

`/home/linuxbrew/.linuxbrew/lib/python3.10/site-packages/`

- arviz
- biopython
- cmdstanpy
- matplotlib
- numpy
- pandas
- Pillow
- psutil
- pytest
- requests
- scikit-learn
- scipy
- seaborn
- statsmodels
- tomli
- tqdm


### R packages

`/home/local/lib/R/library`

- ape
- BioConductor (Biostrings, GenomicRanges, *etc.*)
- cmdstanr
- cowplot
- igraph
- Rcpp
- rgl
- tidyverse (ggplot2, dplyr, tidyr, *etc.*)
