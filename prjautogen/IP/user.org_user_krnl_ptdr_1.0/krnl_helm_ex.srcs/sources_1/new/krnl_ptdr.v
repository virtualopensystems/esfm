// This is a generated file. Use and modify at your own risk.
//////////////////////////////////////////////////////////////////////////////// 
// default_nettype of none prevents implicit wire declaration.
`default_nettype none
`timescale 1 ns / 1 ps
// Top level of the kernel. Do not modify module name, parameters or ports.
module krnl_ptdr #(
  parameter integer C_S_AXI_CONTROL_ADDR_WIDTH = 12 ,
  parameter integer C_S_AXI_CONTROL_DATA_WIDTH = 32 ,
  parameter integer C_M_AXI_GMEM0_ADDR_WIDTH   = 64 ,
  parameter integer C_M_AXI_GMEM0_DATA_WIDTH   = 64
)
(
  // System Signals
  input  wire                                    ap_clk               ,
  input  wire                                    ap_rst_n             ,
  //  Note: A minimum subset of AXI4 memory mapped signals are declared.  AXI
  // signals omitted from these interfaces are automatically inferred with the
  // optimal values for Xilinx accleration platforms.  This allows Xilinx AXI4 Interconnects
  // within the system to be optimized by removing logic for AXI4 protocol
  // features that are not necessary. When adapting AXI4 masters within the RTL
  // kernel that have signals not declared below, it is suitable to add the
  // signals to the declarations below to connect them to the AXI4 Master.
  // 
  // List of ommited signals - effect
  // -------------------------------
  // ID - Transaction ID are used for multithreading and out of order
  // transactions.  This increases complexity. This saves logic and increases Fmax
  // in the system when ommited.
  // SIZE - Default value is log2(data width in bytes). Needed for subsize bursts.
  // This saves logic and increases Fmax in the system when ommited.
  // BURST - Default value (0b01) is incremental.  Wrap and fixed bursts are not
  // recommended. This saves logic and increases Fmax in the system when ommited.
  // LOCK - Not supported in AXI4
  // CACHE - Default value (0b0011) allows modifiable transactions. No benefit to
  // changing this.
  // PROT - Has no effect in current acceleration platforms.
  // QOS - Has no effect in current acceleration platforms.
  // REGION - Has no effect in current acceleration platforms.
  // USER - Has no effect in current acceleration platforms.
  // RESP - Not useful in most acceleration platforms.
  // 
  // AXI4 master interface m_axi_gmem0
  output wire                                    m_axi_gmem0_awvalid  ,
  input  wire                                    m_axi_gmem0_awready  ,
  output wire [C_M_AXI_GMEM0_ADDR_WIDTH-1:0]     m_axi_gmem0_awaddr   ,
  output wire [8-1:0]                            m_axi_gmem0_awlen    ,
    output wire [1:0]m_axi_gmem0_arid,
  output wire                                    m_axi_gmem0_wvalid   ,
  input  wire                                    m_axi_gmem0_wready   ,
  output wire [C_M_AXI_GMEM0_DATA_WIDTH-1:0]     m_axi_gmem0_wdata    ,
  output wire [C_M_AXI_GMEM0_DATA_WIDTH/8-1:0]   m_axi_gmem0_wstrb    ,
  output wire                                    m_axi_gmem0_wlast    ,
    output wire [1:0]m_axi_gmem0_awid,
  input  wire                                    m_axi_gmem0_bvalid   ,
  output wire                                    m_axi_gmem0_bready   ,
    input wire [1:0]m_axi_gmem0_bid,
  output wire                                    m_axi_gmem0_arvalid  ,
  input  wire                                    m_axi_gmem0_arready  ,
  output wire [C_M_AXI_GMEM0_ADDR_WIDTH-1:0]     m_axi_gmem0_araddr   ,
  output wire [8-1:0]                            m_axi_gmem0_arlen    ,
  input  wire                                    m_axi_gmem0_rvalid   ,
  output wire                                    m_axi_gmem0_rready   ,
  input  wire [C_M_AXI_GMEM0_DATA_WIDTH-1:0]     m_axi_gmem0_rdata    ,
  input  wire                                    m_axi_gmem0_rlast    ,
    input wire [1:0]m_axi_gmem0_rid,
  // AXI4-Lite slave interface
  input  wire                                    s_axi_control_awvalid,
  output wire                                    s_axi_control_awready,
  input  wire [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_awaddr ,
  input  wire                                    s_axi_control_wvalid ,
  output wire                                    s_axi_control_wready ,
  input  wire [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_wdata  ,
  input  wire [C_S_AXI_CONTROL_DATA_WIDTH/8-1:0] s_axi_control_wstrb  ,
  input  wire                                    s_axi_control_arvalid,
  output wire                                    s_axi_control_arready,
  input  wire [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_araddr ,
  output wire                                    s_axi_control_rvalid ,
  input  wire                                    s_axi_control_rready ,
  output wire [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_rdata  ,
  output wire [2-1:0]                            s_axi_control_rresp  ,
  output wire                                    s_axi_control_bvalid ,
  input  wire                                    s_axi_control_bready ,
  output wire [2-1:0]                            s_axi_control_bresp  ,
  output wire                                    interrupt            
);

///////////////////////////////////////////////////////////////////////////////
// Local Parameters
///////////////////////////////////////////////////////////////////////////////
  design_1 design_1_i
       (.ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .interrupt(interrupt),
        .m_axi_gmem0_araddr(m_axi_gmem0_araddr),
        .m_axi_gmem0_arburst(),
        .m_axi_gmem0_arcache(),
        .m_axi_gmem0_arid(m_axi_gmem0_arid),
        .m_axi_gmem0_arlen(m_axi_gmem0_arlen),
        .m_axi_gmem0_arlock(),
        .m_axi_gmem0_arprot(),
        .m_axi_gmem0_arqos(),
        .m_axi_gmem0_arready(m_axi_gmem0_arready),
        .m_axi_gmem0_arregion(),
        .m_axi_gmem0_arsize(),
        .m_axi_gmem0_aruser(),
        .m_axi_gmem0_arvalid(m_axi_gmem0_arvalid),
        .m_axi_gmem0_awaddr(m_axi_gmem0_awaddr),
        .m_axi_gmem0_awburst(),
        .m_axi_gmem0_awcache(),
        .m_axi_gmem0_awid(m_axi_gmem0_awid),
        .m_axi_gmem0_awlen(m_axi_gmem0_awlen),
        .m_axi_gmem0_awlock(),
        .m_axi_gmem0_awprot(),
        .m_axi_gmem0_awqos(),
        .m_axi_gmem0_awready(m_axi_gmem0_awready),
        .m_axi_gmem0_awregion(),
        .m_axi_gmem0_awsize(),
        .m_axi_gmem0_awuser(),
        .m_axi_gmem0_awvalid(m_axi_gmem0_awvalid),
        .m_axi_gmem0_bid(m_axi_gmem0_bid),
        .m_axi_gmem0_bready(m_axi_gmem0_bready),
        .m_axi_gmem0_bresp(),
        .m_axi_gmem0_buser(),
        .m_axi_gmem0_bvalid(m_axi_gmem0_bvalid),
        .m_axi_gmem0_rdata(m_axi_gmem0_rdata),
        .m_axi_gmem0_rid(m_axi_gmem0_rid),
        .m_axi_gmem0_rlast(m_axi_gmem0_rlast),
        .m_axi_gmem0_rready(m_axi_gmem0_rready),
        .m_axi_gmem0_rresp(),
        .m_axi_gmem0_ruser(),
        .m_axi_gmem0_rvalid(m_axi_gmem0_rvalid),
        .m_axi_gmem0_wdata(m_axi_gmem0_wdata),
        .m_axi_gmem0_wlast(m_axi_gmem0_wlast),
        .m_axi_gmem0_wready(m_axi_gmem0_wready),
        .m_axi_gmem0_wstrb(m_axi_gmem0_wstrb),
        .m_axi_gmem0_wuser(),
        .m_axi_gmem0_wvalid(m_axi_gmem0_wvalid),
        .s_axi_control_araddr(s_axi_control_araddr),
        .s_axi_control_arready(s_axi_control_arready),
        .s_axi_control_arvalid(s_axi_control_arvalid),
        .s_axi_control_awaddr(s_axi_control_awaddr),
        .s_axi_control_awready(s_axi_control_awready),
        .s_axi_control_awvalid(s_axi_control_awvalid),
        .s_axi_control_bready(s_axi_control_bready),
        .s_axi_control_bresp(s_axi_control_bresp),
        .s_axi_control_bvalid(s_axi_control_bvalid),
        .s_axi_control_rdata(s_axi_control_rdata),
        .s_axi_control_rready(s_axi_control_rready),
        .s_axi_control_rresp(s_axi_control_rresp),
        .s_axi_control_rvalid(s_axi_control_rvalid),
        .s_axi_control_wdata(s_axi_control_wdata),
        .s_axi_control_wready(s_axi_control_wready),
        .s_axi_control_wstrb(s_axi_control_wstrb),
        .s_axi_control_wvalid(s_axi_control_wvalid));
        
/////////////////////////////////////////////////////////////////////////////////
//// Wires and Variables
/////////////////////////////////////////////////////////////////////////////////
//(* DONT_TOUCH = "yes" *)
//reg                                 areset                         = 1'b0;
//wire                                ap_start                      ;
//wire                                ap_idle                       ;
//wire                                ap_done                       ;
//wire                                ap_ready                      ;
//wire                                ap_continue                   ;
//wire [32-1:0]                       num_times                     ;
//wire [32-1:0]                       durations                     ;
//wire [32-1:0]                       route                         ;
//wire [32-1:0]                       position                      ;
//wire [32-1:0]                       departure                     ;
//wire [32-1:0]                       seed                          ;
//wire [64-1:0]                       base                          ;

//// Register and invert reset signal.
//always @(posedge ap_clk) begin
//  areset <= ~ap_rst_n;
//end

/////////////////////////////////////////////////////////////////////////////////
//// Begin control interface RTL.  Modifying not recommended.
/////////////////////////////////////////////////////////////////////////////////


//// AXI4-Lite slave interface
//krnl_helm_control_s_axi #(
//  .C_S_AXI_ADDR_WIDTH ( C_S_AXI_CONTROL_ADDR_WIDTH ),
//  .C_S_AXI_DATA_WIDTH ( C_S_AXI_CONTROL_DATA_WIDTH )
//)
//inst_control_s_axi (
//  .ACLK        ( ap_clk                ),
//  .ARESET      ( areset                ),
//  .ACLK_EN     ( 1'b1                  ),
//  .AWVALID     ( s_axi_control_awvalid ),
//  .AWREADY     ( s_axi_control_awready ),
//  .AWADDR      ( s_axi_control_awaddr  ),
//  .WVALID      ( s_axi_control_wvalid  ),
//  .WREADY      ( s_axi_control_wready  ),
//  .WDATA       ( s_axi_control_wdata   ),
//  .WSTRB       ( s_axi_control_wstrb   ),
//  .ARVALID     ( s_axi_control_arvalid ),
//  .ARREADY     ( s_axi_control_arready ),
//  .ARADDR      ( s_axi_control_araddr  ),
//  .RVALID      ( s_axi_control_rvalid  ),
//  .RREADY      ( s_axi_control_rready  ),
//  .RDATA       ( s_axi_control_rdata   ),
//  .RRESP       ( s_axi_control_rresp   ),
//  .BVALID      ( s_axi_control_bvalid  ),
//  .BREADY      ( s_axi_control_bready  ),
//  .BRESP       ( s_axi_control_bresp   ),
//  .interrupt   ( interrupt             ),
//  .ap_start    ( ap_start              ),
//  .ap_done     ( ap_done               ),
//  .ap_ready    ( ap_ready              ),
//  .ap_idle     ( ap_idle               ),
//  .ap_continue ( ap_continue           ),
//  .num_times   ( num_times             ),
//  .durations   ( durations             ),
//  .route       ( route                 ),
//  .position    ( position              ),
//  .departure   ( departure             ),
//  .seed        ( seed                  ),
//  .base        ( base                  )
//);

/////////////////////////////////////////////////////////////////////////////////
//// Add kernel logic here.  Modify/remove example code as necessary.
/////////////////////////////////////////////////////////////////////////////////

//// Example RTL block.  Remove to insert custom logic.
//krnl_helm_example #(
//  .C_M_AXI_GMEM0_ADDR_WIDTH ( C_M_AXI_GMEM0_ADDR_WIDTH ),
//  .C_M_AXI_GMEM0_DATA_WIDTH ( C_M_AXI_GMEM0_DATA_WIDTH )
//)
//inst_example (
//  .ap_clk              ( ap_clk              ),
//  .ap_rst_n            ( ap_rst_n            ),
//  .m_axi_gmem0_awvalid ( m_axi_gmem0_awvalid ),
//  .m_axi_gmem0_awready ( m_axi_gmem0_awready ),
//  .m_axi_gmem0_awaddr  ( m_axi_gmem0_awaddr  ),
//  .m_axi_gmem0_awlen   ( m_axi_gmem0_awlen   ),
//  .m_axi_gmem0_wvalid  ( m_axi_gmem0_wvalid  ),
//  .m_axi_gmem0_wready  ( m_axi_gmem0_wready  ),
//  .m_axi_gmem0_wdata   ( m_axi_gmem0_wdata   ),
//  .m_axi_gmem0_wstrb   ( m_axi_gmem0_wstrb   ),
//  .m_axi_gmem0_wlast   ( m_axi_gmem0_wlast   ),
//  .m_axi_gmem0_bvalid  ( m_axi_gmem0_bvalid  ),
//  .m_axi_gmem0_bready  ( m_axi_gmem0_bready  ),
//  .m_axi_gmem0_arvalid ( m_axi_gmem0_arvalid ),
//  .m_axi_gmem0_arready ( m_axi_gmem0_arready ),
//  .m_axi_gmem0_araddr  ( m_axi_gmem0_araddr  ),
//  .m_axi_gmem0_arlen   ( m_axi_gmem0_arlen   ),
//  .m_axi_gmem0_rvalid  ( m_axi_gmem0_rvalid  ),
//  .m_axi_gmem0_rready  ( m_axi_gmem0_rready  ),
//  .m_axi_gmem0_rdata   ( m_axi_gmem0_rdata   ),
//  .m_axi_gmem0_rlast   ( m_axi_gmem0_rlast   ),
//  .ap_start            ( ap_start            ),
//  .ap_done             ( ap_done             ),
//  .ap_idle             ( ap_idle             ),
//  .ap_ready            ( ap_ready            ),
//  .ap_continue         ( ap_continue         ),
//  .num_times           ( num_times           ),
//  .durations           ( durations           ),
//  .route               ( route               ),
//  .position            ( position            ),
//  .departure           ( departure           ),
//  .seed                ( seed                ),
//  .base                ( base                )
//);

endmodule
`default_nettype wire
