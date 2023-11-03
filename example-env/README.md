# Neovim Dev Environment via Dockerfile
Build the image with the provided Dockerfile:
```bash
docker buildx build -t neovim-testenv .
```

Run the container (as a temporary container) to test the environment:
```bash
docker container run --rm -it neovim-testenv
```

Note that the Github Copilot configuration is not included in this image.
You have to launch the container and trigger the authentication process
manually with the ex command `:Copilot auth`.
The configuration will then be store here:
```
~/.config/github-copilot
├── hosts.json
└── versions.json
```

# Neovim Dev Environment Manual Creation
Execute the following commands (inside a container):

## Base Image
Start with the running the Manjaro base image as a container:
```bash
docker container run --name manjarotest -it manjarolinux/base
```

## System Update and Dependencies
- Update the system `pacman -Syu --noconfirm`
- Install base dev tools `pacman -S --noconfirm git gcc make`
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

## Neovim Config and Github Copilot
- Install neovim config by moving to `~/jni-dot-files/neovim` and executing 
`./install.sh`

- After the installation run Neovim with `vim` (aliased to `nvim`) and trigger
the Github Copilot authentication process with the ex command `:Copilot auth`.

## Snapshotting to a new image
Exit the container and commit the changes to a new image:
```bash
docker container commit manjarotest neovim-testenv
```

Then stop and remove the test container:
```bash
docker container stop manjarotest && \
docker container rm manjarotest
```

Run the new container with neovim installed:
```bash
docker container run --rm -it neovim-testenv /bin/zsh
```

# Appendix
## Using Webserver Feature
Run the container with an open port:
```bash
docker container run --rm -p 8080:8080 -it pxd-neovim-devenv /bin/zsh
```
Use the command `webserver 8080` in a directory you want to have exposed.

## Committing/Snapshotting a container
Run a container named "manjaro-base" to operate on.
```bash
docker container run --name manjaro-base -it manjarolinux/base
```

Change the content of the container.
```bash
echo "Hello PXD" > /var/test.txt
```

Exit the container (stops it) and commit the changes to a new image.
```bash
docker container commit manjaro-base manjaro-test-txt
```

Remove the the stopped container you created a new image from:
```bash
docker container rm manjaro-base
```

Test if the newly created image contains the file.
```bash
docker container run --rm manjaro-test-txt cat /var/test.txt
```
