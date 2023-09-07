// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Version: 2022.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module krnl_helm_compute_1_Pipeline_VITIS_LOOP_34_13_VITIS_LOOP_35_14_VITIS_LOOP_36_15 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        D_buf_address0,
        D_buf_ce0,
        D_buf_q0,
        t_address0,
        t_ce0,
        t_q0,
        r_address0,
        r_ce0,
        r_we0,
        r_d0,
        ap_ext_blocking_n,
        ap_str_blocking_n,
        ap_int_blocking_n,
        grp_fu_174_p_din0,
        grp_fu_174_p_din1,
        grp_fu_174_p_dout0,
        grp_fu_174_p_ce
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [10:0] D_buf_address0;
output   D_buf_ce0;
input  [63:0] D_buf_q0;
output  [10:0] t_address0;
output   t_ce0;
input  [63:0] t_q0;
output  [10:0] r_address0;
output   r_ce0;
output   r_we0;
output  [63:0] r_d0;
output   ap_ext_blocking_n;
output   ap_str_blocking_n;
output   ap_int_blocking_n;
output  [63:0] grp_fu_174_p_din0;
output  [63:0] grp_fu_174_p_din1;
input  [63:0] grp_fu_174_p_dout0;
output   grp_fu_174_p_ce;

reg ap_idle;
reg D_buf_ce0;
reg t_ce0;
reg r_ce0;
reg r_we0;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_enable_reg_pp0_iter4;
reg    ap_enable_reg_pp0_iter5;
reg    ap_enable_reg_pp0_iter6;
reg    ap_enable_reg_pp0_iter7;
reg    ap_enable_reg_pp0_iter8;
reg    ap_enable_reg_pp0_iter9;
reg    ap_enable_reg_pp0_iter10;
reg    ap_enable_reg_pp0_iter11;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_state4_pp0_stage0_iter3;
wire    ap_block_state5_pp0_stage0_iter4;
wire    ap_block_state6_pp0_stage0_iter5;
wire    ap_block_state7_pp0_stage0_iter6;
wire    ap_block_state8_pp0_stage0_iter7;
wire    ap_block_state9_pp0_stage0_iter8;
wire    ap_block_state10_pp0_stage0_iter9;
wire    ap_block_state11_pp0_stage0_iter10;
wire    ap_block_state12_pp0_stage0_iter11;
wire    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln34_fu_155_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg   [0:0] icmp_ln34_reg_395;
wire    ap_block_pp0_stage0_11001;
wire   [0:0] icmp_ln35_fu_176_p2;
reg   [0:0] icmp_ln35_reg_399;
wire   [0:0] and_ln34_fu_212_p2;
reg   [0:0] and_ln34_reg_410;
wire   [3:0] select_ln36_fu_224_p3;
reg   [3:0] select_ln36_reg_416;
wire   [6:0] add_ln38_1_fu_332_p2;
reg   [6:0] add_ln38_1_reg_421;
wire   [63:0] zext_ln38_fu_346_p1;
reg   [63:0] zext_ln38_reg_431;
reg   [63:0] zext_ln38_reg_431_pp0_iter4_reg;
reg   [63:0] zext_ln38_reg_431_pp0_iter5_reg;
reg   [63:0] zext_ln38_reg_431_pp0_iter6_reg;
reg   [63:0] zext_ln38_reg_431_pp0_iter7_reg;
reg   [63:0] zext_ln38_reg_431_pp0_iter8_reg;
reg   [63:0] zext_ln38_reg_431_pp0_iter9_reg;
reg   [63:0] zext_ln38_reg_431_pp0_iter10_reg;
reg   [63:0] D_buf_load_reg_446;
reg   [63:0] t_load_reg_451;
reg   [63:0] mul200_i_reg_456;
reg    ap_condition_exit_pp0_iter1_stage0;
wire    ap_block_pp0_stage0;
reg   [3:0] c3_fu_64;
wire   [3:0] add_ln36_fu_232_p2;
wire    ap_loop_init;
reg   [3:0] ap_sig_allocacmp_c3_load;
reg   [3:0] c2_3_fu_68;
wire   [3:0] select_ln35_fu_322_p3;
reg   [7:0] indvar_flatten150_fu_72;
wire   [7:0] select_ln35_1_fu_244_p3;
reg   [7:0] ap_sig_allocacmp_indvar_flatten150_load;
reg   [3:0] c1_fu_76;
wire   [3:0] select_ln34_1_fu_188_p3;
reg   [3:0] ap_sig_allocacmp_c1_load;
reg   [10:0] indvar_flatten169_fu_80;
wire   [10:0] add_ln34_fu_161_p2;
reg   [10:0] ap_sig_allocacmp_indvar_flatten169_load;
wire   [3:0] add_ln34_1_fu_182_p2;
wire   [0:0] icmp_ln36_fu_206_p2;
wire   [0:0] xor_ln34_fu_200_p2;
wire   [0:0] or_ln36_fu_218_p2;
wire   [7:0] add_ln35_1_fu_238_p2;
wire   [3:0] mul_ln36_fu_279_p0;
wire   [4:0] mul_ln36_fu_279_p1;
wire   [6:0] mul_ln36_fu_279_p2;
wire   [3:0] select_ln34_fu_285_p3;
wire   [3:0] add_ln35_fu_299_p2;
wire   [3:0] mul_ln36_1_fu_309_p0;
wire   [4:0] mul_ln36_1_fu_309_p1;
wire   [6:0] mul_ln36_1_fu_309_p2;
wire   [6:0] select_ln34_2_fu_292_p3;
wire   [6:0] select_ln36_1_fu_315_p3;
wire   [6:0] c3_3_cast17_fu_329_p1;
wire   [10:0] grp_fu_351_p3;
wire   [3:0] grp_fu_351_p0;
wire   [6:0] grp_fu_351_p1;
wire   [6:0] grp_fu_351_p2;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg    ap_loop_exit_ready_pp0_iter2_reg;
reg    ap_loop_exit_ready_pp0_iter3_reg;
reg    ap_loop_exit_ready_pp0_iter4_reg;
reg    ap_loop_exit_ready_pp0_iter5_reg;
reg    ap_loop_exit_ready_pp0_iter6_reg;
reg    ap_loop_exit_ready_pp0_iter7_reg;
reg    ap_loop_exit_ready_pp0_iter8_reg;
reg    ap_loop_exit_ready_pp0_iter9_reg;
reg    ap_loop_exit_ready_pp0_iter10_reg;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
wire   [10:0] grp_fu_351_p00;
wire   [10:0] grp_fu_351_p20;
wire   [6:0] mul_ln36_1_fu_309_p00;
wire   [6:0] mul_ln36_fu_279_p00;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter4 = 1'b0;
#0 ap_enable_reg_pp0_iter5 = 1'b0;
#0 ap_enable_reg_pp0_iter6 = 1'b0;
#0 ap_enable_reg_pp0_iter7 = 1'b0;
#0 ap_enable_reg_pp0_iter8 = 1'b0;
#0 ap_enable_reg_pp0_iter9 = 1'b0;
#0 ap_enable_reg_pp0_iter10 = 1'b0;
#0 ap_enable_reg_pp0_iter11 = 1'b0;
#0 ap_done_reg = 1'b0;
end

