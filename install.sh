#!/bin/bash

wget https://raw.githubusercontent.com/tinytub/vim/master/vimrc -O $HOME/.vimrc
go get -u github.com/jstemmer/gotags

vim -E -u $HOME/.vimrc +qall

echo "need install vim8 --with-python3"

#编译python3


#编译vim
#sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common
#
#sudo apt-get install liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev
# sudo yum install -y ruby ruby-devel lua lua-devel luajit \
#     luajit-devel ctags git python python-devel \
#     python3 python3-devel tcl-devel \
#     perl perl-devel perl-ExtUtils-ParseXS \
#     perl-ExtUtils-XSpp perl-ExtUtils-CBuilder \
#     perl-ExtUtils-Embed
# This step is needed to rectify an issue with how Fedora 20 installs XSubPP:
# 
# # symlink xsubpp (perl) from /usr/bin to the perl dir
# sudo ln -s /usr/bin/xsubpp /usr/share/perl5/ExtUtils/xsubpp
#
##Optional: so vim can be uninstalled again via `dpkg -r vim`
#sudo apt-get install checkinstall
#
#sudo rm -rf /usr/local/share/vim /usr/bin/vim
#
#cd ~
#git clone https://github.com/vim/vim
#cd vim
#git pull && git fetch
#
##In case Vim was already installed
#cd src
#make distclean
#cd ..
#
#./configure \
#--enable-multibyte \
#--enable-perlinterp=dynamic \
#--enable-rubyinterp=dynamic \
#--with-ruby-command=/usr/local/bin/ruby \
#--enable-pythoninterp=dynamic \
#--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
#--enable-python3interp \
#--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
#--enable-luainterp \
#--with-luajit \
#--enable-cscope \
#--enable-gui=auto \
#--with-features=huge \
#--with-x \
#--enable-fontset \
#--enable-largefile \
#--disable-netbeans \
#--with-compiledby="yourname" \
#--enable-fail-if-missing

# 用这个

sudo yum install -y ruby ruby-devel lua lua-devel luajit     luajit-devel ctags git python python-devel     python3 python3-devel tcl-devel     perl perl-devel perl-ExtUtils-ParseXS     perl-ExtUtils-XSpp perl-ExtUtils-CBuilder     perl-ExtUtils-Embed
sudo ln -s /usr/bin/xsubpp /usr/share/perl5/ExtUtils/xsubpp
yum search python3
yum install python34.x86_64 python34-devel
yum install python34-pip
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib64/python2.6/config \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.5/config \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr/local

make VIMRUNTIMEDIR=/usr/local/share/vim/vim80
make && sudo make install

# 如果用 nvim
ln -s ~/.vim .config/nvim
ln -s ~/.vimrc .config/nvim/init.vim

echo 'Install Complete! '

# tmux
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
TMUX_HOME=${TMUX_HOME:-'/usr/local/share/tmux'}
./configure --prefix=${TMUX_HOME%/} && make

cd
ln -sf vim/tmux/tmux.conf .tmux.conf
ln -sf vim/tmux/tmux.conf.local .tmux.conf.local

#oh my zsh
ln -sf vim/zshrc .zshrc

# 初始化 Python venv
sh venv.sh
# 初始化 coc.nvim
sh init_coc.sh

formulas=(
    #bat
    #diff-so-fancy
    fzf
    git
    grep 
    highlight
    #hub
    markdown
    #mas
    #neovim
    #node
    python
    reattach-to-user-namespace
    the_silver_searcher
    shellcheck
    tmux
    trash
    tree
    wget
    #vim
    z
    zsh
    ripgrep
    #git-standup
    #entr
    neovim --HEAD
    zplug   
    yarn
)

for formula in "${formulas[@]}"; do
    formula_name=$( echo "$formula" | awk '{print $1}' )
    if brew list "$formula_name" > /dev/null 2>&1; then
        echo "$formula_name already installed... skipping."
    else
        brew install "$formula"
    fi
done
