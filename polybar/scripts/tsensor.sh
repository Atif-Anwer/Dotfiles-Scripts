sensors | grep Tctl | awk 'NR==2 {print $2}' | tr -d +
