_jkyon_tmux_autostart() {
    # Roda de novo em todo precmd até o tmux realmente iniciar (ou condição não bater).
    # Necessário porque plugins turbo (zinit ice wait) podem reatribuir
    # $precmd_functions inteiro depois do nosso registro, apagando o hook
    # antes dele disparar — isso resolve o hook sozinho, sem depender de ordem.

    if [[ -n "$TMUX" ]] || [[ -n "$NO_TMUX" ]]; then
        add-zsh-hook -d precmd _jkyon_tmux_autostart
        return
    fi

    if [[ -t 0 ]] && \
        [[ -x "$(command -v tmux)" ]] && \
        [[ $- == *i* ]] && \
        [[ "$TERM_PROGRAM" != "vscode" ]]; then

        add-zsh-hook -d precmd _jkyon_tmux_autostart

        local session_number
        session_number=$(tmux list-sessions -F '#{session_name}' 2>/dev/null |
                         grep '^[0-9]\+$' |
                         sort -n |
                         tail -n 1 |
                         awk '{print $1 + 1}')

        [[ -z "$session_number" ]] && session_number=1

        if ! tmux new-session -s "$session_number" >/dev/null 2>&1; then
            echo "Erro ao criar sessão tmux!"
        fi
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _jkyon_tmux_autostart