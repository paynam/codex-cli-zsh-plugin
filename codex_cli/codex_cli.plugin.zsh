# ~/.oh-my-zsh/custom/plugins/codex_cli/codex_cli.plugin.zsh

_codex_cli_require() {
  command -v codex >/dev/null 2>&1 || { zle -M "codex CLI not found on PATH"; return 1; }
}

# Ctrl+N: turn English into a shell command (replaces BUFFER)
codex_shell() {
  _codex_cli_require || return 1
  local prompt="$BUFFER"
  [[ -z "$prompt" ]] && { zle -M "Type an instruction first"; return 0; }

  local out err
  out="$(mktemp)"
  err="$(mktemp)"

  zle -M "Codex: generating command…"
  zle -R
  # codex exec "<task>" prints FINAL message to stdout; progress to stderr
  # --skip-git-repo-check allows running from any directory (avoids "trusted dir" error)
  codex exec --skip-git-repo-check "Convert this into ONE shell command. Output ONLY the command, no explanation: $prompt" \
    >"$out" 2>"$err"

  zle -M ""
  zle -R
  if [[ -s "$out" ]]; then
    BUFFER="$(tr -d '\r' < "$out")"
    CURSOR=${#BUFFER}
  else
    zle -M "Codex returned no output. See: $err"
  fi

  rm -f "$out" "$err"
}

# Ctrl+G: explain what is currently in the command line (opens pager)
codex_explain() {
  _codex_cli_require || return 1
  local prompt="$BUFFER"
  [[ -z "$prompt" ]] && { zle -M "Nothing to explain"; return 0; }

  local out err
  out="$(mktemp)"
  err="$(mktemp)"

  zle -M "Codex: explaining command…"
  zle -R
  codex exec --skip-git-repo-check "Explain what this shell command does and any risks: $prompt" \
    >"$out" 2>"$err"

  zle -M ""
  zle -R
  if [[ -s "$out" ]]; then
    less -R "$out"
  else
    zle -M "Codex returned no output. See: $err"
  fi

  rm -f "$out" "$err"
}

zle -N codex_shell
zle -N codex_explain
bindkey '^N' codex_shell
bindkey '^G' codex_explain
