HISTSIZE=3000
SAVEHIST=50000
HISTFILE=~/.zsh_history
PS1="%{$fg[red]%}%(3~|</%2~|%2~)/%#%{$reset_color%} "

# Report CPU usage for commands running longer than 10 seconds. Similar to
# prefixing a command with time
REPORTTIME=10

# stop on '/' when operating on words, e.g. moving or deleting
WORDCHARS="${WORDCHARS:s#/#}"
