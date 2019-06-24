#!/bin/bash

set -e

//check input
if [ $# -ne 2]
then
    echo "input wrong"
fi

config = $1
sync = $2

//check file existence
if [ ! -e config]
then
    echo "config file does not exist"
    exit 1
fi

if [ ! -e sync]
then
    echo "sync file does not exist"
    exit 1
fi

//get target user and passport
user = $(head -1 config | cut -f1 -d ' ')
pass = $(head -1 config | cut -f2 -d ' ')

//transport sync file
sshpass -p $pass scp $sync $user:$sync

//divide the config into two
split -l $((($(wc -l < config)+1)/2)) $config ${config}_

//use the first half config file to cover the original local config file
cp -f $config ${config}_aa

//transport second half config file and fast_sync.sh
sshpass -p $pass scp fast_sync.sh $user:/fast_sync.sh
sshpass -p $pass scp ${config}_ab $user:/$config

//let remote computer run fast_sync.sh
sshpass -p $pass ssh $user "sh/fast_sync.sh $config $sync"
