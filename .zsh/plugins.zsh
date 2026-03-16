# autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=13'

# syntax highlight
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# k8s補完
autoload -Uz compinit
compinit
[[ /opt/homebrew/bin/kubectl ]] && source <(kubectl completion zsh)
