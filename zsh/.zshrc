# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
#        Title:      .zshrc
#        Brief:      Dispatcher principal — decide perfil completo vs. mínimo
#

# Config da máquina atual (pode setar JKYON_HEADLESS=true, ex: Builder)
local host="${(L)HOST}"
[[ -r "$ZDOTDIR/machines/$host.zsh" ]] && source "$ZDOTDIR/machines/$host.zsh"

if [[ "$TERM" == "linux" || "$JKYON_HEADLESS" == "true" ]]; then
    source "$ZDOTDIR/minimal.zsh"
    return
fi

# ---------- Perfil completo ----------
[[ -r "$ZDOTDIR/secrets/api-keys.zsh" ]] && source "$ZDOTDIR/secrets/api-keys.zsh"

# Ordem é proposital, não alfabética — ver nota abaixo
local -a JKYON_MODULES=(theme plugins environment history keybinds aliases vscode pay-respects tmux)
for module in "${JKYON_MODULES[@]}"; do
    [[ -r "$ZDOTDIR/shared/$module.zsh" ]] && source "$ZDOTDIR/shared/$module.zsh"
done

for func in "$ZDOTDIR/shared/functions"/*.zsh(N); do
    source "$func"
done
