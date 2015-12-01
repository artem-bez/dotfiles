# cd without typing cd
setopt auto_cd

# List choices on an ambiguous completion
setopt auto_list

# Use menu on second consecutive Tab
setopt auto_menu

# allow multiple zsh append to single hist file
setopt append_history

# Add to hist on each exec and not only on exit from zsh
setopt inc_append_history

# Do not reload the history whenever you use it. Keep histories of each instance
# separate.
unsetopt share_history

# add timestamps to saved history
setopt extended_history

# List choices even if something like prefix was inserted
unsetopt list_ambiguous

# Do not put possible complitions right away
unsetopt menu_complete

# Allow completion within a word/phrase. e.g. if something is missing inside
setopt complete_in_word

# No beeping when completing
setopt no_beep

# If no match while filename gen let zsh abort operation and report error.
setopt nomatch

# Do not save command to hist if preceded by space
setopt hist_ignore_space

# Do not allow truncation of existing files. Use >! >>! to override.
unsetopt clobber
