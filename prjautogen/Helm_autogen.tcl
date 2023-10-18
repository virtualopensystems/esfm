################################################################################
# Copyright (C) 2023 - Virtual Open Systems SAS - All rights reserved.
# Reproduction and communication of this document is strictly prohibited
# unless specifically authorized in writing by Virtual Open Systems.
################################################################################
# File Name   : HelmHBM.tcl
# Author      : STEFANO CIRICI <s.cirici@virtualopensystems.com>
# Description : Generate a Vivado Block Design project with HelmHoltz kernels,
#               launch synthetesis and implementation, exporting the bitstream
#               file when finished.
################################################################################

# Change Design options here
set prj_name "Helm8HBM"
set kernel_num 8
set use_secondary_HBM 0
set num_jobs 16
set prj_part "xcu55c-fsvh2892-2L-e"
set board_part "xilinx.com:au55c:part0:1.0"
set constr_file "./constr_u55c.xdc"
set DEBUG 0
set OPT 0
set dont_ask 1

# Some more design details, change only if really needed
set prj_folder "./${prj_name}"
set bitstream_path "./${prj_name}.bit"
set design_name "design_1"
set ip_repo_path "./IP"


################################################################
# bool ask(question)
#   Ask for a question and return 1 if reply is Yes, 0 if No
################################################################
proc ask {question} {
    while 1 {
        puts -nonewline "${question} (Yes/No) "
        flush stdout;    # <<<<<<<< IMPORTANT!
        if {[gets stdin line] < 0 && [eof stdin]} {
            return -code error "end of file detected"
        } elseif {[string is true -strict [string tolower $line]]} {
            return 1
        } elseif {[string is false -strict [string tolower $line]]} {
            return 0
        }
        puts "Please respond with yes or no"
    }
}

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.1
set current_vivado_version [version -short]

if {[string first $scripts_vivado_version $current_vivado_version] == -1} {
    puts "WARNING: This script was generated using Vivado $scripts_vivado_version and is being run in $current_vivado_version of Vivado."
    if {$dont_ask eq 0 && ![ask "Some IP may be incompatible, do you want to continue anyway?"]} {
        puts "Exiting"
        return
    }
}

################################################################
# Create Project
################################################################

# Check number of kernels
set kernel_max_num 15
if {$use_secondary_HBM eq 1} {
    set kernel_max_num 14
}
if {$kernel_num < 1 || $kernel_num > $kernel_max_num} {
    puts "ERROR: Invalid kernel number $kernel_num < 1 or > 14 (15 with 1 HBM only)"
    return
}

# Check if constraint file exists
if {![file exists $constr_file] || [file isdirectory $constr_file]} {
    puts "ERROR: Constraint file $constr_file does not exists."
    return
}

# Check if IP folder exists
if {![file exists $ip_repo_path] || ![file isdirectory $ip_repo_path]} {
    puts "ERROR: IP repo folder $ip_repo_path does not exists."
    return
}

# Check if the project folder already exists
if {[file exists $prj_folder] && [file isdirectory $prj_folder]} {
    puts "ERROR: Project $prj_folder already exists."
    return
}

puts "\n\nCreating project ${prj_name} in ${prj_folder}"
create_project ${prj_name} ${prj_folder} -part ${prj_part}
set_property BOARD_PART ${board_part} [current_project]
set_property TARGET_LANGUAGE VHDL [current_project]

# Check IPs
set list_check_ips "\
virtualopensystems.com:qdma:flr_assert:1.0\
user.org:user:krnl_helm:1.0\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:hbm:1.0\
xilinx.com:ip:qdma:4.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:util_ds_buf:2.2\
xilinx.com:ip:xlconstant:1.1\
"

# Set IP repository paths
set_property "ip_repo_paths" "[file normalize "${ip_repo_path}"]" [current_fileset]

# Rebuild user ip_repo's index
update_ip_catalog -rebuild

set list_ips_missing ""
#puts "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."
foreach ip_vlnv $list_check_ips {
    set ip_obj [get_ipdefs -all $ip_vlnv]
    if {$ip_obj eq ""} {
        lappend list_ips_missing $ip_vlnv
    }
}

if {$list_ips_missing ne ""} {
    puts "ERROR: The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project."
    return
}

##################################################################
# BLOCK DESIGN
##################################################################

