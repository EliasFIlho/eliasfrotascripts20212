grep -E 'sshd' -vi auth.log
grep -E 'Accepted.{15}j' auth.log 
grep -E 'sshd.*root' auth.log 
grep -E 'Oct[[:space:]]*(11|12).+Accepted' auth.log
