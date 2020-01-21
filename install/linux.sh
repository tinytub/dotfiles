#!/usr/bin/env bash

if test ! "$( command -v zsh )"; then
yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
yum install -y zsh wget curl ripgrep
fi

ZSH=${ZSH:-~/.oh-my-zsh}
if [ ! -d "$ZSH" ]; then
	#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if test ! "$( command -v node )"; then
	curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash -
	yum install -y nodejs
fi

if test ! "$( command -v yarn )"; then
	curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
	sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
	yum install -y yarn
fi

#ctags

if test ! "$( command -v ctags )"; then
	yum install -y autoconf automake libtool
	git clone https://github.com/universal-ctags/ctags.git ~/ctags
	cd ~/ctags
	./autogen.sh 
	./configure
	make
	make install
	cd -
fi


FZFBase=${FZFBase:-~/.fzf/}
if [ ! -d "$FZFBase" ]; then 
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi

#if test ! "$( command -v brew )"; then
#    echo "Installing homebrew"
#    ruby -e "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install )"
#fi
#
#echo -e "\\n\\nInstalling homebrew packages..."
#echo "=============================="
#
#formulas=(
#
#    bat
#    diff-so-fancy
#    dnsmasq
#    fzf
#    git
#    grep
#    highlight
#    hub
#    markdown
#    mas
#    neovim
#    python
#    reattach-to-user-namespace
#    the_silver_searcher
#    shellcheck
#    tmux
#    trash
#    tree
#    wget
#    vim
#    z
#    zsh
#    ripgrep
#    git-standup
#    entr
#    yarn
#    --HEAD universal-ctags/universal-ctags/universal-ctags
#    zsh-autosuggestions
#    autojump
#)
#
#for formula in "${formulas[@]}"; do
#    formula_name=$( echo "$formula" | awk '{print $1}' )
#    if brew list "$formula_name" > /dev/null 2>&1; then
#        echo "$formula_name already installed... skipping."
#    else
#        brew install "$formula"
#    fi
#done

# Install fnm from the creator's custom tap until it's merged into main.
# fast node manager https://github.com/Schniz/fnm
brew install Schniz/tap/fnm

# After the install, setup fzf
echo -e "\\n\\nRunning fzf install script..."
echo "=============================="
~/.fzf/install --all --no-bash --no-fish

# Change the default shell to zsh
zsh_path="$( command -v zsh )"
if ! grep "$zsh_path" /etc/shells; then
    echo "adding $zsh_path to /etc/shells"
    echo "$zsh_path" | sudo tee -a /etc/shells
fi

if [[ "$SHELL" != "$zsh_path" ]]; then
    chsh -s "$zsh_path"
    echo "default shell changed to $zsh_path"
fi
