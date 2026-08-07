# ~/.config/zsh/zshrc.d/ssh-agent.zsh

# 0. Prioridade máxima: o ssh-agent "de verdade", se estiver de pé nesse path fixo.
#    Existe pra evitar que o suporte SSH do gpg-agent (que só aceita chaves GPG)
#    seja usado por engano no lugar do agente OpenSSH comum.
_real_ssh_agent_socket="/run/user/$(id -u)/ssh-agent.socket"
if [[ -S "$_real_ssh_agent_socket" ]]; then
    export SSH_AUTH_SOCK="$_real_ssh_agent_socket"
fi
unset _real_ssh_agent_socket

# 1. Tenta herdar variáveis do systemd (PAM/Gnome-Keyring/SSH)
if [[ ! -S "$SSH_AUTH_SOCK" ]] && command -v systemctl >/dev/null 2>&1; then
    # Captura as variáveis essenciais exportadas pelo serviço que criamos
    eval $(systemctl --user show-environment | grep -E '^(GNOME_KEYRING|SSH_AUTH_SOCK|DBUS_SESSION_BUS_ADDRESS)')
    export GNOME_KEYRING_CONTROL SSH_AUTH_SOCK DBUS_SESSION_BUS_ADDRESS
fi

# 2. Se após a tentativa do systemd o socket ainda não existir, usa o keychain
if [[ ! -S "$SSH_AUTH_SOCK" ]]; then
    if command -v keychain >/dev/null 2>&1; then
        eval $(keychain --eval --quiet Viamar-GitHub)
    fi
fi
