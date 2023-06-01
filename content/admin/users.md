+++
title = "Users"
draft = true
[menu.main]
  parent = "admin"
+++

## NIS

### NIS server

```conf
# /etc/defaultdomain
scorpion

# /etc/default/nis
NISSERVER=master
NISCLIENT=false

# /etc/yp.conf
ypserver scorpion.local

# /etc/ypserv.securenetsssh
255.255.255.0           192.168.1.0

ypbind -c
sudo systemctl restart rpcbind ypserv yppasswdd ypxfrd
sudo systemctl enable  rpcbind ypserv yppasswdd ypxfrd
sudo /usr/lib/yp/ypinit -m
```

### NIS client

```conf
# /etc/default/nis
NISSERVER=false
NISCLIENT=true

# /etc/yp.conf
domain scorpion server scorpion.local

# /etc/nsswitch.conf
passwd:         compat systemd nis
group:          compat systemd nis
shadow:         compat nis
gshadow:        files nis

ypbind -c
sudo systemctl restart rpcbind nscd ypbind
sudo systemctl enable  rpcbind nscd ypbind
sudo /usr/lib/yp/ypinit -s scorpion
ypcat passwd
```


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
