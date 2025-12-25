# Codex CLI Zsh Plugin

Zsh plugin for OpenAI Codex, via the OpenAI Codex CLI, that adds two keybindings:
- `Ctrl+N` (`codex_shell`): turn a natural-language instruction into a single shell command (replaces the current command line).
- `Ctrl+G` (`codex_explain`): explain the current command line and any risks.

## Requirements
- **zsh**
- **Codex CLI** installed and available on your `PATH`
- (Optional) **Oh My Zsh** if you want to install it as a custom plugin

## Installation

For the official OpenAI Codex CLI installation guide, see:
```
https://developers.openai.com/codex/cli
```

### Option A: Oh My Zsh (recommended)
1. Clone this repo into your custom plugins directory:
   ```sh
   git clone https://github.com/paynam/codex-cli-zsh-plugin.git ~/.oh-my-zsh/custom/plugins/codex_cli
   ```
2. Enable the plugin in your `~/.zshrc`:
   ```sh
   plugins=(... codex_cli)
   ```
3. Reload your shell:
   ```sh
   source ~/.zshrc
   ```

### Option B: Manual
1. Clone this repo anywhere:
   ```sh
   git clone https://github.com/paynam/codex-cli-zsh-plugin.git ~/codex-cli-zsh-plugin
   ```
2. Source the plugin file from your `~/.zshrc`:
   ```sh
   source ~/codex-cli-zsh-plugin/codex_cli/codex_cli.plugin.zsh
   ```
3. Reload your shell:
   ```sh
   source ~/.zshrc
   ```

## Notes
- The plugin uses `codex exec --skip-git-repo-check` so it can run from any directory.
- It prints a status message while Codex runs and clears it after a response.

## Keybindings
- `Ctrl+N`: Generate a command from the current prompt text (replaces `BUFFER`).
- `Ctrl+G`: Explain the current command and risks in a pager.

## Troubleshooting
- If `Ctrl+N` or `Ctrl+G` says Codex is not found, confirm `codex` is installed and in `PATH`.
- If nothing appears, verify you are logged in to the Codex CLI (`codex login`).

## License
MIT