# Creating Block Design
puts "\n\nCreating Block Design <$design_name> in project"
create_bd_design $design_name
current_bd_design $design_name

#Use root
set parentCell [get_bd_cells /]

# Get object for parentCell
set parentObj [get_bd_cells $parentCell]
if {$parentObj == ""} {
    puts "ERROR: Unable to find parent cell <$parentCell>!"
    return
}

# Make sure parentObj is hier blk
set parentType [get_property TYPE $parentObj]
if {$parentType ne "hier"} {
    puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
    return
}

# Save current instance; Restore later
set oldCurInst [current_bd_instance .]

# Set parent object as current
current_bd_instance $parentObj

# Set number of HBM controllers to be used
set hbm_ctrl_num 1
if {$use_secondary_HBM >= 1} {
    set hbm_ctrl_num 2
}

### CREATE BD CELLS (IP)

# Create instance: qdma_0, and set properties
set qdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:qdma:4.0 qdma_0 ]

# Use block automation to generate clock buffer IP (FIX to manual creation)
apply_bd_automation -rule xilinx.com:bd_rule:qdma -config { axi_clk {Maximum Data Width} axi_intf {AXI_MM} bar_size {Disable} lane_width {X16} link_speed {8.0 GT/s (PCIe Gen 3)}}  [get_bd_cells qdma_0]

# VF number can only be a multiple of 4
set VF_num [expr { int( ceil($kernel_num / 4.0) * 4 ) }]