krnl_helm_mul_4ns_5ns_7_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 4 ),
    .din1_WIDTH( 5 ),
    .dout_WIDTH( 7 ))
mul_4ns_5ns_7_1_1_U90(
    .din0(mul_ln36_fu_279_p0),
    .din1(mul_ln36_fu_279_p1),
    .dout(mul_ln36_fu_279_p2)
);

krnl_helm_mul_4ns_5ns_7_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 4 ),
    .din1_WIDTH( 5 ),
    .dout_WIDTH( 7 ))
mul_4ns_5ns_7_1_1_U91(
    .din0(mul_ln36_1_fu_309_p0),
    .din1(mul_ln36_1_fu_309_p1),
    .dout(mul_ln36_1_fu_309_p2)
);

krnl_helm_mac_muladd_4ns_7ns_7ns_11_4_1 #(
    .ID( 1 ),
    .NUM_STAGE( 4 ),
    .din0_WIDTH( 4 ),
    .din1_WIDTH( 7 ),
    .din2_WIDTH( 7 ),
    .dout_WIDTH( 11 ))
mac_muladd_4ns_7ns_7ns_11_4_1_U92(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_351_p0),
    .din1(grp_fu_351_p1),
    .din2(grp_fu_351_p2),
    .ce(1'b1),
    .dout(grp_fu_351_p3)
);

