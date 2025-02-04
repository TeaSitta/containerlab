# Network lab testing with containerlab

## install-containerlab.sh will do the initial containerlab install on debian.

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
`console.sh`  - attach to the docker console of a container, use simple hostname as the argument

`tail-logs.sh` - tail logs of a docker container, use simple hostname as the argument




# Other stuff

containerlab/custom-multitool - `docker make` to build the Dockerfile. Currently set up to add apks to alpine linux.

lab-dir/cfg-backup.sh - Download running configs and overwrite lab-dir/config/node.txt
- Currently hard coded node names and junos password
