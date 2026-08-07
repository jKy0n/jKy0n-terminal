# Integração do VSCode Shell
# Habilita recursos como navegação de histórico, detecção de comandos, etc.

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    if command -v code >/dev/null 2>&1; then
        . "$(code --locate-shell-integration-path zsh)"
    fi
fi
