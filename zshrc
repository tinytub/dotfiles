export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="fino"
plugins=(git python golang osx)
source $ZSH/oh-my-zsh.sh

[[ -s "/Users/zhaopeng/.gvm/scripts/gvm" ]] && source "/Users/zhaopeng/.gvm/scripts/gvm"

export GOPATH="/Users/zhaopeng/Documents/local_project/goworks"
export GOROOT="/usr/local/go"
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/openssl/bin:$GOROOT/bin:$GOPATH/bin:$PATH"

#autossh
export AUTOSSH_PIDFILE=~/autossh.pid
export AUTOSSH_POLL=60
export AUTOSSH_FIRST_POLL=30
export AUTOSSH_GATETIME=0
export AUTOSSH_DEBUG=1
#export HOMEBREW_GITHUB_API_TOKEN="973779785e652a4787d5bd9b0a6ed54ddee9f782"
source ~/.bash_profile
source ~/.vim/plugged/gruvbox/gruvbox_256palette.sh
alias vim="nvim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#brew install ripgrep
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
