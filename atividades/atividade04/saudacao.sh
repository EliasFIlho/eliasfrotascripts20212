#!/bin/bash

echo -e "Olá $(whoami),\n Hoje é dia $(date +%d), do mês $(date +%m) do ano de $(date +%Y)" | tee saudação.log
