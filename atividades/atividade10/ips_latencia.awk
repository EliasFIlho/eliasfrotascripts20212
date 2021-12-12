ping -c 10 8.8.8.8 | awk '{print $4 $7}' | cut