set_property -dict [ list \
    CONFIG.MAILBOX_ENABLE {true} \
    CONFIG.PCIE_BOARD_INTERFACE {pci_express_x16} \
    CONFIG.PF0_MSIX_CAP_TABLE_SIZE_qdma {007} \
    CONFIG.PF0_SRIOV_CAP_INITIAL_VF "$VF_num" \
    CONFIG.PF0_SRIOV_FIRST_VF_OFFSET {4} \
    CONFIG.PF0_SRIOV_VF_DEVICE_ID {A03F} \
    CONFIG.PF1_MSIX_CAP_TABLE_SIZE_qdma {000} \
    CONFIG.SRIOV_CAP_ENABLE {true} \
    CONFIG.SRIOV_FIRST_VF_OFFSET {4} \
    CONFIG.SYS_RST_N_BOARD_INTERFACE {pcie_perstn} \
    CONFIG.acs_ext_cap_enable {false} \
    CONFIG.axi_data_width {512_bit} \
    CONFIG.axibar_notranslate {false} \
    CONFIG.axilite_master_en {false} \
    CONFIG.axist_bypass_en {false} \
    CONFIG.axisten_freq {250} \
    CONFIG.barlite_mb_pf0 {1} \
    CONFIG.barlite_mb_pf1 {0} \
    CONFIG.barlite_mb_pf2 {0} \
    CONFIG.cfg_ext_if {true} \
    CONFIG.cfg_mgmt_if {false} \
    CONFIG.csr_axilite_slave {false} \
    CONFIG.dma_intf_sel_qdma {AXI_MM} \
    CONFIG.en_bridge_slv {false} \
    CONFIG.enable_jtag_dbg {false} \
    CONFIG.flr_enable {true} \
    CONFIG.mode_selection {Advanced} \
    CONFIG.pcie_extended_tag {false} \
    CONFIG.pf0_Use_Class_Code_Lookup_Assistant_qdma {true} \
    CONFIG.pf0_ari_enabled {true} \
    CONFIG.pf0_bar0_prefetchable_qdma {true} \
    CONFIG.pf0_bar2_64bit_qdma {false} \
    CONFIG.pf0_bar2_enabled_qdma {false} \
    CONFIG.pf0_bar2_prefetchable_qdma {false} \
    CONFIG.pf0_bar2_scale_qdma {Kilobytes} \
    CONFIG.pf0_bar2_size_qdma {4} \
    CONFIG.pf0_bar2_type_qdma {AXI_Lite_Master} \
    CONFIG.pf0_bar4_64bit_qdma {false} \
    CONFIG.pf0_bar4_enabled_qdma {false} \
    CONFIG.pf0_bar4_prefetchable_qdma {false} \
    CONFIG.pf0_bar4_size_qdma {128} \
    CONFIG.pf0_bar4_type_qdma {AXI_Bridge_Master} \
    CONFIG.pf0_base_class_menu_qdma {Memory_controller} \
    CONFIG.pf0_class_code_base_qdma {05} \
    CONFIG.pf0_class_code_interface_qdma {00} \
    CONFIG.pf0_class_code_qdma {058000} \
    CONFIG.pf0_class_code_sub_qdma {80} \
    CONFIG.pf0_expansion_rom_enabled_qdma {false} \
    CONFIG.pf0_sriov_bar2_64bit {false} \
    CONFIG.pf0_sriov_bar2_enabled {false} \
    CONFIG.pf0_sriov_bar2_prefetchable {false} \
    CONFIG.pf0_sriov_bar2_scale {Kilobytes} \
    CONFIG.pf0_sriov_bar2_size {4} \
    CONFIG.pf0_sub_class_interface_menu_qdma {Other_memory_controller} \
    CONFIG.pf1_Use_Class_Code_Lookup_Assistant_qdma {false} \
    CONFIG.pf1_bar0_prefetchable_qdma {true} \
    CONFIG.pf1_bar2_64bit_qdma {false} \
    CONFIG.pf1_bar2_enabled_qdma {false} \
    CONFIG.pf1_bar2_prefetchable_qdma {false} \
    CONFIG.pf1_bar2_scale_qdma {Kilobytes} \
    CONFIG.pf1_bar2_size_qdma {4} \
    CONFIG.pf1_bar2_type_qdma {AXI_Lite_Master} \
    CONFIG.pf1_bar4_64bit_qdma {false} \
    CONFIG.pf1_bar4_enabled_qdma {false} \
    CONFIG.pf1_bar4_prefetchable_qdma {false} \
    CONFIG.pf1_bar4_size_qdma {128} \
    CONFIG.pf1_bar4_type_qdma {AXI_Bridge_Master} \
    CONFIG.pf1_base_class_menu_qdma {Processing_accelerators} \
    CONFIG.pf1_class_code_base_qdma {12} \
    CONFIG.pf1_class_code_qdma {120000} \
    CONFIG.pf1_class_code_sub_qdma {00} \
    CONFIG.pf1_expansion_rom_enabled_qdma {false} \
    CONFIG.pf1_msix_enabled_qdma {false} \
    CONFIG.pf1_sriov_bar2_64bit {false} \
    CONFIG.pf1_sriov_bar2_enabled {false} \
    CONFIG.pf1_sriov_bar2_prefetchable {false} \
    CONFIG.pf1_sriov_bar2_scale {Kilobytes} \
    CONFIG.pf1_sriov_bar2_size {4} \
    CONFIG.pf1_sub_class_interface_menu_qdma {Unknown} \
    CONFIG.pf2_bar0_prefetchable_qdma {true} \
    CONFIG.pf2_bar2_64bit_qdma {false} \
    CONFIG.pf2_bar2_enabled_qdma {false} \
    CONFIG.pf2_bar2_prefetchable_qdma {false} \
    CONFIG.pf2_bar2_scale_qdma {Kilobytes} \
    CONFIG.pf2_bar2_size_qdma {4} \
    CONFIG.pf2_bar2_type_qdma {AXI_Lite_Master} \
    CONFIG.pf2_bar4_64bit_qdma {false} \
    CONFIG.pf2_bar4_enabled_qdma {false} \
    CONFIG.pf2_bar4_prefetchable_qdma {false} \
    CONFIG.pf2_bar4_size_qdma {128} \
    CONFIG.pf2_bar4_type_qdma {AXI_Bridge_Master} \
    CONFIG.pf2_base_class_menu_qdma {Processing_accelerators} \
    CONFIG.pf2_class_code_base_qdma {12} \
    CONFIG.pf2_class_code_qdma {120000} \
    CONFIG.pf2_class_code_sub_qdma {00} \
    CONFIG.pf2_expansion_rom_enabled_qdma {false} \
    CONFIG.pf2_sriov_bar2_64bit {false} \
    CONFIG.pf2_sriov_bar2_enabled {false} \
    CONFIG.pf2_sriov_bar2_prefetchable {false} \
    CONFIG.pf2_sriov_bar2_scale {Kilobytes} \
    CONFIG.pf2_sriov_bar2_size {4} \
    CONFIG.pf2_sub_class_interface_menu_qdma {Unknown} \
    CONFIG.pf3_bar0_prefetchable_qdma {true} \
    CONFIG.pf3_bar2_64bit_qdma {false} \
    CONFIG.pf3_bar2_enabled_qdma {false} \
    CONFIG.pf3_bar2_prefetchable_qdma {false} \
    CONFIG.pf3_bar2_scale_qdma {Kilobytes} \
    CONFIG.pf3_bar2_size_qdma {4} \
    CONFIG.pf3_bar2_type_qdma {AXI_Lite_Master} \
    CONFIG.pf3_bar4_64bit_qdma {false} \
    CONFIG.pf3_bar4_enabled_qdma {false} \
    CONFIG.pf3_bar4_prefetchable_qdma {false} \
    CONFIG.pf3_bar4_size_qdma {128} \
    CONFIG.pf3_bar4_type_qdma {AXI_Bridge_Master} \
    CONFIG.pf3_expansion_rom_enabled_qdma {false} \
    CONFIG.pf3_sriov_bar2_64bit {false} \
    CONFIG.pf3_sriov_bar2_enabled {false} \
    CONFIG.pf3_sriov_bar2_prefetchable {false} \
    CONFIG.pf3_sriov_bar2_scale {Kilobytes} \
    CONFIG.pf3_sriov_bar2_size {4} \
    CONFIG.pl_link_cap_max_link_speed {8.0_GT/s} \
    CONFIG.pl_link_cap_max_link_width {X16} \
    CONFIG.ref_clk_freq {100_MHz} \
    CONFIG.tl_pf_enable_reg {1} \
    CONFIG.vdm_en {false} \
] $qdma_0

