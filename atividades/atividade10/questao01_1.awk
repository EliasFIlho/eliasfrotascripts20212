# Correção: 0,0. Não está invocado como informado na descrição da ativdade.
awk '$5 !~ /^sshd/ {print}' auth.log

