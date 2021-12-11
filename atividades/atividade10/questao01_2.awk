awk '$6 == "Accepted" && $9 ~ /^(J|j)/ && $5 ~ /^sshd/ {print}' auth.log 
