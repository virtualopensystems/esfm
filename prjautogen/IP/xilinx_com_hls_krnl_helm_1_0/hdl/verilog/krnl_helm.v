// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Version: 2022.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="krnl_helm_krnl_helm,hls_ip_2022_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xcu55c-fsvh2892-2L-e,HLS_INPUT_CLOCK=4.444000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=1.880000,HLS_SYN_LAT=1,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=467,HLS_SYN_LUT=816,HLS_VERSION=2022_1}" *)

module krnl_helm (
        ap_clk,
        ap_rst_n,
        event_done,
        m_axi_gmem0_AWVALID,
        m_axi_gmem0_AWREADY,
        m_axi_gmem0_AWADDR,
        m_axi_gmem0_AWID,
        m_axi_gmem0_AWLEN,
        m_axi_gmem0_AWSIZE,
        m_axi_gmem0_AWBURST,
        m_axi_gmem0_AWLOCK,
        m_axi_gmem0_AWCACHE,
        m_axi_gmem0_AWPROT,
        m_axi_gmem0_AWQOS,
        m_axi_gmem0_AWREGION,
        m_axi_gmem0_AWUSER,
        m_axi_gmem0_WVALID,
        m_axi_gmem0_WREADY,
        m_axi_gmem0_WDATA,
        m_axi_gmem0_WSTRB,
        m_axi_gmem0_WLAST,
        m_axi_gmem0_WID,
        m_axi_gmem0_WUSER,
        m_axi_gmem0_ARVALID,
        m_axi_gmem0_ARREADY,
        m_axi_gmem0_ARADDR,
        m_axi_gmem0_ARID,
        m_axi_gmem0_ARLEN,
        m_axi_gmem0_ARSIZE,
        m_axi_gmem0_ARBURST,
        m_axi_gmem0_ARLOCK,
        m_axi_gmem0_ARCACHE,
        m_axi_gmem0_ARPROT,
        m_axi_gmem0_ARQOS,
        m_axi_gmem0_ARREGION,
        m_axi_gmem0_ARUSER,
        m_axi_gmem0_RVALID,
        m_axi_gmem0_RREADY,
        m_axi_gmem0_RDATA,
        m_axi_gmem0_RLAST,
        m_axi_gmem0_RID,
        m_axi_gmem0_RUSER,
        m_axi_gmem0_RRESP,
        m_axi_gmem0_BVALID,
        m_axi_gmem0_BREADY,
        m_axi_gmem0_BRESP,
        m_axi_gmem0_BID,
        m_axi_gmem0_BUSER,
        durations_kernel,
        durations_kernel_ap_vld,
        durations_kernel_ap_ack,
        route_kernel,
        position_kernel,
        departure_kernel,
        seed_kernel,
        s_axi_control_AWVALID,
        s_axi_control_AWREADY,
        s_axi_control_AWADDR,
        s_axi_control_WVALID,
        s_axi_control_WREADY,
        s_axi_control_WDATA,
        s_axi_control_WSTRB,
        s_axi_control_ARVALID,
        s_axi_control_ARREADY,
        s_axi_control_ARADDR,
        s_axi_control_RVALID,
        s_axi_control_RREADY,
        s_axi_control_RDATA,
        s_axi_control_RRESP,
        s_axi_control_BVALID,
        s_axi_control_BREADY,
        s_axi_control_BRESP,
        interrupt,
        event_start,
        stall_start_ext,
        stall_done_ext,
        stall_start_str,
        stall_done_str,
        stall_start_int,
        stall_done_int
);

parameter    ap_ST_fsm_state1 = 2'd1;
parameter    ap_ST_fsm_state2 = 2'd2;
parameter    C_S_AXI_CONTROL_DATA_WIDTH = 32;
parameter    C_S_AXI_CONTROL_ADDR_WIDTH = 7;
parameter    C_S_AXI_DATA_WIDTH = 32;
parameter    C_M_AXI_GMEM0_ID_WIDTH = 1;
parameter    C_M_AXI_GMEM0_ADDR_WIDTH = 64;
parameter    C_M_AXI_GMEM0_DATA_WIDTH = 64;
parameter    C_M_AXI_GMEM0_AWUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM0_ARUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM0_WUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM0_RUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM0_BUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM0_USER_VALUE = 0;
parameter    C_M_AXI_GMEM0_PROT_VALUE = 0;
parameter    C_M_AXI_GMEM0_CACHE_VALUE = 3;

