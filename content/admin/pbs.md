+++
title = "PBS"
draft = true
[menu.main]
  parent = "admin"
+++

<https://github.com/openpbs/openpbs>

## Build from source

Preparation.
Make sure `PATH` contains only stable and standard directories:
```sh
sudo su -
PATH=/opt/pbs/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

Backup `qmgr` settings:
```sh
qmgr -c "print server" > qmgr_print_server.txt
qmgr -c "print node @default" > qmgr_print_node_default.txt
```

Stop and move old installation:
```sh
service pbs stop
ps -ef | grep pbs_
mv /opt/pbs /opt/pbs-pro
mv /var/spool/pbs /var/spool/pbs-pro
```

Download the latest source, and read `INSTALL`:
```sh
cd /home/local/src/
[ -e "openpbs" ] || git clone https://github.com/openpbs/openpbs.git
cd openpbs/
git pull
less INSTALL
```

Install the prerequisites:
```sh
apt install gcc make libtool libhwloc-dev libx11-dev \
  libxt-dev libedit-dev libical-dev ncurses-dev perl \
  postgresql-server-dev-all postgresql-contrib python3-dev tcl-dev tk-dev swig \
  libexpat-dev libssl-dev libxext-dev libxft-dev autoconf \
  automake g++
apt install expat libedit2 postgresql python3 postgresql-contrib sendmail-bin \
  sudo tcl tk libical3 postgresql-server-dev-all
```

Build and install OpenPBS:
```sh
./autogen.sh
./configure --help
./configure --prefix=/opt/pbs
make -j4
make install
/opt/pbs/libexec/pbs_postinstall
chmod 4755 /opt/pbs/sbin/pbs_iff /opt/pbs/sbin/pbs_rcp
```


## Configuration

Set time zone:
```sh
# /var/spool/pbs/pbs_environment
PATH=/bin:/usr/bin
TZ="Asia/Tokyo"
```

Configure head node:
```ini
# /etc/pbs.conf
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

Configure compute nodes:
```ini
# /etc/pbs.conf
PBS_EXEC=/opt/pbs
PBS_SERVER=scorpion
PBS_START_SERVER=0
PBS_START_SCHED=0
PBS_START_COMM=0
PBS_START_MOM=1
PBS_HOME=/var/spool/pbs
PBS_CORE_LIMIT=unlimited
PBS_SCP=/usr/bin/scp
```
```
# /var/spool/pbs/mom_priv/config
$clienthost scorpion
$usecp *:/home/ /home/
$restrict_user_maxsysid 999
```

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


Restore `qmgr` settings from the backup:
```sh
qmgr < qmgr_print_server.txt
qmgr < qmgr_print_node_default.txt
qmgr -c "print server"
qmgr -c "list node @default"
```

Start service:
```sh
/etc/init.d/pbs start
/etc/init.d/pbs status
qstat -B
pbsnodes -a
```
