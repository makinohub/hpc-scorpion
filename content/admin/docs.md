+++
title = "Documentation"
draft = true
[menu.main]
  parent = "admin"
+++

## Preparation

1.  Install [Hugo](https://gohugo.io/) on your local machine.
1.  Fork [makinohub/hpc-scorpion](https://github.com/makinohub/hpc-scorpion) to your account.
1.  Clone your fork repository to your local machine:
    ```sh
    REPO=https://github.com/{YOUR_NAME_HERE}/hpc-scorpion.git
    git clone -b master --single-branch --recurse-submodules $REPO
    cd hpc-scorpion/
    ```
1.  Set `upstream` repository:
    `git remote add upstream https://github.com/makinohub/hpc-scorpion.git`


## Routine

1.  Fetch and merge any updates in `upstream` to your `origin`.
1.  Start a local hugo server to preview the output:
    `hugo -Dw server`<br>
1.  View: <http://localhost:1313/hpc-scorpion/>
    (the port may vary)
1.  Edit some markdown files in `content/`.
    The output HTML gets updated immediately by the hugo server.
1.  Stop the hugo server: <kbd>ctrl</kbd><kbd>c</kbd>
1.  Make a new branch to commit the updates.
1.  Make a Pull Request to [makinohub/hpc-scorpion](https://github.com/makinohub/hpc-scorpion).


## Deploy document

```sh
make public && make deploy
```

1.  Generate public documents.
1.  Copy generated documents to `scorpion:/var/www/html/`.
