JNI SHELL
=========

## What it will perform
* Installs zsh, oh my zsh, PowerLevel10k theme.
* Configures the above with my favorite settings.
* Provides a custom shell configuration file with aliases and extra configs

## How to install

```
curl -sSL https://raw.githubusercontent.com/mopore/jni-dot-files/main/vim/install_neovim_config.sh | /bin/bash
```


## Configuration Overview

### General


## For testing with Debian or Manjaro in Docker
### Debian-based
Create the container in the background. Start with bash, execute the script and exit.
```
docker run -it --rm -d --name debian_test debian && \
docker exec -it debian_test /bin/bash
```

In the container add sudo and curl an install the shell:
```
apt-get update && apt-get upgrade -y && apt-get install -y sudo curl
curl -sSL https://raw.githubusercontent.com/mopore/jni-dot-files/main/jni-shell/install_jni-shell.sh | /bin/bash
```
Exit the container.

Test the newly installed zsh:
```
docker exec -it debian_test /bin/zsh 
```

Stop the container (which will remove it):
```
docker container stop debian_test
```

### Manjaro
Create the container in the background. Start with bash, execute the script and exit.
```
docker run -it --rm -d --name manjaro_test manjarolinux/base && \
docker exec -it manjaro_test /bin/bash
```

In the container install the shell with: `curl -sSL https://raw.githubusercontent.com/mopore/jni-dot-files/main/jni-shell/install_jni-shell.sh | /bin/bash`

Exit the container.

Test the newly installed zsh:
```
docker exec -it manjaro_test /bin/zsh 
```

Stop the container (which will remove it):
```
docker container stop manjaro_test
```

