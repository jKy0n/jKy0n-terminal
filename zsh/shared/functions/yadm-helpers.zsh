# ~/.config/zsh/zshrc.d/functions/yadm.zsh

#------------------------------------------------------------------------------
# yadm-cp: Realiza 'yadm commit' e 'yadm push' em um único comando.
#------------------------------------------------------------------------------
yadm-cp() {
    # 1. Validação: Garante que uma mensagem de commit foi passada.
    if [[ -z "$1" ]]; then
        print -P "%F{red}❌ Erro:%f Faltou a mensagem de commit para o yadm."
        print "Uso correto: yadm-cp \"sua mensagem\""
        return 1
    fi

    # 2. Execução: Roda os comandos do yadm.
    yadm commit -am "$*" && yadm push
}