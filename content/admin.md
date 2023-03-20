+++
title = "Admin"
menu = "main"
draft = true
+++

## Power

### Boot

1.  Start the head node.
1.  Start the compute nodes.

### Shutdown

1.  Notify the users.
1.  Run `sudo shutdown -h now` to stop the compute nodes.
1.  Run `sudo shutdown -h now` to stop the head node.


## Documentation

### Preparation

1.  Install [Hugo](https://gohugo.io/) on your local machine.

1.  Fork [heavywatal/hpc-scorpion](https://github.com/heavywatal/hpc-scorpion) to your account.

1.  Clone your fork repository to your local machine:

    ```sh
    REPO=https://github.com/{YOUR_NAME_HERE}/hpc-scorpion.git
    git clone -b master --single-branch --recurse-submodules $REPO
    cd hpc-scorpion/
    ```

1.  Set `upstream` repository:
    `git remote add upstream https://github.com/heavywatal/hpc-scorpion.git`


### Routine

1.  Fetch and merge any updates in `upstream` to your `origin`.

1.  Start a local hugo server to preview the output:
    `hugo -Dw server`<br>
    - View: http://localhost:1313/hpc-scorpion/
      (the port may vary)
    - Stop: <kbd>ctrl</kbd><kbd>c</kbd>

1.  Edit some markdown files in `content/`.
    The output HTML gets updated immediately by the hugo server.

1.  Make a new branch to commit the updates.

1.  Make a Pull Request to [heavywatal/hpc-scorpion](https://github.com/heavywatal/hpc-scorpion).


### Deploy document

```sh
make public && make deploy
```

1.  Generate public documents.

1.  Copy generated documents to `scorpion:/var/www/html/`.



## Add a new user

1.  Check a new entry on [Google Form](https://docs.google.com/forms/d/1Lb1Mu07HyLxTPJO2IPQPoYidoHg_VXgB46zeS2lxQJs/edit)

1.  Create an account:

    ```sh
    NEWUSER=______
    sudo adduser ${NEWUSER}
    ```

    Generate random password (e.g., copy partial sequence from ssh public key),
    and forget it.

1.  Update NIS:

    ```sh
    sudo make -C /var/yp
    sudo ypbind -c
    sudo ypcat passwd
    ```

1.  Configure SSH:

    ```sh
    sudo mkdir /home/${NEWUSER}/.ssh
    sudo vim /home/${NEWUSER}/.ssh/authorized_keys
    sudo chmod 700 /home/${NEWUSER}/.ssh
    sudo chmod 600 /home/${NEWUSER}/.ssh/authorized_keys
    sudo chown -R ${NEWUSER}:users /home/${NEWUSER}/.ssh
    ```

1.  Add the user to
    [scorpion-tohoku](https://groups.google.com/forum/#!forum/scorpion-tohoku):
    "Manage" => "Direct add members".
    Message example:

    ```
    Your email address has been registered to scorpion-tohoku mailing list.
    Various notifications such as server maintenance and updates will be delivered.
    You can also post questions and requests here.
    ```

1.  Send an email to them:

    ```
    Dear ______,
    CC: Prof. ______,

    You have been successfully registered as a user of the Scorpion system.
    Try logging in to the server with the following command:

    ssh scorpion
    or
    ssh ______@scorpion.biology.tohoku.ac.jp

    Best,
    Watal
    ```

### Remove a user

1.  `sudo userdel --remove ${THE_USER}`
1.  Update NIS
1.  Remove the user from [scorpion-tohoku](https://groups.google.com/forum/#!forum/scorpion-tohoku):
    "☑ Select => ⊖ Remove member"


## Initial settings

-   Modify `/etc/adduser.conf`:
    ```sh
    USERGROUPS=no
    DIR_MODE=0700
    ```
-   Clean `/etc/skel/`.
-   Create `/etc/profile.d/scorpion.sh` to set `PATH` for all the users.
-   Disable `motd`:
    ```sh
    cd /etc/update-motd.d
    sudo mkdir disabled
    sudo mv *-* disabled/
    ```


## Install softwares

### apt

```
sudo apt update
sudo apt install build-essential zsh emacs g++-8 clang-8
sudo apt install libblas-dev liblapack-dev libatlas-base-dev f2c
```

### Homebrew

https://docs.brew.sh/Homebrew-on-Linux

- If the software is available on Homebrew, use it.
- `brew` must be executed by a non-root user.
- Unlink `gcc` to remove it from `PATH`.
- Append `eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)` to `/etc/profile.d/scorpion.sh`.


### Python

Install python3 and some packages:
```sh
brew install python
$(brew --prefix)/bin/pip3 install -U pip setuptools wheel
$(brew --prefix)/bin/pip3 install -U --upgrade-strategy=eager -r /home/linuxbrew/requirements.txt
```

Check updates:
```sh
$(brew --prefix)/bin/pip3 list --outdated
```

### R

- https://cran.r-project.org/bin/linux/ubuntu/
- https://cran.r-project.org/doc/manuals/R-admin.html

Install R from the official repository:
```sh
sudo apt install --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt update
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
R_LIBS_SITE="/home/local/lib/R/library/%v"
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
mkdir -p /home/local/lib/R/library/4.2
```

Install packages to site library as `root`:
```sh
sudo MAKEFLAGS=-j8 R --no-save --no-restore-data
```
```r
.Library.site
.libPaths()
getOption("repos")
source("https://docs.rstudio.com/rspm/admin/check-user-agent.R")

install.packages("pak", lib = .Library.site)

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
pak::pkg_install(pkgs, lib = .Library.site)

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
pak::pkg_install(biocpkgs, lib = .Library.site)

pak::repo_add(stan = "https://mc-stan.org/r-packages")
pak::pkg_install("cmdstanr", lib = .Library.site)
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

- Download an archive to `/home/local/src/`
- Install it with a prefix `/home/local`
- If the software does not provide any installation method,
  move the whole directory to `/home/local/Cellar/` with a version number,
  and create symlinks to `/home/local/bin`, `include`, `lib`, and so on.


## PBS

`/etc/pbs.conf` in head node:
```ini
PBS_EXEC=/opt/pbs
PBS_SERVER=scorpion
PBS_START_SERVER=1
PBS_START_SCHED=1
PBS_START_COMM=1
PBS_START_MOM=0
PBS_HOME=/var/spool/pbs
PBS_CORE_LIMIT=unlimited
PBS_SCP=/usr/bin/scp
```

`PBS_START_MOM=1` in compute nodes.

Some config files and logs are stored in `$PBS_HOME` (`/var/spool/pbs/`).


### Configuring the Server and Queues

```sh
man /opt/pbs/bin/qmgr

# interactively
qmgr

# with stdin
echo "print server" | qmgr
qmgr < input_file

# with command-line arguments
qmgr -c "print server"
qmgr -c "set server job_history_enable=True"
qmgr -c "set server job_history_duration=720:00:00"
```


## Install hardwares

-   https://www.hpc.co.jp/
