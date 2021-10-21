#!/bin/bash

echo "Digite Seu Nome: "
read nome;
echo -e "Olá $nome,\n Hoje é dia $(date +%d), do mês $(date +%m) do ano de $(date +%Y)" | tee saudação.log
