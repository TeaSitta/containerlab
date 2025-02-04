#!/bin/bash


if [ $# -ne 1 ] || [ -z "$1" ]; then
    echo "Usage: $0 <hostname>"
    exit 1
fi


prefix=$(grep '^name:' "$(basename "$PWD").clab.yaml" | awk '{print $2}')

echo "$prefix - $1"

sudo docker exec -it clab-$prefix-$1 /bin/ash

