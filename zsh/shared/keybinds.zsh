#
#        Title:      keybinds.zsh
#        Brief:      Personal Zsh keybindings for efficient command line navigation and editing.
#        Path:       /home/jkyon/.config/zsh/zshrc.d/keybinds.zsh
#        Author:     John Kennedy a.k.a. jKyon
#        Created:    2025-08-11
#        Updated:    2026-03-17
#        Notes:
#


# Apagar segmento de path com Ctrl+Backspace
delete-path-segment-backward() {
    if [[ "$LBUFFER" == */* ]]; then
        local stripped="${LBUFFER%/}"
        if [[ "$stripped" == */* ]]; then
            LBUFFER="${stripped%/*}/"
        else
            LBUFFER="${LBUFFER%%/*}"
        fi
    else
        zle backward-kill-word
    fi
}
zle -N delete-path-segment-backward delete-path-segment-backward


# Modo de edição (emacs ou vi)
bindkey -e  # Usando modo emacs

# Navegação em linhas
bindkey "^[[H"      beginning-of-line               # Home
bindkey "^[[F"      end-of-line                     # End
bindkey "^[[3~"     delete-char                     # Delete

# Navegação por palavras
bindkey "^[[1;5D"   backward-word                   # Ctrl + ←
bindkey "^[[1;5C"   forward-word                    # Ctrl + →

# Início/fim do buffer (linha de comando multilinha ou histórico)
bindkey "^[[1;5H"   beginning-of-buffer-or-history  # Ctrl + Home
bindkey "^[[1;5F"   end-of-buffer-or-history        # Ctrl + End

# Atalhos específicos
bindkey "^[[1;3B"   menu-complete                   # Alt + ↓ (rotação de completions)
bindkey "^H"        delete-path-segment-backward    # Ctrl + Backspace
bindkey "^[^[[C"    autosuggest-accept              # Aceitar sugestão (→)

bindkey "^[[3;2~"   kill-whole-line                 # Shift + Delete apaga a linha inteira