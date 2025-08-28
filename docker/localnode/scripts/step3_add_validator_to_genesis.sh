#!/bin/bash

jq '.validators = []' ~/.wle/config/genesis.json > ~/.wle/config/tmp_genesis.json
cd build/generated/gentx
IDX=0
for FILE in *
do
    jq '.validators['$IDX'] |= .+ {}' ~/.wle/config/tmp_genesis.json > ~/.wle/config/tmp_genesis_step_1.json && rm ~/.wle/config/tmp_genesis.json
    KEY=$(jq '.body.messages[0].pubkey.key' $FILE -c)
    DELEGATION=$(jq -r '.body.messages[0].value.amount' $FILE)
    POWER=$(($DELEGATION / 1000000))
    jq '.validators['$IDX'] += {"power":"'$POWER'"}' ~/.wle/config/tmp_genesis_step_1.json > ~/.wle/config/tmp_genesis_step_2.json && rm ~/.wle/config/tmp_genesis_step_1.json
    jq '.validators['$IDX'] += {"pub_key":{"type":"tendermint/PubKeyEd25519","value":'$KEY'}}' ~/.wle/config/tmp_genesis_step_2.json > ~/.wle/config/tmp_genesis_step_3.json && rm ~/.wle/config/tmp_genesis_step_2.json
    mv ~/.wle/config/tmp_genesis_step_3.json ~/.wle/config/tmp_genesis.json
    IDX=$(($IDX+1))
done

mv ~/.wle/config/tmp_genesis.json ~/.wle/config/genesis.json
