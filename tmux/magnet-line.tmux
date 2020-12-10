## Move status bar to the top
#set -g status 'on'
##set -g status-position top
#set -g status-position bottom
#set -g status-justify 'centre'
#set -g status-left-length '100'
#set -g status-right-length '100'
#
#set-window-option -g window-status-format '#[bg=colour238]#[fg=colour107] #I #[bg=colour239]#[fg=colour110] #[bg=colour240]#W#[bg=colour239]#[fg=colour195]#F#[bg=colour238] '
#set-window-option -g window-status-current-format '#[bg=colour236]#[fg=colour215,bold] #I:#[bg=colour235]#[fg=colour167] #[bg=colour234]#W#[bg=colour235]#[fg=colour195]#F#[bg=colour236] '
#
#set -g status-left '\
##[fg=colour232,bg=#6272a4] %Y-%m-%d \
##[bg=#1b2b34] \
##[fg=colour232,bg=#6272a4] %a %H:%M '
##[fg=colour232,bg=colour154] #(rainbarf --battery --remaining --no-rgb) '
#
#set -g status-right '\
##{?client_prefix,🐠,} \
##[bg=#1b2b34] '


# status bar
set -g status-fg colour8
set -g status-bg colour234
# current session
set -g status-left ' #S '
set -g status-left-length 15
# set -g status-left-fg colour229
# set -g status-left-bg colour166
# window list
set -g window-status-format "#[fg=colour8] #I #[fg=colour231]#W#[fg=colour166]#F "
set -g window-status-current-format "#[fg=colour117,bg=colour31] #I #[fg=colour231]#W#[fg=colour234]#F "
set -g window-status-separator ""
# battery status
set -g status-right ' #(battery) '
set -g status-interval 15
