# Create the Neovim Dev environment Image manually

Run the Manjaro base image
```bash
docker container run --name manjarotest -it manjarolinux/base
```

Exectute the following inside the container:

## Prepare the system
Update the system `pacman -Syu --noconfirm`
Install base dev tools `pacman -S --noconfirm git gcc make`
And furhter dev tools `pacman -S --noconfirm nodejs npm go python python-pip`
Install packages for tis demo `pacman -S --noconfirm ripgrep fzf exa bat neovim`

Switch to home `cd ~`
Clone the jni dot files `git clone https://github.com/mopore/jni-dot-files`
Switch to jni shell directory `cd jni-dot-files/jni-shell`
Execute `./install_jni-shell.sh`
Exit the shell (the container will be stopped)
Start the container again `docker container start manjarotest`
Enter the container `docker container exec -it manjarotest /bin/zsh`

Install neovim config by moving to `~/jni-dot-files/neovim` and executing 
`./install.sh`

You could commit the new container version with neovim installed:
```bash
docker container commit manjarotest manjarotest-neovim
```
Then stop and remove the test container:
```bash
docker container stop manjarotest && \
docker container rm manjarotest
```

Run the new container with neovim installed:
```bash
docker container run --rm -it manjarotest-neovim /bin/zsh
```


# Committing/Snapshotting a container
Run a container named "manajortest" to operate on.
```bash
docker container run --name manjarotest -it manjarolinux/base
```

Change the content of the container.
```bash
echo "Hello PXD" > /test.txt
```

Commit your change to a new image.
```bash
docker container commit manjarotest manjarotest-test.txt
```

Stop and remove the committed container: 
```bash
docker container stop manjarotest && \
docker container rm manjarotest
```

Test if the newly created image contains the file.
```bash
docker container run --rm manjarotest-test.txt cat /test.txt
```