# Create instance: xlconstant_0
set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

# Create instance: flr_assert_0
set flr_assert_0 [ create_bd_cell -type ip -vlnv virtualopensystems.com:qdma:flr_assert:1.0 flr_assert_0 ]

# Create instance: smartconnect_0, and set properties
set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
set_property -dict [ list \
    CONFIG.NUM_MI "[expr {$kernel_num + $hbm_ctrl_num}]" \
    CONFIG.NUM_SI {1} \
] $smartconnect_0

# Create kernel_num kernels IP
for {set i 0} {$i < $kernel_num} {incr i} {
    # Create instance: krnl_X, and set properties
    set krnl_tmp [ create_bd_cell -type ip -vlnv user.org:user:krnl_helm:1.0 krnl_$i ]
    set_property -dict [ list \
        CONFIG.C_M_AXI_GMEM0_DATA_WIDTH {256} \
        CONFIG.C_M_AXI_GMEM0_ENABLE_ID_PORTS {false} \
        CONFIG.C_M_AXI_GMEM0_ENABLE_USER_PORTS {false} \
        CONFIG.C_M_AXI_GMEM1_DATA_WIDTH {256} \
        CONFIG.C_M_AXI_GMEM1_ENABLE_ID_PORTS {false} \
        CONFIG.C_M_AXI_GMEM1_ENABLE_USER_PORTS {false} \
    ] $krnl_tmp
}

# Create kernel_num axi_mem_interconnect_X
for {set i 0} {$i < $kernel_num} {incr i} {
    # Create instance: axi_mem_intercon_X, and set properties
    set axi_mem_intercon_tmp [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_mem_intercon_$i ]
    set_property -dict [ list \
        CONFIG.NUM_MI "$hbm_ctrl_num" \
        CONFIG.NUM_SI {2} \
    ] $axi_mem_intercon_tmp
}

# Create instance: clk_wiz_0, and set properties
set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
set_property -dict [ list \
    CONFIG.OPTIMIZE_CLOCKING_STRUCTURE_EN {true} \
    CONFIG.RESET_PORT {resetn} \
    CONFIG.RESET_TYPE {ACTIVE_LOW} \
    CONFIG.USE_LOCKED {false} \
] $clk_wiz_0

# If needed, create clock for secondary HBM controller
if {$hbm_ctrl_num eq 2} {
    # Create instance: clk_wiz_1, and set properties
    set clk_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_1 ]
    set_property -dict [ list \
        CONFIG.OPTIMIZE_CLOCKING_STRUCTURE_EN {true} \
        CONFIG.RESET_PORT {resetn} \
        CONFIG.RESET_TYPE {ACTIVE_LOW} \
        CONFIG.USE_LOCKED {false} \
    ] $clk_wiz_1
}