krnl_helm_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage0),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter10_reg == 1'b1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter10 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter10 <= ap_enable_reg_pp0_iter9;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter11 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter11 <= ap_enable_reg_pp0_iter10;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter1_stage0)) begin
            ap_enable_reg_pp0_iter2 <= 1'b0;
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter4 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter5 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter5 <= ap_enable_reg_pp0_iter4;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter6 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter6 <= ap_enable_reg_pp0_iter5;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter7 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter7 <= ap_enable_reg_pp0_iter6;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter8 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter8 <= ap_enable_reg_pp0_iter7;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter9 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter9 <= ap_enable_reg_pp0_iter8;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln34_fu_155_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            c1_fu_76 <= select_ln34_1_fu_188_p3;
        end else if ((ap_loop_init == 1'b1)) begin
            c1_fu_76 <= 4'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if ((ap_loop_init == 1'b1)) begin
            c2_3_fu_68 <= 4'd0;
        end else if (((ap_enable_reg_pp0_iter1 == 1'b1) & (icmp_ln34_reg_395 == 1'd0))) begin
            c2_3_fu_68 <= select_ln35_fu_322_p3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln34_fu_155_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            c3_fu_64 <= add_ln36_fu_232_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            c3_fu_64 <= 4'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln34_fu_155_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            indvar_flatten150_fu_72 <= select_ln35_1_fu_244_p3;
        end else if ((ap_loop_init == 1'b1)) begin
            indvar_flatten150_fu_72 <= 8'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln34_fu_155_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            indvar_flatten169_fu_80 <= add_ln34_fu_161_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            indvar_flatten169_fu_80 <= 11'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        D_buf_load_reg_446 <= D_buf_q0;
        ap_loop_exit_ready_pp0_iter10_reg <= ap_loop_exit_ready_pp0_iter9_reg;
        ap_loop_exit_ready_pp0_iter3_reg <= ap_loop_exit_ready_pp0_iter2_reg;
        ap_loop_exit_ready_pp0_iter4_reg <= ap_loop_exit_ready_pp0_iter3_reg;
        ap_loop_exit_ready_pp0_iter5_reg <= ap_loop_exit_ready_pp0_iter4_reg;
        ap_loop_exit_ready_pp0_iter6_reg <= ap_loop_exit_ready_pp0_iter5_reg;
        ap_loop_exit_ready_pp0_iter7_reg <= ap_loop_exit_ready_pp0_iter6_reg;
        ap_loop_exit_ready_pp0_iter8_reg <= ap_loop_exit_ready_pp0_iter7_reg;
        ap_loop_exit_ready_pp0_iter9_reg <= ap_loop_exit_ready_pp0_iter8_reg;
        mul200_i_reg_456 <= grp_fu_174_p_dout0;
        t_load_reg_451 <= t_q0;
        zext_ln38_reg_431[10 : 0] <= zext_ln38_fu_346_p1[10 : 0];
        zext_ln38_reg_431_pp0_iter10_reg[10 : 0] <= zext_ln38_reg_431_pp0_iter9_reg[10 : 0];
        zext_ln38_reg_431_pp0_iter4_reg[10 : 0] <= zext_ln38_reg_431[10 : 0];
        zext_ln38_reg_431_pp0_iter5_reg[10 : 0] <= zext_ln38_reg_431_pp0_iter4_reg[10 : 0];
        zext_ln38_reg_431_pp0_iter6_reg[10 : 0] <= zext_ln38_reg_431_pp0_iter5_reg[10 : 0];
        zext_ln38_reg_431_pp0_iter7_reg[10 : 0] <= zext_ln38_reg_431_pp0_iter6_reg[10 : 0];
        zext_ln38_reg_431_pp0_iter8_reg[10 : 0] <= zext_ln38_reg_431_pp0_iter7_reg[10 : 0];
        zext_ln38_reg_431_pp0_iter9_reg[10 : 0] <= zext_ln38_reg_431_pp0_iter8_reg[10 : 0];
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln34_reg_395 == 1'd0))) begin
        add_ln38_1_reg_421 <= add_ln38_1_fu_332_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln34_fu_155_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        and_ln34_reg_410 <= and_ln34_fu_212_p2;
        icmp_ln35_reg_399 <= icmp_ln35_fu_176_p2;
        select_ln36_reg_416 <= select_ln36_fu_224_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        ap_loop_exit_ready_pp0_iter2_reg <= ap_loop_exit_ready_pp0_iter1_reg;
        icmp_ln34_reg_395 <= icmp_ln34_fu_155_p2;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1))) begin
        D_buf_ce0 = 1'b1;
    end else begin
        D_buf_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln34_fu_155_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln34_reg_395 == 1'd1))) begin
        ap_condition_exit_pp0_iter1_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter1_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter10_reg == 1'b1))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_idle_pp0 == 1'b1) & (ap_start_int == 1'b0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter11 == 1'b0) & (ap_enable_reg_pp0_iter10 == 1'b0) & (ap_enable_reg_pp0_iter9 == 1'b0) & (ap_enable_reg_pp0_iter8 == 1'b0) & (ap_enable_reg_pp0_iter7 == 1'b0) & (ap_enable_reg_pp0_iter6 == 1'b0) & (ap_enable_reg_pp0_iter5 == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_c1_load = 4'd0;
    end else begin
        ap_sig_allocacmp_c1_load = c1_fu_76;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_c3_load = 4'd0;
    end else begin
        ap_sig_allocacmp_c3_load = c3_fu_64;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_indvar_flatten150_load = 8'd0;
    end else begin
        ap_sig_allocacmp_indvar_flatten150_load = indvar_flatten150_fu_72;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_indvar_flatten169_load = 11'd0;
    end else begin
        ap_sig_allocacmp_indvar_flatten169_load = indvar_flatten169_fu_80;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter11 == 1'b1))) begin
        r_ce0 = 1'b1;
    end else begin
        r_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter11 == 1'b1))) begin
        r_we0 = 1'b1;
    end else begin
        r_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1))) begin
        t_ce0 = 1'b1;
    end else begin
        t_ce0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign D_buf_address0 = zext_ln38_fu_346_p1;

