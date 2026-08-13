#
#        Title:      minimal.zsh
#        Brief:      Perfil mínimo — TTY físico do kernel OU máquina headless
#

source "$ZDOTDIR/shared/environment.zsh"
source "$ZDOTDIR/shared/history.zsh"
source "$ZDOTDIR/shared/keybinds.zsh"
[[ -r "$ZDOTDIR/secrets/api-keys.zsh" ]] && source "$ZDOTDIR/secrets/api-keys.zsh"

# Completion básica — sem fzf-tab: depende do binário fzf e de um
# terminal mais capaz do que o console do kernel costuma oferecer.
local zcompdump_d="${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
[[ -d "$zcompdump_d" ]] || mkdir -p "$zcompdump_d"
autoload -Uz compinit
compinit -d "$zcompdump_d/zcompdump"
setopt COMPLETE_ALIASES

# autosuggestions e syntax-highlighting são scripts zsh puros, sem
# depender de nerd-font/truecolor — funcionam normalmente no console.
ZSH_PLUGINS_D="$ZDOTDIR/plugins"
[[ -r "$ZSH_PLUGINS_D/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$ZSH_PLUGINS_D/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -r "$ZSH_PLUGINS_D/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$ZSH_PLUGINS_D/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v atuin  >/dev/null 2>&1 && eval "$(atuin init zsh)"

# Força modo ASCII no p10k: sem isso, ícones de nerd-font viram
# caixas vazias — o console só tem a fonte bitmap carregada (Terminus),
# sem os glyphs Unicode extras que o terminal gráfico tem.
typeset -g POWERLEVEL9K_MODE='ascii'
source "$ZDOTDIR/shared/theme.zsh"

[[ -r "$ZDOTDIR/shared/functions/git.zsh" ]] && source "$ZDOTDIR/shared/functions/git.zsh"
[[ -r "$ZDOTDIR/shared/functions/ssh-agent.zsh" ]] && source "$ZDOTDIR/shared/functions/ssh-agent.zsh"
[[ -r "$ZDOTDIR/shared/aliases.zsh" ]] && source "$ZDOTDIR/shared/aliases.zsh"
[[ -r "$ZDOTDIR/shared/tmux.zsh" ]] && source "$ZDOTDIR/shared/tmux.zsh"
