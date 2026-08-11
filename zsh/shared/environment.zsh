#
#        Title:      environment.zsh
#        Brief:      Configurações de ambiente compartilhadas entre as 4 máquinas
#

export EDITOR=nvim
export SUDO_EDITOR=nvim
export SYSTEMD_EDITOR=nvim

export CARGO_HOME="$HOME/.build/cargo"
export CARGO_TARGET_DIR="$HOME/.build/cargo-target"

export PIP_CACHE_DIR="$HOME/.build/pip-cache"

# DISTCC_HOSTS mora cifrado em zsh/secrets/ desde o passo 2
[[ -r "$HOME/.config/zsh/secrets/distcc-hosts.zsh" ]] && source "$HOME/.config/zsh/secrets/distcc-hosts.zsh"

export CCACHE_DIR="$HOME/.build/ccache"
export CCACHE_COMPRESS=1
export CCACHE_MAXSIZE=10G

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PATH="$HOME/.local/bin:$PATH"

export PATH="$PATH:$HOME/.spicetify"

export PAY_RESPECTS_REQUIRE_CONFIRMATION="true"

setopt EXTENDED_GLOB
setopt GLOB_DOTS
setopt INTERACTIVE_COMMENTS

[[ -z "$TMUX" ]] && export SHELL=$(which zsh)
