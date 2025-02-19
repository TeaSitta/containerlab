# Network lab testing with containerlab

## install-containerlab.sh will do the initial containerlab install on Debian.
- Ensure nested virtualization is on and the Debian guest is passed the physical CPU properties.


## cd into one of the following topology directories:

simple-evpn -- 2 node collapsed core for evpn-mpls, ESI and RT5 testing.

evpn-mpls -- large evpn-mpls core with meshed leafs and PoP regional head end routers.

## run containerlab, or clab 
common commands:

```
clab inspect
clab destroy --cleanup
clab deploy
```


# Shell scripts
Run these from the topology dir, e.g. containerlab/simple-evpn

`console.sh`  - attach to the docker console of a container, use simple hostname as the argument

`tail-logs.sh` - tail logs of a docker container, use simple hostname as the argument

example commands:
../tail-logs.sh evpn1
../console.sh ixia1


## Other stuff

containerlab/custom-multitool - `docker make` to build the Dockerfile. Currently set up to add apks to the Alpine Linux based wbitt/network-multitool:latest.

lab-dir/cfg-backup.sh - Download running configs and overwrite lab-dir/config/node.txt
- Currently hard coded node names and junos password
- Requires sshpass  `sudo apt install -y sshpass`