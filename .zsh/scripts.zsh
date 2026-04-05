eval "$(starship init zsh)"

# gitリポジトリ検索
fdr() {
  local selected="$(ghq list | fzf)"

  if [[ -n "$selected" ]]; then
    cd "$(ghq root)/$selected"
  fi
}
bindkey -s '^z' 'fdr\n'

# リポジトリ内のディレクトリ検索
fdd() {
  local top_dir
  top_dir="$(git rev-parse --show-toplevel 2>/dev/null)"
  if [ -z "$top_dir" ]; then
    echo "Not in a Git repository."
    return 1
  fi

  local dir
  dir="$(
    cd "$top_dir" || return 1
    fd --type d --exclude .git | fzf
  )"

  [ -z "$dir" ] && return
  cd "$top_dir/$dir"
}
bindkey -s '^x' 'fdd\n'

# リポジトリ作成
ghcr() {
  local repo_name="$1"
  local visibility="${2:-public}"  # public default
  if [ -z "$repo_name" ]; then
    echo "Usage: ghcr <repo_name> [public|private]"
    return 1
  fi

  gh repo create "$repo_name" --"$visibility" --confirm || {
    echo "Error: could not create repository '$repo_name'"
    return 1
  }

  ghq get -p "$(git config user.name)/$repo_name" || {
    echo "Error: could not ghq get '$repo_name'"
    return 1
  }

  local repo_path
  repo_path="$(ghq list -p "$repo_name")"
  if [ -n "$repo_path" ]; then
    cd "$repo_path" || {
      echo "Error: could not cd to '$repo_path'"
      return 1
    }
  else
    echo "Error: could not find repository path for '$repo_name'"
    return 1
  fi
}

# Ctrl+R の履歴検索に実行時刻を表示
# fzf-history-widget() {
#   local selected history_number
#
#   selected="$(fc -rli 1 | fzf --query="$LBUFFER")" || return
#   history_number="$(awk '{print $1; exit}' <<<"$selected")"
#   zle vi-fetch-history -n "$history_number"
#   zle reset-prompt
# }
# zle -N fzf-history-widget
# bindkey '^R' fzf-history-widget

# 実行に成功したコマンドのみ履歴に保存
autoload -Uz add-zsh-hook

typeset -g __last_history_command=""
typeset -g HISTORY_IGNORE='(ls|ll|pwd|exit)'

zshaddhistory() {
  __last_history_command="${1%$'\n'}"

  if [[ -o hist_ignore_space && "$__last_history_command" == [[:space:]]* ]]; then
    __last_history_command=""
  elif [[ -n "$HISTORY_IGNORE" && "$__last_history_command" == ${~HISTORY_IGNORE} ]]; then
    __last_history_command=""
  fi

  # いったん通常の履歴保存を止め、precmd で成功時だけ手動追加する
  return 1
}

add_successful_history() {
  local exit_status=$?

  if (( exit_status == 0 )) && [[ -n "$__last_history_command" ]]; then
    print -sr -- "$__last_history_command"
  fi

  __last_history_command=""
}

add-zsh-hook precmd add_successful_history
