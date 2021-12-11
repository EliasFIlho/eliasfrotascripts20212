awk '$5 !~ /^sshd/ {print}' auth.log

