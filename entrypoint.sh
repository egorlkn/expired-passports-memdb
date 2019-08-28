#!/bin/bash

# Turn on bash's job control
set -m

# Mark data loading as in process
echo -n 'In process' > data_load_status

# Start Redis and put it in the background
redis-server redis.conf &

# Load data to Redis
sh load_data.sh

# Mark data loading as completed
echo -n 'Completed' > data_load_status

# Bring the Redis back into the foreground
fg %1
