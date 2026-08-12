#
#        Title:      command-timer.zsh
#        Brief:      Grava o início de cada comando pra a status bar do tmux
#                    mostrar um timer ao vivo enquanto ele roda.
#        Path:       ~/.config/zsh/shared/functions/command-timer.zsh
#        Notes:      Só ativa dentro do tmux — fora dele, $TMUX_PANE não
#                    existe e as funções saem no primeiro return.
#

_cmd_timer_preexec() {
    [[ -n "$TMUX_PANE" ]] || return
    date +%s > "/tmp/tmux-cmd-timer-${TMUX_PANE}"
}

_cmd_timer_precmd() {
    [[ -n "$TMUX_PANE" ]] || return
    rm -f "/tmp/tmux-cmd-timer-${TMUX_PANE}"
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _cmd_timer_preexec
add-zsh-hook precmd  _cmd_timer_precmd