# Create instance: hbm_0, and set properties
set hbm_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:hbm:1.0 hbm_0 ]
set_property -dict [ list \
    CONFIG.USER_APB_EN {false} \
    CONFIG.USER_CLK_SEL_LIST0 "AXI_00_ACLK" \
    CONFIG.USER_SAXI_02 {false} \
    CONFIG.USER_SAXI_03 {false} \
    CONFIG.USER_SAXI_04 {false} \
    CONFIG.USER_SAXI_05 {false} \
    CONFIG.USER_SAXI_06 {false} \
    CONFIG.USER_SAXI_07 {false} \
    CONFIG.USER_SAXI_08 {false} \
    CONFIG.USER_SAXI_09 {false} \
    CONFIG.USER_SAXI_10 {false} \
    CONFIG.USER_SAXI_11 {false} \
    CONFIG.USER_SAXI_12 {false} \
    CONFIG.USER_SAXI_13 {false} \
    CONFIG.USER_SAXI_14 {false} \
    CONFIG.USER_SAXI_15 {false} \
] $hbm_0
# Enable hbm_0 AXI interfaces for each kernel
for {set i 1} {$i < $kernel_num} {incr i} {
    set axin [format "%02u" [expr {$i + 1}]]
    set_property -dict [ list CONFIG.USER_SAXI_${axin} {true} ] $hbm_0
}

# If needed, create secondary HBM controller instance
if {$hbm_ctrl_num eq 2} {
    # Create instance: hbm_1, and set properties
    set hbm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:hbm:1.0 hbm_1 ]
    set_property -dict [ list \
        CONFIG.USER_APB_EN {false} \
        CONFIG.USER_CLK_SEL_LIST0 "AXI_00_ACLK" \
        CONFIG.USER_SAXI_02 {false} \
        CONFIG.USER_SAXI_03 {false} \
        CONFIG.USER_SAXI_04 {false} \
        CONFIG.USER_SAXI_05 {false} \
        CONFIG.USER_SAXI_06 {false} \
        CONFIG.USER_SAXI_07 {false} \
        CONFIG.USER_SAXI_08 {false} \
        CONFIG.USER_SAXI_09 {false} \
        CONFIG.USER_SAXI_10 {false} \
        CONFIG.USER_SAXI_11 {false} \
        CONFIG.USER_SAXI_12 {false} \
        CONFIG.USER_SAXI_13 {false} \
        CONFIG.USER_SAXI_14 {false} \
        CONFIG.USER_SAXI_15 {false} \
        CONFIG.USER_SINGLE_STACK_SELECTION {RIGHT} \
    ] $hbm_1
    # Enable hbm_1 AXI interfaces for each kernel
    for {set i 1} {$i < $kernel_num} {incr i} {
        set axin [format "%02u" [expr {$i + 1}]]
        set_property -dict [ list CONFIG.USER_SAXI_${axin} {true} ] $hbm_1
    }
}

### Create interface connections

# Iterate on kern - axi_mem interfaces
for {set i 0} {$i < $kernel_num} {incr i} {
    connect_bd_intf_net -intf_net S00_AXI_${i} [get_bd_intf_pins axi_mem_intercon_${i}/S00_AXI] [get_bd_intf_pins krnl_${i}/m_axi_gmem0]
    connect_bd_intf_net -intf_net S01_AXI_${i} [get_bd_intf_pins axi_mem_intercon_${i}/S01_AXI] [get_bd_intf_pins krnl_${i}/m_axi_gmem1]
}

# Iterate on axi_mem - HBM interfaces
for {set i 0} {$i < $kernel_num} {incr i} {
    set ifn [format "%02u" [expr {$i + 1}]]
    connect_bd_intf_net -intf_net axi_mem_intercon_${i}_M00_AXI [get_bd_intf_pins axi_mem_intercon_${i}/M00_AXI] [get_bd_intf_pins hbm_0/SAXI_${ifn}_8HI]
    # also set for secondary hbm controller, if present
    if {$hbm_ctrl_num eq 2} {
        connect_bd_intf_net -intf_net axi_mem_intercon_${i}_M01_AXI [get_bd_intf_pins axi_mem_intercon_${i}/M01_AXI] [get_bd_intf_pins hbm_1/SAXI_${ifn}_RT_8HI]
    }
}

