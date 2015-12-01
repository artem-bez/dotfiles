# Initialize completion system
autoload -U compinit && compinit

# Don't use index. Lower performance but no need to run rehash after each install
zstyle ":completion:*commands" rehash 1



