// (c) Copyright 1995-2023 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:kernel_compute_profile:1.0
// IP Revision: 1

(* X_CORE_INFO = "kernel_compute_profile,Vivado 2022.1" *)
(* CHECK_LICENSE_TYPE = "design_1_kernel_compute_profi_0_0,kernel_compute_profile,{}" *)
(* CORE_GENERATION_INFO = "design_1_kernel_compute_profi_0_0,kernel_compute_profile,{x_ipProduct=Vivado 2022.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=kernel_compute_profile,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_kernel_compute_profi_0_0 (
  clock,
  reset,
  start_port,
  durations,
  route,
  position,
  departure,
  seed,
  m_axi_common_AWREADY,
  m_axi_common_WREADY,
  m_axi_common_BID,
  m_axi_common_BRESP,
  m_axi_common_BUSER,
  m_axi_common_BVALID,
  m_axi_common_ARREADY,
  m_axi_common_RID,
  m_axi_common_RDATA,
  m_axi_common_RRESP,
  m_axi_common_RLAST,
  m_axi_common_RUSER,
  m_axi_common_RVALID,
  done_port,
  m_axi_common_AWID,
  m_axi_common_AWADDR,
  m_axi_common_AWLEN,
  m_axi_common_AWSIZE,
  m_axi_common_AWBURST,
  m_axi_common_AWLOCK,
  m_axi_common_AWCACHE,
  m_axi_common_AWPROT,
  m_axi_common_AWQOS,
  m_axi_common_AWREGION,
  m_axi_common_AWUSER,
  m_axi_common_AWVALID,
  m_axi_common_WID,
  m_axi_common_WDATA,
  m_axi_common_WSTRB,
  m_axi_common_WLAST,
  m_axi_common_WUSER,
  m_axi_common_WVALID,
  m_axi_common_BREADY,
  m_axi_common_ARID,
  m_axi_common_ARADDR,
  m_axi_common_ARLEN,
  m_axi_common_ARSIZE,
  m_axi_common_ARBURST,
  m_axi_common_ARLOCK,
  m_axi_common_ARCACHE,
  m_axi_common_ARPROT,
  m_axi_common_ARQOS,
  m_axi_common_ARREGION,
  m_axi_common_ARUSER,
  m_axi_common_ARVALID,
  m_axi_common_RREADY
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clock, ASSOCIATED_BUSIF m_axi_common, ASSOCIATED_RESET reset, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clock CLK" *)
input wire clock;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *)
input wire reset;
input wire start_port;
input wire [63 : 0] durations;
input wire [63 : 0] route;
input wire [63 : 0] position;
input wire [63 : 0] departure;
input wire [63 : 0] seed;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common AWREADY" *)
input wire m_axi_common_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common WREADY" *)
input wire m_axi_common_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common BID" *)
input wire [0 : 0] m_axi_common_BID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common BRESP" *)
input wire [1 : 0] m_axi_common_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common BUSER" *)
input wire [0 : 0] m_axi_common_BUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common BVALID" *)
input wire m_axi_common_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common ARREADY" *)
input wire m_axi_common_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common RID" *)
input wire [0 : 0] m_axi_common_RID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common RDATA" *)
input wire [63 : 0] m_axi_common_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common RRESP" *)
input wire [1 : 0] m_axi_common_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common RLAST" *)
input wire m_axi_common_RLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common RUSER" *)
input wire [0 : 0] m_axi_common_RUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common RVALID" *)
input wire m_axi_common_RVALID;
output wire done_port;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common AWID" *)
output wire [0 : 0] m_axi_common_AWID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common AWADDR" *)
output wire [63 : 0] m_axi_common_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common AWLEN" *)
output wire [7 : 0] m_axi_common_AWLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common AWSIZE" *)
output wire [2 : 0] m_axi_common_AWSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common AWBURST" *)
output wire [1 : 0] m_axi_common_AWBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common AWLOCK" *)
output wire [0 : 0] m_axi_common_AWLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common AWCACHE" *)
output wire [3 : 0] m_axi_common_AWCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common AWPROT" *)
output wire [2 : 0] m_axi_common_AWPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common AWQOS" *)
output wire [3 : 0] m_axi_common_AWQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common AWREGION" *)
output wire [3 : 0] m_axi_common_AWREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common AWUSER" *)
output wire [0 : 0] m_axi_common_AWUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common AWVALID" *)
output wire m_axi_common_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common WID" *)
output wire [0 : 0] m_axi_common_WID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common WDATA" *)
output wire [63 : 0] m_axi_common_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common WSTRB" *)
output wire [7 : 0] m_axi_common_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common WLAST" *)
output wire m_axi_common_WLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common WUSER" *)
output wire [0 : 0] m_axi_common_WUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common WVALID" *)
output wire m_axi_common_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common BREADY" *)
output wire m_axi_common_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common ARID" *)
output wire [0 : 0] m_axi_common_ARID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common ARADDR" *)
output wire [63 : 0] m_axi_common_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common ARLEN" *)
output wire [7 : 0] m_axi_common_ARLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common ARSIZE" *)
output wire [2 : 0] m_axi_common_ARSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common ARBURST" *)
output wire [1 : 0] m_axi_common_ARBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common ARLOCK" *)
output wire [0 : 0] m_axi_common_ARLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common ARCACHE" *)
output wire [3 : 0] m_axi_common_ARCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common ARPROT" *)
output wire [2 : 0] m_axi_common_ARPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common ARQOS" *)
output wire [3 : 0] m_axi_common_ARQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common ARREGION" *)
output wire [3 : 0] m_axi_common_ARREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common ARUSER" *)
output wire [0 : 0] m_axi_common_ARUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common ARVALID" *)
output wire m_axi_common_ARVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_common, DATA_WIDTH 64, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 1, ADDR_WIDTH 64, AWUSER_WIDTH 1, ARUSER_WIDTH 1, WUSER_WIDTH 1, RUSER_WIDTH 1, BUSER_WIDTH 1, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN design_1_ap_clk_0, NUM_READ_THREADS 1, NUM_WRITE_THREAD\
S 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_common RREADY" *)
output wire m_axi_common_RREADY;

  kernel_compute_profile inst (
    .clock(clock),
    .reset(reset),
    .start_port(start_port),
    .durations(durations),
    .route(route),
    .position(position),
    .departure(departure),
    .seed(seed),
    .m_axi_common_AWREADY(m_axi_common_AWREADY),
    .m_axi_common_WREADY(m_axi_common_WREADY),
    .m_axi_common_BID(m_axi_common_BID),
    .m_axi_common_BRESP(m_axi_common_BRESP),
    .m_axi_common_BUSER(m_axi_common_BUSER),
    .m_axi_common_BVALID(m_axi_common_BVALID),
    .m_axi_common_ARREADY(m_axi_common_ARREADY),
    .m_axi_common_RID(m_axi_common_RID),
    .m_axi_common_RDATA(m_axi_common_RDATA),
    .m_axi_common_RRESP(m_axi_common_RRESP),
    .m_axi_common_RLAST(m_axi_common_RLAST),
    .m_axi_common_RUSER(m_axi_common_RUSER),
    .m_axi_common_RVALID(m_axi_common_RVALID),
    .done_port(done_port),
    .m_axi_common_AWID(m_axi_common_AWID),
    .m_axi_common_AWADDR(m_axi_common_AWADDR),
    .m_axi_common_AWLEN(m_axi_common_AWLEN),
    .m_axi_common_AWSIZE(m_axi_common_AWSIZE),
    .m_axi_common_AWBURST(m_axi_common_AWBURST),
    .m_axi_common_AWLOCK(m_axi_common_AWLOCK),
    .m_axi_common_AWCACHE(m_axi_common_AWCACHE),
    .m_axi_common_AWPROT(m_axi_common_AWPROT),
    .m_axi_common_AWQOS(m_axi_common_AWQOS),
    .m_axi_common_AWREGION(m_axi_common_AWREGION),
    .m_axi_common_AWUSER(m_axi_common_AWUSER),
    .m_axi_common_AWVALID(m_axi_common_AWVALID),
    .m_axi_common_WID(m_axi_common_WID),
    .m_axi_common_WDATA(m_axi_common_WDATA),
    .m_axi_common_WSTRB(m_axi_common_WSTRB),
    .m_axi_common_WLAST(m_axi_common_WLAST),
    .m_axi_common_WUSER(m_axi_common_WUSER),
    .m_axi_common_WVALID(m_axi_common_WVALID),
    .m_axi_common_BREADY(m_axi_common_BREADY),
    .m_axi_common_ARID(m_axi_common_ARID),
    .m_axi_common_ARADDR(m_axi_common_ARADDR),
    .m_axi_common_ARLEN(m_axi_common_ARLEN),
    .m_axi_common_ARSIZE(m_axi_common_ARSIZE),
    .m_axi_common_ARBURST(m_axi_common_ARBURST),
    .m_axi_common_ARLOCK(m_axi_common_ARLOCK),
    .m_axi_common_ARCACHE(m_axi_common_ARCACHE),
    .m_axi_common_ARPROT(m_axi_common_ARPROT),
    .m_axi_common_ARQOS(m_axi_common_ARQOS),
    .m_axi_common_ARREGION(m_axi_common_ARREGION),
    .m_axi_common_ARUSER(m_axi_common_ARUSER),
    .m_axi_common_ARVALID(m_axi_common_ARVALID),
    .m_axi_common_RREADY(m_axi_common_RREADY)
  );
endmodule
