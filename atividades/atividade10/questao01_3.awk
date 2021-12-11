awk '$6 == "Disconnected" && $8 == "authenticating" && $10 == "root" {print}' auth.log 


