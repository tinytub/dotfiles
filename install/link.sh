#!/usr/bin/env bash

DOTFILES=$HOME/.dotfiles

echo -e "\\nCreating symlinks"
echo "=============================="
# 基础文件,如 tmux,zshrc 的软连
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
    target="$HOME/.$( basename "$file" '.symlink' )"
    if [ -e "$target" ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating symlink for $file"
        ln -s "$file" "$target"
    fi
done

echo -e "\\n\\ninstalling to ~/.config"
echo "=============================="
if [ ! -d "$HOME/.config" ]; then
    echo "Creating ~/.config"
    mkdir -p "$HOME/.config"
fi

# for nvim
if [ -e "$HOME/.config/nvim" ]; then
    echo "nvim config ok"
else
    ln -s "$DOTFILES/config/nvim" "$HOME/.config/"
fi

# for vim8
if [ -e "$HOME/.config/nvim" ]; then
    echo "vim8 config ok"
else
    ln -s "$DOTFILES/config/nvim" "$HOME/.vim"
fi

#config_files=$( find "$DOTFILES/config" -d 1 2>/dev/null )
## nvim 相关目录及文件
#for config in $config_files; do
#    target="$HOME/.config/$( basename "$config" )"
#    if [ -e "$target" ]; then
#        echo "~${target#$HOME} already exists... Skipping."
#    else
#        echo "Creating symlink for $config"
#        ln -s "$config" "$target"
#    fi
#done

# create vim symlinks
# As I have moved off of vim as my full time editor in favor of neovim,
# I feel it doesn't make sense to leave my vimrc intact in the dotfiles repo
# as it is not really being actively maintained. However, I would still
# like to configure vim, so lets symlink ~/.vimrc and ~/.vim over to their
# neovim equivalent.
# vim 配置文件软连接
echo -e "\\n\\nCreating vim symlinks"
echo "=============================="
VIMFILES=( "$HOME/.vim:$DOTFILES/config/nvim"
        "$HOME/.vimrc:$DOTFILES/config/nvim/init.vim" )

for file in "${VIMFILES[@]}"; do
    KEY=${file%%:*}
    VALUE=${file#*:}
        ln -sf "${VALUE}" "${KEY}"
    if [ -e "${KEY}" ]; then
        echo "${KEY} already exists... skipping."
    else
        echo "Creating symlink for $KEY"
        ln -sf "${VALUE}" "${KEY}"
    fi
done
