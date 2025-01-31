source ~/.zsh/aliases.zsh
source ~/.zsh/extras.zsh
source ~/.zsh/ohmy.zsh
source <(fzf --zsh)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=13'
ZSH_THEME="eastwood"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export FZF_DEFAULT_COMMAND="fd -H -E .git"
export FZF_DEFAULT_OPTS="--preview 'bat --color=always --style=header,grid --line-range :100 {}'"
export FZF_CTRL_T_COMMAND="fd --type f -H -E .git"
export FZF_ALT_C_COMMAND="fd --type d -H -E .git"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=header,grid --line-range :100 {}'"
export FZF_ALT_C_OPTS="--preview 'exa {} -h -T -F  --no-user --no-time --no-filesize --no-permissions --long | head -200'"
export PATH="$PATH:/Users/asano/go/bin"
export PATH="/Users/asano/istio-1.24.2/bin:$PATH"i

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
 [[ /opt/homebrew/bin/kubectl ]] && source <(kubectl completion zsh)
