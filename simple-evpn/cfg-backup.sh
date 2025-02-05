#!/bin/bash

# REQUIRES sshpass
# apt install sshpass

declare -a vrouterhosts=("evpn1" "evpn2")
declare -a vsrxhosts=("srx1" "srx2")

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR


for i in "${vrouterhosts[@]}"
do
    dev="clab-evpn-$i"
    echo "Backing up $dev"
    sshpass -p "admin@123" scp -O admin@$dev:/config/juniper.conf.gz .
    gunzip juniper.conf.gz
    mv -f juniper.conf configs/$i.txt
done

for i in "${vsrxhosts[@]}"
do
    dev="clab-evpn-$i"
    echo "Backing up $dev"
    sshpass -p "admin@123" scp -O admin@$dev:/config/juniper.conf .
    mv -f juniper.conf configs/$i.txt
done


exit 0
