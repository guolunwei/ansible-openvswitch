# ansible-openvswitch
Install OpenvSwitch and Build a SDN lab environment.
1. Install OpenvSwitch
2. Build VXLAN Tunnel
3. Install OpenDayLight

## Preparation
|Hotsname|System|ens33|ens36|
|----|----|----|----|
|ovs-server01|	CentOS7	|10.0.0.61|	-|
|ovs-server02|	CentOS7	|10.0.0.62|	|
|sdn-controller|	CentOS7	|10.0.0.63| |


## Install
```
ansible-playbook -i hosts site.yml
```

## Stop all vms
```
ansible -i hosts ovs -a "virsh destroy {{ vm_name }}" --become
```

## Start all vms
```
ansible -i hosts ovs -a "virsh start {{ vm_name }}" --become
```

## Connect with VNC
If you have a host with ip 10.0.0.62, you can connect cloud-vm using like `10.0.0.62::5900`, the port is defined in `cloud_vm.xml`

