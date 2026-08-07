#
#        Title:      plugins.zsh
#        Brief:      Carregamento unificado de plugins (mesmo path em Arch e Gentoo, via submodule)
#        Path:       ~/.config/zsh/shared/plugins.zsh
#

ZSH_PLUGINS_D="$HOME/.config/zsh/plugins"

# 1. Completion precisa existir antes de qualquer coisa que dependa dela
autoload -Uz compinit
compinit
setopt COMPLETE_ALIASES

# 2. fzf-tab: logo após compinit, antes de plugins que "embrulham" widgets
if [[ -r "$ZSH_PLUGINS_D/fzf-tab/fzf-tab.plugin.zsh" ]]; then
    source "$ZSH_PLUGINS_D/fzf-tab/fzf-tab.plugin.zsh"
else
    echo "[ERRO] fzf-tab não encontrado em $ZSH_PLUGINS_D"
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:*' fzf-flags --height=40%

# 3. Sugestão inline
if [[ -r "$ZSH_PLUGINS_D/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$ZSH_PLUGINS_D/zsh-autosuggestions/zsh-autosuggestions.zsh"
else
    echo "[ERRO] zsh-autosuggestions não encontrado em $ZSH_PLUGINS_D"
fi

# 4. Syntax highlighting — SEMPRE por último, sem exceção
if [[ -r "$ZSH_PLUGINS_D/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$ZSH_PLUGINS_D/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
else
    echo "[ERRO] zsh-syntax-highlighting não encontrado em $ZSH_PLUGINS_D"
fi

# 5. Binários do sistema (pacman/emerge, não são submodules)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v atuin  >/dev/null 2>&1 && eval "$(atuin init zsh)"
