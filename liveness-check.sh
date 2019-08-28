#!/bin/bash

## Check that Redis is available
REDIS_PING=$(redis-cli PING)
if [ "$REDIS_PING" != 'PONG' ]; then
	exit 1
fi

exit 0
