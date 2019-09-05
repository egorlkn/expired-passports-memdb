#!/bin/bash

# Send signal to child processes
trap 'pkill -INT -P $$' SIGINT
trap 'pkill -TERM -P $$' SIGTERM

# Mark data loading as in process
echo -n 'In process' > /init/data_load_status

# Download archive with expired passports
wget "http://guvm.mvd.ru/upload/expired-passports/list_of_expired_passports.csv.bz2"

# Decompress archive
bzip2 -d -v list_of_expired_passports.csv.bz2

# Check that Redis is available
REDIS_PING=$(redis-cli PING)
if [ "$REDIS_PING" != "PONG" ]; then
	exit 1
fi

# Load expired passports to Redis
awk -f awk.progfile list_of_expired_passports.csv | redis-cli --pipe

# Cleanup	
rm -v list_of_expired_passports.csv

# Mark data loading as completed
echo -n 'Completed' > /init/data_load_status

exit 0
