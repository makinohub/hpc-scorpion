+++
title = "Usage"
menu = "main"
weight = 5
+++

## Getting Started

1.  **Read through all the pages in this document.**
1.  [Prepare an SSH key pair on your local computer]({{< relref "usage.md#how-to-setup-ssh-keys" >}}).
1.  Complete [the online registration form](https://forms.gle/8bMtnevb9oxsRz6q9).
1.  Wait for a while until you are added to [the user mailing list](https://groups.google.com/forum/#!forum/scorpion-tohoku).
1.  Login to the server: `ssh USERNAME@scorpion.biology.tohoku.ac.jp`

<!--more-->

## Notes

- Access:
    - Feel free to post any question and request to
      [the mailing list](https://groups.google.com/forum/#!forum/scorpion-tohoku).
      It will help other users and improving this document.
      Do NOT contact the administrators personally.
    - No graphical user interface (GUI) is available;
      all the operation has to be carried out with a **command-line interface (CLI)** over **SSH** connection.
      Basic knowledge of shell scripting is required.
    - <del>The server is accessible **only from the Tohoku University LAN**.
      You may want to consider [TAINS VPN](https://www.tains.tohoku.ac.jp/contents/remote/remote-access.html) for remote access.</del>
      Now the server is temporarily accessible from everywhere.
      Please keep the URL secret to reduce the potential risk of attacks.
- Data Storage:
    - **20GB** disk space is allocated for each user.
      The size may be changed in the future.
    - **Do NOT think this system as a long-term storage service**.
      Transfer output data to your local computer,
      and delete them from the server immediately after each job execution.
      Or, at least, always keep your data deletable on the server.
    - It is recommended to use [**rsync**](https://www.google.co.jp/search?q=rsync+ssh)
      to transfer/synchronize your files between your local computer and the server.
      [**Git**](https://git-scm.com/) is also useful to manage your scripts.
    - Your home directory `~/` on the head node is shared with the compute nodes.
      You don't have to care about data transfer between nodes within the system.
- Job execution:
    - **Do NOT execute programs directly on the head node**.
      All the computational tasks must be managed by the PBS job scheduler
      [(as detailed below)](#pbs-job-scheduler).
      Very small tasks in the following examples are the exceptions,
      i.e., you can execute only these commands on the head node:
        - Basic shell operation: `pwd`, `cd`, `ls`, `cat`, `mv`, `rm`, etc.
        - File transfer: `rsync`, `git`, etc.
        - Text editor: `vim`, `emacs`, `nano`, etc.
        - Compilation/installation of a small program:
          `gcc`, `make`, `cmake`, `pip`, etc.
        - PBS command: `pbsnodes`, `qstat`, `qsub`, etc.
    - Check [the list of available softwares]({{< relref "software.md" >}}).
      You can install additional softwares into your home directory,
      or ask the administrator via the mailing list for system-wide installation.

## How to setup SSH keys

1.  Prepare UNIX-like OS such as macOS and Linux.

    - Windows users can setup Linux (Ubuntu) environment via [WSL](https://www.google.co.jp/search?q=wsl+windows).

      In WSL terminal, create/open `/etc/wsl.conf` file (with a command like `sudo nano /etc/wsl.conf`)
      and add the following lines:
      ```
      [automount]
      options = "metadata"
      ```

      Then, **restart WSL** (or Windows) to enable the config above.
      This setting is required to set permissions with `chmod` command.

1.  Generate SSH keys on the terminal of your local computer with the following command:

    ```
    mkdir ~/.ssh
    ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519_scorpion
    ```

1.  Create `~/.ssh/config` file (plain text, **not directory**) on your local computer, and write some lines as follows:

    ```
    Host scorpion scorpion.biology.tohoku.ac.jp
      Hostname scorpion.biology.tohoku.ac.jp
      IdentityFile ~/.ssh/id_ed25519_scorpion
      User tamakino
    ```

    **Replace `tamakino` with your user name on scorpion server**
    (NOT the one on your local computer).
    You can decide your user name, but it should be **short and lowercase alphabets** without any space or special character.

1.  Check the created keys and config file:

    ```sh
    ls -al ~/.ssh
    # drwx------ 11 winston staff 374 Apr  4 10:00 ./
    # -rw-r--r--  1 winston staff 749 Apr  4 10:00 config
    # -rw-------  1 winston staff 399 Apr  4 10:00 id_ed25519_scorpion
    # -rw-r--r--  1 winston staff  92 Apr  4 10:00 id_ed25519_scorpion.pub
    ```

    The [permissions](https://www.google.co.jp/search?q=permission+unix) of `~/.ssh` and `~/.ssh/id_ed25519_scorpion` must be `700` (`drwx------`) and `600` (`-rw-------`), respectively.
    Execute the following commands to set permissions correctly:
    ```sh
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/id_ed25519_scorpion
    chmod 644 ~/.ssh/config
    ```

    Check `ls -al ~/.ssh` again.

1.  Copy and paste the whole content of the public key (**NOT** private key) to
    [the online registration form](https://forms.gle/8bMtnevb9oxsRz6q9).
    For example, `pbcopy` command is useful on macOS:

    ```sh
    cat ~/.ssh/id_ed25519_scorpion.pub | pbcopy
    ```

1.  The administrator will notify you when your public key is registered to your `~/.ssh/authorized_keys` on the server.
    Then you can login to scorpion with the following command:

    ```sh
    ssh scorpion
    # or
    ssh YOUR_USERNAME@scorpion.biology.tohoku.ac.jp
    ```

You can add another public key to `~/.ssh/authorized_keys` by yourself so that you can login from your secondary PC.
Do not submit user registration twice.


## PBS job scheduler

Read [PBS User's Guide](https://www.google.co.jp/search?q=pbs+professional+19+user's+guide).

### Check ths system status

```
pbsnodes -aSj
```

### Check the status of jobs

```sh
# List
qstat -x

# See the detail of a job
qstat -fx <PBS_JOBID>
```

### Delete a job

```sh
qdel <PBS_JOBID>
```

### Submit a job

You can submit a job in several ways:

```sh
# stdin
echo "echo 'hello world!'; sleep 60" | qsub -N hello

# giving the full path to a program
qsub -N hello -- /bin/echo "hello world!"

# job script
qsub hello.sh
```

An example job script `hello.sh`:

```sh
#!/bin/bash
#PBS -N hello
#PBS -l select=1:ncpus=1:mem=1gb

pwd
cd $PBS_O_WORKDIR
pwd
echo "Hello, world!"
sleep 60
```

An example of an array job `array.sh`:

```sh
#!/bin/bash
#PBS -N array-ms
#PBS -l select=1:ncpus=1:mem=1gb
#PBS -J 0-3

cd $PBS_O_WORKDIR
param_range=($(seq 5.0 0.5 6.5))  # (5.0, 5.5, 6.0, 6.5)
theta=${param_range[@]:${PBS_ARRAY_INDEX}:1}
ms 4 2 -t $theta
```

An equivalent job script in Python:

```py
#!/usr/bin/env python3
#PBS -N array-ms-py
#PBS -l select=1:ncpus=1:mem=1gb
#PBS -J 0-3
import os
import subprocess
import numpy as np

os.chdir(os.getenv('PBS_O_WORKDIR', '.'))
array_index = int(os.getenv('PBS_ARRAY_INDEX', '0'))
param_range = np.linspace(5.0, 6.5, 4)  # [5.0, 5.5, 6.0, 6.5]
theta = param_range[array_index]
cmd = 'ms 4 2 -t {}'.format(theta)
proc = subprocess.run(cmd.split(), stdout=subprocess.PIPE)
print(proc.stdout.decode(), end='')
```

Useful options and environment variables:

`-N jobname`
: to set job's name.

`-o ***`, `-e ***`
: to specify the path for the standard output/error stream.
  By default, they are writen to the current working directory where `qsub` was executed,
  i.e., `${PBS_O_WORKDIR}/${PBS_JOBNAME}.o<sequence_number>`

`-j oe`
: to merge the standard error stream into the standard output stream.
  It is equivalent to `2>&1` in shell redirection.

`-J 0-3`
: to declare the job is an array job (with size 4 in this example).
  A current index (`0`, `1`, ...) can be obtained via `PBS_ARRAY_INDEX`.

`-l ***`
: to request PBS job scheduler to allocate resources for a job.
  A job has to wait in a queue until the requested resources are available.
: e.g., `-l select=1:ncpus=4:mem=32gb:host=scorpion02`
  requests 4 CPU cores and 32GB RAM (in total, not per core) on `scorpion02` node.
: Note that it does not affect how a job script itself and programs run,
  i.e., it does not automatically accelerate single-threaded jobs.
  To achieve parallel execution using multiple CPU cores,
  you need to write your script as such,
  or to give an explicit option to each program like
  `blast -num_threads 4`, `samtools -@ 4`, `make -j4`, etc.

`-v VAR1=value,VAR2`
: to export environment variables to the job.
: `-V` to export all the variables in the current shell environment.

`PBS_JOBID`
: the ID of the job.

`PBS_JOBNAME`
: the name of the job.

`PBS_O_WORKDIR`
: the working directory where `qsub` was called.
  By default, stdout/stderr are copied to here,
  although jobs are executed in `$HOME`.
  You may want to `cd $PBS_O_WORKDIR` in many cases.

See `man qsub` for more details.
