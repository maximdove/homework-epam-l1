#!/bin/bash

# set the log file location
log_file='/home/ubuntu18/homework/example_log.log'

# 1. From which ip were the most requests?
echo "IP address with the most requests:"
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" $log_file | sort | uniq -c | sort -nr | head -n 1

# 2. What is the most requested page?
echo "Most requested page:"
grep -oE "\"[A-Z]{3,4} [^\"]+" $log_file | awk '{print $2}' | sort | uniq -c | sort -nr | head -n 1

# 3. How many requests were there from each ip?
echo "Number of requests from each IP:"
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" $log_file | sort | uniq -c | sort -nr

# 4. What non-existent pages were clients referred to?
echo "Non-existent pages:"
grep "404" $log_file | awk '{print $7}' | sort | uniq -c | sort -nr

# 5. What time did site get the most requests?
echo "Time with the most requests:"
grep -oE "[[:digit:]]{2}/[[:alpha:]]{3}/[[:digit:]]{4}:[[:digit:]]{2}:[[:digit:]]{2}" $log_file | awk -F: '{print $2}' | sort | uniq -c | sort -nr | head -n 1

# 6. What search bots have accessed the site?
echo "Search bots that accessed the site (UA + IP):"
while read line; do
    if [[ $line =~ (bot|crawler|spider) ]]; then
        ip=$(echo $line | awk '{print $1}')
        ua=$(echo $line | awk -F\" '{print $6}')
        echo "IP: $ip, UA: $ua"
    fi
done < <(grep -oE "[^ ]+\"[^\"]+\"" $log_file)


