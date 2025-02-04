#!/bin/bash


if [ $# -ne 1 ] || [ -z "$1" ]; then
    echo "Usage: $0 <hostname>"
    echo "If running in the same directory as a clab.yaml file, then only use the node name."
    echo "ex.  'router1'   instead of 'cvlab-topology-node"
    exit 1
fi

if [[ -f "$(basename "$PWD").clab.yaml" ]]; then
    prefix=$(grep '^name:' "$(basename "$PWD").clab.yaml" | awk '{print $2}')
    echo "$prefix - $1"
    docker logs -f clab-$prefix-$1
    exit 0
fi

docker logs -f $1