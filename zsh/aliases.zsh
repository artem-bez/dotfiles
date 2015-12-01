alias ls='ls -F --color=auto'
alias l='ls -F'
alias l.='ls -CFd .*'
alias ll='ls -FhlA'
alias tf='tail -f'
alias cal='cal -3'
alias grep='grep --color=auto'
alias igrep='grep -i'
alias diff='colordiff'
alias df='df -h'
alias du='du -ch'
alias fehh='feh -rZFSname '
alias feht='feh -t -E 150 -y 150'
alias drb='dropbox-cli'
alias mkdir='mkdir -p'
alias tmuxn='tmux new'
alias tmuxa='tmua attach'
alias mpv='mpv --af=scaletempo'
alias tp=trash-put
alias e=$EDITOR
alias o=xdg-open
alias 'ps?'=pgrep -a
alias -g DN=/dev/null
alias -g L='| less'
alias -g HS='| cut -c -$((COLUMNS - 5)) | head -n $((LINES - 5))'
alias -g T='| tail'
alias -g TS='| cut -c -$((COLUMNS - 5)) | tail -n $((LINES - 5))'
alias -g TF='| tail -f'
alias -g S='| cut -c -$((COLUMNS - 5))'
alias -g XC='| xclip'
alias -g C='| wc -l'
alias suspend='systemctl suspend'
alias reboot='systemctl reboot'
alias shtdn='systemctl poweroff'

if [[ $UID != 0 ]]; then
  alias svim='sudo -E vim'
  alias upgrade='sudo pacmatic -Syu'
  alias pacs='sudo pacman -S'
fi
