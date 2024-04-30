+++
title = "Software"
menu = "main"
weight = 20
+++

## OS

Ubuntu 22.04 LTS (Jammy Jellyfish)

### System Library

`/usr/bin`, `/bin`

- Shells
    - bash 5.1.16
    - zsh 5.8.1
- Editors
    - emacs 27.1
    - vim 8.2
    - nano 6.2
- Compilers and interpreters
    - gcc 11.4.0, 12.3.0
    - clang 14.0
    - rustc 1.66.1
    - python3 3.10.12
    - ruby 3.0
    - R 4.3.1
- Other tools
    - git 2.34.1
    - cmake 3.22.1

Some tools are available in newer version. See below.

### Job Management System

`/opt/pbs`

[OpenPBS](https://github.com/openpbs/openpbs) 22.0


## Additional Tools

Additional tools are installed with [Homebrew](https://docs.brew.sh/)
to `/home/linuxbrew/.linuxbrew/` if available.
Otherwise, they are manually installed to `/home/antares/`.
The environment variable `PATH` for their `bin`s is preset for all users.

### Compilers, Interpreters, and Libraries

- gcc 13.2
- python 3.12
- boost 1.85
- eigen 3.4.0
- gsl 2.7.1

### General tools

- tmux 3.4
- cmake 3.29
- git 2.45

### Bioinformatics tools

- bcftools 1.20
- bedtools 2.31
- blast 2.15
- bowtie2 2.5.3
- bwa 0.7.18
- fastp 0.23.4
- gatk 4.3.0
- hisat2 2.2.1
- hmmer 3.4
- htslib/samtools 1.20
- lastz 1.04.22
- libsequence 1.9.8
- mafft 7.526
- multiz 20191003
- paml 4.9j
- PLINK v1.90b5
- PHAST v1.6
- RAxML 8.2.12
- SeqKit 2.8.1
- SnpEff 4.3
- sratoolkit 3.1.0
- STAR 2.7.10
- stringtie 2.1.4
- varscan 2.4.4
- velvet 1.2.10

`/home/antares/sif/bin`

- MEME 5.5.5
- orthofinder 2.5.5
- RepeatMasker 4.1.5
- salmon 1.10.3
- Trinity 2.15.1


`/home/antares/bin`

- [ms](http://home.uchicago.edu/~rhudson1/source/mksamples.html)
- RSEM 1.3.3
- signalp 5.0b
- tmhmm 2.0c


### Python

- `/usr/bin/python3@ -> python3.10`
- `/usr/bin/python3.10`
- `/usr/bin/python3.12`

The system does not provide any package globally according to [PEP 668](https://peps.python.org/pep-0668/).
You can install packages to your local environment with [venv](https://docs.python.org/3/library/venv.html).


### R packages

`/home/antares/.R/library`

- ape
- BioConductor (Biostrings, GenomicRanges, *etc.*)
- brms
- cmdstanr
- cowplot
- igraph
- lme4
- Rcpp
- rgl
- rmarkdown
- rstanarm
- Seurat
- tidyverse (ggplot2, dplyr, tidyr, *etc.*)