connect_bd_intf_net -intf_net qdma_0_M_AXI [get_bd_intf_pins qdma_0/M_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins hbm_0/SAXI_00_8HI] [get_bd_intf_pins smartconnect_0/M00_AXI]
if {$hbm_ctrl_num eq 2} {
    connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins hbm_1/SAXI_00_RT_8HI] [get_bd_intf_pins smartconnect_0/M01_AXI]
}

# Iterate on smartconnect - kern interfaces
for {set i 0} {$i < $kernel_num} {incr i} {
    set ifn [format "%02u" [expr {$i + $hbm_ctrl_num}]]
    connect_bd_intf_net -intf_net smartconnect_0_M${ifn}_AXI [get_bd_intf_pins krnl_${i}/s_axi_control] [get_bd_intf_pins smartconnect_0/M${ifn}_AXI]
}

### Create port connections

connect_bd_net -net clk_wiz0_clk_out1 [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins hbm_0/APB_0_PCLK] [get_bd_pins hbm_0/HBM_REF_CLK_0]
if {$hbm_ctrl_num eq 2} {
    connect_bd_net -net clk_wiz1_clk_out1 [get_bd_pins clk_wiz_1/clk_out1] [get_bd_pins hbm_1/APB_0_PCLK] [get_bd_pins hbm_1/HBM_REF_CLK_0]
}

connect_bd_net -net qdma_0_axi_aclk [get_bd_pins flr_assert_0/s_axi_aclk] [get_bd_pins qdma_0/axi_aclk] [get_bd_pins smartconnect_0/aclk] [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins hbm_0/AXI_00_ACLK]
if {$hbm_ctrl_num eq 2} {
    connect_bd_net -net qdma_0_axi_aclk [get_bd_pins clk_wiz_1/clk_in1] [get_bd_pins hbm_1/AXI_00_ACLK]
}

# Connect clock to kernel, HBM kernels' axi, kernels' axi_mem_interconn interfaces
for {set i 0} {$i < $kernel_num} {incr i} {
    set axin [format "%02u" [expr {$i + 1}]]
    connect_bd_net -net qdma_0_axi_aclk [get_bd_pins krnl_${i}/ap_clk]
    connect_bd_net -net qdma_0_axi_aclk [get_bd_pins hbm_0/AXI_${axin}_ACLK]
    connect_bd_net -net qdma_0_axi_aclk [get_bd_pins axi_mem_intercon_${i}/ACLK]
    connect_bd_net -net qdma_0_axi_aclk [get_bd_pins axi_mem_intercon_${i}/M00_ACLK]
    connect_bd_net -net qdma_0_axi_aclk [get_bd_pins axi_mem_intercon_${i}/S00_ACLK]
    connect_bd_net -net qdma_0_axi_aclk [get_bd_pins axi_mem_intercon_${i}/S01_ACLK]
    if {$hbm_ctrl_num eq 2} {
        connect_bd_net -net qdma_0_axi_aclk [get_bd_pins hbm_1/AXI_${axin}_ACLK]
        connect_bd_net -net qdma_0_axi_aclk [get_bd_pins axi_mem_intercon_${i}/M01_ACLK]
    }
}

connect_bd_net -net qdma_0_axi_aresetn [get_bd_pins flr_assert_0/s_axi_aresetn] [get_bd_pins qdma_0/axi_aresetn] [get_bd_pins smartconnect_0/aresetn] [get_bd_pins clk_wiz_0/resetn] [get_bd_pins hbm_0/APB_0_PRESET_N] [get_bd_pins hbm_0/AXI_00_ARESET_N]
if {$hbm_ctrl_num eq 2} {
    connect_bd_net -net qdma_0_axi_aresetn [get_bd_pins clk_wiz_1/resetn] [get_bd_pins hbm_1/APB_0_PRESET_N] [get_bd_pins hbm_1/AXI_00_ARESET_N]
}

