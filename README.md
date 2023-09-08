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

For a list of the available options, run:
``` shell
$> ./esfm --help
EVEREST SRIOV FPGA manager
Utility to attach and detach VF to VMs

Usage: esfm <pf_dev> <command> [options]

  <pf_dev>                  Pass the PF device ID in the format
                              DDDD:BB:DD.F Domain:Bus:Device.Function

Available commands:
  init <VF_NUM>             Init PF device with VF_NUM virtual functions and
                              attach them to VM (flash bitstream if provided)
  reconf <VF_NUM>           Reconfigure num of VF and attach them to VMs (flash
                              bitstream if provided). Use 0 to remove all VFs

Available options:
  -b, --bitstream <file>    Also flash the provided bitstream file
  -qn, --queues_num <num>   Define number of queues during init, default is 32
  -vm, --vm_names <name>    Define VM base name, VM index will be appended
                              based on VF_NUM, default is everestg
  -p, --pause               Pause the VF attached to the VMs when removing them
  -h, --help                Print this help and exit
  -q, --quiet               Do not print info messages
  -d, --driver_log          Print driver log info
  -v, --verbose             Print script debug info
  -y, --yes                 Automatic yes to prompts
```

