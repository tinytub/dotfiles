#!/bin/bash

wget https://raw.githubusercontent.com/tinytub/vim/master/vimrc -O $HOME/.vimrc
go get -u github.com/jstemmer/gotags

vim -E -u $HOME/.vimrc +qall

echo 'Install Complete! '
