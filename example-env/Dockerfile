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
    pacman -S --noconfirm git gcc nodejs npm go gcc make python python-pip && \
    pacman -S --noconfirm ripgrep fzf zoxide exa bat neovim 

# Install JNI Shell with zsh, oh-my-zsh and powerlevel10k
RUN git clone https://github.com/mopore/jni-dot-files && \
    /root/jni-dot-files/jni-shell/install_jni-shell.sh

# Install Neovim config
RUN cd /root/jni-dot-files/neovim
RUN /bin/zsh -c "source /root/jni-dot-files/neovim/install.sh --noconfirm"

CMD ["/bin/zsh"]