# Connect reset to kernel, HBM kernels' axi, kernels' axi_mem_interconn interfaces
for {set i 0} {$i < $kernel_num} {incr i} {
    set axin [format "%02u" [expr {$i + 1}]]
    connect_bd_net -net qdma_0_axi_aresetn [get_bd_pins krnl_${i}/ap_rst_n]
    connect_bd_net -net qdma_0_axi_aresetn [get_bd_pins hbm_0/AXI_${axin}_ARESET_N]
    connect_bd_net -net qdma_0_axi_aresetn [get_bd_pins axi_mem_intercon_${i}/ARESETN]
    connect_bd_net -net qdma_0_axi_aresetn [get_bd_pins axi_mem_intercon_${i}/M00_ARESETN]
    connect_bd_net -net qdma_0_axi_aresetn [get_bd_pins axi_mem_intercon_${i}/S00_ARESETN]
    connect_bd_net -net qdma_0_axi_aresetn [get_bd_pins axi_mem_intercon_${i}/S01_ARESETN]
    if {$hbm_ctrl_num eq 2} {
        connect_bd_net -net qdma_0_axi_aresetn [get_bd_pins hbm_1/AXI_${axin}_ARESET_N]
        connect_bd_net -net qdma_0_axi_aresetn [get_bd_pins axi_mem_intercon_${i}/M01_ARESETN]
    }
}

connect_bd_net -net flr_assert_0_usr_flr_done_fnc [get_bd_pins flr_assert_0/usr_flr_done_fnc] [get_bd_pins qdma_0/usr_flr_done_fnc]
connect_bd_net -net flr_assert_0_usr_flr_done_vld [get_bd_pins flr_assert_0/usr_flr_done_vld] [get_bd_pins qdma_0/usr_flr_done_vld]
connect_bd_net -net qdma_0_usr_flr_clr [get_bd_pins flr_assert_0/usr_flr_clr] [get_bd_pins qdma_0/usr_flr_clr]
connect_bd_net -net qdma_0_usr_flr_fnc [get_bd_pins flr_assert_0/usr_flr_fnc] [get_bd_pins qdma_0/usr_flr_fnc]
connect_bd_net -net qdma_0_usr_flr_set [get_bd_pins flr_assert_0/usr_flr_set] [get_bd_pins qdma_0/usr_flr_set]
connect_bd_net -net xlconstant_0_dout [get_bd_pins qdma_0/qsts_out_rdy] [get_bd_pins qdma_0/tm_dsc_sts_rdy] [get_bd_pins xlconstant_0/dout]
connect_bd_net -net pcie_perstn_1 [get_bd_ports pcie_perstn] [get_bd_pins qdma_0/soft_reset_n]

### Create address segments

# Kernels
for {set i 0} {$i < $kernel_num} {incr i} {
    set axin [format "%02u" [expr {$i + 1}]]

    # HBM0 addressing
    for {set j 0} {$j < 16} {incr j} {
        set hbm_addr [format "0x%016x" [expr { 0x000000000000 + $j * 0x20000000}]]
        set mem_num [format "%02u" $j]
        assign_bd_address -offset $hbm_addr -range 0x20000000 -target_address_space [get_bd_addr_spaces krnl_${i}/Data_m_axi_gmem0] [get_bd_addr_segs hbm_0/SAXI_${axin}_8HI/HBM_MEM${mem_num}] -force
        assign_bd_address -offset $hbm_addr -range 0x20000000 -target_address_space [get_bd_addr_spaces krnl_${i}/Data_m_axi_gmem1] [get_bd_addr_segs hbm_0/SAXI_${axin}_8HI/HBM_MEM${mem_num}] -force
    }

    # HBM1 addressing
    if {$hbm_ctrl_num eq 2} {
        for {set j 0} {$j < 16} {incr j} {
            set hbm_addr [format "0x%016x" [expr { 0x000200000000 + $j * 0x20000000}]]
            set mem_num [format "%02u" $j]
            assign_bd_address -offset $hbm_addr -range 0x20000000 -target_address_space [get_bd_addr_spaces krnl_${i}/Data_m_axi_gmem0] [get_bd_addr_segs hbm_1/SAXI_${axin}_RT_8HI/HBM_MEM${mem_num}] -force
            assign_bd_address -offset $hbm_addr -range 0x20000000 -target_address_space [get_bd_addr_spaces krnl_${i}/Data_m_axi_gmem1] [get_bd_addr_segs hbm_1/SAXI_${axin}_RT_8HI/HBM_MEM${mem_num}] -force
        }
    }
}

# QDMA HBM0 addressing
for {set i 0} {$i < 16} {incr i} {
    set hbm_addr [format "0x%016x" [expr { 0x000000000000 + $i * 0x20000000}]]
    set mem_num [format "%02u" $i]
    assign_bd_address -offset $hbm_addr -range 0x20000000 -target_address_space [get_bd_addr_spaces qdma_0/M_AXI] [get_bd_addr_segs hbm_0/SAXI_00_8HI/HBM_MEM${mem_num}] -force
}

