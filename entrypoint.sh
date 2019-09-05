#!/bin/bash

# Send signal to child processes
trap 'pkill -INT -P $$' SIGINT
trap 'pkill -TERM -P $$' SIGTERM

# Start Redis
redis-server "$1" &

# Start to load data into Redis
/bin/bash /init/load_data.sh &

# Wait the terminate of child processes before exit
wait %2
wait %1

exit 0
