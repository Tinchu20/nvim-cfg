#!/bin/bash

set -e

NVIM_REPO_URL="https://github.com/neovim/neovim.git"
BRANCH="stable"

installed_ver_chk()
{
    if command -v nvim &>/dev/null; then
        nvim --version | head -n 1 | awk '{print $2}' | sed 's/-.*//'
    fi
}

remote_ver_chk()
{
    git ls-remote --tags https://github.com/neovim/neovim.git   | 
        grep -E 'refs/tags/v[0-9]+\.[0-9]+\.[0-9]+$'            | 
        cut -d/ -f3                                             | 
        sort -V                                                 | 
        tail -n1
}

version_lt() 
{
	echo "Compare function"
    v1=$(echo "$1" | sed 's/^v//')
    v2=$(echo "$2" | sed 's/^v//')

    [ "$(printf '%s\n' "$v1" "$v2" | sort -V | head -n 1)" != "$v2" ]
}

install_required_software()
{
	echo "Installing software"
    git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
    cd nerd-fonts
    ./install.sh

    cd ..
    rm -rf nerd-fonts

    sudo apt install ripgrep
}

# MAIN
echo "[+] 🔍 Checking current Neovim version ..."
CURRENT_VERSION=$(installed_ver_chk)
echo "[-] Installed version : $CURRENT_VERSION"

echo "[+] 🔍 Checking remote repo Neovim version ..."
REMOTE_REPO_VERSION=$(remote_ver_chk)
echo "[-] Remote repo version : $REMOTE_REPO_VERSION"

if version_lt "$CURRENT_VERSION" "$REMOTE_REPO_VERSION"; then
    install_required_software
    echo "⚠️ Need to insall new version $REMOTE_REPO_VERSION"
    echo "  Downloading github repo"
    git clone $NVIM_REPO_URL
    cd neovim
    git checkout $BRANCH   # Use latest stable version
    echo "[+] 📦 Installing  neovim"
    make CMAKE_BUILD_TYPE=Debug
    sudo make install
else
    echo "✅  NVIM is updated"
fi

#Backup existing config
if [ -d "$HOME/.config/nvim" ]; then
    mv -f "$HOME/.config/nvim" "$HOME/.config/nvim.bak.$(date +%s)"
    echo "[-] ⚠️ Existing config backed up"
fi

git clone https://github.com/Tinchu20/nvim-cfg ~/.config/nvim
echo "[+] ✅ Done. Launch Neovim with: nvim"

echo " Neovim"   # nf-dev-neovim
echo " GitHub"   # nf-fa-github
echo " Git"      # nf-dev-git
echo " Nvim"

echo -e "\ue62b Neovim"
echo -e "\ue7c5 Neovim"
echo -e "\e[1;32m\ue7c5 Neovim\e[0m"

echo "✅ Success"
echo "⚠️ Warning"
echo "❌ Failed"
echo "📦 Installing package"
echo "🔍 Checking versions..."




