# EVEREST SRIOV FPGA Manager

Enable flexible utilization of SR-IOV to attach accelerators to the VM at the highest speed on PCIe-attached FPGAs.

The ESFM is capable of:
- Initialize the PCI device and eventually write the FPGA bitstream
- Create VF on the SR-IOV PCI device
- Attach VF device to different Guest VM using the Virtual Machine Monitor (libvirt KVM/QEMU)
- Re-configure the VF number and manage attach/detach to/from VM


Usage:
``` shell
$ ./esfm -h
Utility to attach and detach VF to VMs

Usage: esfm <command> [options]

Available commands:
  init <VF_NUM>             Init PF device with VF_NUM virtual functions and
                              attach them to VM (flash bitstream if provided)
  reconf <VF_NUM>           Reconfigure num of VF and attach them to VMs (flash
                              bitstream if provided). Use 0 to remove all VFs

Available options:
  -p, --pf_dev <ID>         Define the PF device ID in the format
                              DDDD:BB:DD.F Domain:Bus:Device.Function
                              default is 0000:e1:00.0
  -b, --bitstream <file>    Also flash the provided bitstream file
  -qn, --queues_num <num>   Define number of queues during init, default is 32
  -vm, --vm_names <name>    Define VM base name, VM index will be appended
                              based on VF_NUM, default is everestg
  -h, --help                Print this help and exit
  -q, --quiet               Do not print info messages
  -d, --driver_log          Print driver log info
  -v, --verbose             Print script debug info
  -y, --yes                 Automatic yes to prompts
```
