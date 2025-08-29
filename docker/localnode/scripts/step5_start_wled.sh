#!/usr/bin/env sh

NODE_ID=${ID:-0}
INVARIANT_CHECK_INTERVAL=${INVARIANT_CHECK_INTERVAL:-0}

LOG_DIR="build/generated/logs"
mkdir -p $LOG_DIR

echo "Starting the wled process for node $NODE_ID with invariant check interval=${INVARIANT_CHECK_INTERVAL}..."

wled start --chain-id wle --inv-check-period ${INVARIANT_CHECK_INTERVAL} > "$LOG_DIR/wled-$NODE_ID.log" 2>&1 &
echo "Node $NODE_ID wled is started now"
echo "Done" >> build/generated/launch.complete
