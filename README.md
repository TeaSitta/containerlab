# Network lab testing with containerlab

## install-containerlab.sh will do the initial containerlab install on debian.

## cd into one of the following topology directories:

simple-evpn -- 2 node collapsed core with

stellar-evpn -- larger evpn-mpls core and pops

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