parameter C_S_AXI_CONTROL_WSTRB_WIDTH = (32 / 8);
parameter C_S_AXI_WSTRB_WIDTH = (32 / 8);
parameter C_M_AXI_GMEM0_WSTRB_WIDTH = (64 / 8);

input   ap_clk;
input   ap_rst_n;
output   event_done;
output   m_axi_gmem0_AWVALID;
input   m_axi_gmem0_AWREADY;
output  [C_M_AXI_GMEM0_ADDR_WIDTH - 1:0] m_axi_gmem0_AWADDR;
output  [C_M_AXI_GMEM0_ID_WIDTH - 1:0] m_axi_gmem0_AWID;
output  [7:0] m_axi_gmem0_AWLEN;
output  [2:0] m_axi_gmem0_AWSIZE;
output  [1:0] m_axi_gmem0_AWBURST;
output  [1:0] m_axi_gmem0_AWLOCK;
output  [3:0] m_axi_gmem0_AWCACHE;
output  [2:0] m_axi_gmem0_AWPROT;
output  [3:0] m_axi_gmem0_AWQOS;
output  [3:0] m_axi_gmem0_AWREGION;
output  [C_M_AXI_GMEM0_AWUSER_WIDTH - 1:0] m_axi_gmem0_AWUSER;
output   m_axi_gmem0_WVALID;
input   m_axi_gmem0_WREADY;
output  [C_M_AXI_GMEM0_DATA_WIDTH - 1:0] m_axi_gmem0_WDATA;
output  [C_M_AXI_GMEM0_WSTRB_WIDTH - 1:0] m_axi_gmem0_WSTRB;
output   m_axi_gmem0_WLAST;
output  [C_M_AXI_GMEM0_ID_WIDTH - 1:0] m_axi_gmem0_WID;
output  [C_M_AXI_GMEM0_WUSER_WIDTH - 1:0] m_axi_gmem0_WUSER;
output   m_axi_gmem0_ARVALID;
input   m_axi_gmem0_ARREADY;
output  [C_M_AXI_GMEM0_ADDR_WIDTH - 1:0] m_axi_gmem0_ARADDR;
output  [C_M_AXI_GMEM0_ID_WIDTH - 1:0] m_axi_gmem0_ARID;
output  [7:0] m_axi_gmem0_ARLEN;
output  [2:0] m_axi_gmem0_ARSIZE;
output  [1:0] m_axi_gmem0_ARBURST;
output  [1:0] m_axi_gmem0_ARLOCK;
output  [3:0] m_axi_gmem0_ARCACHE;
output  [2:0] m_axi_gmem0_ARPROT;
output  [3:0] m_axi_gmem0_ARQOS;
output  [3:0] m_axi_gmem0_ARREGION;
output  [C_M_AXI_GMEM0_ARUSER_WIDTH - 1:0] m_axi_gmem0_ARUSER;
input   m_axi_gmem0_RVALID;
output   m_axi_gmem0_RREADY;
input  [C_M_AXI_GMEM0_DATA_WIDTH - 1:0] m_axi_gmem0_RDATA;
input   m_axi_gmem0_RLAST;
input  [C_M_AXI_GMEM0_ID_WIDTH - 1:0] m_axi_gmem0_RID;
input  [C_M_AXI_GMEM0_RUSER_WIDTH - 1:0] m_axi_gmem0_RUSER;
input  [1:0] m_axi_gmem0_RRESP;
input   m_axi_gmem0_BVALID;
output   m_axi_gmem0_BREADY;
input  [1:0] m_axi_gmem0_BRESP;
input  [C_M_AXI_GMEM0_ID_WIDTH - 1:0] m_axi_gmem0_BID;
input  [C_M_AXI_GMEM0_BUSER_WIDTH - 1:0] m_axi_gmem0_BUSER;
output  [31:0] durations_kernel;
output   durations_kernel_ap_vld;
input   durations_kernel_ap_ack;
output  [31:0] route_kernel;
output  [31:0] position_kernel;
output  [31:0] departure_kernel;
output  [31:0] seed_kernel;
input   s_axi_control_AWVALID;
output   s_axi_control_AWREADY;
input  [C_S_AXI_CONTROL_ADDR_WIDTH - 1:0] s_axi_control_AWADDR;
input   s_axi_control_WVALID;
output   s_axi_control_WREADY;
input  [C_S_AXI_CONTROL_DATA_WIDTH - 1:0] s_axi_control_WDATA;
input  [C_S_AXI_CONTROL_WSTRB_WIDTH - 1:0] s_axi_control_WSTRB;
input   s_axi_control_ARVALID;
output   s_axi_control_ARREADY;
input  [C_S_AXI_CONTROL_ADDR_WIDTH - 1:0] s_axi_control_ARADDR;
output   s_axi_control_RVALID;
input   s_axi_control_RREADY;
output  [C_S_AXI_CONTROL_DATA_WIDTH - 1:0] s_axi_control_RDATA;
output  [1:0] s_axi_control_RRESP;
output   s_axi_control_BVALID;
input   s_axi_control_BREADY;
output  [1:0] s_axi_control_BRESP;
output   interrupt;
output   event_start;
output   stall_start_ext;
output   stall_done_ext;
output   stall_start_str;
output   stall_done_str;
output   stall_start_int;
output   stall_done_int;

