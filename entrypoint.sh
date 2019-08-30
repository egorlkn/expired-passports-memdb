#!/bin/bash

# Turn on bash's job control
set -m

# Mark data loading as in process
echo -n 'In process' > /init/data_load_status

# Start Redis and put it in the background
redis-server "$1" &

# Load data to Redis
/bin/bash /init/load_data.sh

# Mark data loading as completed
echo -n 'Completed' > /init/data_load_status

# Bring the Redis back into the foreground
fg %1
