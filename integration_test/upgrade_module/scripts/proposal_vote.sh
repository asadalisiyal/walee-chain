#!/bin/bash

PROPOSAL_ID=${1//\'/}  # Remove single quotes
PROPOSAL_ID=${PROPOSAL_ID//\"/}  # Remove double quotes

echo "PROPOSAL_ID=$PROPOSAL_ID" >> /tmp/proposal_id

printf "12345678\n" | wled tx gov vote $PROPOSAL_ID yes --from node_admin --chain-id wle --fees 2000uwle -b block -y --output json | jq -r .code
