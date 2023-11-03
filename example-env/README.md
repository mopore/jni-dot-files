# Neovim Dev Environment via Dockerfile
- Build the image with the provided Dockerfile:
```bash
docker buildx -t manjarotest-env .
```

- Run the container (as a temporary container) to test the environment:
```bash
docker container run --rm -it manjarotest-env
```

# Neovim Dev Environment Manual Creation
Execute the following commands (inside a container):

## Base Image
- Start with the running the Manjaro base image as a container:
```bash
docker container run --name manjarotest -it manjarolinux/base
```

## System Update and Dependencies
- Update the system `pacman -Syu --noconfirm`
- Install base dev tools `pacman -S --noconfirm git gcc make &&`
- And furhter dev tools `pacman -S --noconfirm nodejs npm go python python-pip`
- Install packages for tis demo `pacman -S --noconfirm ripgrep fzf exa bat zoxide neovim`

## JNI Shell
- Switch to home `cd ~`
- Clone the JNI dot files `git clone https://github.com/mopore/jni-dot-files`
- Switch to JNI shell directory `cd jni-dot-files/jni-shell`
- Execute `./install_jni-shell.sh`
- Exit the shell (the container will be stopped)
- Start the container again `docker container start manjarotest`
- Enter the container `docker container exec -it manjarotest /bin/zsh`

## Neovim  Config
- Install neovim config by moving to `~/jni-dot-files/neovim` and executing 
`./install.sh`

## Snapshotting to a new image
- Exit the container and commit the changes to a new image:
```bash
docker container commit manjarotest manjarotest-neovim
```

- Then stop and remove the test container:
```bash
docker container stop manjarotest && \
docker container rm manjarotest
```

- Run the new container with neovim installed:
```bash
docker container run --rm -it manjarotest-neovim /bin/zsh
```

# Appendix
## Committing/Snapshotting a container
- Run a container named "manajortest" to operate on.
```bash
docker container run --name manjarotest -it manjarolinux/base
```

- Change the content of the container.
```bash
echo "Hello PXD" > /test.txt
```

- Commit your change to a new image.
```bash
docker container commit manjarotest manjarotest-test.txt
```

- Stop and remove the committed container: 
```bash
docker container stop manjarotest && \
docker container rm manjarotest
```

- Test if the newly created image contains the file.
```bash
docker container run --rm manjarotest-test.txt cat /test.txt
```
