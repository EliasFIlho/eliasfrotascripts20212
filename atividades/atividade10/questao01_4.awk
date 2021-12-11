awk '$6 == "Accepted" && $2 ~ /10|11/ {print}' auth.log
