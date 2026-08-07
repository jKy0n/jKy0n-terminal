#
#        Title:      history.zsh
#        Brief:      Configuração de histórico — por-máquina, fora da árvore versionada
#

typeset -g ZSH_STATE_D="${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
[[ -d "$ZSH_STATE_D" ]] || mkdir -p "$ZSH_STATE_D"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$ZSH_STATE_D/history"

setopt append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history
