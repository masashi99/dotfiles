# autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=13'

# fzf
source <(fzf --zsh)

# syntax highlight
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# k8s補完
autoload -Uz compinit
compinit
[[ /opt/homebrew/bin/kubectl ]] && source <(kubectl completion zsh)
