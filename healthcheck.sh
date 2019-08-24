#!/bin/bash

## Check that Redis is available
REDIS_PING=$(redis-cli PING)
if [ "$REDIS_PING" != 'PONG' ]; then
	exit 1
fi

## Check that data loading is complete
DATA_LOAD_STATUS=$(cat data_load_status)
if [ "$DATA_LOAD_STATUS" != 'Completed' ]; then
	echo -n 'Data loading is in process.'
	exit 1
fi

exit 0
