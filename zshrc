# some config from https://github.com/nicknisi/dotfiles/blob/master/zsh/zshrc.symlink
export ZSH=$HOME/.oh-my-zsh
# display how long all tasks over 10 seconds take
export REPORTTIME=10


ZSH_THEME="fino"
plugins=(git vim python golang osx tmux)
source $ZSH/oh-my-zsh.sh
#source ~/.bash_profile
source ~/.vim/plugged/gruvbox/gruvbox_256palette.sh
#export GOPATH="/home/zhaopeng/goworks"
#export GOROOT="/usr/local/go"
export GOPATH="/home/zhaopeng/goworks"
export GOROOT="/home/zhaopeng/go1.11"
#export GOPATH="/home/zhaopeng/goworks1.8.3/src/jd.com/jstack-thirdparty-libs"
#export GOROOT="/home/zhaopeng/go1.8.3"
export PATH="$HOME/bin:$GOROOT/bin:$GOPATH/bin:$PATH"

#autossh
export AUTOSSH_PIDFILE=~/autossh.pid
export AUTOSSH_POLL=60
export AUTOSSH_FIRST_POLL=30
export AUTOSSH_GATETIME=0
export AUTOSSH_DEBUG=1
alias vim="nvim"

# adding path directory for custom scripts

#if [ -z "$TMUX" ]; then
#    #export TERM=xterm-256color-italic
#    export TERM=xterm-256color
#else
#    export TERM=tmux-256color-italic
#    #export TERM=xterm-color
#fi

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

export EDITOR="vim"


function start_tuproxy {
    export https_proxy=http://127.0.0.1:8888;export http_proxy=http://127.0.0.1:8888
}

function start_git_proxy {
    export http_proxy=http://git-proxy.jcloud.com:80
}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# tmux
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'

