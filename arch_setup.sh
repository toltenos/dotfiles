#!/usr/bin/env bash
set -ex

install_python_deps() {
    pip install -U --user \
        "python-language-server[all]" \
        awscli \
        bandit \
        black \
        boto3 \
        bpytop \
        dataset \
        dateparser \
        django-stubs \
        docker-compose \
        flake8 \
        flake8-polyfill \
        ipdb \
        ipython \
        iredis \
        jedi \
        litecli \
        mypy \
        neovim \
        nptime \
        pipenv \
        pulumi \
        pulumi-kubernetes \
        pulumi-hcloud \
        pulumi-aws \
        pydocstyle \
        pyflakes \
        pyinotify \
        python-dateutil \
        radon \
        requests \
        selenium \
        youtube-dl \
        vim-vint \
        yamllint \
        --no-warn-script-location \
        && echo -e '\033[1mPIP install success\033[0m'
    }


install_go_packages() {
    export GOPATH=~/code/go

    go get -u github.com/motemen/gore/cmd/gore
    go get -u github.com/stamblerre/gocode
    go get -u golang.org/x/tools/cmd/godoc
    go get -u golang.org/x/tools/cmd/goimports
    go get -u golang.org/x/tools/cmd/gorename
    go get -u golang.org/x/tools/cmd/guru
    go get -u github.com/cweill/gotests/...
    go get -u github.com/fatih/gomodifytags
    go get -u github.com/ericchiang/pup
}

install_yay() {
    command -v yay 2>/dev/null && return

    pushd .

    rm -rf /tmp/yay-install
    mkdir /tmp/yay-install
    cd /tmp/yay-install
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm

    popd
}

install_base_pacman_packages() {
    sudo pacman -S --needed --noconfirm \
        base-devel \
        kubectl \
        postgresql \
        tmux \
        neovim \
        man-db \
        man-pages \
        git \
        stow \
        ctags \
        npm \
        rclone \
        nodejs \
        ripgrep \
        fzf \
        exa \
        bat \
        fd \
        wget \
        go \
        jq \
        rust \
        zsh \
        tldr \
        zsh-completions \
        zsh-syntax-highlighting \
        python \
    && echo -e '\033[1mPacman base install success\033[0m'

    tldr -u
    sudo sed -i '/PasswordAuthentication/c\PasswordAuthentication no' /etc/ssh/sshd_config
    sudo systemctl enable sshd --now

    sudo chsh $(whoami) -s /bin/zsh
}

install_desktop_pacman_packages() {
    sudo pacman -S --needed --noconfirm \
        docker \
        xclip \
        smb4k \
        alacritty \
        pamixer \
        telegram-desktop \
        mpv \
        libldac \
        acpi \
        pavucontrol \
        brightnessctl \
        playerctl \
    && echo -e '\033[1mDesktop install success\033[0m'

    sudo gpasswd -a $USER docker
    sudo systemctl enable docker --now

    yay -S --needed --noconfirm \
        pulseaudio-modules-bt
}


install_npm_packages() {
    sudo npm install -g --silent @bitwarden/cli
    sudo npm install -g --silent \
        neovim \
        bash-language-server \
        dockerfile-language-server-nodejs \
        elasticdump \
        javascript-typescript-langserver \
        marked \
        prettier \
        pyright \
        standard \
    && echo -e '\033[1mNPM install success\033[0m'

}

install_yay_packages() {
    yay -S --needed --noconfirm \
        google-chrome \
        mailspring \
        toptracker \
        pulumi-bin \
    && echo -e '\033[1mYAY install success\033[0m'

    # sudo pacman -S --needed --noconfirm libsecret gnome-keyring
}

install_base_pacman_packages
install_yay
install_yay_packages
install_python_deps
install_go_packages
install_npm_packages
install_desktop_pacman_packages