assign add_ln34_1_fu_182_p2 = (ap_sig_allocacmp_c1_load + 4'd1);

assign add_ln34_fu_161_p2 = (ap_sig_allocacmp_indvar_flatten169_load + 11'd1);

assign add_ln35_1_fu_238_p2 = (ap_sig_allocacmp_indvar_flatten150_load + 8'd1);

assign add_ln35_fu_299_p2 = (select_ln34_fu_285_p3 + 4'd1);

assign add_ln36_fu_232_p2 = (select_ln36_fu_224_p3 + 4'd1);

assign add_ln38_1_fu_332_p2 = (select_ln36_1_fu_315_p3 + c3_3_cast17_fu_329_p1);

assign and_ln34_fu_212_p2 = (xor_ln34_fu_200_p2 & icmp_ln36_fu_206_p2);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_state10_pp0_stage0_iter9 = ~(1'b1 == 1'b1);

assign ap_block_state11_pp0_stage0_iter10 = ~(1'b1 == 1'b1);

assign ap_block_state12_pp0_stage0_iter11 = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage0_iter4 = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage0_iter5 = ~(1'b1 == 1'b1);

assign ap_block_state7_pp0_stage0_iter6 = ~(1'b1 == 1'b1);

assign ap_block_state8_pp0_stage0_iter7 = ~(1'b1 == 1'b1);

assign ap_block_state9_pp0_stage0_iter8 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_ext_blocking_n = (1'b1 & 1'b1);

assign ap_int_blocking_n = (1'b1 & 1'b1);

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign ap_str_blocking_n = (1'b1 & 1'b1);

assign c3_3_cast17_fu_329_p1 = select_ln36_reg_416;

assign grp_fu_174_p_ce = 1'b1;

assign grp_fu_174_p_din0 = D_buf_load_reg_446;

assign grp_fu_174_p_din1 = t_load_reg_451;

assign grp_fu_351_p0 = grp_fu_351_p00;

assign grp_fu_351_p00 = select_ln34_1_fu_188_p3;

assign grp_fu_351_p1 = 11'd121;

assign grp_fu_351_p2 = grp_fu_351_p20;

assign grp_fu_351_p20 = add_ln38_1_reg_421;

assign icmp_ln34_fu_155_p2 = ((ap_sig_allocacmp_indvar_flatten169_load == 11'd1331) ? 1'b1 : 1'b0);

assign icmp_ln35_fu_176_p2 = ((ap_sig_allocacmp_indvar_flatten150_load == 8'd121) ? 1'b1 : 1'b0);

assign icmp_ln36_fu_206_p2 = ((ap_sig_allocacmp_c3_load == 4'd11) ? 1'b1 : 1'b0);

assign mul_ln36_1_fu_309_p0 = mul_ln36_1_fu_309_p00;

assign mul_ln36_1_fu_309_p00 = add_ln35_fu_299_p2;

assign mul_ln36_1_fu_309_p1 = 7'd11;

assign mul_ln36_fu_279_p0 = mul_ln36_fu_279_p00;

assign mul_ln36_fu_279_p00 = c2_3_fu_68;

assign mul_ln36_fu_279_p1 = 7'd11;

assign or_ln36_fu_218_p2 = (icmp_ln35_fu_176_p2 | and_ln34_fu_212_p2);

assign r_address0 = zext_ln38_reg_431_pp0_iter10_reg;

assign r_d0 = mul200_i_reg_456;

assign select_ln34_1_fu_188_p3 = ((icmp_ln35_fu_176_p2[0:0] == 1'b1) ? add_ln34_1_fu_182_p2 : ap_sig_allocacmp_c1_load);

assign select_ln34_2_fu_292_p3 = ((icmp_ln35_reg_399[0:0] == 1'b1) ? 7'd0 : mul_ln36_fu_279_p2);

assign select_ln34_fu_285_p3 = ((icmp_ln35_reg_399[0:0] == 1'b1) ? 4'd0 : c2_3_fu_68);

assign select_ln35_1_fu_244_p3 = ((icmp_ln35_fu_176_p2[0:0] == 1'b1) ? 8'd1 : add_ln35_1_fu_238_p2);

assign select_ln35_fu_322_p3 = ((and_ln34_reg_410[0:0] == 1'b1) ? add_ln35_fu_299_p2 : select_ln34_fu_285_p3);

assign select_ln36_1_fu_315_p3 = ((and_ln34_reg_410[0:0] == 1'b1) ? mul_ln36_1_fu_309_p2 : select_ln34_2_fu_292_p3);

assign select_ln36_fu_224_p3 = ((or_ln36_fu_218_p2[0:0] == 1'b1) ? 4'd0 : ap_sig_allocacmp_c3_load);

assign t_address0 = zext_ln38_fu_346_p1;

assign xor_ln34_fu_200_p2 = (icmp_ln35_fu_176_p2 ^ 1'd1);

assign zext_ln38_fu_346_p1 = grp_fu_351_p3;

always @ (posedge ap_clk) begin
    zext_ln38_reg_431[63:11] <= 53'b00000000000000000000000000000000000000000000000000000;
    zext_ln38_reg_431_pp0_iter4_reg[63:11] <= 53'b00000000000000000000000000000000000000000000000000000;
    zext_ln38_reg_431_pp0_iter5_reg[63:11] <= 53'b00000000000000000000000000000000000000000000000000000;
    zext_ln38_reg_431_pp0_iter6_reg[63:11] <= 53'b00000000000000000000000000000000000000000000000000000;
    zext_ln38_reg_431_pp0_iter7_reg[63:11] <= 53'b00000000000000000000000000000000000000000000000000000;
    zext_ln38_reg_431_pp0_iter8_reg[63:11] <= 53'b00000000000000000000000000000000000000000000000000000;
    zext_ln38_reg_431_pp0_iter9_reg[63:11] <= 53'b00000000000000000000000000000000000000000000000000000;
    zext_ln38_reg_431_pp0_iter10_reg[63:11] <= 53'b00000000000000000000000000000000000000000000000000000;
end

endmodule //krnl_helm_compute_1_Pipeline_VITIS_LOOP_34_13_VITIS_LOOP_35_14_VITIS_LOOP_36_15