reg[31:0] route_kernel;
reg[31:0] position_kernel;
reg[31:0] departure_kernel;
reg[31:0] seed_kernel;
reg stall_start_ext;
reg stall_done_ext;
reg stall_start_str;
reg stall_done_str;
reg stall_start_int;
reg stall_done_int;

(* shreg_extract = "no" *) reg    ap_rst_reg_2;
(* shreg_extract = "no" *) reg    ap_rst_reg_1;
(* shreg_extract = "no" *) reg    ap_rst_n_inv;
wire    ap_start;
reg    ap_done;
reg    ap_idle;
(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    ap_ready;
wire   [31:0] num_times;
wire   [31:0] durations;
wire   [31:0] route;
wire   [31:0] position;
wire   [31:0] departure;
wire   [31:0] seed;
wire   [63:0] base_r;
reg    durations_kernel_blk_n;
wire    ap_CS_fsm_state2;
reg    ap_block_state1;
wire   [31:0] add_ln66_fu_166_p2;
reg   [31:0] route_kernel_preg;
wire   [31:0] add_ln70_fu_173_p2;
reg   [31:0] position_kernel_preg;
wire   [31:0] add_ln74_fu_180_p2;
reg   [31:0] departure_kernel_preg;
wire   [31:0] add_ln78_fu_187_p2;
reg   [31:0] seed_kernel_preg;
wire   [31:0] trunc_ln61_fu_155_p1;
wire    regslice_forward_durations_kernel_U_apdone_blk;
reg    ap_block_state2;
reg   [1:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
reg    ap_ST_fsm_state2_blk;
wire    ap_ext_blocking_n;
wire    ap_str_blocking_n;
wire    ap_int_blocking_n;
reg    ap_ext_blocking_n_reg;
reg    ap_str_blocking_n_reg;
reg    ap_int_blocking_n_reg;
wire   [31:0] durations_kernel_int_regslice;
reg    durations_kernel_ap_vld_int_regslice;
wire    durations_kernel_ap_ack_int_regslice;
wire    regslice_forward_durations_kernel_U_vld_out;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_rst_reg_2 = 1'b1;
#0 ap_rst_reg_1 = 1'b1;
#0 ap_rst_n_inv = 1'b1;
#0 ap_CS_fsm = 2'd1;
#0 route_kernel_preg = 32'd0;
#0 position_kernel_preg = 32'd0;
#0 departure_kernel_preg = 32'd0;
#0 seed_kernel_preg = 32'd0;
end

krnl_helm_control_s_axi #(
    .C_S_AXI_ADDR_WIDTH( C_S_AXI_CONTROL_ADDR_WIDTH ),
    .C_S_AXI_DATA_WIDTH( C_S_AXI_CONTROL_DATA_WIDTH ))
control_s_axi_U(
    .AWVALID(s_axi_control_AWVALID),
    .AWREADY(s_axi_control_AWREADY),
    .AWADDR(s_axi_control_AWADDR),
    .WVALID(s_axi_control_WVALID),
    .WREADY(s_axi_control_WREADY),
    .WDATA(s_axi_control_WDATA),
    .WSTRB(s_axi_control_WSTRB),
    .ARVALID(s_axi_control_ARVALID),
    .ARREADY(s_axi_control_ARREADY),
    .ARADDR(s_axi_control_ARADDR),
    .RVALID(s_axi_control_RVALID),
    .RREADY(s_axi_control_RREADY),
    .RDATA(s_axi_control_RDATA),
    .RRESP(s_axi_control_RRESP),
    .BVALID(s_axi_control_BVALID),
    .BREADY(s_axi_control_BREADY),
    .BRESP(s_axi_control_BRESP),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .num_times(num_times),
    .durations(durations),
    .route(route),
    .position(position),
    .departure(departure),
    .seed(seed),
    .base_r(base_r),
    .ap_start(ap_start),
    .interrupt(interrupt),
    .event_start(event_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_idle(ap_idle)
);

krnl_helm_regslice_forward #(
    .DataWidth( 32 ))
regslice_forward_durations_kernel_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(durations_kernel_int_regslice),
    .vld_in(durations_kernel_ap_vld_int_regslice),
    .ack_in(durations_kernel_ap_ack_int_regslice),
    .data_out(durations_kernel),
    .vld_out(regslice_forward_durations_kernel_U_vld_out),
    .ack_out(durations_kernel_ap_ack),
    .apdone_blk(regslice_forward_durations_kernel_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        departure_kernel_preg <= 32'd0;
    end else begin
        if ((~((durations_kernel_ap_ack_int_regslice == 1'b0) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
            departure_kernel_preg <= add_ln74_fu_180_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        position_kernel_preg <= 32'd0;
    end else begin
        if ((~((durations_kernel_ap_ack_int_regslice == 1'b0) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
            position_kernel_preg <= add_ln70_fu_173_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        route_kernel_preg <= 32'd0;
    end else begin
        if ((~((durations_kernel_ap_ack_int_regslice == 1'b0) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
            route_kernel_preg <= add_ln66_fu_166_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        seed_kernel_preg <= 32'd0;
    end else begin
        if ((~((durations_kernel_ap_ack_int_regslice == 1'b0) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
            seed_kernel_preg <= add_ln78_fu_187_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    ap_rst_n_inv <= ap_rst_reg_1;
end

always @ (posedge ap_clk) begin
    ap_rst_reg_1 <= ap_rst_reg_2;
end

always @ (posedge ap_clk) begin
    ap_rst_reg_2 <= ~ap_rst_n;
end

always @ (*) begin
    if (((durations_kernel_ap_ack_int_regslice == 1'b0) | (ap_start == 1'b0))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if (((durations_kernel_ap_ack_int_regslice == 1'b0) | (regslice_forward_durations_kernel_U_apdone_blk == 1'b1))) begin
        ap_ST_fsm_state2_blk = 1'b1;
    end else begin
        ap_ST_fsm_state2_blk = 1'b0;
    end
end

always @ (*) begin
    if ((~((durations_kernel_ap_ack_int_regslice == 1'b0) | (regslice_forward_durations_kernel_U_apdone_blk == 1'b1)) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((~((durations_kernel_ap_ack_int_regslice == 1'b0) | (regslice_forward_durations_kernel_U_apdone_blk == 1'b1)) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((~((durations_kernel_ap_ack_int_regslice == 1'b0) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        departure_kernel = add_ln74_fu_180_p2;
    end else begin
        departure_kernel = departure_kernel_preg;
    end
end

always @ (*) begin
    if ((~((durations_kernel_ap_ack_int_regslice == 1'b0) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        durations_kernel_ap_vld_int_regslice = 1'b1;
    end else begin
        durations_kernel_ap_vld_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) | ((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)))) begin
        durations_kernel_blk_n = durations_kernel_ap_ack_int_regslice;
    end else begin
        durations_kernel_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((durations_kernel_ap_ack_int_regslice == 1'b0) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        position_kernel = add_ln70_fu_173_p2;
    end else begin
        position_kernel = position_kernel_preg;
    end
end

always @ (*) begin
    if ((~((durations_kernel_ap_ack_int_regslice == 1'b0) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        route_kernel = add_ln66_fu_166_p2;
    end else begin
        route_kernel = route_kernel_preg;
    end
end

always @ (*) begin
    if ((~((durations_kernel_ap_ack_int_regslice == 1'b0) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        seed_kernel = add_ln78_fu_187_p2;
    end else begin
        seed_kernel = seed_kernel_preg;
    end
end

always @ (*) begin
    if (((ap_ext_blocking_n_reg == 1'b0) & (ap_ext_blocking_n == 1'b1))) begin
        stall_done_ext = 1'b1;
    end else begin
        stall_done_ext = 1'b0;
    end
end

always @ (*) begin
    if (((ap_int_blocking_n_reg == 1'b0) & (ap_int_blocking_n == 1'b1))) begin
        stall_done_int = 1'b1;
    end else begin
        stall_done_int = 1'b0;
    end
end

always @ (*) begin
    if (((ap_str_blocking_n_reg == 1'b0) & (ap_str_blocking_n == 1'b1))) begin
        stall_done_str = 1'b1;
    end else begin
        stall_done_str = 1'b0;
    end
end

always @ (*) begin
    if (((ap_ext_blocking_n_reg == 1'b1) & (ap_ext_blocking_n == 1'b0))) begin
        stall_start_ext = 1'b1;
    end else begin
        stall_start_ext = 1'b0;
    end
end

always @ (*) begin
    if (((ap_int_blocking_n_reg == 1'b1) & (ap_int_blocking_n == 1'b0))) begin
        stall_start_int = 1'b1;
    end else begin
        stall_start_int = 1'b0;
    end
end

always @ (*) begin
    if (((ap_str_blocking_n_reg == 1'b1) & (ap_str_blocking_n == 1'b0))) begin
        stall_start_str = 1'b1;
    end else begin
        stall_start_str = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((durations_kernel_ap_ack_int_regslice == 1'b0) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if ((~((durations_kernel_ap_ack_int_regslice == 1'b0) | (regslice_forward_durations_kernel_U_apdone_blk == 1'b1)) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln66_fu_166_p2 = (trunc_ln61_fu_155_p1 + route);

assign add_ln70_fu_173_p2 = (trunc_ln61_fu_155_p1 + position);

assign add_ln74_fu_180_p2 = (trunc_ln61_fu_155_p1 + departure);

assign add_ln78_fu_187_p2 = (trunc_ln61_fu_155_p1 + seed);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

always @ (*) begin
    ap_block_state1 = ((durations_kernel_ap_ack_int_regslice == 1'b0) | (ap_start == 1'b0));
end

always @ (*) begin
    ap_block_state2 = ((durations_kernel_ap_ack_int_regslice == 1'b0) | (regslice_forward_durations_kernel_U_apdone_blk == 1'b1));
end

assign ap_ext_blocking_n = (1'b1 & 1'b1);

assign ap_int_blocking_n = (1'b1 & 1'b1);

assign ap_str_blocking_n = (1'b1 & 1'b1);

assign durations_kernel_ap_vld = regslice_forward_durations_kernel_U_vld_out;

assign durations_kernel_int_regslice = (trunc_ln61_fu_155_p1 + durations);

assign event_done = ap_done;

assign m_axi_gmem0_ARADDR = 64'd0;

assign m_axi_gmem0_ARBURST = 2'd0;

assign m_axi_gmem0_ARCACHE = 4'd0;

assign m_axi_gmem0_ARID = 1'd0;

assign m_axi_gmem0_ARLEN = 8'd0;

assign m_axi_gmem0_ARLOCK = 2'd0;

assign m_axi_gmem0_ARPROT = 3'd0;

assign m_axi_gmem0_ARQOS = 4'd0;

assign m_axi_gmem0_ARREGION = 4'd0;

assign m_axi_gmem0_ARSIZE = 3'd0;

assign m_axi_gmem0_ARUSER = 1'd0;

assign m_axi_gmem0_ARVALID = 1'b0;

assign m_axi_gmem0_AWADDR = 64'd0;

assign m_axi_gmem0_AWBURST = 2'd0;

assign m_axi_gmem0_AWCACHE = 4'd0;

assign m_axi_gmem0_AWID = 1'd0;

assign m_axi_gmem0_AWLEN = 8'd0;

assign m_axi_gmem0_AWLOCK = 2'd0;

assign m_axi_gmem0_AWPROT = 3'd0;

assign m_axi_gmem0_AWQOS = 4'd0;

assign m_axi_gmem0_AWREGION = 4'd0;

assign m_axi_gmem0_AWSIZE = 3'd0;

assign m_axi_gmem0_AWUSER = 1'd0;

assign m_axi_gmem0_AWVALID = 1'b0;

assign m_axi_gmem0_BREADY = 1'b0;

assign m_axi_gmem0_RREADY = 1'b0;

assign m_axi_gmem0_WDATA = 64'd0;

assign m_axi_gmem0_WID = 1'd0;

assign m_axi_gmem0_WLAST = 1'b0;

assign m_axi_gmem0_WSTRB = 8'd0;

assign m_axi_gmem0_WUSER = 1'd0;

assign m_axi_gmem0_WVALID = 1'b0;

assign trunc_ln61_fu_155_p1 = base_r[31:0];

always @ (posedge ap_clk) begin
    ap_ext_blocking_n_reg <= 1'b1;
    ap_str_blocking_n_reg <= 1'b1;
    ap_int_blocking_n_reg <= 1'b1;
end

endmodule //krnl_helm