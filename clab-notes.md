# clab install
https://containerlab.dev/quickstart/#container-image
`curl -sL https://containerlab.dev/setup | sudo -E bash -s "all"`


# Common commands
`sudo docker images`   - See what images are registered
``
`sudo containerlab inspect` - show running clab containers
`sudo containerlab destroy x` - x=topology file, kill containers

- vJunos takes a while to load (vm inside container), monitor container with:
`docker logs -f <container-name>`

- Attach to vtysh of an frr router
`docker exec -it clab-frr01-router1 vtysh`

- linux container shell
`docker exec -it clab-host1 /bin/bash`

# Image list:
## image kinds
https://containerlab.dev/manual/kinds/

## Open images:

kind: nokia_srlinux
image: ghcr.io/nokia/srlinux:24.3.3

kind crpd
image crpd:latest

kind: linux
image: grafana/grafana:7.4.3

kind: ovs-bridge
(no image needed) https://containerlab.dev/manual/kinds/ovs-bridge/


# Container details (vrnetlab)
## vJunos-router (default login admin:admin@123)
- if running clab in vm, cpu must = host
- must enable nested virtualization in kvm (enabled by default on proxmox?)

Build with vrnetlab from vJunos-router-23.4R2-S2.1
https://containerlab.dev/manual/vrnetlab/

`git clone https://github.com/hellt/vrnetlab && cd vrnetlab`
- Move vJunos-router .qcow2 image to vjunosrouter/  (or vsrx.qcow2 to vsrx/)
- `cd vjunosrouter && sudo make`
- `sudo docker images` to confirm image registered
```
absurd@clab:~/containerlab/vrnetlab/vjunosrouter$ sudo docker images
REPOSITORY                       TAG           IMAGE ID       CREATED              SIZE
vrnetlab/juniper_vjunos-router   23.4R2-S2.1   8b9c17ec25bb   About a minute ago   3.93GB
ghcr.io/nokia/srlinux            24.3.3        4ad2a62aa1f7   6 months ago         3.03GB

```
* Note and use the tag in the image!

## vSRX
- Same as above, prep container with vrnetlab
```
    juniper_vsrx:
      image: vrnetlab/juniper_vsrx:24.2R1-S2.5
```

### Example yaml with frr+vjunos
```
name: frr01

topology:
  nodes:
    router1:
      kind: linux
      image: frrouting/frr:v7.5.1
      binds:
        - router1/daemons:/etc/frr/daemons
        - router1/frr.conf:/etc/frr/frr.conf
    router2:
      kind: linux
      image: frrouting/frr:v7.5.1
      binds:
        - router2/daemons:/etc/frr/daemons
        - router2/frr.conf:/etc/frr/frr.conf
    vjunos1:
      kind: juniper_vjunosrouter
      image: vrnetlab/juniper_vjunos-router:23.4R2-S2.1
    PC1:
      kind: linux
      image: praqma/network-multitool:latest
    PC2:
      kind: linux
      image: praqma/network-multitool:latest

  links:
    - endpoints: ["router1:eth1", "vjunos1:eth1"]
    - endpoints: ["router1:eth2", "vjunos1:eth2"]
    - endpoints: ["PC1:eth1", "router1:eth3"]
    - endpoints: ["PC2:eth1", "router2:eth3"]
```
**NOTE: Unable to find a way to change MTU on FRR interfaces to make OSPF negotiate with junos**



### Example yaml with vSRX and vJunos-router
```
Topology:
  nodes:
    vrouter1:
      kind: juniper_vjunosrouter
      image: vrnetlab/juniper_vjunos-router:23.4R2-S2.1
#      startup-config:
    vsrx1:
      kind: juniper_vsrx
      image: vrnetlab/juniper_vsrx:23.2R2.21
    vsrx2:
      kind: juniper_vsrx
      image: vrnetlab/juniper_vsrx:23.2R2.21
```


## FRR
https://brianlinkletter.com/2021/05/use-containerlab-to-emulate-open-source-routers/

```
topology:
  nodes:
    router1:
      kind: linux
      image: frrouting/frr:v7.5.1
      binds:
        - router1/daemons:/etc/frr/daemons
        - router1/frr.conf:/etc/frr/frr.conf

```

frr.conf in router1 subdir
```
frr version 7.5.1_git
frr defaults traditional
hostname router1
no ipv6 forwarding
!
interface eth1
 ip address 10.1.1.2/30
!
interface eth2
 ip address 192.168.1.1/24
!
interface lo
 ip address 10.10.10.1/32
!
router ospf
 passive-interface eth2
 network 10.1.1.0/30 area 0.0.0.0
 network 192.168.2.0/24 area 0.0.0.0
 network 10.10.10.1/32 area 0.0.0.0
```

> **MTU 9500 by default for ospf interfaces** cannot be changed?




# Troubleshooting
### Cannot deploy/inspect/etc lab
`Error: the 'containerlab name' lab has already been deployed. Destroy the lab before deploying a lab with the same name`

> docker network prune
> docker container prune