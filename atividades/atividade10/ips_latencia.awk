# Correção: 0.0. Não deveria ser awk dentro de shell script, mas sim o contrário.
ping -c 10 8.8.8.8 | awk '{print $4 $7}' | cut
