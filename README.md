# EVEREST SRIOV FPGA Manager

Enable flexible utilization of SR-IOV to attach accelerators to the VM at the highest speed on PCIe-attached FPGAs.

The ESFM is capable of:
- Initialize the PCI device and eventually write the FPGA bitstream
- Create VF on the SR-IOV PCI device
- Attach VF device to different Guest VM using the Virtual Machine Monitor (libvirt KVM/QEMU)
- Re-configure the VF number and manage attach/detach to/from VMs
- Reduce downtime during re-configurations thanks to the pause functionality


Prerequisites are:

- Linux-based host server (x86) with root access and virtualization extensions (KVM) (tested on RHEL 8.7, kernel Linux 4.18)
- QEMU 7.1.0 patched with pause functionality and libvirt 8
- Linux-based QEMU VMs (tested on 4 Ubuntu 22.04 VM, kernel 5.15, platform Standard PC \_Q35 + ICH9, 2009\_)
- Xilinx Alveo FPGA (tested on Alveo U55c) with QDMA and multiple Virtual Functions (VFs), demo provided as `qdma_demo.bit`
- QDMA Linux drivers with custom drivers for the accelerators


To test it on 4 VMs with the FPGA device id `0000:83:00.0`:
```shell
$> git clone Everests SDK
$> cd esfm
$> ./esfm 0000:83:00.0 init 4 --bitstream qdma_demo.bit
```

To change the number of VF attached to the VMs to 2:
```shell
$> ./esfm 0000:83:00.0 reconf 2
```

To list the available VF:
```shell
$> ./esfm 0000:83:00.00 list_vfs
```

To attach a VF(e.g the second one from before, ID 1) to a VM(e.g everestg0):
```shell
$> ./esfm 0000:83:00.00 attach 1 everestg0
```

To attach another VF(e.g the first one from before, ID 0) to a VM(e.g everestg6):
```shell
$> ./esfm 0000:83:00.00 attach 0 everestg6
```

To list the VF-VM association:
```shell
$> ./esfm 0000:83:00.0 list_vf_vm
```

To detach the VF 1 from its VM
```shell
$> ./esfm 0000:83:00.0 detach 15
```

For a list of the available options, run:
``` shell
$> ./esfm --help
EVEREST SRIOV FPGA manager
Utility to attach and detach VF to VMs

Usage: esfm <pf_dev> <command> [options]

  <pf_dev>                  Pass the PF device ID in the format
                              DDDD:BB:DD.F Domain:Bus:Device.Function

Available commands:
  init <VF_NUM>             Init PF device with VF_NUM virtual functions
                              (flash bitstream if provided)
  reconf <VF_NUM>           Reconfigure num of VF (flash bitstream if provided).
                              Use 0 to remove all VFs
  attach <VF_IDX> <VM_NAME> Attach VF_IDX to VM_NAME

  detach <VF_IDX>           Detach VF_IDX from the VM it is attached to
  list_vfs                  List VF for a given PF
  list_vf_vm                List VF association to VM

Available options:
  -b, --bitstream <file>    Also flash the provided bitstream file
  -qn, --queues_num <num>   Define number of queues during init, default is 32
  -p, --pause               Pause the VF attached to the VMs when removing them
  -h, --help                Print this help and exit
  -q, --quiet               Do not print info messages
  -d, --driver_log          Print driver log info
  -v, --verbose             Print script debug info
  -y, --yes                 Automatic yes to prompts
```