# QDMA HBM1 addressing
if {$hbm_ctrl_num eq 2} {
    for {set i 0} {$i < 16} {incr i} {
        set hbm_addr [format "0x%016x" [expr { 0x000200000000 + $i * 0x20000000}]]
        set mem_num [format "%02u" $i]
        assign_bd_address -offset $hbm_addr -range 0x20000000 -target_address_space [get_bd_addr_spaces qdma_0/M_AXI] [get_bd_addr_segs hbm_1/SAXI_00_RT_8HI/HBM_MEM${mem_num}] -force
    }
}

# QDMA Kernels addressing
for {set i 0} {$i < $kernel_num} {incr i} {
    set kern_addr [format "0x%016x" [expr { 0x000400000000 + $i * 0x00010000}]]
    assign_bd_address -offset ${kern_addr} -range 0x00000080 -target_address_space [get_bd_addr_spaces qdma_0/M_AXI] [get_bd_addr_segs krnl_${i}/s_axi_control/Reg] -force
}

# Restore current instance
current_bd_instance $oldCurInst

# Add constraint file
set constr_path "./${prj_name}/${prj_name}.srcs/constrs_1"
file mkdir ${constr_path}
file copy ./${constr_file} ${constr_path}/constr_1.xdc
set constr_file ${constr_path}/constr_1.xdc
set obj [get_filesets constrs_1]
set file "[file normalize ${constr_file}]"
set file_added [add_files -norecurse -fileset $obj [list $file]]
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property -name "file_type" -value "XDC" -objects $file_obj
set obj [get_filesets constrs_1]
set_property -name "target_constrs_file" -value "$constr_file" -objects $obj
set_property -name "target_ucf" -value "$constr_file" -objects $obj

save_bd_design

puts "\n\nValidating Block Design"
validate_bd_design
save_bd_design

puts "\n\nCreating BD wrapper for design ${design_name}"
make_wrapper -files [get_files ${design_name}.bd] -top
add_files -norecurse ./${prj_name}/${prj_name}.gen/sources_1/bd/${design_name}/hdl/${design_name}_wrapper.vhd


##################################################################
# SYNTHESIS
##################################################################

# Clear IP cache
config_ip_cache -clear_output_repo

if {$DEBUG eq 1} {
    # DEBUG: Enable fast synthesis
    set_property strategy Flow_RuntimeOptimized [get_runs synth_1]
} elseif {$OPT eq 1} {
    # Enable performance-optimized synthesis
    set_property strategy Flow_AlternateRoutability [get_runs synth_1]
}

puts "\n\nLaunching synthesis of ${design_name}\n"
launch_runs synth_1 -jobs $num_jobs

# Wait for the completion of the synthesis phase
wait_on_run synth_1

# Check if synt_1 completed successfully
set progress [get_property PROGRESS [get_runs synth_1]]
if {${progress} != "100%"} {
    set status [get_property STATUS [get_runs synth_1]]
    puts "ERROR: Synthesis failed (status: ${status}, progress: ${progress})"
    return
}


##################################################################
# IMPLEMENTATION
##################################################################

if {$DEBUG eq 1} {
    # DEBUG: Enable fast implementation
    set_property strategy Flow_Quick [get_runs impl_1]
} elseif {$OPT eq 1} {
    # Enable performance-optimized implementation
    set_property strategy Performance_ExtraTimingOpt [get_runs impl_1]
    set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
}

puts "\n\nLaunching implementation of ${design_name}\n"
launch_runs impl_1 -to_step write_bitstream -jobs $num_jobs

# Wait for the completion of the implementation phase
wait_on_run impl_1

# Check if impl_1 completed successfully
set progress [get_property PROGRESS [get_runs impl_1]]
if {${progress} != "100%"} {
    set status [get_property STATUS [get_runs impl_1]]
    puts "ERROR: Implementation failed (status: ${status}, progress: ${progress})"
    return
}

puts "\n\nCreated design \"${design_name}\" with $kernel_num kernels!"

# Copy bitstream file
file copy ./${prj_name}/${prj_name}.runs/impl_1/${design_name}_wrapper.bit $bitstream_path
puts "Bitstream copied to $bitstream_path"

