autoload -U edit-command-line
autoload -U colors && colors

source ~/.zsh/aliases.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/parameters.zsh
source ~/.zsh/setopt.zsh
# See https://wiki.archlinux.org/index.php/Pkgfile
source /usr/share/doc/pkgfile/command-not-found.zsh
# venvwrapper must be sources after exports.
source /usr/bin/virtualenvwrapper.sh
source ~/.zsh/completion.zsh

# load fzf 
[[ -f /etc/profile.d/fzf.zsh ]] && source /etc/profile.d/fzf.zsh

stty -ixon
bindkey -e

zle -N edit-command-line
bindkey '^x^e' edit-command-line

# To make Home and End work. From arch wiki
autoload zkbd
function zkbd_file() {
    [[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
    [[ -f ~/.zkbd/${TERM}-${DISPLAY}          ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}" &&
return 0
    return 1
}

[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
keyfile=$(zkbd_file)
ret=$?
if [[ ${ret} -ne 0 ]]; then
    zkbd
    keyfile=$(zkbd_file)
    ret=$?
fi
if [[ ${ret} -eq 0 ]] ; then
    source "${keyfile}"
else
    printf 'Failed to setup keys using zkbd.\n'
fi
unfunction zkbd_file; unset keyfile ret

[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line

# End of lines added by compinstall

type -p dircolors &>/dev/null && eval "$(dircolors -b)"

# Run keychain and receive envirenment variables from it
eval $(keychain --eval --quiet id_rsa)

MOST_RECENT_LEN=20
function chpwd {
    if [[ $(ls --format=vertical -w ${COLUMNS} | wc -l) -lt $((LINES - 1)) ]] {
           ls
       } else {
           echo $(find . -maxdepth 1 | wc -l) entries. \
                Showing $MOST_RECENT_LEN most recent \(ctime\)
           ls -c | head -n$MOST_RECENT_LEN
       }
}

calc () { bc -l <<< "$@" }

externalip () {
    case "$1" in
        ""|dns)  # default
            echo 'Trying: dig +short myip.opendns.com @resolver1.opendns.com'
            dig +short myip.opendns.com @resolver1.opendns.com ;;
        http)
            echo 'Trying: curl -s http://whatismyip.akamai.com/ && echo'
            curl -s http://whatismyip.akamai.com/ && echo ;;
        https)
            echo 'Trying: curl -s https://4.ifcfg.me/'
            curl -s https://4.ifcfg.me/ ;;
        ftp)
            echo 'Trying: echo close | ftp 4.ifcfg.me | awk "{print $4; exit}"'
            echo close | ftp 4.ifcfg.me | awk '{print $4; exit}' ;;
        telnet)
            echo 'Trying: nc 4.ifcfg.me 23 | grep IPv4 | cut -d' ' -f4'
            nc 4.ifcfg.me 23 | grep IPv4 | cut -d' ' -f4 ;;
        *) echo Bad argument >&2 && exit 1 ;;
    esac
}

unalias run-help
function run-help() {
  if [ $TMUX ]; then
    tmux split-window "man $@"
  else
    man $@
  fi
}

function fname() { find . -iname "*$@*"; }
