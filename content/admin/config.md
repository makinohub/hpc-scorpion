+++
title = "Config"
draft = true
[menu.main]
  parent = "admin"
  weight = -255
+++


## Server room

### Air conditioner and ventilation

- Leave the **AC on** to keep the room temperature below 27℃.
- Leave the **ventilation off** unless necessary.
- **Never use the heat exchange ventilation in summer**
  because it causes condensation and leakage problems.
  The AC should not be configured extremely cold in the same reason.
  It is not a general problem, but just our infrastructure is very poor.


## Power

### Boot

1.  Start the head node.
1.  Start the compute nodes.

### Shutdown

1.  Notify the users.
1.  Run `sudo shutdown -h now` to stop the compute nodes.
1.  Run `sudo shutdown -h now` to stop the head node.


## Network

### SSH

```conf
# /etc/ssh/sshd_config
PasswordAuthentication no
KbdInteractiveAuthentication no
UsePAM no

# /etc/ssh/ssh_config.d/scorpion.conf
host localhost 192.168.1.* scorpion*
  GSSAPIAuthentication no
  StrictHostKeyChecking no
```
`sudo service ssh restart`


### NFS

Compute nodes mount `/home` of the head node via NFS.
Use `autofs`, not `/etc/fstab`:
```sh
df -h

# /etc/auto.master
/misc   /etc/auto.misc

# /etc/auto.misc
home    -rw,intr,lookupcache=none        192.168.1.100:/home
```

### Firewall

```sh
sudo ufw status
sudo ufw allow ssh
sudo ufw allow "Apache Full"
sudo ufw allow from 192.168.1.0/24 to any
sudo ufw reload
sudo ufw status
```

Enable NAT forwarding:
```sh
# /etc/default/ufw
DEFAULT_FORWARD_POLICY="ACCEPT"
```


## Install softwares

### apt

```
sudo apt update
sudo apt install build-essential zsh emacs
sudo apt install libblas-dev liblapack-dev libatlas-base-dev f2c
```

### Homebrew

https://docs.brew.sh/Homebrew-on-Linux

- If the software is available on Homebrew, use it.
- `brew` must be executed by a non-root user.
- Append `eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)` to `/etc/profile.d/scorpion.sh`.


### Python

Install newer versions via [ppa:deadsnakes/ppa](https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa).
```sh
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
```

Do not `pip3 install` globally according to [PEP 668](https://peps.python.org/pep-0668/).


### R

- https://cran.r-project.org/bin/linux/ubuntu/
- https://cran.r-project.org/doc/manuals/R-admin.html

Install R from the official repository:
```sh
sudo apt install --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt update && apt list --upgradable
sudo apt upgrade
sudo apt install r-base r-base-dev
```

Install some `-dev` packages required by R packages:
```sh
sudo apt install libcurl4-openssl-dev libxml2-dev
sudo apt install libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev  # ragg
sudo apt install libharfbuzz-dev libfribidi-dev  # textshaping
sudo apt install libssl-dev libv8-dev
sudo apt install libgeos-dev  # rgeos seurat
```

Modify `/etc/R/Renviron.site` in the all nodes:
```sh
#R_LIBS_SITE="/usr/local/lib/R/site-library/:${R_LIBS_SITE}:/usr/lib/R/library"
R_LIBS_SITE="/home/antares/.R/library/%v"
R_LIBS_USER='~/.R/library/%v'
```

Append [RSPM](https://packagemanager.rstudio.com/) options to `/etc/R/Rprofile.site` in the all nodes:
```r
options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])))
options(repos = c(CRAN = "https://packagemanager.rstudio.com/cran/__linux__/jammyt/latest"))
options(BioC_mirror = "https://packagemanager.rstudio.com/bioconductor")
```

Create site library:
```sh
mkdir -p /home/antares/.R/library/4.4
```

Install packages to site library as `root`:
```sh
MAKEFLAGS=-j8 R --no-save --no-restore-data
```
```r
.Library.site
.libPaths()
getOption("repos")
source("https://docs.rstudio.com/rspm/admin/check-user-agent.R")

install.packages("pak")

pkgs = "
ape
bayesplot
BiocManager
brms
cowplot
devtools
future
furrr
ggrepel
ggridges
lme4
palmerpenguins
Rcpp
rgl
rmarkdown
rstanarm
Seurat
tidyverse
"
pkgs = readLines(textConnection(trimws(pkgs)))
pak::pkg_install(pkgs)

biopkgs = "
Biostrings
edgeR
GenomicRanges
ggtree
rtracklayer
topGO
VariantAnnotation
"
biocpkgs = readLines(textConnection(trimws(biopkgs)))
pak::pkg_install(biocpkgs)

pak::repo_add(stan = "https://mc-stan.org/r-packages")
pak::pkg_install("cmdstanr")
library(cmdstanr)
check_cmdstan_toolchain()
install_cmdstan(cores = 4)
cmdstan_path()
cmdstan_version()
```

Check updates from time to time:
```sh
Rscript -e 'old.packages()'
Rscript -e 'BiocManager::valid()'
```
```r
pkgs = old.packages(lib = .Library.site) |> print()
pak::pkg_install(rownames(pkgs), lib = .Library.site)

stdpkgs = old.packages(lib = .Library) |> print()
pak::pkg_install(rownames(stdpkgs), lib = .Library)
```


### Others

- Download an archive to `/home/antares/src/`
- Install it with a prefix `/home/antares`
- If the software does not provide any installation method,
  move the whole directory to `/home/antares/Cellar/` with a version number,
  and create symlinks to `/home/antares/bin`, `include`, `lib`, and so on.
- Disable `motd`:
  ```sh
  cd /etc/update-motd.d
  sudo mkdir disabled
  sudo mv *-* disabled/
  ```

## Install hardwares

-   https://www.hpc.co.jp/
