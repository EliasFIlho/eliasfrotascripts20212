#!/bin/bash
# Correção: 1,5
# Evite usar acentuação e cedilha em scripts. Você esqueceu o -a no comando tee, então o arquivo de log não é atualizado.
echo -e "Olá $(whoami),\n Hoje é dia $(date +%d), do mês $(date +%m) do ano de $(date +%Y)" | tee saudação.log
