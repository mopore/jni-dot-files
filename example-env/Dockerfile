# Biuld with:
#
# docker buildx build -t example-env .
# Run with:
#
# docker container run -it --rm example-env


FROM manjarolinux/base:latest

ENV TERM xterm

WORKDIR /root

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm git gcc make && \
    pacman -S --noconfirm nodejs npm go python python-pip && \
    pacman -S --noconfirm ripgrep fzf exa bat zoxide neovim 

# Install JNI Shell with zsh, oh-my-zsh and powerlevel10k
RUN git clone https://github.com/mopore/jni-dot-files && \
    /root/jni-dot-files/jni-shell/install_jni-shell.sh

# Install Neovim config
WORKDIR /root/jni-dot-files/neovim/
RUN ./install.sh --noconfirm

WORKDIR /root
CMD ["/bin/zsh"]
