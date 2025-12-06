/*
----------------------------------------------------------------------------------
-                                                                                -
-  Unpublished work. Copyright 2021 Siemens                                      -
-                                                                                -
-  This material contains trade secrets or otherwise confidential                -
-  information owned by Siemens Industry Software Inc. or its affiliates         -
-  (collectively, SISW), or its licensors. Access to and use of this             -
-  information is strictly limited as set forth in the Customer's                -
-  applicable agreements with SISW.                                              -
-                                                                                -
----------------------------------------------------------------------------------
-  File created by: Tessent Shell                                                -
-          Version: 2022.3                                                       -
-       Created on: Sat Nov 15 20:33:20 EST 2025                                 -
----------------------------------------------------------------------------------


*/
`timescale 100 ps / 10 ps

/*------------------------------------------------------------------------------
     Module      :  memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_interface_m1
 
     Description :  This module contains the interface logic for the memory
                    module RM_IHPSG13_1P_8192x32_c4
 
--------------------------------------------------------------------------------
     Interface Options in Effect
 
     BistDataPipelineStages        : 0;
     BitGrouping                   : 1;
     BitSliceWidth                 : 1;
     ConcurrentWrite               : OFF 
     ConcurrentRead                : OFF 
     ControllerType                : PROG;
     DataOutStage                  : NONE;
     DefaultAlgorithm              : SMARCHCHKBCIL;
     DefaultOperationSet           : SYNC;
     InternalScanLogic             : OFF;
     LocalComparators              : ON;
     MemoryType                    : RAM;
     ObservationLogic              : ON;
     OutputEnableControl           : ALWAYSON;
     PipelineSerialDataOut         : OFF;
     ScanWriteThru                 : OFF;
     ShadowRead                    : OFF;
     ShadowWrite                   : OFF;
     Stop-On-Error Limit           : 4096;
     TransparentMode               : SYNCMUX;
 
---------------------------------------------------------------------------- */

module memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_interface_m1 (
  input  wire        A_MEN_IN,
  input  wire        A_WEN_IN,
  input  wire        A_REN_IN,
  input  wire [12:0] A_ADDR_IN,
  input  wire [31:0] A_DIN_IN,
  input  wire [31:0] A_DOUT_IN,
  input  wire        TCK,
  input  wire        BIST_CMP,
  input  wire        INCLUDE_MEM_RESULTS_REG,
  input  wire        BIST_SELECT,
  input  wire        BIST_WRITEENABLE,
  input  wire        BIST_READENABLE,
  input  wire [3:0]  BIST_COL_ADD,
  input  wire [8:0]  BIST_ROW_ADD,
  input  wire [1:0]  BIST_WRITE_DATA,
  input  wire        CHKBCI_PHASE,
  input  wire        BIST_TESTDATA_SELECT_TO_COLLAR,
  input  wire        MEM_BYPASS_EN,
  input  wire        SCAN_SHIFT_EN,
  input  wire        MCP_BOUNDING_EN,
  input  wire        BIST_ON,
  input  wire        BIST_RUN,
  input  wire        BIST_ASYNC_RESETN,
  input  wire        BIST_CLK,
  input  wire        BIST_SHIFT_COLLAR,
  input  wire [1:0]  BIST_EXPECT_DATA,
  input  wire        BIST_SI,
  input  wire        BIST_COLLAR_SETUP,
  input  wire        BIST_COLLAR_HOLD,
  input  wire        BIST_DIAG_EN,
  input  wire        BIST_CLEAR_DEFAULT,
  input  wire        BIST_CLEAR,
  input  wire        BIST_SETUP0,
  input  wire        LV_TM,
  input  wire        FREEZE_STOP_ERROR,
  input  wire        BIST_COLLAR_EN,
  input  wire        RESET_REG_SETUP2,
  input  wire        ERROR_CNT_ZERO,
  output wire        A_MEN,
  output wire        A_WEN,
  output wire        A_REN,
  output reg  [12:0] A_ADDR,
  output reg  [31:0] A_DIN,
  output reg  [31:0] A_DOUT,
  output reg  [5:0]  SCAN_OBS_FLOPS,
  output wire        BIST_SO,
  output wire        BIST_GO
);


wire        CMP_EN;
wire [31:0] BIST_WRITE_DATA_REP;
wire [31:0] BIST_WRITE_DATA_INT;
reg         BIST_INPUT_SELECT;
wire        BIST_EN_RST;
wire        BIST_CLK_INT;
wire        BIST_CLK_OR_TCK;
wire [31:0] BIST_EXPECT_DATA_REP;
wire [31:0] BIST_EXPECT_DATA_INT;
wire        BIST_CLK_EN;
wire        GO_EN;
wire        COLLAR_STATUS_SO;
wire        STATUS_SO;
wire        COLLAR_STATUS_SI;
wire        BIST_INPUT_SELECT_INT;
wire [0:0]  ERROR;
wire [0:0]  ERROR_R;
wire [31:0] RAW_CMP_STAT;
wire [31:0] DATA_TO_MEM;
wire [31:0] DATA_FROM_MEM;
wire [31:0] DATA_FROM_MEM_EXP;
wire        A_MEN_TEST_IN;
reg         A_MEN_NOT_GATED;
wire        A_MEN_TO_MUX;
wire        A_WEN_TEST_IN;
reg         A_WEN_NOT_GATED;
wire        A_WEN_TO_MUX;
wire        A_REN_TEST_IN;
reg         A_REN_NOT_GATED;
wire        A_REN_TO_MUX;
wire [12:0] A_ADDR_TEST_IN;
wire [31:0] A_DIN_DIN_OBS;
wire [31:0] A_DOUT_TO_BYPASS;
wire [31:0] A_DOUT_FROM_BYPASS;
wire [31:0] A_DIN_TEST_IN;
reg  [31:0] A_DOUT_SCAN_IN;
wire        EDATA_CKB_EN;
wire        EDATA_COL_ADD_BIT0;
wire        USE_DEFAULTS;
wire        BIST_COLLAR_HOLD_INT;
wire        FREEZE_STOP_ERROR_RST;
wire        FREEZE_STOP_ERROR_SI;
wire        HOLD_EN;
wire        BIST_SETUP0_SYNC;
wire        LOGIC_HIGH;

//---------------------------
// Memory Interface Main Code
//---------------------------
   assign LOGIC_HIGH = 1'b1;
//----------------------
//-- BIST_ON Sync-ing --
//----------------------
    memlibc_memory_bist_assembly_rtl_tessent_and2 tessent_persistent_cell_AND_BIST_SETUP0_SYNC (
        .a          ( BIST_SETUP0                                ),
        .b          ( BIST_ON                                    ),
        .y          ( BIST_SETUP0_SYNC                           )
    );

//----------------------
//-- BIST_EN Retiming --
//----------------------
    assign BIST_EN_RST              = ~BIST_ASYNC_RESETN;
    always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
       if (~BIST_ASYNC_RESETN)
          BIST_INPUT_SELECT <= 1'b0;
       else
       if (~MCP_BOUNDING_EN) begin
          BIST_INPUT_SELECT <= BIST_RUN | BIST_TESTDATA_SELECT_TO_COLLAR;
       end
   end

    wire BIST_INPUT_SELECT_INT_BUF;
    memlibc_memory_bist_assembly_rtl_tessent_buf tessent_persistent_cell_BIST_INPUT_SELECT_INT (
        .a                          (BIST_INPUT_SELECT & ((~LV_TM)|MEM_BYPASS_EN)),
        .y                          (BIST_INPUT_SELECT_INT_BUF)
    );
    assign #(20.0) BIST_INPUT_SELECT_INT = BIST_INPUT_SELECT_INT_BUF;
    assign USE_DEFAULTS = ~BIST_SETUP0_SYNC;
    assign BIST_COLLAR_HOLD_INT = HOLD_EN;
//-----------------------
//-- Observation Logic --
//-----------------------
  // synopsys async_set_reset "BIST_ASYNC_RESETN"
  always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
    if (~BIST_ASYNC_RESETN)
      SCAN_OBS_FLOPS    <= 6'b000000;
    else
      SCAN_OBS_FLOPS    <= {6{MEM_BYPASS_EN} } & {
                          A_MEN_NOT_GATED      ^ A_WEN_NOT_GATED      ^ A_REN_NOT_GATED      ,
                          A_ADDR[12]           ^ A_ADDR[11]           ^ A_ADDR[10]           ,
                          A_ADDR[9]            ^ A_ADDR[8]            ^ A_ADDR[7]            ,
                          A_ADDR[6]            ^ A_ADDR[5]            ^ A_ADDR[4]            ,
                          A_ADDR[3]            ^ A_ADDR[2]            ^ A_ADDR[1]            ,
                          A_ADDR[0]            
                           };
  end
 
//--------------------------
//-- Replicate Write Data --
//--------------------------
   assign BIST_WRITE_DATA_REP      = {
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA
                                     };
 
//-----------------------
//-- Checkerboard Data --
//-----------------------
   assign BIST_WRITE_DATA_INT       = ~(CHKBCI_PHASE) ? BIST_WRITE_DATA_REP : ({32{BIST_WRITE_DATA_REP[0]}} ^ {32{BIST_COL_ADD[0]}});
   assign DATA_TO_MEM              = BIST_WRITE_DATA_INT;
 
 
 
 

//--------------------------
//-- Memory Control Ports --
//--------------------------

   // Port: A_MEN LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A_MEN_IN or A_MEN_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A_MEN_NOT_GATED = A_MEN_IN;
      1'b1 : A_MEN_NOT_GATED = A_MEN_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign A_MEN                     = A_MEN_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign #(20.0) A_MEN_TEST_IN     = (BIST_COLLAR_EN & A_MEN_TO_MUX);
   assign A_MEN_TO_MUX              = BIST_SELECT;

   // Port: A_MEN }}}

   // Port: A_WEN LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A_WEN_IN or A_WEN_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A_WEN_NOT_GATED = A_WEN_IN;
      1'b1 : A_WEN_NOT_GATED = A_WEN_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign A_WEN                     = A_WEN_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign #(20.0) A_WEN_TEST_IN     = (BIST_COLLAR_EN & A_WEN_TO_MUX);
   assign A_WEN_TO_MUX              = BIST_WRITEENABLE;

   // Port: A_WEN }}}

   // Port: A_REN LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A_REN_IN or A_REN_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A_REN_NOT_GATED = A_REN_IN;
      1'b1 : A_REN_NOT_GATED = A_REN_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign A_REN                     = A_REN_NOT_GATED & ~(LV_TM & (MEM_BYPASS_EN | SCAN_SHIFT_EN));

   // Control logic during memory test
   assign #(20.0) A_REN_TEST_IN     = (BIST_COLLAR_EN & A_REN_TO_MUX);
   assign A_REN_TO_MUX              = BIST_READENABLE;

   // Port: A_REN }}}

//--------------------------
//-- Memory Address Ports --
//--------------------------

   // Port: A_ADDR LogicalPort: ## Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A_ADDR_IN or A_ADDR_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A_ADDR = A_ADDR_IN;
      1'b1 : A_ADDR = A_ADDR_TEST_IN;
      endcase
   end
   // Address logic during memory test
   wire   [3:0]                     BIST_COL_ADD_SHADOW;
   wire   [8:0]                     BIST_ROW_ADD_SHADOW;
   assign BIST_ROW_ADD_SHADOW[8] = BIST_ROW_ADD[8];
   assign BIST_ROW_ADD_SHADOW[7] = BIST_ROW_ADD[7];
   assign BIST_ROW_ADD_SHADOW[6] = BIST_ROW_ADD[6];
   assign BIST_ROW_ADD_SHADOW[5] = BIST_ROW_ADD[5];
   assign BIST_ROW_ADD_SHADOW[4] = BIST_ROW_ADD[4];
   assign BIST_ROW_ADD_SHADOW[3] = BIST_ROW_ADD[3];
   assign BIST_ROW_ADD_SHADOW[2] = BIST_ROW_ADD[2];
   assign BIST_ROW_ADD_SHADOW[1] = BIST_ROW_ADD[1];
   assign BIST_ROW_ADD_SHADOW[0] = BIST_ROW_ADD[0];
   assign BIST_COL_ADD_SHADOW[3] = BIST_COL_ADD[3];
   assign BIST_COL_ADD_SHADOW[2] = BIST_COL_ADD[2];
   assign BIST_COL_ADD_SHADOW[1] = BIST_COL_ADD[1];
   assign BIST_COL_ADD_SHADOW[0] = BIST_COL_ADD[0];
   assign #(20.0) A_ADDR_TEST_IN    = {
                                         BIST_ROW_ADD_SHADOW[8],
                                         BIST_ROW_ADD_SHADOW[7],
                                         BIST_ROW_ADD_SHADOW[6],
                                         BIST_ROW_ADD_SHADOW[5],
                                         BIST_ROW_ADD_SHADOW[4],
                                         BIST_ROW_ADD_SHADOW[3],
                                         BIST_ROW_ADD_SHADOW[2],
                                         BIST_ROW_ADD_SHADOW[1],
                                         BIST_ROW_ADD_SHADOW[0],
                                         BIST_COL_ADD_SHADOW[3],
                                         BIST_COL_ADD_SHADOW[2],
                                         BIST_COL_ADD_SHADOW[1],
                                         BIST_COL_ADD_SHADOW[0] 
                                      };

   // Port: A_ADDR }}}

//--------------------
//-- Data To Memory --
//--------------------


   // Intercept functional signal with test mux
   always @( A_DIN_IN or A_DIN_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A_DIN = A_DIN_IN;
      1'b1 : A_DIN = A_DIN_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(20.0) A_DIN_TEST_IN     = {
                                        DATA_TO_MEM[31],
                                        DATA_TO_MEM[30],
                                        DATA_TO_MEM[29],
                                        DATA_TO_MEM[28],
                                        DATA_TO_MEM[27],
                                        DATA_TO_MEM[26],
                                        DATA_TO_MEM[25],
                                        DATA_TO_MEM[24],
                                        DATA_TO_MEM[23],
                                        DATA_TO_MEM[22],
                                        DATA_TO_MEM[21],
                                        DATA_TO_MEM[20],
                                        DATA_TO_MEM[19],
                                        DATA_TO_MEM[18],
                                        DATA_TO_MEM[17],
                                        DATA_TO_MEM[16],
                                        DATA_TO_MEM[15],
                                        DATA_TO_MEM[14],
                                        DATA_TO_MEM[13],
                                        DATA_TO_MEM[12],
                                        DATA_TO_MEM[11],
                                        DATA_TO_MEM[10],
                                        DATA_TO_MEM[9],
                                        DATA_TO_MEM[8],
                                        DATA_TO_MEM[7],
                                        DATA_TO_MEM[6],
                                        DATA_TO_MEM[5],
                                        DATA_TO_MEM[4],
                                        DATA_TO_MEM[3],
                                        DATA_TO_MEM[2],
                                        DATA_TO_MEM[1],
                                        DATA_TO_MEM[0] 
                                      };
   // External memory bypass during logic test
   assign A_DIN_DIN_OBS             = {
                                        A_DIN[31],
                                        A_DIN[30],
                                        A_DIN[29],
                                        A_DIN[28],
                                        A_DIN[27],
                                        A_DIN[26],
                                        A_DIN[25],
                                        A_DIN[24],
                                        A_DIN[23],
                                        A_DIN[22],
                                        A_DIN[21],
                                        A_DIN[20],
                                        A_DIN[19],
                                        A_DIN[18],
                                        A_DIN[17],
                                        A_DIN[16],
                                        A_DIN[15],
                                        A_DIN[14],
                                        A_DIN[13],
                                        A_DIN[12],
                                        A_DIN[11],
                                        A_DIN[10],
                                        A_DIN[9],
                                        A_DIN[8],
                                        A_DIN[7],
                                        A_DIN[6],
                                        A_DIN[5],
                                        A_DIN[4],
                                        A_DIN[3],
                                        A_DIN[2],
                                        A_DIN[1],
                                        A_DIN[0] 
                                      };
//-------------------
//-- Memory Bypass --
//-------------------
   always @( A_DOUT_IN or A_DOUT_FROM_BYPASS or MEM_BYPASS_EN) begin
      case (MEM_BYPASS_EN) // synopsys infer_mux
      1'b0 : A_DOUT = A_DOUT_IN;
      1'b1 : A_DOUT = A_DOUT_FROM_BYPASS;
      endcase
   end

   assign A_DOUT_FROM_BYPASS        = A_DOUT_SCAN_IN;

   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      A_DOUT_SCAN_IN                <= 32'd0;
   else
      A_DOUT_SCAN_IN                <= {32{MEM_BYPASS_EN}} & A_DOUT_TO_BYPASS;
   end
 
   assign A_DOUT_TO_BYPASS          = {
                                        A_DIN_DIN_OBS[31],
                                        A_DIN_DIN_OBS[30],
                                        A_DIN_DIN_OBS[29],
                                        A_DIN_DIN_OBS[28],
                                        A_DIN_DIN_OBS[27],
                                        A_DIN_DIN_OBS[26],
                                        A_DIN_DIN_OBS[25],
                                        A_DIN_DIN_OBS[24],
                                        A_DIN_DIN_OBS[23],
                                        A_DIN_DIN_OBS[22],
                                        A_DIN_DIN_OBS[21],
                                        A_DIN_DIN_OBS[20],
                                        A_DIN_DIN_OBS[19],
                                        A_DIN_DIN_OBS[18],
                                        A_DIN_DIN_OBS[17],
                                        A_DIN_DIN_OBS[16],
                                        A_DIN_DIN_OBS[15],
                                        A_DIN_DIN_OBS[14],
                                        A_DIN_DIN_OBS[13],
                                        A_DIN_DIN_OBS[12],
                                        A_DIN_DIN_OBS[11],
                                        A_DIN_DIN_OBS[10],
                                        A_DIN_DIN_OBS[9],
                                        A_DIN_DIN_OBS[8],
                                        A_DIN_DIN_OBS[7],
                                        A_DIN_DIN_OBS[6],
                                        A_DIN_DIN_OBS[5],
                                        A_DIN_DIN_OBS[4],
                                        A_DIN_DIN_OBS[3],
                                        A_DIN_DIN_OBS[2],
                                        A_DIN_DIN_OBS[1],
                                        A_DIN_DIN_OBS[0] 
                                      };
 

//----------------------
//-- Data From Memory --
//----------------------
 
   assign DATA_FROM_MEM             = {
                                       A_DOUT[31],
                                       A_DOUT[30],
                                       A_DOUT[29],
                                       A_DOUT[28],
                                       A_DOUT[27],
                                       A_DOUT[26],
                                       A_DOUT[25],
                                       A_DOUT[24],
                                       A_DOUT[23],
                                       A_DOUT[22],
                                       A_DOUT[21],
                                       A_DOUT[20],
                                       A_DOUT[19],
                                       A_DOUT[18],
                                       A_DOUT[17],
                                       A_DOUT[16],
                                       A_DOUT[15],
                                       A_DOUT[14],
                                       A_DOUT[13],
                                       A_DOUT[12],
                                       A_DOUT[11],
                                       A_DOUT[10],
                                       A_DOUT[9],
                                       A_DOUT[8],
                                       A_DOUT[7],
                                       A_DOUT[6],
                                       A_DOUT[5],
                                       A_DOUT[4],
                                       A_DOUT[3],
                                       A_DOUT[2],
                                       A_DOUT[1],
                                       A_DOUT[0] 
                                      };
 
    assign EDATA_CKB_EN             = CHKBCI_PHASE;

    assign EDATA_COL_ADD_BIT0       = BIST_COL_ADD[0:0];

//---------------------------
//-- Replicate Expect Data --
//---------------------------
 
   assign BIST_EXPECT_DATA_REP      = { // 
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA,
                                      BIST_EXPECT_DATA
                                     };
//-----------------
//-- Expect Data --
//-----------------
   assign BIST_EXPECT_DATA_INT      = ~(EDATA_CKB_EN) ? BIST_EXPECT_DATA_REP : ({32{BIST_EXPECT_DATA_REP[0]}} ^ {32{EDATA_COL_ADD_BIT0}});
   assign DATA_FROM_MEM_EXP         = BIST_EXPECT_DATA_INT;
assign CMP_EN = BIST_CMP;

//-----------------------
//-- Local Comparators --
//-----------------------
 
   assign RAW_CMP_STAT[31]          = ~(DATA_FROM_MEM[31] == DATA_FROM_MEM_EXP[31]);
   assign RAW_CMP_STAT[30]          = ~(DATA_FROM_MEM[30] == DATA_FROM_MEM_EXP[30]);
   assign RAW_CMP_STAT[29]          = ~(DATA_FROM_MEM[29] == DATA_FROM_MEM_EXP[29]);
   assign RAW_CMP_STAT[28]          = ~(DATA_FROM_MEM[28] == DATA_FROM_MEM_EXP[28]);
   assign RAW_CMP_STAT[27]          = ~(DATA_FROM_MEM[27] == DATA_FROM_MEM_EXP[27]);
   assign RAW_CMP_STAT[26]          = ~(DATA_FROM_MEM[26] == DATA_FROM_MEM_EXP[26]);
   assign RAW_CMP_STAT[25]          = ~(DATA_FROM_MEM[25] == DATA_FROM_MEM_EXP[25]);
   assign RAW_CMP_STAT[24]          = ~(DATA_FROM_MEM[24] == DATA_FROM_MEM_EXP[24]);
   assign RAW_CMP_STAT[23]          = ~(DATA_FROM_MEM[23] == DATA_FROM_MEM_EXP[23]);
   assign RAW_CMP_STAT[22]          = ~(DATA_FROM_MEM[22] == DATA_FROM_MEM_EXP[22]);
   assign RAW_CMP_STAT[21]          = ~(DATA_FROM_MEM[21] == DATA_FROM_MEM_EXP[21]);
   assign RAW_CMP_STAT[20]          = ~(DATA_FROM_MEM[20] == DATA_FROM_MEM_EXP[20]);
   assign RAW_CMP_STAT[19]          = ~(DATA_FROM_MEM[19] == DATA_FROM_MEM_EXP[19]);
   assign RAW_CMP_STAT[18]          = ~(DATA_FROM_MEM[18] == DATA_FROM_MEM_EXP[18]);
   assign RAW_CMP_STAT[17]          = ~(DATA_FROM_MEM[17] == DATA_FROM_MEM_EXP[17]);
   assign RAW_CMP_STAT[16]          = ~(DATA_FROM_MEM[16] == DATA_FROM_MEM_EXP[16]);
   assign RAW_CMP_STAT[15]          = ~(DATA_FROM_MEM[15] == DATA_FROM_MEM_EXP[15]);
   assign RAW_CMP_STAT[14]          = ~(DATA_FROM_MEM[14] == DATA_FROM_MEM_EXP[14]);
   assign RAW_CMP_STAT[13]          = ~(DATA_FROM_MEM[13] == DATA_FROM_MEM_EXP[13]);
   assign RAW_CMP_STAT[12]          = ~(DATA_FROM_MEM[12] == DATA_FROM_MEM_EXP[12]);
   assign RAW_CMP_STAT[11]          = ~(DATA_FROM_MEM[11] == DATA_FROM_MEM_EXP[11]);
   assign RAW_CMP_STAT[10]          = ~(DATA_FROM_MEM[10] == DATA_FROM_MEM_EXP[10]);
   assign RAW_CMP_STAT[9]           = ~(DATA_FROM_MEM[9] == DATA_FROM_MEM_EXP[9]);
   assign RAW_CMP_STAT[8]           = ~(DATA_FROM_MEM[8] == DATA_FROM_MEM_EXP[8]);
   assign RAW_CMP_STAT[7]           = ~(DATA_FROM_MEM[7] == DATA_FROM_MEM_EXP[7]);
   assign RAW_CMP_STAT[6]           = ~(DATA_FROM_MEM[6] == DATA_FROM_MEM_EXP[6]);
   assign RAW_CMP_STAT[5]           = ~(DATA_FROM_MEM[5] == DATA_FROM_MEM_EXP[5]);
   assign RAW_CMP_STAT[4]           = ~(DATA_FROM_MEM[4] == DATA_FROM_MEM_EXP[4]);
   assign RAW_CMP_STAT[3]           = ~(DATA_FROM_MEM[3] == DATA_FROM_MEM_EXP[3]);
   assign RAW_CMP_STAT[2]           = ~(DATA_FROM_MEM[2] == DATA_FROM_MEM_EXP[2]);
   assign RAW_CMP_STAT[1]           = ~(DATA_FROM_MEM[1] == DATA_FROM_MEM_EXP[1]);
   assign RAW_CMP_STAT[0]           = ~(DATA_FROM_MEM[0] == DATA_FROM_MEM_EXP[0]);
  
wire                                FREEZE_GO_ID;
reg                                 FREEZE_STOP_ERROR_EARLY_R; 
assign FREEZE_GO_ID = BIST_SHIFT_COLLAR | (~(BIST_CMP & BIST_COLLAR_EN)) | FREEZE_STOP_ERROR_EARLY_R;
   
//----------------
// STOP_ON_ERROR  
//----------------
wire                                SOE_ERROR;
wire                                FREEZE_STOP_ERROR_CLEAR;
wire                                FREEZE_STOP_ERROR_EARLY;
assign SOE_ERROR = (|ERROR) & BIST_ON;
assign FREEZE_STOP_ERROR_EARLY = ERROR_CNT_ZERO & SOE_ERROR;
  
// synopsys sync_set_reset "FREEZE_STOP_ERROR_CLEAR"
assign FREEZE_STOP_ERROR_CLEAR = (~GO_EN) & (~(BIST_COLLAR_HOLD|FREEZE_STOP_ERROR)) & (~BIST_SHIFT_COLLAR);
 
// synopsys async_set_reset "BIST_ASYNC_RESETN"
always @(posedge BIST_CLK_OR_TCK or negedge BIST_ASYNC_RESETN) begin
  if (~BIST_ASYNC_RESETN) begin
    FREEZE_STOP_ERROR_EARLY_R <= 1'b0;
  end else 
  if (FREEZE_STOP_ERROR_CLEAR) begin
    FREEZE_STOP_ERROR_EARLY_R <= 1'b0;
  end else begin
    if (BIST_SHIFT_COLLAR) begin
      FREEZE_STOP_ERROR_EARLY_R <= FREEZE_STOP_ERROR_SI;
    end else 
    if ((~(BIST_COLLAR_HOLD|FREEZE_STOP_ERROR)) & GO_EN) begin
        FREEZE_STOP_ERROR_EARLY_R <= FREEZE_STOP_ERROR_EARLY | FREEZE_STOP_ERROR_EARLY_R;
    end
  end
end

assign HOLD_EN = BIST_COLLAR_HOLD | FREEZE_STOP_ERROR_EARLY_R | FREEZE_STOP_ERROR;
 
assign COLLAR_STATUS_SI = BIST_SI;
memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_interface_m1_STATUS MBISTPG_STATUS (
    .BIST_CLK                      ( BIST_CLK_OR_TCK              ),
    .BIST_ASYNC_RESETN             (BIST_ASYNC_RESETN           ),
    .MCP_BOUNDING_EN               (MCP_BOUNDING_EN      ), 
    .FREEZE_GO_ID                  (FREEZE_GO_ID                ),
    .CMP_EN                        (CMP_EN                      ),
    .FREEZE_STOP_ERROR_EARLY_R     (FREEZE_STOP_ERROR_EARLY_R   ),
   .GO_EN                          (GO_EN                      ),
   .BIST_COLLAR_SETUP              (BIST_COLLAR_SETUP          ),
   .BIST_COLLAR_HOLD               (BIST_COLLAR_HOLD_INT       ),
   .BIST_SHIFT_COLLAR              (BIST_SHIFT_COLLAR          ),
   .BIST_ON                        (BIST_ON                    ),
   .BIST_CLEAR                     (BIST_CLEAR                 ),
   .USE_DEFAULTS                   (USE_DEFAULTS               ),
   .SI                             (COLLAR_STATUS_SI           ),
   .ERROR                          ( ERROR               ),
   .ERROR_R                        ( ERROR_R             ),
   .BIST_DIAG_EN                   (BIST_DIAG_EN         ),
   .RAW_CMP_STAT                   (RAW_CMP_STAT               ),
   .BIST_GO                        (BIST_GO              ),
   .INCLUDE_MEM_RESULTS_REG        (INCLUDE_MEM_RESULTS_REG    ),
   .SO                             (COLLAR_STATUS_SO           )
);
assign FREEZE_STOP_ERROR_SI = COLLAR_STATUS_SO;
 
assign STATUS_SO = FREEZE_STOP_ERROR_EARLY_R;
    
assign BIST_SO                      = STATUS_SO;
 
 
    assign BIST_CLK_EN  = BIST_RUN | BIST_COLLAR_SETUP|BIST_CLEAR|BIST_CLEAR_DEFAULT|RESET_REG_SETUP2|(BIST_INPUT_SELECT ^ BIST_TESTDATA_SELECT_TO_COLLAR);
//---------------------
//-- BIST_CLK Gating --
//---------------------
wire   INJECT_TCK;      
    assign INJECT_TCK = BIST_SHIFT_COLLAR & ~LV_TM; 
    memlibc_memory_bist_assembly_rtl_tessent_clk_gate_and tessent_persistent_cell_GATING_BIST_CLK (
        .clk        ( BIST_CLK                    ),
        .te         ( 1'b0         ),
        .fe         ( BIST_CLK_EN  ),
        .clkg       ( BIST_CLK_INT                )
    );
        memlibc_memory_bist_assembly_rtl_tessent_clk_mux2 tessent_persistent_cell_BIST_CLK_OR_TCK (
        .s          ( INJECT_TCK                                 ),
        .a          ( BIST_CLK_INT                               ),
        .b          ( TCK                                        ),
        .y          ( BIST_CLK_OR_TCK                            )
    );

endmodule // memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_interface_m1



    
module memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_interface_m1_STATUS (
  input  wire        BIST_CLEAR,
  input  wire        FREEZE_STOP_ERROR_EARLY_R,
  input  wire        FREEZE_GO_ID,
  input  wire        CMP_EN,
  input  wire        BIST_ASYNC_RESETN,
  input  wire        BIST_CLK,
  input  wire        BIST_COLLAR_SETUP,
  input  wire        BIST_COLLAR_HOLD,
  input  wire        BIST_SHIFT_COLLAR,
  input  wire        BIST_ON,
  input  wire        USE_DEFAULTS,
  input  wire        SI,
  input  wire        BIST_DIAG_EN,
  input  wire [31:0] RAW_CMP_STAT,
  input  wire        MCP_BOUNDING_EN,
  input  wire        INCLUDE_MEM_RESULTS_REG,
  output reg         GO_EN,
  output wire [0:0]  ERROR,
  output wire [0:0]  ERROR_R,
  output wire        SO,
  output wire        BIST_GO
);
wire        GO_ID_REG_RST;
reg  [31:0] GO_ID_REG;
wire        BIST_GO_INT;
wire [31:0] ROW_DATA_MAP;
wire        GO_ID_FEEDBACK_EN;
wire [0:0]  IO_SEG_GLOBAL_GO_ID;
reg  [0:0]  ERROR_R1;

 
   //----------------
   // Row Data Map --
   //----------------
 assign ROW_DATA_MAP = RAW_CMP_STAT;
 
   //-----------
   //-- GO_EN --
   //-----------
   //synopsys sync_set_reset "BIST_ON"
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK or negedge BIST_ASYNC_RESETN) begin
      if (~BIST_ASYNC_RESETN)
         GO_EN       <= 1'b0;
      else
      if (~BIST_ON) begin
         GO_EN       <= 1'b0;
      end else begin
         if (BIST_COLLAR_SETUP) begin
            GO_EN    <= 1'b1; 
         end
      end
   end
   assign GO_ID_FEEDBACK_EN         = ~(BIST_DIAG_EN) ;
   assign BIST_GO_INT               = ~|ERROR_R;
   assign BIST_GO    = BIST_GO_INT;
 
 
 
   //---------------
   //-- GO_ID_REG --
   //---------------
reg  CMP_EN_R;
  // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK or negedge BIST_ASYNC_RESETN) begin
      if (~BIST_ASYNC_RESETN) begin
         CMP_EN_R    <= 1'b0;
      end else begin
         CMP_EN_R    <= (~FREEZE_GO_ID) & (~BIST_COLLAR_HOLD);
      end
   end

   assign GO_ID_REG_RST            = BIST_CLEAR | (~INCLUDE_MEM_RESULTS_REG & BIST_SHIFT_COLLAR);
   wire HOLD_OR_RESET;
    
wire [31:0] GO_ID_REG_MUX, BIST_SHIFT_COLLAR_MUX;
wire [31:0] GO_ID_REG_MUX_SEL ;
wire GO_ID_REG_CLR;
wire GO_ID_REG_BYPASS;
  // synopsys sync_set_reset "GO_ID_REG_RST"
   assign HOLD_OR_RESET = MCP_BOUNDING_EN | GO_ID_REG_RST | BIST_COLLAR_HOLD | ~GO_EN;
   assign GO_ID_REG_CLR = (~MCP_BOUNDING_EN) & (GO_ID_REG_RST | ((~BIST_COLLAR_HOLD) & (~GO_ID_FEEDBACK_EN) & CMP_EN) | (CMP_EN_R & BIST_COLLAR_HOLD & (~FREEZE_STOP_ERROR_EARLY_R)));
// Instantiate persistent GO_ID_REG_MUX cells {{{
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG0 (
            .s       ( GO_ID_REG_MUX_SEL[0]        ),
            .b       ( BIST_SHIFT_COLLAR_MUX[0] & ~GO_ID_REG_CLR  ),
            .a       ( ROW_DATA_MAP[0]             ),
            .y       ( GO_ID_REG_MUX[0]            )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG1 (
            .s       ( GO_ID_REG_MUX_SEL[1]        ),
            .b       ( BIST_SHIFT_COLLAR_MUX[1] & ~GO_ID_REG_CLR  ),
            .a       ( ROW_DATA_MAP[1]             ),
            .y       ( GO_ID_REG_MUX[1]            )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG2 (
            .s       ( GO_ID_REG_MUX_SEL[2]        ),
            .b       ( BIST_SHIFT_COLLAR_MUX[2] & ~GO_ID_REG_CLR  ),
            .a       ( ROW_DATA_MAP[2]             ),
            .y       ( GO_ID_REG_MUX[2]            )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG3 (
            .s       ( GO_ID_REG_MUX_SEL[3]        ),
            .b       ( BIST_SHIFT_COLLAR_MUX[3] & ~GO_ID_REG_CLR  ),
            .a       ( ROW_DATA_MAP[3]             ),
            .y       ( GO_ID_REG_MUX[3]            )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG4 (
            .s       ( GO_ID_REG_MUX_SEL[4]        ),
            .b       ( BIST_SHIFT_COLLAR_MUX[4] & ~GO_ID_REG_CLR  ),
            .a       ( ROW_DATA_MAP[4]             ),
            .y       ( GO_ID_REG_MUX[4]            )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG5 (
            .s       ( GO_ID_REG_MUX_SEL[5]        ),
            .b       ( BIST_SHIFT_COLLAR_MUX[5] & ~GO_ID_REG_CLR  ),
            .a       ( ROW_DATA_MAP[5]             ),
            .y       ( GO_ID_REG_MUX[5]            )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG6 (
            .s       ( GO_ID_REG_MUX_SEL[6]        ),
            .b       ( BIST_SHIFT_COLLAR_MUX[6] & ~GO_ID_REG_CLR  ),
            .a       ( ROW_DATA_MAP[6]             ),
            .y       ( GO_ID_REG_MUX[6]            )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG7 (
            .s       ( GO_ID_REG_MUX_SEL[7]        ),
            .b       ( BIST_SHIFT_COLLAR_MUX[7] & ~GO_ID_REG_CLR  ),
            .a       ( ROW_DATA_MAP[7]             ),
            .y       ( GO_ID_REG_MUX[7]            )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG8 (
            .s       ( GO_ID_REG_MUX_SEL[8]        ),
            .b       ( BIST_SHIFT_COLLAR_MUX[8] & ~GO_ID_REG_CLR  ),
            .a       ( ROW_DATA_MAP[8]             ),
            .y       ( GO_ID_REG_MUX[8]            )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG9 (
            .s       ( GO_ID_REG_MUX_SEL[9]        ),
            .b       ( BIST_SHIFT_COLLAR_MUX[9] & ~GO_ID_REG_CLR  ),
            .a       ( ROW_DATA_MAP[9]             ),
            .y       ( GO_ID_REG_MUX[9]            )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG10 (
            .s       ( GO_ID_REG_MUX_SEL[10]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[10] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[10]            ),
            .y       ( GO_ID_REG_MUX[10]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG11 (
            .s       ( GO_ID_REG_MUX_SEL[11]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[11] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[11]            ),
            .y       ( GO_ID_REG_MUX[11]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG12 (
            .s       ( GO_ID_REG_MUX_SEL[12]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[12] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[12]            ),
            .y       ( GO_ID_REG_MUX[12]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG13 (
            .s       ( GO_ID_REG_MUX_SEL[13]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[13] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[13]            ),
            .y       ( GO_ID_REG_MUX[13]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG14 (
            .s       ( GO_ID_REG_MUX_SEL[14]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[14] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[14]            ),
            .y       ( GO_ID_REG_MUX[14]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG15 (
            .s       ( GO_ID_REG_MUX_SEL[15]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[15] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[15]            ),
            .y       ( GO_ID_REG_MUX[15]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG16 (
            .s       ( GO_ID_REG_MUX_SEL[16]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[16] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[16]            ),
            .y       ( GO_ID_REG_MUX[16]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG17 (
            .s       ( GO_ID_REG_MUX_SEL[17]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[17] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[17]            ),
            .y       ( GO_ID_REG_MUX[17]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG18 (
            .s       ( GO_ID_REG_MUX_SEL[18]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[18] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[18]            ),
            .y       ( GO_ID_REG_MUX[18]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG19 (
            .s       ( GO_ID_REG_MUX_SEL[19]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[19] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[19]            ),
            .y       ( GO_ID_REG_MUX[19]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG20 (
            .s       ( GO_ID_REG_MUX_SEL[20]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[20] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[20]            ),
            .y       ( GO_ID_REG_MUX[20]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG21 (
            .s       ( GO_ID_REG_MUX_SEL[21]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[21] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[21]            ),
            .y       ( GO_ID_REG_MUX[21]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG22 (
            .s       ( GO_ID_REG_MUX_SEL[22]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[22] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[22]            ),
            .y       ( GO_ID_REG_MUX[22]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG23 (
            .s       ( GO_ID_REG_MUX_SEL[23]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[23] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[23]            ),
            .y       ( GO_ID_REG_MUX[23]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG24 (
            .s       ( GO_ID_REG_MUX_SEL[24]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[24] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[24]            ),
            .y       ( GO_ID_REG_MUX[24]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG25 (
            .s       ( GO_ID_REG_MUX_SEL[25]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[25] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[25]            ),
            .y       ( GO_ID_REG_MUX[25]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG26 (
            .s       ( GO_ID_REG_MUX_SEL[26]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[26] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[26]            ),
            .y       ( GO_ID_REG_MUX[26]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG27 (
            .s       ( GO_ID_REG_MUX_SEL[27]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[27] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[27]            ),
            .y       ( GO_ID_REG_MUX[27]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG28 (
            .s       ( GO_ID_REG_MUX_SEL[28]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[28] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[28]            ),
            .y       ( GO_ID_REG_MUX[28]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG29 (
            .s       ( GO_ID_REG_MUX_SEL[29]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[29] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[29]            ),
            .y       ( GO_ID_REG_MUX[29]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG30 (
            .s       ( GO_ID_REG_MUX_SEL[30]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[30] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[30]            ),
            .y       ( GO_ID_REG_MUX[30]           )
            );
    memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_MUX_GO_ID_REG31 (
            .s       ( GO_ID_REG_MUX_SEL[31]       ),
            .b       ( BIST_SHIFT_COLLAR_MUX[31] & ~GO_ID_REG_CLR                ),
            .a       ( ROW_DATA_MAP[31]            ),
            .y       ( GO_ID_REG_MUX[31]           )
            );
// Instantiate persistent GO_ID_REG_MUX cells }}}
   assign GO_ID_REG_MUX_SEL = (GO_ID_REG & {32{GO_ID_FEEDBACK_EN}})  | {32 {HOLD_OR_RESET | FREEZE_GO_ID }};
   assign BIST_SHIFT_COLLAR_MUX = ((~MCP_BOUNDING_EN) & BIST_SHIFT_COLLAR) ? {SI,GO_ID_REG[31:1]} : GO_ID_REG;
 
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK or negedge BIST_ASYNC_RESETN) begin
      if (~BIST_ASYNC_RESETN)
         GO_ID_REG   <= {32{1'b0}};
      else
         GO_ID_REG   <= GO_ID_REG_MUX;
   end
   assign GO_ID_REG_BYPASS = (INCLUDE_MEM_RESULTS_REG) ? GO_ID_REG[0] : SI;

    
  assign IO_SEG_GLOBAL_GO_ID[0] = |GO_ID_REG;
  assign ERROR[0] = GO_EN & IO_SEG_GLOBAL_GO_ID[0] & (CMP_EN_R | GO_ID_FEEDBACK_EN | BIST_COLLAR_HOLD);
  // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK  or negedge BIST_ASYNC_RESETN) begin
        if (~BIST_ASYNC_RESETN) begin
         ERROR_R1    <= {1{1'b0}};
      end else 
      if ( BIST_CLEAR ) begin
         ERROR_R1    <= {1{1'b0}};
      end else begin
         ERROR_R1    <= ERROR;
      end
   end
  assign ERROR_R   = ERROR_R1;

                       
   //------
   // SO --
   //------
   assign SO         = GO_ID_REG_BYPASS;
endmodule // memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_interface_m1_STATUS



