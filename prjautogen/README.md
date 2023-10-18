# Vivado project autogeneration

Auto-generate a Vivado Block Design project, adding the QDMA, 1 or 2 HBM controllers, a number of Helmholtz or PTDR kernels, then synthesize  it and generate a bitstream.
All automatically.

Prerequisites are:

- Linux-based x86-64 machine (tested on RHEL 8.7, kernel Linux 4.18).
- Xilinx Vivado installed (tested with Vivado 2022.1, the script will throw a warning if a different version is used).


## How to configure it

There are two TCL scripts, one for the Helmholtz kernel (`Helm_autogen.tcl`) and one for the PTDR kernel (`PTDR_autogen.tcl`).

At the beginning of each script, there are some parameters that can be adjusted:

- **prj_name**: name of the project. There must not be any other project with the same name in the folder.
- **kernel_num**: number of kernels to use. For this design, 1 to 15 kernels (14 if using 2 HBM, see later) are supported.
- **use_secondary_HBM**: activate the secondary HBM. Set to 0 to use 1 HBM controller (8GB of memory will be available), 1 to use 2 HBM controllers (16GB of memory will be available).
- **num_jobs**: (max) number of jobs (threads) to use for compilation.
- **prj_part**: project device. Target device (FPGA) for the project (tested on xcu55c only).
- **board_part**: board device. Target board for the project (tested on Alveo U55C only).
- **constr_file**: constraint file for the project board. The one for the Alveo U55C is provided.
- **DEBUG**: 1 to enable fast synthesis and implementation. Should be used for debug only.
- **OPT**: 1 to enable optimized synthesis and implementation. Ignored if DEBUG is active.
- **dont_ask**: dont ask for questions and continue anyway. The script will terminate with success or in case of failure.

Some additional options are available:

- **prj_folder**: folder where the project with "prj_name" will be created.
- **bitstream_path**: path and name of the bitsream. By default the bitstream is copied in the script folder with the project name.
- **design_name**: name of the block design. This value is not visible outside the project.
- **ip_repo_path**: folder where the additional IPs (kernels and FLR assert) can be found.


## How to use

Make sure you source the Vivado init script (if not already done in the `~/.bashrc` file):

```sh
$ source /tools/Xilinx/Vivado/2022.1/settings64.sh
```

Edit the configuration parameters as needed, as shown above.

To start the process for the Helmholtz kernel, launch the command:

```sh
$ vivado -notrace -nolog -nojournal -mode batch -source ./Helm_autogen.tcl
```

To start the process for the PTDR kernel, launch the command:

```sh
$ vivado -notrace -nolog -nojournal -mode batch -source ./PTDR_autogen.tcl
```

