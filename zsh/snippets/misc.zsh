# https://superuser.com/questions/480928/is-there-any-command-like-time-but-for-memory-usage/767491
autoload -Uz colors
colors

() {
    local white_b=$fg_bold[white] blue=$fg[blue] rst=$reset_color
    TIMEFMT=("$white_b%J$rst"$'\n'
        "User: $blue%U$rst"$'\t'"System: $blue%S$rst  Total: $blue%*Es$rst"$'\n'
        "CPU:  $blue%P$rst"$'\t'"Mem:    $blue%M MB$rst")
}

SPROMPT="%B%F{yellow}zsh: correct '%R' be '%r' [nyae]?%f%b "

WORDCHARS=''
DIRSTACKSIZE=100

# 直接输入路径即可跳转
setopt auto_cd
# 允许多次重定向
setopt multios
# 自动添加目录栈
setopt auto_pushd
setopt pushd_ignore_dups
# 补全列表允许不同列宽
setopt listpacked
# 交互模式下使用注释
setopt interactive_comments
# RPROMPT 执行完命令后就消除, 便于复制
setopt transient_rprompt
# setopt 输出显示开关状态
setopt ksh_option_print
# 单引号中 '' 表示一个 '
setopt rc_quotes
# 增强 glob
setopt extended_glob
# 没有匹配时原样输出 glob 而不是报错
setopt no_nomatch
# 开启拼写检查
setopt correct
