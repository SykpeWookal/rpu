module rpu_thread_control(
  input         clock,
  input         reset,
  input         io_data_stall,
  input         io_control_stall,
  input         io_tkend,
  input         io_addtk,
  input  [31:0] io_time,
  input  [31:0] io_tid,
  input  [31:0] io_ti,
  output        io_wb_pc,
  output        io_pc_we,
  output        io_ifid_clear,
  output        io_ifid_we,
  output        io_idex_clear,
  output        io_idex_we,
  output        io_exmm_clear,
  output        io_exmm_we,
  output        io_mmwb_clear,
  output        io_mmwb_we,
  output        io_thread_id_we,
  output [1:0]  io_thread_id_wdata
);
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] tt_queue [0:15]; // @[rpu_thread_control.scala 39:21]
  wire [63:0] tt_queue_MPORT_1_data; // @[rpu_thread_control.scala 39:21]
  wire [3:0] tt_queue_MPORT_1_addr; // @[rpu_thread_control.scala 39:21]
  wire [63:0] tt_queue_io_thread_id_wdata_MPORT_data; // @[rpu_thread_control.scala 39:21]
  wire [3:0] tt_queue_io_thread_id_wdata_MPORT_addr; // @[rpu_thread_control.scala 39:21]
  wire [63:0] tt_queue_MPORT_data; // @[rpu_thread_control.scala 39:21]
  wire [3:0] tt_queue_MPORT_addr; // @[rpu_thread_control.scala 39:21]
  wire  tt_queue_MPORT_mask; // @[rpu_thread_control.scala 39:21]
  wire  tt_queue_MPORT_en; // @[rpu_thread_control.scala 39:21]
  reg [3:0] tt_start; // @[rpu_thread_control.scala 40:25]
  reg [3:0] tt_end; // @[rpu_thread_control.scala 41:23]
  reg [1:0] state; // @[rpu_thread_control.scala 44:22]
  wire [3:0] _T_1 = tt_end + 4'h1; // @[rpu_thread_control.scala 49:28]
  wire  _T_2 = _T_1 != tt_start; // @[rpu_thread_control.scala 49:34]
  wire [4:0] _GEN_62 = {{1'd0}, _T_1}; // @[rpu_thread_control.scala 51:30]
  wire [4:0] _GEN_0 = _GEN_62 % 5'h10; // @[rpu_thread_control.scala 51:30]
  wire [3:0] _tt_end_T_2 = _GEN_0[3:0]; // @[rpu_thread_control.scala 51:30]
  wire  _T_5 = state == 2'h3; // @[rpu_thread_control.scala 52:22]
  wire  _T_6 = tt_start != tt_end; // @[rpu_thread_control.scala 52:42]
  wire [3:0] _tt_start_T_1 = tt_start + 4'h1; // @[rpu_thread_control.scala 53:27]
  wire [4:0] _GEN_63 = {{1'd0}, _tt_start_T_1}; // @[rpu_thread_control.scala 53:34]
  wire [4:0] _GEN_1 = _GEN_63 % 5'h10; // @[rpu_thread_control.scala 53:34]
  wire [3:0] _tt_start_T_2 = _GEN_1[3:0]; // @[rpu_thread_control.scala 53:34]
  wire  _T_8 = 2'h0 == state; // @[Conditional.scala 37:30]
  wire  _GEN_13 = io_tkend ? 1'h0 : 1'h1; // @[rpu_thread_control.scala 59:23 rpu_thread_control.scala 39:21 rpu_thread_control.scala 62:51]
  wire  _T_13 = 2'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_14 = 2'h2 == state; // @[Conditional.scala 37:30]
  wire  _T_15 = 2'h3 == state; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_14 = _T_15 ? 2'h0 : state; // @[Conditional.scala 39:67 rpu_thread_control.scala 75:13 rpu_thread_control.scala 44:22]
  wire  _T_17 = state == 2'h2; // @[rpu_thread_control.scala 92:22]
  wire  _T_18 = state == 2'h1; // @[rpu_thread_control.scala 105:22]
  wire  _io_pc_we_T = ~io_data_stall; // @[rpu_thread_control.scala 133:17]
  wire  _GEN_23 = io_control_stall | ~io_data_stall; // @[rpu_thread_control.scala 118:34 rpu_thread_control.scala 120:14 rpu_thread_control.scala 133:14]
  wire  _GEN_25 = io_control_stall ? 1'h0 : _io_pc_we_T; // @[rpu_thread_control.scala 118:34 rpu_thread_control.scala 122:16 rpu_thread_control.scala 135:16]
  wire  _GEN_26 = io_control_stall | io_data_stall; // @[rpu_thread_control.scala 118:34 rpu_thread_control.scala 123:19 rpu_thread_control.scala 136:19]
  wire  _GEN_27 = io_control_stall ? 1'h0 : 1'h1; // @[rpu_thread_control.scala 118:34 rpu_thread_control.scala 124:16 rpu_thread_control.scala 137:16]
  wire  _GEN_30 = state == 2'h1 ? 1'h0 : _GEN_23; // @[rpu_thread_control.scala 105:36 rpu_thread_control.scala 107:14]
  wire  _GEN_31 = state == 2'h1 | io_control_stall; // @[rpu_thread_control.scala 105:36 rpu_thread_control.scala 108:19]
  wire  _GEN_32 = state == 2'h1 ? 1'h0 : _GEN_25; // @[rpu_thread_control.scala 105:36 rpu_thread_control.scala 109:16]
  wire  _GEN_33 = state == 2'h1 | _GEN_26; // @[rpu_thread_control.scala 105:36 rpu_thread_control.scala 110:19]
  wire  _GEN_34 = state == 2'h1 ? 1'h0 : _GEN_27; // @[rpu_thread_control.scala 105:36 rpu_thread_control.scala 111:16]
  wire  _GEN_35 = state == 2'h1 ? 1'h0 : 1'h1; // @[rpu_thread_control.scala 105:36 rpu_thread_control.scala 113:16]
  wire  _GEN_38 = state == 2'h2 ? 1'h0 : _T_18; // @[rpu_thread_control.scala 92:35 rpu_thread_control.scala 93:14]
  wire  _GEN_39 = state == 2'h2 ? 1'h0 : _GEN_30; // @[rpu_thread_control.scala 92:35 rpu_thread_control.scala 94:14]
  wire  _GEN_40 = state == 2'h2 ? 1'h0 : _GEN_31; // @[rpu_thread_control.scala 92:35 rpu_thread_control.scala 95:19]
  wire  _GEN_41 = state == 2'h2 ? 1'h0 : _GEN_32; // @[rpu_thread_control.scala 92:35 rpu_thread_control.scala 96:16]
  wire  _GEN_42 = state == 2'h2 ? 1'h0 : _GEN_33; // @[rpu_thread_control.scala 92:35 rpu_thread_control.scala 97:19]
  wire  _GEN_43 = state == 2'h2 ? 1'h0 : _GEN_34; // @[rpu_thread_control.scala 92:35 rpu_thread_control.scala 98:16]
  wire  _GEN_44 = state == 2'h2 ? 1'h0 : _GEN_35; // @[rpu_thread_control.scala 92:35 rpu_thread_control.scala 100:16]
  wire  _GEN_46 = state == 2'h2 ? 1'h0 : 1'h1; // @[rpu_thread_control.scala 92:35 rpu_thread_control.scala 102:16]
  wire [31:0] _GEN_61 = _T_5 ? tt_queue_io_thread_id_wdata_MPORT_data[31:0] : 32'h0; // @[rpu_thread_control.scala 79:24 rpu_thread_control.scala 91:24]
  assign tt_queue_MPORT_1_addr = tt_start;
  assign tt_queue_MPORT_1_data = tt_queue[tt_queue_MPORT_1_addr]; // @[rpu_thread_control.scala 39:21]
  assign tt_queue_io_thread_id_wdata_MPORT_addr = tt_start;
  assign tt_queue_io_thread_id_wdata_MPORT_data = tt_queue[tt_queue_io_thread_id_wdata_MPORT_addr]; // @[rpu_thread_control.scala 39:21]
  assign tt_queue_MPORT_data = {io_time,io_tid};
  assign tt_queue_MPORT_addr = tt_end;
  assign tt_queue_MPORT_mask = 1'h1;
  assign tt_queue_MPORT_en = io_addtk & _T_2;
  assign io_wb_pc = _T_5 ? 1'h0 : _GEN_38; // @[rpu_thread_control.scala 79:24 rpu_thread_control.scala 80:14]
  assign io_pc_we = _T_5 ? 1'h0 : _GEN_39; // @[rpu_thread_control.scala 79:24 rpu_thread_control.scala 81:14]
  assign io_ifid_clear = _T_5 ? 1'h0 : _GEN_40; // @[rpu_thread_control.scala 79:24 rpu_thread_control.scala 82:19]
  assign io_ifid_we = _T_5 ? 1'h0 : _GEN_41; // @[rpu_thread_control.scala 79:24 rpu_thread_control.scala 83:16]
  assign io_idex_clear = _T_5 ? 1'h0 : _GEN_42; // @[rpu_thread_control.scala 79:24 rpu_thread_control.scala 84:19]
  assign io_idex_we = _T_5 ? 1'h0 : _GEN_43; // @[rpu_thread_control.scala 79:24 rpu_thread_control.scala 85:16]
  assign io_exmm_clear = _T_5 ? 1'h0 : _GEN_38; // @[rpu_thread_control.scala 79:24 rpu_thread_control.scala 80:14]
  assign io_exmm_we = _T_5 ? 1'h0 : _GEN_44; // @[rpu_thread_control.scala 79:24 rpu_thread_control.scala 87:16]
  assign io_mmwb_clear = _T_5 ? 1'h0 : _T_17; // @[rpu_thread_control.scala 79:24 rpu_thread_control.scala 88:19]
  assign io_mmwb_we = _T_5 ? 1'h0 : _GEN_46; // @[rpu_thread_control.scala 79:24 rpu_thread_control.scala 89:16]
  assign io_thread_id_we = state == 2'h3; // @[rpu_thread_control.scala 79:15]
  assign io_thread_id_wdata = _GEN_61[1:0];
  always @(posedge clock) begin
    if(tt_queue_MPORT_en & tt_queue_MPORT_mask) begin
      tt_queue[tt_queue_MPORT_addr] <= tt_queue_MPORT_data; // @[rpu_thread_control.scala 39:21]
    end
    if (reset) begin // @[rpu_thread_control.scala 40:25]
      tt_start <= 4'h0; // @[rpu_thread_control.scala 40:25]
    end else if (!(io_addtk & _T_1 != tt_start)) begin // @[rpu_thread_control.scala 49:48]
      if (state == 2'h3 & tt_start != tt_end) begin // @[rpu_thread_control.scala 52:54]
        tt_start <= _tt_start_T_2; // @[rpu_thread_control.scala 53:14]
      end
    end
    if (reset) begin // @[rpu_thread_control.scala 41:23]
      tt_end <= 4'h0; // @[rpu_thread_control.scala 41:23]
    end else if (io_addtk & _T_1 != tt_start) begin // @[rpu_thread_control.scala 49:48]
      tt_end <= _tt_end_T_2; // @[rpu_thread_control.scala 51:12]
    end
    if (reset) begin // @[rpu_thread_control.scala 44:22]
      state <= 2'h0; // @[rpu_thread_control.scala 44:22]
    end else if (_T_8) begin // @[Conditional.scala 40:58]
      if (io_tkend) begin // @[rpu_thread_control.scala 59:23]
        state <= 2'h1; // @[rpu_thread_control.scala 61:15]
      end else if (_T_6 & tt_queue_MPORT_1_data[63:32] < io_ti) begin // @[rpu_thread_control.scala 62:79]
        state <= 2'h1; // @[rpu_thread_control.scala 63:15]
      end else begin
        state <= 2'h0; // @[rpu_thread_control.scala 65:15]
      end
    end else if (_T_13) begin // @[Conditional.scala 39:67]
      state <= 2'h2; // @[rpu_thread_control.scala 69:13]
    end else if (_T_14) begin // @[Conditional.scala 39:67]
      state <= 2'h3; // @[rpu_thread_control.scala 72:13]
    end else begin
      state <= _GEN_14;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    tt_queue[initvar] = _RAND_0[63:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  tt_start = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  tt_end = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  state = _RAND_3[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module rpu_pc_group(
  input         clock,
  input         reset,
  input  [31:0] io_boot_addr_0,
  input  [31:0] io_boot_addr_1,
  input  [31:0] io_boot_addr_2,
  input  [31:0] io_boot_addr_3,
  input         io_thread_id_we,
  input  [1:0]  io_thread_id_wdata,
  input         io_npc_we,
  input  [31:0] io_npc_wdata,
  output [31:0] io_pc
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pc_group_0; // @[rpu_pc_group.scala 25:25]
  reg [31:0] pc_group_1; // @[rpu_pc_group.scala 25:25]
  reg [31:0] pc_group_2; // @[rpu_pc_group.scala 25:25]
  reg [31:0] pc_group_3; // @[rpu_pc_group.scala 25:25]
  reg [1:0] thread_id; // @[rpu_pc_group.scala 27:22]
  wire [31:0] _GEN_14 = 2'h1 == thread_id ? pc_group_1 : pc_group_0; // @[rpu_pc_group.scala 34:9 rpu_pc_group.scala 34:9]
  wire [31:0] _GEN_15 = 2'h2 == thread_id ? pc_group_2 : _GEN_14; // @[rpu_pc_group.scala 34:9 rpu_pc_group.scala 34:9]
  assign io_pc = 2'h3 == thread_id ? pc_group_3 : _GEN_15; // @[rpu_pc_group.scala 34:9 rpu_pc_group.scala 34:9]
  always @(posedge clock) begin
    if (reset) begin // @[rpu_pc_group.scala 25:25]
      pc_group_0 <= io_boot_addr_0; // @[rpu_pc_group.scala 25:25]
    end else if (!(io_thread_id_we)) begin // @[rpu_pc_group.scala 29:65]
      if (io_npc_we) begin // @[rpu_pc_group.scala 31:26]
        if (2'h0 == thread_id) begin // @[rpu_pc_group.scala 32:27]
          pc_group_0 <= io_npc_wdata; // @[rpu_pc_group.scala 32:27]
        end
      end
    end
    if (reset) begin // @[rpu_pc_group.scala 25:25]
      pc_group_1 <= io_boot_addr_1; // @[rpu_pc_group.scala 25:25]
    end else if (!(io_thread_id_we)) begin // @[rpu_pc_group.scala 29:65]
      if (io_npc_we) begin // @[rpu_pc_group.scala 31:26]
        if (2'h1 == thread_id) begin // @[rpu_pc_group.scala 32:27]
          pc_group_1 <= io_npc_wdata; // @[rpu_pc_group.scala 32:27]
        end
      end
    end
    if (reset) begin // @[rpu_pc_group.scala 25:25]
      pc_group_2 <= io_boot_addr_2; // @[rpu_pc_group.scala 25:25]
    end else if (!(io_thread_id_we)) begin // @[rpu_pc_group.scala 29:65]
      if (io_npc_we) begin // @[rpu_pc_group.scala 31:26]
        if (2'h2 == thread_id) begin // @[rpu_pc_group.scala 32:27]
          pc_group_2 <= io_npc_wdata; // @[rpu_pc_group.scala 32:27]
        end
      end
    end
    if (reset) begin // @[rpu_pc_group.scala 25:25]
      pc_group_3 <= io_boot_addr_3; // @[rpu_pc_group.scala 25:25]
    end else if (!(io_thread_id_we)) begin // @[rpu_pc_group.scala 29:65]
      if (io_npc_we) begin // @[rpu_pc_group.scala 31:26]
        if (2'h3 == thread_id) begin // @[rpu_pc_group.scala 32:27]
          pc_group_3 <= io_npc_wdata; // @[rpu_pc_group.scala 32:27]
        end
      end
    end
    if (io_thread_id_we) begin // @[rpu_pc_group.scala 29:65]
      thread_id <= io_thread_id_wdata; // @[rpu_pc_group.scala 30:15]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pc_group_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  pc_group_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  pc_group_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  pc_group_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  thread_id = _RAND_4[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module rpu_register_file_group(
  input         clock,
  input         io_thread_id_we,
  input  [1:0]  io_thread_id_wdata,
  input  [4:0]  io_raddr_a,
  output [31:0] io_rdata_a,
  input  [4:0]  io_raddr_b,
  output [31:0] io_rdata_b,
  input  [4:0]  io_raddr_c,
  output [31:0] io_rdata_c,
  input  [4:0]  io_waddr_a,
  input  [31:0] io_wdata_a,
  input         io_we_a
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regfile_group [0:127]; // @[rpu_register_file_group.scala 27:26]
  wire [31:0] regfile_group_io_rdata_a_MPORT_data; // @[rpu_register_file_group.scala 27:26]
  wire [6:0] regfile_group_io_rdata_a_MPORT_addr; // @[rpu_register_file_group.scala 27:26]
  wire [31:0] regfile_group_io_rdata_b_MPORT_data; // @[rpu_register_file_group.scala 27:26]
  wire [6:0] regfile_group_io_rdata_b_MPORT_addr; // @[rpu_register_file_group.scala 27:26]
  wire [31:0] regfile_group_io_rdata_c_MPORT_data; // @[rpu_register_file_group.scala 27:26]
  wire [6:0] regfile_group_io_rdata_c_MPORT_addr; // @[rpu_register_file_group.scala 27:26]
  wire [31:0] regfile_group_MPORT_data; // @[rpu_register_file_group.scala 27:26]
  wire [6:0] regfile_group_MPORT_addr; // @[rpu_register_file_group.scala 27:26]
  wire  regfile_group_MPORT_mask; // @[rpu_register_file_group.scala 27:26]
  wire  regfile_group_MPORT_en; // @[rpu_register_file_group.scala 27:26]
  reg [1:0] thread_id; // @[rpu_register_file_group.scala 29:22]
  wire  _T_3 = io_raddr_a == 5'h0; // @[rpu_register_file_group.scala 37:20]
  wire  _T_4 = io_raddr_b == 5'h0; // @[rpu_register_file_group.scala 42:20]
  wire  _T_5 = io_raddr_c == 5'h0; // @[rpu_register_file_group.scala 47:20]
  assign regfile_group_io_rdata_a_MPORT_addr = {thread_id,io_raddr_a};
  assign regfile_group_io_rdata_a_MPORT_data = regfile_group[regfile_group_io_rdata_a_MPORT_addr]; // @[rpu_register_file_group.scala 27:26]
  assign regfile_group_io_rdata_b_MPORT_addr = {thread_id,io_raddr_b};
  assign regfile_group_io_rdata_b_MPORT_data = regfile_group[regfile_group_io_rdata_b_MPORT_addr]; // @[rpu_register_file_group.scala 27:26]
  assign regfile_group_io_rdata_c_MPORT_addr = {thread_id,io_raddr_c};
  assign regfile_group_io_rdata_c_MPORT_data = regfile_group[regfile_group_io_rdata_c_MPORT_addr]; // @[rpu_register_file_group.scala 27:26]
  assign regfile_group_MPORT_data = io_wdata_a;
  assign regfile_group_MPORT_addr = {thread_id,io_waddr_a};
  assign regfile_group_MPORT_mask = 1'h1;
  assign regfile_group_MPORT_en = io_thread_id_we ? 1'h0 : io_we_a;
  assign io_rdata_a = io_raddr_a == 5'h0 ? 32'h0 : regfile_group_io_rdata_a_MPORT_data; // @[rpu_register_file_group.scala 37:29 rpu_register_file_group.scala 38:16 rpu_register_file_group.scala 40:16]
  assign io_rdata_b = io_raddr_b == 5'h0 ? 32'h0 : regfile_group_io_rdata_b_MPORT_data; // @[rpu_register_file_group.scala 42:29 rpu_register_file_group.scala 43:16 rpu_register_file_group.scala 45:16]
  assign io_rdata_c = io_raddr_c == 5'h0 ? 32'h0 : regfile_group_io_rdata_c_MPORT_data; // @[rpu_register_file_group.scala 47:29 rpu_register_file_group.scala 48:16 rpu_register_file_group.scala 50:16]
  always @(posedge clock) begin
    if(regfile_group_MPORT_en & regfile_group_MPORT_mask) begin
      regfile_group[regfile_group_MPORT_addr] <= regfile_group_MPORT_data; // @[rpu_register_file_group.scala 27:26]
    end
    if (io_thread_id_we) begin // @[rpu_register_file_group.scala 31:67]
      thread_id <= io_thread_id_wdata; // @[rpu_register_file_group.scala 32:15]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 128; initvar = initvar+1)
    regfile_group[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  thread_id = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module rpu_decoder(
  input  [31:0] io_ir,
  output [5:0]  io_instr_type,
  output [4:0]  io_rs1,
  output [4:0]  io_rs2,
  output [4:0]  io_rs3,
  output [4:0]  io_rd,
  output [31:0] io_imm
);
  wire  _T_1 = 7'h37 == io_ir[6:0]; // @[Conditional.scala 37:30]
  wire  _T_2 = 7'h17 == io_ir[6:0]; // @[Conditional.scala 37:30]
  wire  _T_3 = 7'h6f == io_ir[6:0]; // @[Conditional.scala 37:30]
  wire  _T_4 = 7'h67 == io_ir[6:0]; // @[Conditional.scala 37:30]
  wire  _T_5 = 7'h13 == io_ir[6:0]; // @[Conditional.scala 37:30]
  wire  _T_7 = 3'h0 == io_ir[14:12]; // @[Conditional.scala 37:30]
  wire  _T_8 = 3'h1 == io_ir[14:12]; // @[Conditional.scala 37:30]
  wire  _T_9 = 3'h2 == io_ir[14:12]; // @[Conditional.scala 37:30]
  wire  _T_10 = 3'h3 == io_ir[14:12]; // @[Conditional.scala 37:30]
  wire  _T_11 = 3'h4 == io_ir[14:12]; // @[Conditional.scala 37:30]
  wire  _T_12 = 3'h5 == io_ir[14:12]; // @[Conditional.scala 37:30]
  wire  _T_14 = io_ir[31:25] == 7'h0; // @[rpu_decoder.scala 51:31]
  wire  _T_16 = io_ir[31:25] == 7'h20; // @[rpu_decoder.scala 53:38]
  wire [4:0] _GEN_0 = io_ir[31:25] == 7'h20 ? 5'h1b : 5'h0; // @[rpu_decoder.scala 53:48 rpu_decoder.scala 54:27 rpu_decoder.scala 19:17]
  wire [4:0] _GEN_1 = io_ir[31:25] == 7'h0 ? 5'h1a : _GEN_0; // @[rpu_decoder.scala 51:40 rpu_decoder.scala 52:27]
  wire  _T_17 = 3'h6 == io_ir[14:12]; // @[Conditional.scala 37:30]
  wire  _T_18 = 3'h7 == io_ir[14:12]; // @[Conditional.scala 37:30]
  wire [4:0] _GEN_2 = _T_18 ? 5'h18 : 5'h0; // @[Conditional.scala 39:67 rpu_decoder.scala 61:25 rpu_decoder.scala 19:17]
  wire [4:0] _GEN_3 = _T_17 ? 5'h17 : _GEN_2; // @[Conditional.scala 39:67 rpu_decoder.scala 58:25]
  wire [4:0] _GEN_4 = _T_12 ? _GEN_1 : _GEN_3; // @[Conditional.scala 39:67]
  wire [4:0] _GEN_5 = _T_11 ? 5'h16 : _GEN_4; // @[Conditional.scala 39:67 rpu_decoder.scala 48:25]
  wire [4:0] _GEN_6 = _T_10 ? 5'h15 : _GEN_5; // @[Conditional.scala 39:67 rpu_decoder.scala 45:25]
  wire [4:0] _GEN_7 = _T_9 ? 5'h14 : _GEN_6; // @[Conditional.scala 39:67 rpu_decoder.scala 42:25]
  wire [4:0] _GEN_8 = _T_8 ? 5'h19 : _GEN_7; // @[Conditional.scala 39:67 rpu_decoder.scala 39:25]
  wire [4:0] _GEN_9 = _T_7 ? 5'h13 : _GEN_8; // @[Conditional.scala 40:58 rpu_decoder.scala 36:25]
  wire  _T_19 = 7'h33 == io_ir[6:0]; // @[Conditional.scala 37:30]
  wire [4:0] _GEN_10 = _T_16 ? 5'h1d : 5'h0; // @[rpu_decoder.scala 70:48 rpu_decoder.scala 71:27 rpu_decoder.scala 19:17]
  wire [4:0] _GEN_11 = _T_14 ? 5'h1c : _GEN_10; // @[rpu_decoder.scala 68:40 rpu_decoder.scala 69:27]
  wire [5:0] _GEN_12 = _T_16 ? 6'h23 : 6'h0; // @[rpu_decoder.scala 89:48 rpu_decoder.scala 90:27 rpu_decoder.scala 19:17]
  wire [5:0] _GEN_13 = _T_14 ? 6'h22 : _GEN_12; // @[rpu_decoder.scala 87:40 rpu_decoder.scala 88:27]
  wire [5:0] _GEN_14 = _T_18 ? 6'h25 : 6'h0; // @[Conditional.scala 39:67 rpu_decoder.scala 97:25 rpu_decoder.scala 19:17]
  wire [5:0] _GEN_15 = _T_17 ? 6'h24 : _GEN_14; // @[Conditional.scala 39:67 rpu_decoder.scala 94:25]
  wire [5:0] _GEN_16 = _T_12 ? _GEN_13 : _GEN_15; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_17 = _T_11 ? 6'h21 : _GEN_16; // @[Conditional.scala 39:67 rpu_decoder.scala 84:25]
  wire [5:0] _GEN_18 = _T_10 ? 6'h20 : _GEN_17; // @[Conditional.scala 39:67 rpu_decoder.scala 81:25]
  wire [5:0] _GEN_19 = _T_9 ? 6'h1f : _GEN_18; // @[Conditional.scala 39:67 rpu_decoder.scala 78:25]
  wire [5:0] _GEN_20 = _T_8 ? 6'h1e : _GEN_19; // @[Conditional.scala 39:67 rpu_decoder.scala 75:25]
  wire [5:0] _GEN_21 = _T_7 ? {{1'd0}, _GEN_11} : _GEN_20; // @[Conditional.scala 40:58]
  wire  _T_37 = 7'h3 == io_ir[6:0]; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_22 = _T_12 ? 4'hf : 4'h0; // @[Conditional.scala 39:67 rpu_decoder.scala 116:25 rpu_decoder.scala 19:17]
  wire [3:0] _GEN_23 = _T_11 ? 4'he : _GEN_22; // @[Conditional.scala 39:67 rpu_decoder.scala 113:25]
  wire [3:0] _GEN_24 = _T_9 ? 4'hd : _GEN_23; // @[Conditional.scala 39:67 rpu_decoder.scala 110:25]
  wire [3:0] _GEN_25 = _T_8 ? 4'hc : _GEN_24; // @[Conditional.scala 39:67 rpu_decoder.scala 107:25]
  wire [3:0] _GEN_26 = _T_7 ? 4'hb : _GEN_25; // @[Conditional.scala 40:58 rpu_decoder.scala 104:25]
  wire  _T_44 = 7'h23 == io_ir[6:0]; // @[Conditional.scala 37:30]
  wire [4:0] _GEN_27 = _T_9 ? 5'h12 : 5'h0; // @[Conditional.scala 39:67 rpu_decoder.scala 129:25 rpu_decoder.scala 19:17]
  wire [4:0] _GEN_28 = _T_8 ? 5'h11 : _GEN_27; // @[Conditional.scala 39:67 rpu_decoder.scala 126:25]
  wire [4:0] _GEN_29 = _T_7 ? 5'h10 : _GEN_28; // @[Conditional.scala 40:58 rpu_decoder.scala 123:25]
  wire  _T_49 = 7'h63 == io_ir[6:0]; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_30 = _T_18 ? 4'ha : 4'h0; // @[Conditional.scala 39:67 rpu_decoder.scala 151:25 rpu_decoder.scala 19:17]
  wire [3:0] _GEN_31 = _T_17 ? 4'h9 : _GEN_30; // @[Conditional.scala 39:67 rpu_decoder.scala 148:25]
  wire [3:0] _GEN_32 = _T_12 ? 4'h8 : _GEN_31; // @[Conditional.scala 39:67 rpu_decoder.scala 145:25]
  wire [3:0] _GEN_33 = _T_11 ? 4'h7 : _GEN_32; // @[Conditional.scala 39:67 rpu_decoder.scala 142:25]
  wire [3:0] _GEN_34 = _T_8 ? 4'h6 : _GEN_33; // @[Conditional.scala 39:67 rpu_decoder.scala 139:25]
  wire [3:0] _GEN_35 = _T_7 ? 4'h5 : _GEN_34; // @[Conditional.scala 40:58 rpu_decoder.scala 136:25]
  wire  _T_57 = 7'hb == io_ir[6:0]; // @[Conditional.scala 37:30]
  wire  _T_63 = io_ir[31:25] == 7'h1; // @[rpu_decoder.scala 160:38]
  wire [5:0] _GEN_36 = _T_63 ? 6'h29 : 6'h0; // @[rpu_decoder.scala 164:47 rpu_decoder.scala 165:27 rpu_decoder.scala 19:17]
  wire [5:0] _GEN_37 = _T_63 ? 6'h28 : _GEN_36; // @[rpu_decoder.scala 162:47 rpu_decoder.scala 163:27]
  wire [5:0] _GEN_38 = io_ir[31:25] == 7'h1 ? 6'h27 : _GEN_37; // @[rpu_decoder.scala 160:47 rpu_decoder.scala 161:27]
  wire [5:0] _GEN_39 = _T_14 ? 6'h26 : _GEN_38; // @[rpu_decoder.scala 158:40 rpu_decoder.scala 159:27]
  wire [5:0] _GEN_40 = _T_63 ? 6'h2b : 6'h0; // @[rpu_decoder.scala 171:47 rpu_decoder.scala 172:27 rpu_decoder.scala 19:17]
  wire [5:0] _GEN_41 = _T_14 ? 6'h2a : _GEN_40; // @[rpu_decoder.scala 169:40 rpu_decoder.scala 170:27]
  wire [5:0] _GEN_42 = _T_14 ? 6'h2c : 6'h0; // @[rpu_decoder.scala 176:40 rpu_decoder.scala 177:27 rpu_decoder.scala 19:17]
  wire [5:0] _GEN_43 = _T_63 ? 6'h2e : 6'h0; // @[rpu_decoder.scala 183:47 rpu_decoder.scala 184:27 rpu_decoder.scala 19:17]
  wire [5:0] _GEN_44 = _T_14 ? 6'h2d : _GEN_43; // @[rpu_decoder.scala 181:40 rpu_decoder.scala 182:27]
  wire [5:0] _GEN_45 = _T_10 ? _GEN_44 : 6'h0; // @[Conditional.scala 39:67 rpu_decoder.scala 19:17]
  wire [5:0] _GEN_46 = _T_9 ? _GEN_42 : _GEN_45; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_47 = _T_8 ? _GEN_41 : _GEN_46; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_48 = _T_7 ? _GEN_39 : _GEN_47; // @[Conditional.scala 40:58]
  wire [5:0] _GEN_49 = _T_57 ? _GEN_48 : 6'h0; // @[Conditional.scala 39:67 rpu_decoder.scala 19:17]
  wire [5:0] _GEN_50 = _T_49 ? {{2'd0}, _GEN_35} : _GEN_49; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_51 = _T_44 ? {{1'd0}, _GEN_29} : _GEN_50; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_52 = _T_37 ? {{2'd0}, _GEN_26} : _GEN_51; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_53 = _T_19 ? _GEN_21 : _GEN_52; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_54 = _T_5 ? {{1'd0}, _GEN_9} : _GEN_53; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_55 = _T_4 ? 6'h4 : _GEN_54; // @[Conditional.scala 39:67 rpu_decoder.scala 31:21]
  wire [5:0] _GEN_56 = _T_3 ? 6'h3 : _GEN_55; // @[Conditional.scala 39:67 rpu_decoder.scala 28:21]
  wire [5:0] _GEN_57 = _T_2 ? 6'h2 : _GEN_56; // @[Conditional.scala 39:67 rpu_decoder.scala 25:21]
  wire  _T_83 = io_instr_type == 6'h2; // @[rpu_decoder.scala 202:23]
  wire  _T_84 = io_instr_type == 6'h1 | _T_83; // @[rpu_decoder.scala 201:42]
  wire [31:0] _io_imm_T = io_ir & 32'hfffff000; // @[rpu_decoder.scala 203:21]
  wire [11:0] io_imm_hi_hi_hi = io_ir[31] ? 12'hfff : 12'h0; // @[Bitwise.scala 72:12]
  wire [7:0] io_imm_hi_hi_lo = io_ir[19:12]; // @[rpu_decoder.scala 205:45]
  wire  io_imm_hi_lo = io_ir[20]; // @[rpu_decoder.scala 205:60]
  wire [9:0] io_imm_lo_hi = io_ir[30:21]; // @[rpu_decoder.scala 205:71]
  wire [31:0] _io_imm_T_3 = {io_imm_hi_hi_hi,io_imm_hi_hi_lo,io_imm_hi_lo,io_imm_lo_hi,1'h0}; // @[Cat.scala 30:58]
  wire [20:0] io_imm_hi_1 = io_ir[31] ? 21'h1fffff : 21'h0; // @[Bitwise.scala 72:12]
  wire [11:0] io_imm_lo_1 = io_ir[31:20]; // @[rpu_decoder.scala 207:45]
  wire [32:0] _io_imm_T_6 = {io_imm_hi_1,io_imm_lo_1}; // @[Cat.scala 30:58]
  wire  _T_88 = io_instr_type == 6'h6; // @[rpu_decoder.scala 209:30]
  wire  _T_89 = io_instr_type == 6'h5 | _T_88; // @[rpu_decoder.scala 208:49]
  wire  _T_90 = io_instr_type == 6'h7; // @[rpu_decoder.scala 210:30]
  wire  _T_91 = _T_89 | _T_90; // @[rpu_decoder.scala 209:49]
  wire  _T_92 = io_instr_type == 6'h8; // @[rpu_decoder.scala 211:30]
  wire  _T_93 = _T_91 | _T_92; // @[rpu_decoder.scala 210:49]
  wire  _T_94 = io_instr_type == 6'h9; // @[rpu_decoder.scala 212:30]
  wire  _T_95 = _T_93 | _T_94; // @[rpu_decoder.scala 211:49]
  wire  _T_96 = io_instr_type == 6'ha; // @[rpu_decoder.scala 213:30]
  wire  _T_97 = _T_95 | _T_96; // @[rpu_decoder.scala 212:50]
  wire [19:0] io_imm_hi_hi_hi_1 = io_ir[31] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire  io_imm_hi_hi_lo_1 = io_ir[7]; // @[rpu_decoder.scala 214:45]
  wire [5:0] io_imm_hi_lo_1 = io_ir[30:25]; // @[rpu_decoder.scala 214:55]
  wire [3:0] io_imm_lo_hi_1 = io_ir[11:8]; // @[rpu_decoder.scala 214:70]
  wire [31:0] _io_imm_T_9 = {io_imm_hi_hi_hi_1,io_imm_hi_hi_lo_1,io_imm_hi_lo_1,io_imm_lo_hi_1,1'h0}; // @[Cat.scala 30:58]
  wire  _T_99 = io_instr_type == 6'hc; // @[rpu_decoder.scala 216:30]
  wire  _T_100 = io_instr_type == 6'hb | _T_99; // @[rpu_decoder.scala 215:48]
  wire  _T_101 = io_instr_type == 6'hd; // @[rpu_decoder.scala 217:30]
  wire  _T_102 = _T_100 | _T_101; // @[rpu_decoder.scala 216:48]
  wire  _T_103 = io_instr_type == 6'he; // @[rpu_decoder.scala 218:30]
  wire  _T_104 = _T_102 | _T_103; // @[rpu_decoder.scala 217:48]
  wire  _T_105 = io_instr_type == 6'hf; // @[rpu_decoder.scala 219:30]
  wire  _T_106 = _T_104 | _T_105; // @[rpu_decoder.scala 218:49]
  wire  _T_107 = io_instr_type == 6'h13; // @[rpu_decoder.scala 220:30]
  wire  _T_108 = _T_106 | _T_107; // @[rpu_decoder.scala 219:49]
  wire  _T_109 = io_instr_type == 6'h14; // @[rpu_decoder.scala 221:30]
  wire  _T_110 = _T_108 | _T_109; // @[rpu_decoder.scala 220:50]
  wire  _T_111 = io_instr_type == 6'h15; // @[rpu_decoder.scala 222:30]
  wire  _T_112 = _T_110 | _T_111; // @[rpu_decoder.scala 221:50]
  wire  _T_113 = io_instr_type == 6'h16; // @[rpu_decoder.scala 223:30]
  wire  _T_114 = _T_112 | _T_113; // @[rpu_decoder.scala 222:51]
  wire  _T_115 = io_instr_type == 6'h17; // @[rpu_decoder.scala 224:30]
  wire  _T_116 = _T_114 | _T_115; // @[rpu_decoder.scala 223:50]
  wire  _T_117 = io_instr_type == 6'h18; // @[rpu_decoder.scala 225:30]
  wire  _T_118 = _T_116 | _T_117; // @[rpu_decoder.scala 224:49]
  wire  _T_119 = io_instr_type == 6'h19; // @[rpu_decoder.scala 226:30]
  wire  _T_120 = _T_118 | _T_119; // @[rpu_decoder.scala 225:50]
  wire  _T_121 = io_instr_type == 6'h1a; // @[rpu_decoder.scala 227:30]
  wire  _T_122 = _T_120 | _T_121; // @[rpu_decoder.scala 226:50]
  wire  _T_123 = io_instr_type == 6'h1b; // @[rpu_decoder.scala 228:30]
  wire  _T_124 = _T_122 | _T_123; // @[rpu_decoder.scala 227:50]
  wire [10:0] io_imm_lo_3 = io_ir[30:20]; // @[rpu_decoder.scala 229:45]
  wire [31:0] _io_imm_T_12 = {io_imm_hi_1,io_imm_lo_3}; // @[Cat.scala 30:58]
  wire  _T_126 = io_instr_type == 6'h11; // @[rpu_decoder.scala 231:30]
  wire  _T_127 = io_instr_type == 6'h10 | _T_126; // @[rpu_decoder.scala 230:48]
  wire  _T_128 = io_instr_type == 6'h12; // @[rpu_decoder.scala 232:30]
  wire  _T_129 = _T_127 | _T_128; // @[rpu_decoder.scala 231:48]
  wire [31:0] _io_imm_T_15 = {io_imm_hi_1,io_imm_hi_lo_1,io_ir[11:7]}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_60 = _T_129 ? _io_imm_T_15 : 32'hdeadbeef; // @[rpu_decoder.scala 232:49 rpu_decoder.scala 233:12 rpu_decoder.scala 200:10]
  wire [31:0] _GEN_61 = _T_124 ? _io_imm_T_12 : _GEN_60; // @[rpu_decoder.scala 228:51 rpu_decoder.scala 229:12]
  wire [31:0] _GEN_62 = _T_97 ? _io_imm_T_9 : _GEN_61; // @[rpu_decoder.scala 213:51 rpu_decoder.scala 214:12]
  wire [32:0] _GEN_63 = io_instr_type == 6'h4 ? _io_imm_T_6 : {{1'd0}, _GEN_62}; // @[rpu_decoder.scala 206:51 rpu_decoder.scala 207:12]
  wire [32:0] _GEN_64 = io_instr_type == 6'h3 ? {{1'd0}, _io_imm_T_3} : _GEN_63; // @[rpu_decoder.scala 204:50 rpu_decoder.scala 205:12]
  wire [32:0] _GEN_65 = _T_84 ? {{1'd0}, _io_imm_T} : _GEN_64; // @[rpu_decoder.scala 202:45 rpu_decoder.scala 203:12]
  assign io_instr_type = _T_1 ? 6'h1 : _GEN_57; // @[Conditional.scala 40:58 rpu_decoder.scala 22:21]
  assign io_rs1 = io_ir[19:15]; // @[rpu_decoder.scala 191:18]
  assign io_rs2 = io_ir[24:20]; // @[rpu_decoder.scala 192:18]
  assign io_rs3 = io_instr_type == 6'h2b ? io_rd : 5'h0; // @[rpu_decoder.scala 194:45 rpu_decoder.scala 195:12 rpu_decoder.scala 197:12]
  assign io_rd = io_ir[11:7]; // @[rpu_decoder.scala 193:17]
  assign io_imm = _GEN_65[31:0];
endmodule
module rpu_control(
  input  [5:0] io_instr_type,
  output       io_jump,
  output       io_branch,
  output       io_alu_op1_src,
  output       io_alu_op2_src,
  output [3:0] io_alu_op,
  output [1:0] io_alu_result_src,
  output [2:0] io_comp_op,
  output       io_r2_src,
  output       io_tg_we,
  output       io_ti_we,
  output       io_to,
  output       io_addtk,
  output       io_tkend,
  output       io_mem_write,
  output [3:0] io_mem_op,
  output       io_reg_write,
  output [1:0] io_reg_write_src
);
  wire  _io_jump_T = io_instr_type == 6'h4; // @[rpu_control.scala 30:28]
  wire  _io_jump_T_1 = io_instr_type == 6'h3; // @[rpu_control.scala 30:64]
  wire  _io_jump_T_2 = io_instr_type == 6'h4 | io_instr_type == 6'h3; // @[rpu_control.scala 30:48]
  wire  _io_branch_T = io_instr_type == 6'h5; // @[rpu_control.scala 31:31]
  wire  _io_branch_T_1 = io_instr_type == 6'h6; // @[rpu_control.scala 32:31]
  wire  _io_branch_T_2 = io_instr_type == 6'h5 | _io_branch_T_1; // @[rpu_control.scala 31:50]
  wire  _io_branch_T_3 = io_instr_type == 6'h7; // @[rpu_control.scala 33:31]
  wire  _io_branch_T_4 = _io_branch_T_2 | _io_branch_T_3; // @[rpu_control.scala 32:50]
  wire  _io_branch_T_5 = io_instr_type == 6'h8; // @[rpu_control.scala 34:31]
  wire  _io_branch_T_6 = _io_branch_T_4 | _io_branch_T_5; // @[rpu_control.scala 33:50]
  wire  _io_branch_T_7 = io_instr_type == 6'h9; // @[rpu_control.scala 35:31]
  wire  _io_branch_T_8 = _io_branch_T_6 | _io_branch_T_7; // @[rpu_control.scala 34:50]
  wire  _io_branch_T_9 = io_instr_type == 6'ha; // @[rpu_control.scala 36:31]
  wire  _T = io_instr_type == 6'h2; // @[rpu_control.scala 37:23]
  wire  _T_2 = io_instr_type == 6'h2 | _io_jump_T_1; // @[rpu_control.scala 37:44]
  wire  _T_4 = _T_2 | _io_branch_T; // @[rpu_control.scala 38:42]
  wire  _T_6 = _T_4 | _io_branch_T_1; // @[rpu_control.scala 39:42]
  wire  _T_8 = _T_6 | _io_branch_T_3; // @[rpu_control.scala 40:42]
  wire  _T_10 = _T_8 | _io_branch_T_5; // @[rpu_control.scala 41:42]
  wire  _T_12 = _T_10 | _io_branch_T_7; // @[rpu_control.scala 42:42]
  wire  _T_15 = io_instr_type == 6'h1c; // @[rpu_control.scala 49:23]
  wire  _T_16 = io_instr_type == 6'h1d; // @[rpu_control.scala 50:23]
  wire  _T_17 = io_instr_type == 6'h1c | _T_16; // @[rpu_control.scala 49:42]
  wire  _T_18 = io_instr_type == 6'h1e; // @[rpu_control.scala 51:23]
  wire  _T_19 = _T_17 | _T_18; // @[rpu_control.scala 50:42]
  wire  _T_20 = io_instr_type == 6'h1f; // @[rpu_control.scala 52:23]
  wire  _T_21 = _T_19 | _T_20; // @[rpu_control.scala 51:42]
  wire  _T_22 = io_instr_type == 6'h20; // @[rpu_control.scala 53:23]
  wire  _T_23 = _T_21 | _T_22; // @[rpu_control.scala 52:42]
  wire  _T_24 = io_instr_type == 6'h21; // @[rpu_control.scala 54:23]
  wire  _T_25 = _T_23 | _T_24; // @[rpu_control.scala 53:43]
  wire  _T_26 = io_instr_type == 6'h22; // @[rpu_control.scala 55:23]
  wire  _T_27 = _T_25 | _T_26; // @[rpu_control.scala 54:42]
  wire  _T_28 = io_instr_type == 6'h23; // @[rpu_control.scala 56:23]
  wire  _T_29 = _T_27 | _T_28; // @[rpu_control.scala 55:42]
  wire  _T_30 = io_instr_type == 6'h24; // @[rpu_control.scala 57:23]
  wire  _T_31 = _T_29 | _T_30; // @[rpu_control.scala 56:42]
  wire  _T_33 = _T_31 | _T_15; // @[rpu_control.scala 57:41]
  wire  _T_36 = 6'hb == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_39 = 6'hc == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_42 = 6'hd == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_45 = 6'he == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_48 = 6'hf == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_51 = 6'h10 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_54 = 6'h11 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_57 = 6'h12 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_60 = 6'h1 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_63 = 6'h3 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_66 = 6'h4 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_69 = 6'h2 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_72 = 6'h1c == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_75 = 6'h13 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_78 = 6'h5 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_81 = 6'h6 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_84 = 6'h7 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_87 = 6'h8 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_90 = 6'h9 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_93 = 6'ha == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_96 = 6'h1d == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_99 = 6'h1f == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_102 = 6'h14 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_105 = 6'h20 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_108 = 6'h15 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_111 = 6'h21 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_114 = 6'h16 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_117 = 6'h24 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_120 = 6'h17 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_123 = 6'h25 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_126 = 6'h18 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_129 = 6'h1e == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_132 = 6'h19 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_135 = 6'h22 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_138 = 6'h1a == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_141 = 6'h23 == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_144 = 6'h1b == io_instr_type; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_2 = _T_144 ? 3'h7 : 3'h0; // @[Conditional.scala 39:67 rpu_control.scala 175:17 rpu_control.scala 64:13]
  wire [2:0] _GEN_3 = _T_141 ? 3'h7 : _GEN_2; // @[Conditional.scala 39:67 rpu_control.scala 172:17]
  wire [3:0] _GEN_4 = _T_138 ? 4'h8 : {{1'd0}, _GEN_3}; // @[Conditional.scala 39:67 rpu_control.scala 169:17]
  wire [3:0] _GEN_5 = _T_135 ? 4'h8 : _GEN_4; // @[Conditional.scala 39:67 rpu_control.scala 166:17]
  wire [3:0] _GEN_6 = _T_132 ? 4'h6 : _GEN_5; // @[Conditional.scala 39:67 rpu_control.scala 163:17]
  wire [3:0] _GEN_7 = _T_129 ? 4'h6 : _GEN_6; // @[Conditional.scala 39:67 rpu_control.scala 160:17]
  wire [3:0] _GEN_8 = _T_126 ? 4'h5 : _GEN_7; // @[Conditional.scala 39:67 rpu_control.scala 157:17]
  wire [3:0] _GEN_9 = _T_123 ? 4'h5 : _GEN_8; // @[Conditional.scala 39:67 rpu_control.scala 154:17]
  wire [3:0] _GEN_10 = _T_120 ? 4'h4 : _GEN_9; // @[Conditional.scala 39:67 rpu_control.scala 151:17]
  wire [3:0] _GEN_11 = _T_117 ? 4'h4 : _GEN_10; // @[Conditional.scala 39:67 rpu_control.scala 148:17]
  wire [3:0] _GEN_12 = _T_114 ? 4'h3 : _GEN_11; // @[Conditional.scala 39:67 rpu_control.scala 145:17]
  wire [3:0] _GEN_13 = _T_111 ? 4'h3 : _GEN_12; // @[Conditional.scala 39:67 rpu_control.scala 142:17]
  wire [3:0] _GEN_14 = _T_108 ? 4'hb : _GEN_13; // @[Conditional.scala 39:67 rpu_control.scala 139:17]
  wire [3:0] _GEN_15 = _T_105 ? 4'hb : _GEN_14; // @[Conditional.scala 39:67 rpu_control.scala 136:17]
  wire [3:0] _GEN_16 = _T_102 ? 4'ha : _GEN_15; // @[Conditional.scala 39:67 rpu_control.scala 133:17]
  wire [3:0] _GEN_17 = _T_99 ? 4'ha : _GEN_16; // @[Conditional.scala 39:67 rpu_control.scala 130:17]
  wire [3:0] _GEN_18 = _T_96 ? 4'h2 : _GEN_17; // @[Conditional.scala 39:67 rpu_control.scala 127:17]
  wire [3:0] _GEN_19 = _T_93 ? 4'h1 : _GEN_18; // @[Conditional.scala 39:67 rpu_control.scala 124:17]
  wire [3:0] _GEN_20 = _T_90 ? 4'h1 : _GEN_19; // @[Conditional.scala 39:67 rpu_control.scala 121:17]
  wire [3:0] _GEN_21 = _T_87 ? 4'h1 : _GEN_20; // @[Conditional.scala 39:67 rpu_control.scala 118:17]
  wire [3:0] _GEN_22 = _T_84 ? 4'h1 : _GEN_21; // @[Conditional.scala 39:67 rpu_control.scala 115:17]
  wire [3:0] _GEN_23 = _T_81 ? 4'h1 : _GEN_22; // @[Conditional.scala 39:67 rpu_control.scala 112:17]
  wire [3:0] _GEN_24 = _T_78 ? 4'h1 : _GEN_23; // @[Conditional.scala 39:67 rpu_control.scala 109:17]
  wire [3:0] _GEN_25 = _T_75 ? 4'h1 : _GEN_24; // @[Conditional.scala 39:67 rpu_control.scala 106:17]
  wire [3:0] _GEN_26 = _T_72 ? 4'h1 : _GEN_25; // @[Conditional.scala 39:67 rpu_control.scala 103:17]
  wire [3:0] _GEN_27 = _T_69 ? 4'h1 : _GEN_26; // @[Conditional.scala 39:67 rpu_control.scala 100:17]
  wire [3:0] _GEN_28 = _T_66 ? 4'h1 : _GEN_27; // @[Conditional.scala 39:67 rpu_control.scala 97:17]
  wire [3:0] _GEN_29 = _T_63 ? 4'h1 : _GEN_28; // @[Conditional.scala 39:67 rpu_control.scala 94:17]
  wire [3:0] _GEN_30 = _T_60 ? 4'h9 : _GEN_29; // @[Conditional.scala 39:67 rpu_control.scala 91:17]
  wire [3:0] _GEN_31 = _T_57 ? 4'h1 : _GEN_30; // @[Conditional.scala 39:67 rpu_control.scala 88:17]
  wire [3:0] _GEN_32 = _T_54 ? 4'h1 : _GEN_31; // @[Conditional.scala 39:67 rpu_control.scala 85:17]
  wire [3:0] _GEN_33 = _T_51 ? 4'h1 : _GEN_32; // @[Conditional.scala 39:67 rpu_control.scala 82:17]
  wire [3:0] _GEN_34 = _T_48 ? 4'h1 : _GEN_33; // @[Conditional.scala 39:67 rpu_control.scala 79:17]
  wire [3:0] _GEN_35 = _T_45 ? 4'h1 : _GEN_34; // @[Conditional.scala 39:67 rpu_control.scala 76:17]
  wire [3:0] _GEN_36 = _T_42 ? 4'h1 : _GEN_35; // @[Conditional.scala 39:67 rpu_control.scala 73:17]
  wire [3:0] _GEN_37 = _T_39 ? 4'h1 : _GEN_36; // @[Conditional.scala 39:67 rpu_control.scala 70:17]
  wire  _T_145 = io_instr_type == 6'h29; // @[rpu_control.scala 179:23]
  wire  _T_146 = io_instr_type == 6'h28; // @[rpu_control.scala 181:30]
  wire [1:0] _GEN_39 = io_instr_type == 6'h28 ? 2'h2 : 2'h0; // @[rpu_control.scala 181:52 rpu_control.scala 182:23 rpu_control.scala 184:23]
  wire [2:0] _GEN_41 = _T_93 ? 3'h6 : 3'h0; // @[Conditional.scala 39:67 rpu_control.scala 205:18 rpu_control.scala 187:14]
  wire [2:0] _GEN_42 = _T_90 ? 3'h4 : _GEN_41; // @[Conditional.scala 39:67 rpu_control.scala 202:18]
  wire [2:0] _GEN_43 = _T_87 ? 3'h5 : _GEN_42; // @[Conditional.scala 39:67 rpu_control.scala 199:18]
  wire [2:0] _GEN_44 = _T_84 ? 3'h3 : _GEN_43; // @[Conditional.scala 39:67 rpu_control.scala 196:18]
  wire [2:0] _GEN_45 = _T_81 ? 3'h2 : _GEN_44; // @[Conditional.scala 39:67 rpu_control.scala 193:18]
  wire  _T_165 = io_instr_type == 6'h2b; // @[rpu_control.scala 209:23]
  wire  _io_to_T = io_instr_type == 6'h2a; // @[rpu_control.scala 216:26]
  wire  _io_to_T_2 = io_instr_type == 6'h2a | _T_165; // @[rpu_control.scala 216:47]
  wire  _io_to_T_3 = io_instr_type == 6'h2c; // @[rpu_control.scala 218:26]
  wire  _io_mem_write_T_1 = io_instr_type == 6'h11; // @[rpu_control.scala 222:33]
  wire  _io_mem_write_T_2 = io_instr_type == 6'h10 | _io_mem_write_T_1; // @[rpu_control.scala 221:51]
  wire  _io_mem_write_T_3 = io_instr_type == 6'h12; // @[rpu_control.scala 223:33]
  wire  _io_mem_write_T_4 = _io_mem_write_T_2 | _io_mem_write_T_3; // @[rpu_control.scala 222:51]
  wire  _T_177 = 6'h2b == io_instr_type; // @[Conditional.scala 37:30]
  wire  _T_195 = 6'h2a == io_instr_type; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_48 = _T_195 ? 2'h3 : 2'h0; // @[Conditional.scala 39:67 rpu_control.scala 255:17 rpu_control.scala 225:13]
  wire [1:0] _GEN_49 = _T_42 ? 2'h3 : _GEN_48; // @[Conditional.scala 39:67 rpu_control.scala 252:17]
  wire [2:0] _GEN_50 = _T_48 ? 3'h5 : {{1'd0}, _GEN_49}; // @[Conditional.scala 39:67 rpu_control.scala 249:17]
  wire [2:0] _GEN_51 = _T_39 ? 3'h2 : _GEN_50; // @[Conditional.scala 39:67 rpu_control.scala 246:17]
  wire [2:0] _GEN_52 = _T_45 ? 3'h4 : _GEN_51; // @[Conditional.scala 39:67 rpu_control.scala 243:17]
  wire [2:0] _GEN_53 = _T_36 ? 3'h1 : _GEN_52; // @[Conditional.scala 39:67 rpu_control.scala 240:17]
  wire [3:0] _GEN_54 = _T_177 ? 4'h8 : {{1'd0}, _GEN_53}; // @[Conditional.scala 39:67 rpu_control.scala 237:17]
  wire [3:0] _GEN_55 = _T_57 ? 4'h8 : _GEN_54; // @[Conditional.scala 39:67 rpu_control.scala 234:17]
  wire [3:0] _GEN_56 = _T_54 ? 4'h7 : _GEN_55; // @[Conditional.scala 39:67 rpu_control.scala 231:17]
  wire  _io_reg_write_T_2 = io_instr_type == 6'h1 | _T; // @[rpu_control.scala 258:52]
  wire  _io_reg_write_T_3 = io_instr_type == 6'h13; // @[rpu_control.scala 260:33]
  wire  _io_reg_write_T_4 = _io_reg_write_T_2 | _io_reg_write_T_3; // @[rpu_control.scala 259:54]
  wire  _io_reg_write_T_5 = io_instr_type == 6'h14; // @[rpu_control.scala 261:33]
  wire  _io_reg_write_T_6 = _io_reg_write_T_4 | _io_reg_write_T_5; // @[rpu_control.scala 260:53]
  wire  _io_reg_write_T_8 = _io_reg_write_T_6 | _T_22; // @[rpu_control.scala 261:53]
  wire  _io_reg_write_T_9 = io_instr_type == 6'h16; // @[rpu_control.scala 263:33]
  wire  _io_reg_write_T_10 = _io_reg_write_T_8 | _io_reg_write_T_9; // @[rpu_control.scala 262:53]
  wire  _io_reg_write_T_11 = io_instr_type == 6'h17; // @[rpu_control.scala 264:33]
  wire  _io_reg_write_T_12 = _io_reg_write_T_10 | _io_reg_write_T_11; // @[rpu_control.scala 263:53]
  wire  _io_reg_write_T_13 = io_instr_type == 6'h18; // @[rpu_control.scala 265:33]
  wire  _io_reg_write_T_14 = _io_reg_write_T_12 | _io_reg_write_T_13; // @[rpu_control.scala 264:52]
  wire  _io_reg_write_T_15 = io_instr_type == 6'h19; // @[rpu_control.scala 266:33]
  wire  _io_reg_write_T_16 = _io_reg_write_T_14 | _io_reg_write_T_15; // @[rpu_control.scala 265:53]
  wire  _io_reg_write_T_17 = io_instr_type == 6'h1a; // @[rpu_control.scala 267:33]
  wire  _io_reg_write_T_18 = _io_reg_write_T_16 | _io_reg_write_T_17; // @[rpu_control.scala 266:53]
  wire  _io_reg_write_T_19 = io_instr_type == 6'h1b; // @[rpu_control.scala 268:33]
  wire  _io_reg_write_T_20 = _io_reg_write_T_18 | _io_reg_write_T_19; // @[rpu_control.scala 267:53]
  wire  _io_reg_write_T_22 = _io_reg_write_T_20 | _T_15; // @[rpu_control.scala 268:53]
  wire  _io_reg_write_T_24 = _io_reg_write_T_22 | _T_16; // @[rpu_control.scala 269:52]
  wire  _io_reg_write_T_26 = _io_reg_write_T_24 | _T_18; // @[rpu_control.scala 270:52]
  wire  _io_reg_write_T_28 = _io_reg_write_T_26 | _T_20; // @[rpu_control.scala 271:52]
  wire  _io_reg_write_T_30 = _io_reg_write_T_28 | _T_22; // @[rpu_control.scala 272:52]
  wire  _io_reg_write_T_32 = _io_reg_write_T_30 | _T_24; // @[rpu_control.scala 273:53]
  wire  _io_reg_write_T_34 = _io_reg_write_T_32 | _T_26; // @[rpu_control.scala 274:52]
  wire  _io_reg_write_T_36 = _io_reg_write_T_34 | _T_28; // @[rpu_control.scala 275:52]
  wire  _io_reg_write_T_38 = _io_reg_write_T_36 | _T_30; // @[rpu_control.scala 276:52]
  wire  _io_reg_write_T_39 = io_instr_type == 6'h25; // @[rpu_control.scala 278:33]
  wire  _io_reg_write_T_40 = _io_reg_write_T_38 | _io_reg_write_T_39; // @[rpu_control.scala 277:51]
  wire  _io_reg_write_T_41 = io_instr_type == 6'hb; // @[rpu_control.scala 279:33]
  wire  _io_reg_write_T_42 = _io_reg_write_T_40 | _io_reg_write_T_41; // @[rpu_control.scala 278:52]
  wire  _io_reg_write_T_43 = io_instr_type == 6'hc; // @[rpu_control.scala 280:33]
  wire  _io_reg_write_T_44 = _io_reg_write_T_42 | _io_reg_write_T_43; // @[rpu_control.scala 279:51]
  wire  _io_reg_write_T_45 = io_instr_type == 6'hd; // @[rpu_control.scala 281:33]
  wire  _io_reg_write_T_46 = _io_reg_write_T_44 | _io_reg_write_T_45; // @[rpu_control.scala 280:51]
  wire  _io_reg_write_T_47 = io_instr_type == 6'he; // @[rpu_control.scala 282:33]
  wire  _io_reg_write_T_48 = _io_reg_write_T_46 | _io_reg_write_T_47; // @[rpu_control.scala 281:51]
  wire  _io_reg_write_T_49 = io_instr_type == 6'hf; // @[rpu_control.scala 283:33]
  wire  _io_reg_write_T_50 = _io_reg_write_T_48 | _io_reg_write_T_49; // @[rpu_control.scala 282:52]
  wire  _io_reg_write_T_52 = _io_reg_write_T_50 | _io_jump_T; // @[rpu_control.scala 283:52]
  wire  _io_reg_write_T_54 = _io_reg_write_T_52 | _io_jump_T_1; // @[rpu_control.scala 284:53]
  wire  _io_reg_write_T_56 = _io_reg_write_T_54 | _T_146; // @[rpu_control.scala 285:52]
  wire  _io_reg_write_T_58 = _io_reg_write_T_56 | _T_145; // @[rpu_control.scala 286:54]
  wire  _T_198 = _io_reg_write_T_41 | _io_reg_write_T_43; // @[rpu_control.scala 289:41]
  wire  _T_200 = _T_198 | _io_reg_write_T_45; // @[rpu_control.scala 290:41]
  wire  _T_202 = _T_200 | _io_reg_write_T_47; // @[rpu_control.scala 291:41]
  wire  _T_204 = _T_202 | _io_reg_write_T_49; // @[rpu_control.scala 292:42]
  wire  _T_206 = _T_204 | _io_to_T; // @[rpu_control.scala 293:42]
  wire [1:0] _GEN_58 = _io_jump_T_2 ? 2'h2 : 2'h1; // @[rpu_control.scala 297:51 rpu_control.scala 298:22 rpu_control.scala 300:22]
  assign io_jump = io_instr_type == 6'h4 | io_instr_type == 6'h3; // @[rpu_control.scala 30:48]
  assign io_branch = _io_branch_T_8 | _io_branch_T_9; // @[rpu_control.scala 35:51]
  assign io_alu_op1_src = _T_12 | _io_branch_T_9; // @[rpu_control.scala 43:43]
  assign io_alu_op2_src = _T_33 ? 1'h0 : 1'h1; // @[rpu_control.scala 58:43 rpu_control.scala 59:20 rpu_control.scala 61:20]
  assign io_alu_op = _T_36 ? 4'h1 : _GEN_37; // @[Conditional.scala 40:58 rpu_control.scala 67:17]
  assign io_alu_result_src = io_instr_type == 6'h29 ? 2'h1 : _GEN_39; // @[rpu_control.scala 179:45 rpu_control.scala 180:23]
  assign io_comp_op = _T_78 ? 3'h1 : _GEN_45; // @[Conditional.scala 40:58 rpu_control.scala 190:18]
  assign io_r2_src = io_instr_type == 6'h2b; // @[rpu_control.scala 209:23]
  assign io_tg_we = io_instr_type == 6'h26; // @[rpu_control.scala 214:29]
  assign io_ti_we = io_instr_type == 6'h27; // @[rpu_control.scala 215:29]
  assign io_to = _io_to_T_2 | _io_to_T_3; // @[rpu_control.scala 217:47]
  assign io_addtk = io_instr_type == 6'h2e; // @[rpu_control.scala 219:29]
  assign io_tkend = io_instr_type == 6'h2d; // @[rpu_control.scala 220:29]
  assign io_mem_write = _io_mem_write_T_4 | _T_165; // @[rpu_control.scala 223:51]
  assign io_mem_op = _T_51 ? 4'h6 : _GEN_56; // @[Conditional.scala 40:58 rpu_control.scala 228:17]
  assign io_reg_write = _io_reg_write_T_58 | _io_to_T; // @[rpu_control.scala 287:54]
  assign io_reg_write_src = _T_206 ? 2'h0 : _GEN_58; // @[rpu_control.scala 294:45 rpu_control.scala 295:22]
endmodule
module rpu_alu(
  input  [31:0] io_op_a,
  input  [31:0] io_op_b,
  input  [3:0]  io_operation,
  output [31:0] io_result
);
  wire  _T_2 = 4'h1 == io_operation; // @[Conditional.scala 37:30]
  wire [31:0] _io_result_T_1 = io_op_a + io_op_b; // @[rpu_alu.scala 17:28]
  wire  _T_5 = 4'h2 == io_operation; // @[Conditional.scala 37:30]
  wire [31:0] _io_result_T_3 = io_op_a - io_op_b; // @[rpu_alu.scala 20:28]
  wire  _T_8 = 4'h5 == io_operation; // @[Conditional.scala 37:30]
  wire [31:0] _io_result_T_4 = io_op_a & io_op_b; // @[rpu_alu.scala 23:28]
  wire  _T_11 = 4'h4 == io_operation; // @[Conditional.scala 37:30]
  wire [31:0] _io_result_T_5 = io_op_a | io_op_b; // @[rpu_alu.scala 26:28]
  wire  _T_14 = 4'h3 == io_operation; // @[Conditional.scala 37:30]
  wire [31:0] _io_result_T_6 = io_op_a ^ io_op_b; // @[rpu_alu.scala 29:28]
  wire  _T_17 = 4'h6 == io_operation; // @[Conditional.scala 37:30]
  wire [62:0] _GEN_12 = {{31'd0}, io_op_a}; // @[rpu_alu.scala 32:28]
  wire [62:0] _io_result_T_8 = _GEN_12 << io_op_b[4:0]; // @[rpu_alu.scala 32:28]
  wire  _T_20 = 4'h7 == io_operation; // @[Conditional.scala 37:30]
  wire [31:0] _io_result_T_9 = io_op_a; // @[rpu_alu.scala 35:29]
  wire [31:0] _io_result_T_12 = $signed(io_op_a) >>> io_op_b[4:0]; // @[rpu_alu.scala 35:54]
  wire  _T_23 = 4'h8 == io_operation; // @[Conditional.scala 37:30]
  wire [31:0] _io_result_T_14 = io_op_a >> io_op_b[4:0]; // @[rpu_alu.scala 38:28]
  wire  _T_26 = 4'h9 == io_operation; // @[Conditional.scala 37:30]
  wire  _T_29 = 4'ha == io_operation; // @[Conditional.scala 37:30]
  wire [31:0] _io_result_T_16 = io_op_b; // @[rpu_alu.scala 44:45]
  wire  _T_32 = 4'hb == io_operation; // @[Conditional.scala 37:30]
  wire  _T_35 = 4'h0 == io_operation; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_0 = _T_35 ? 32'hdeadbeef : 32'h0; // @[Conditional.scala 39:67 rpu_alu.scala 50:17 rpu_alu.scala 14:13]
  wire [31:0] _GEN_1 = _T_32 ? {{31'd0}, io_op_a < io_op_b} : _GEN_0; // @[Conditional.scala 39:67 rpu_alu.scala 47:17]
  wire [31:0] _GEN_2 = _T_29 ? {{31'd0}, $signed(_io_result_T_9) < $signed(_io_result_T_16)} : _GEN_1; // @[Conditional.scala 39:67 rpu_alu.scala 44:17]
  wire [31:0] _GEN_3 = _T_26 ? io_op_b : _GEN_2; // @[Conditional.scala 39:67 rpu_alu.scala 41:17]
  wire [31:0] _GEN_4 = _T_23 ? _io_result_T_14 : _GEN_3; // @[Conditional.scala 39:67 rpu_alu.scala 38:17]
  wire [31:0] _GEN_5 = _T_20 ? _io_result_T_12 : _GEN_4; // @[Conditional.scala 39:67 rpu_alu.scala 35:17]
  wire [62:0] _GEN_6 = _T_17 ? _io_result_T_8 : {{31'd0}, _GEN_5}; // @[Conditional.scala 39:67 rpu_alu.scala 32:17]
  wire [62:0] _GEN_7 = _T_14 ? {{31'd0}, _io_result_T_6} : _GEN_6; // @[Conditional.scala 39:67 rpu_alu.scala 29:17]
  wire [62:0] _GEN_8 = _T_11 ? {{31'd0}, _io_result_T_5} : _GEN_7; // @[Conditional.scala 39:67 rpu_alu.scala 26:17]
  wire [62:0] _GEN_9 = _T_8 ? {{31'd0}, _io_result_T_4} : _GEN_8; // @[Conditional.scala 39:67 rpu_alu.scala 23:17]
  wire [62:0] _GEN_10 = _T_5 ? {{31'd0}, _io_result_T_3} : _GEN_9; // @[Conditional.scala 39:67 rpu_alu.scala 20:17]
  wire [62:0] _GEN_11 = _T_2 ? {{31'd0}, _io_result_T_1} : _GEN_10; // @[Conditional.scala 40:58 rpu_alu.scala 17:17]
  assign io_result = _GEN_11[31:0];
endmodule
module rpu_comp(
  input  [2:0]  io_comp_op,
  input  [31:0] io_op_a,
  input  [31:0] io_op_b,
  output        io_result
);
  wire  _T_2 = 3'h1 == io_comp_op; // @[Conditional.scala 37:30]
  wire  _T_5 = 3'h2 == io_comp_op; // @[Conditional.scala 37:30]
  wire  _T_8 = 3'h3 == io_comp_op; // @[Conditional.scala 37:30]
  wire  _T_11 = 3'h4 == io_comp_op; // @[Conditional.scala 37:30]
  wire  _T_14 = 3'h5 == io_comp_op; // @[Conditional.scala 37:30]
  wire  _T_17 = 3'h6 == io_comp_op; // @[Conditional.scala 37:30]
  wire  _GEN_0 = _T_17 & io_op_a >= io_op_b; // @[Conditional.scala 39:67 rpu_alu.scala 81:17 rpu_alu.scala 63:13]
  wire  _GEN_1 = _T_14 ? $signed(io_op_a) >= $signed(io_op_b) : _GEN_0; // @[Conditional.scala 39:67 rpu_alu.scala 78:17]
  wire  _GEN_2 = _T_11 ? io_op_a < io_op_b : _GEN_1; // @[Conditional.scala 39:67 rpu_alu.scala 75:17]
  wire  _GEN_3 = _T_8 ? $signed(io_op_a) < $signed(io_op_b) : _GEN_2; // @[Conditional.scala 39:67 rpu_alu.scala 72:17]
  wire  _GEN_4 = _T_5 ? io_op_a != io_op_b : _GEN_3; // @[Conditional.scala 39:67 rpu_alu.scala 69:17]
  assign io_result = _T_2 ? io_op_a == io_op_b : _GEN_4; // @[Conditional.scala 40:58 rpu_alu.scala 66:17]
endmodule
module rpu_time_unit(
  input         clock,
  input         reset,
  input         io_std_clk,
  input         io_ti_we,
  input  [31:0] io_ti_wdata,
  input         io_tg_we,
  input  [31:0] io_tg_wdata,
  output [31:0] io_ti
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg  tick; // @[rpu_time_unit.scala 20:21]
  wire  _GEN_0 = ~io_std_clk ? 1'h0 : tick; // @[rpu_time_unit.scala 23:40 rpu_time_unit.scala 24:10 rpu_time_unit.scala 26:10]
  wire  _GEN_1 = io_std_clk & ~tick | _GEN_0; // @[rpu_time_unit.scala 21:52 rpu_time_unit.scala 22:10]
  reg [31:0] ti; // @[rpu_time_unit.scala 29:19]
  reg [31:0] tg; // @[rpu_time_unit.scala 30:19]
  reg [31:0] cnt; // @[rpu_time_unit.scala 31:20]
  wire [31:0] _cnt_T_1 = cnt + 32'h1; // @[rpu_time_unit.scala 34:16]
  wire [31:0] _ti_T_1 = ti + 32'h1; // @[rpu_time_unit.scala 43:14]
  assign io_ti = ti; // @[rpu_time_unit.scala 54:9]
  always @(posedge clock) begin
    if (reset) begin // @[rpu_time_unit.scala 20:21]
      tick <= 1'h0; // @[rpu_time_unit.scala 20:21]
    end else if (tick) begin // @[rpu_time_unit.scala 33:15]
      tick <= 1'h0; // @[rpu_time_unit.scala 35:10]
    end else begin
      tick <= _GEN_1;
    end
    if (reset) begin // @[rpu_time_unit.scala 29:19]
      ti <= 32'h0; // @[rpu_time_unit.scala 29:19]
    end else if (io_ti_we) begin // @[rpu_time_unit.scala 40:19]
      ti <= io_ti_wdata; // @[rpu_time_unit.scala 41:8]
    end else if (cnt == tg) begin // @[rpu_time_unit.scala 42:28]
      ti <= _ti_T_1; // @[rpu_time_unit.scala 43:8]
    end
    if (reset) begin // @[rpu_time_unit.scala 30:19]
      tg <= 32'h0; // @[rpu_time_unit.scala 30:19]
    end else if (io_tg_we) begin // @[rpu_time_unit.scala 48:19]
      tg <= io_tg_wdata; // @[rpu_time_unit.scala 49:8]
    end
    if (reset) begin // @[rpu_time_unit.scala 31:20]
      cnt <= 32'h0; // @[rpu_time_unit.scala 31:20]
    end else if (tick) begin // @[rpu_time_unit.scala 33:15]
      cnt <= _cnt_T_1; // @[rpu_time_unit.scala 34:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  tick = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  ti = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  tg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  cnt = _RAND_3[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module rpu_core(
  input         clock,
  input         reset,
  input         io_std_clk,
  input  [31:0] io_boot_addr_0,
  input  [31:0] io_boot_addr_1,
  input  [31:0] io_boot_addr_2,
  input  [31:0] io_boot_addr_3,
  output [31:0] io_instr_addr,
  input  [31:0] io_instr_data,
  output        io_data_we,
  output [3:0]  io_data_be,
  output [31:0] io_data_addr,
  output [31:0] io_data_wdata,
  input  [31:0] io_data_rdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
`endif // RANDOMIZE_REG_INIT
  wire  tc_clock; // @[rpu_core.scala 98:18]
  wire  tc_reset; // @[rpu_core.scala 98:18]
  wire  tc_io_data_stall; // @[rpu_core.scala 98:18]
  wire  tc_io_control_stall; // @[rpu_core.scala 98:18]
  wire  tc_io_tkend; // @[rpu_core.scala 98:18]
  wire  tc_io_addtk; // @[rpu_core.scala 98:18]
  wire [31:0] tc_io_time; // @[rpu_core.scala 98:18]
  wire [31:0] tc_io_tid; // @[rpu_core.scala 98:18]
  wire [31:0] tc_io_ti; // @[rpu_core.scala 98:18]
  wire  tc_io_wb_pc; // @[rpu_core.scala 98:18]
  wire  tc_io_pc_we; // @[rpu_core.scala 98:18]
  wire  tc_io_ifid_clear; // @[rpu_core.scala 98:18]
  wire  tc_io_ifid_we; // @[rpu_core.scala 98:18]
  wire  tc_io_idex_clear; // @[rpu_core.scala 98:18]
  wire  tc_io_idex_we; // @[rpu_core.scala 98:18]
  wire  tc_io_exmm_clear; // @[rpu_core.scala 98:18]
  wire  tc_io_exmm_we; // @[rpu_core.scala 98:18]
  wire  tc_io_mmwb_clear; // @[rpu_core.scala 98:18]
  wire  tc_io_mmwb_we; // @[rpu_core.scala 98:18]
  wire  tc_io_thread_id_we; // @[rpu_core.scala 98:18]
  wire [1:0] tc_io_thread_id_wdata; // @[rpu_core.scala 98:18]
  wire  pcg_clock; // @[rpu_core.scala 100:19]
  wire  pcg_reset; // @[rpu_core.scala 100:19]
  wire [31:0] pcg_io_boot_addr_0; // @[rpu_core.scala 100:19]
  wire [31:0] pcg_io_boot_addr_1; // @[rpu_core.scala 100:19]
  wire [31:0] pcg_io_boot_addr_2; // @[rpu_core.scala 100:19]
  wire [31:0] pcg_io_boot_addr_3; // @[rpu_core.scala 100:19]
  wire  pcg_io_thread_id_we; // @[rpu_core.scala 100:19]
  wire [1:0] pcg_io_thread_id_wdata; // @[rpu_core.scala 100:19]
  wire  pcg_io_npc_we; // @[rpu_core.scala 100:19]
  wire [31:0] pcg_io_npc_wdata; // @[rpu_core.scala 100:19]
  wire [31:0] pcg_io_pc; // @[rpu_core.scala 100:19]
  wire  regg_clock; // @[rpu_core.scala 102:20]
  wire  regg_io_thread_id_we; // @[rpu_core.scala 102:20]
  wire [1:0] regg_io_thread_id_wdata; // @[rpu_core.scala 102:20]
  wire [4:0] regg_io_raddr_a; // @[rpu_core.scala 102:20]
  wire [31:0] regg_io_rdata_a; // @[rpu_core.scala 102:20]
  wire [4:0] regg_io_raddr_b; // @[rpu_core.scala 102:20]
  wire [31:0] regg_io_rdata_b; // @[rpu_core.scala 102:20]
  wire [4:0] regg_io_raddr_c; // @[rpu_core.scala 102:20]
  wire [31:0] regg_io_rdata_c; // @[rpu_core.scala 102:20]
  wire [4:0] regg_io_waddr_a; // @[rpu_core.scala 102:20]
  wire [31:0] regg_io_wdata_a; // @[rpu_core.scala 102:20]
  wire  regg_io_we_a; // @[rpu_core.scala 102:20]
  wire [31:0] decoder_io_ir; // @[rpu_core.scala 104:23]
  wire [5:0] decoder_io_instr_type; // @[rpu_core.scala 104:23]
  wire [4:0] decoder_io_rs1; // @[rpu_core.scala 104:23]
  wire [4:0] decoder_io_rs2; // @[rpu_core.scala 104:23]
  wire [4:0] decoder_io_rs3; // @[rpu_core.scala 104:23]
  wire [4:0] decoder_io_rd; // @[rpu_core.scala 104:23]
  wire [31:0] decoder_io_imm; // @[rpu_core.scala 104:23]
  wire [5:0] control_io_instr_type; // @[rpu_core.scala 106:23]
  wire  control_io_jump; // @[rpu_core.scala 106:23]
  wire  control_io_branch; // @[rpu_core.scala 106:23]
  wire  control_io_alu_op1_src; // @[rpu_core.scala 106:23]
  wire  control_io_alu_op2_src; // @[rpu_core.scala 106:23]
  wire [3:0] control_io_alu_op; // @[rpu_core.scala 106:23]
  wire [1:0] control_io_alu_result_src; // @[rpu_core.scala 106:23]
  wire [2:0] control_io_comp_op; // @[rpu_core.scala 106:23]
  wire  control_io_r2_src; // @[rpu_core.scala 106:23]
  wire  control_io_tg_we; // @[rpu_core.scala 106:23]
  wire  control_io_ti_we; // @[rpu_core.scala 106:23]
  wire  control_io_to; // @[rpu_core.scala 106:23]
  wire  control_io_addtk; // @[rpu_core.scala 106:23]
  wire  control_io_tkend; // @[rpu_core.scala 106:23]
  wire  control_io_mem_write; // @[rpu_core.scala 106:23]
  wire [3:0] control_io_mem_op; // @[rpu_core.scala 106:23]
  wire  control_io_reg_write; // @[rpu_core.scala 106:23]
  wire [1:0] control_io_reg_write_src; // @[rpu_core.scala 106:23]
  wire [31:0] alu_io_op_a; // @[rpu_core.scala 108:19]
  wire [31:0] alu_io_op_b; // @[rpu_core.scala 108:19]
  wire [3:0] alu_io_operation; // @[rpu_core.scala 108:19]
  wire [31:0] alu_io_result; // @[rpu_core.scala 108:19]
  wire [2:0] comp_io_comp_op; // @[rpu_core.scala 110:20]
  wire [31:0] comp_io_op_a; // @[rpu_core.scala 110:20]
  wire [31:0] comp_io_op_b; // @[rpu_core.scala 110:20]
  wire  comp_io_result; // @[rpu_core.scala 110:20]
  wire  tu_clock; // @[rpu_core.scala 112:18]
  wire  tu_reset; // @[rpu_core.scala 112:18]
  wire  tu_io_std_clk; // @[rpu_core.scala 112:18]
  wire  tu_io_ti_we; // @[rpu_core.scala 112:18]
  wire [31:0] tu_io_ti_wdata; // @[rpu_core.scala 112:18]
  wire  tu_io_tg_we; // @[rpu_core.scala 112:18]
  wire [31:0] tu_io_tg_wdata; // @[rpu_core.scala 112:18]
  wire [31:0] tu_io_ti; // @[rpu_core.scala 112:18]
  reg  ifid_stage_regs_valid; // @[rpu_core.scala 120:32]
  reg [31:0] ifid_stage_regs_pc; // @[rpu_core.scala 120:32]
  reg [31:0] ifid_stage_regs_npc; // @[rpu_core.scala 120:32]
  reg [31:0] ifid_stage_regs_ir; // @[rpu_core.scala 120:32]
  reg  idex_stage_regs_valid; // @[rpu_core.scala 152:32]
  reg [31:0] idex_stage_regs_pc; // @[rpu_core.scala 152:32]
  reg [31:0] idex_stage_regs_npc; // @[rpu_core.scala 152:32]
  reg [31:0] idex_stage_regs_r1; // @[rpu_core.scala 152:32]
  reg [31:0] idex_stage_regs_r2; // @[rpu_core.scala 152:32]
  reg [31:0] idex_stage_regs_r3; // @[rpu_core.scala 152:32]
  reg [31:0] idex_stage_regs_imm; // @[rpu_core.scala 152:32]
  reg  idex_stage_regs_reg_write; // @[rpu_core.scala 152:32]
  reg [1:0] idex_stage_regs_reg_write_src; // @[rpu_core.scala 152:32]
  reg [4:0] idex_stage_regs_reg_write_addr; // @[rpu_core.scala 152:32]
  reg  idex_stage_regs_mem_write; // @[rpu_core.scala 152:32]
  reg [3:0] idex_stage_regs_mem_op; // @[rpu_core.scala 152:32]
  reg  idex_stage_regs_jump; // @[rpu_core.scala 152:32]
  reg  idex_stage_regs_branch; // @[rpu_core.scala 152:32]
  reg  idex_stage_regs_alu_op1_src; // @[rpu_core.scala 152:32]
  reg  idex_stage_regs_alu_op2_src; // @[rpu_core.scala 152:32]
  reg [3:0] idex_stage_regs_alu_op; // @[rpu_core.scala 152:32]
  reg [2:0] idex_stage_regs_comp_op; // @[rpu_core.scala 152:32]
  reg [1:0] idex_stage_regs_alu_result_src; // @[rpu_core.scala 152:32]
  reg  idex_stage_regs_r2_src; // @[rpu_core.scala 152:32]
  reg  idex_stage_regs_tg_we; // @[rpu_core.scala 152:32]
  reg  idex_stage_regs_ti_we; // @[rpu_core.scala 152:32]
  reg  idex_stage_regs_to; // @[rpu_core.scala 152:32]
  reg  idex_stage_regs_addtk; // @[rpu_core.scala 152:32]
  reg  idex_stage_regs_tkend; // @[rpu_core.scala 152:32]
  reg [31:0] exmm_stage_regs_npc; // @[rpu_core.scala 165:32]
  reg [31:0] exmm_stage_regs_alu_result; // @[rpu_core.scala 165:32]
  reg [31:0] exmm_stage_regs_r2; // @[rpu_core.scala 165:32]
  reg  exmm_stage_regs_mem_write; // @[rpu_core.scala 165:32]
  reg [3:0] exmm_stage_regs_mem_op; // @[rpu_core.scala 165:32]
  reg  exmm_stage_regs_reg_write; // @[rpu_core.scala 165:32]
  reg [1:0] exmm_stage_regs_reg_write_src; // @[rpu_core.scala 165:32]
  reg [4:0] exmm_stage_regs_reg_write_addr; // @[rpu_core.scala 165:32]
  reg [31:0] mmwb_stage_regs_npc; // @[rpu_core.scala 176:32]
  reg [31:0] mmwb_stage_regs_alu_result; // @[rpu_core.scala 176:32]
  reg [31:0] mmwb_stage_regs_mem_result; // @[rpu_core.scala 176:32]
  reg  mmwb_stage_regs_reg_write; // @[rpu_core.scala 176:32]
  reg [1:0] mmwb_stage_regs_reg_write_src; // @[rpu_core.scala 176:32]
  reg [4:0] mmwb_stage_regs_reg_write_addr; // @[rpu_core.scala 176:32]
  wire [31:0] _GEN_0 = ifid_stage_regs_valid ? ifid_stage_regs_pc : pcg_io_pc; // @[rpu_core.scala 193:41 rpu_core.scala 194:24 rpu_core.scala 196:24]
  wire [31:0] _GEN_1 = idex_stage_regs_valid ? idex_stage_regs_pc : _GEN_0; // @[rpu_core.scala 191:34 rpu_core.scala 192:24]
  wire  _T = idex_stage_regs_branch & comp_io_result; // @[rpu_core.scala 200:59]
  wire [31:0] _pcg_io_npc_wdata_T_1 = pcg_io_pc + 32'h4; // @[rpu_core.scala 203:37]
  wire [31:0] _GEN_2 = idex_stage_regs_jump | idex_stage_regs_branch & comp_io_result ? alu_io_result :
    _pcg_io_npc_wdata_T_1; // @[rpu_core.scala 200:79 rpu_core.scala 201:24 rpu_core.scala 203:24]
  wire  _GEN_3 = tc_io_pc_we; // @[rpu_core.scala 198:29 rpu_core.scala 199:19 rpu_core.scala 206:19]
  wire [31:0] _GEN_4 = tc_io_pc_we ? _GEN_2 : 32'h0; // @[rpu_core.scala 198:29 rpu_core.scala 207:22]
  wire  _GEN_7 = tc_io_ifid_we | ifid_stage_regs_valid; // @[rpu_core.scala 215:31 rpu_core.scala 216:27 rpu_core.scala 221:21]
  wire [1:0] _GEN_36 = tc_io_idex_we ? control_io_alu_result_src : 2'h0; // @[rpu_core.scala 233:31 rpu_core.scala 255:37 rpu_core.scala 145:35]
  wire [1:0] idex_stage_reset_alu_result_src = tc_io_idex_clear ? 2'h0 : _GEN_36; // @[rpu_core.scala 231:27 rpu_core.scala 145:35]
  reg [31:0] ts; // @[rpu_core.scala 289:19]
  wire  _data_stall_T_2 = decoder_io_rs1 == idex_stage_regs_reg_write_addr; // @[rpu_core.scala 300:35]
  wire  _data_stall_T_3 = idex_stage_regs_reg_write & idex_stage_regs_reg_write_addr != 5'h0 & _data_stall_T_2; // @[rpu_core.scala 299:86]
  wire  _data_stall_T_4 = decoder_io_rs2 == idex_stage_regs_reg_write_addr; // @[rpu_core.scala 301:35]
  wire  _data_stall_T_5 = _data_stall_T_3 | _data_stall_T_4; // @[rpu_core.scala 300:71]
  wire  _data_stall_T_6 = decoder_io_rs3 == idex_stage_regs_reg_write_addr; // @[rpu_core.scala 302:35]
  wire  _data_stall_T_7 = _data_stall_T_5 | _data_stall_T_6; // @[rpu_core.scala 301:71]
  wire  _data_stall_T_10 = decoder_io_rs1 == exmm_stage_regs_reg_write_addr; // @[rpu_core.scala 304:35]
  wire  _data_stall_T_11 = exmm_stage_regs_reg_write & exmm_stage_regs_reg_write_addr != 5'h0 & _data_stall_T_10; // @[rpu_core.scala 303:86]
  wire  _data_stall_T_12 = decoder_io_rs2 == exmm_stage_regs_reg_write_addr; // @[rpu_core.scala 305:35]
  wire  _data_stall_T_13 = _data_stall_T_11 | _data_stall_T_12; // @[rpu_core.scala 304:71]
  wire  _data_stall_T_14 = decoder_io_rs3 == exmm_stage_regs_reg_write_addr; // @[rpu_core.scala 306:35]
  wire  _data_stall_T_15 = _data_stall_T_13 | _data_stall_T_14; // @[rpu_core.scala 305:71]
  wire  _data_stall_T_16 = _data_stall_T_7 | _data_stall_T_15; // @[rpu_core.scala 302:72]
  wire  _data_stall_T_19 = decoder_io_rs1 == mmwb_stage_regs_reg_write_addr; // @[rpu_core.scala 308:35]
  wire  _data_stall_T_20 = mmwb_stage_regs_reg_write & mmwb_stage_regs_reg_write_addr != 5'h0 & _data_stall_T_19; // @[rpu_core.scala 307:86]
  wire  _data_stall_T_21 = decoder_io_rs2 == mmwb_stage_regs_reg_write_addr; // @[rpu_core.scala 309:35]
  wire  _data_stall_T_22 = _data_stall_T_20 | _data_stall_T_21; // @[rpu_core.scala 308:71]
  wire  _data_stall_T_23 = decoder_io_rs3 == mmwb_stage_regs_reg_write_addr; // @[rpu_core.scala 310:35]
  wire  _data_stall_T_24 = _data_stall_T_22 | _data_stall_T_23; // @[rpu_core.scala 309:71]
  wire  _T_7 = 2'h0 == idex_stage_regs_alu_result_src; // @[Conditional.scala 37:30]
  wire  _T_10 = 2'h1 == idex_stage_regs_alu_result_src; // @[Conditional.scala 37:30]
  wire  _T_13 = 2'h2 == idex_stage_regs_alu_result_src; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_76 = _T_13 ? tu_io_ti : exmm_stage_regs_alu_result; // @[Conditional.scala 39:67 rpu_core.scala 337:36 rpu_core.scala 165:32]
  wire [31:0] _GEN_77 = _T_10 ? ts : _GEN_76; // @[Conditional.scala 39:67 rpu_core.scala 334:36]
  wire  _T_17 = 4'h6 == exmm_stage_regs_mem_op; // @[Conditional.scala 37:30]
  wire [29:0] io_data_addr_hi = exmm_stage_regs_alu_result[31:2]; // @[rpu_core.scala 364:55]
  wire [31:0] _io_data_addr_T = {io_data_addr_hi,2'h0}; // @[Cat.scala 30:58]
  wire [6:0] _io_data_be_T_1 = 7'h1 << exmm_stage_regs_alu_result[1:0]; // @[rpu_core.scala 365:32]
  wire  _T_20 = 4'h7 == exmm_stage_regs_mem_op; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_98 = exmm_stage_regs_alu_result[1] ? 4'hc : 4'h3; // @[rpu_core.scala 369:46 rpu_core.scala 370:22 rpu_core.scala 372:22]
  wire  _T_24 = 4'h8 == exmm_stage_regs_mem_op; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_99 = _T_24 ? _io_data_addr_T : 32'h0; // @[Conditional.scala 39:67 rpu_core.scala 376:22 rpu_core.scala 360:18]
  wire [3:0] _GEN_100 = _T_24 ? 4'hf : 4'h0; // @[Conditional.scala 39:67 rpu_core.scala 377:20 rpu_core.scala 361:16]
  wire [31:0] _GEN_101 = _T_20 ? _io_data_addr_T : _GEN_99; // @[Conditional.scala 39:67 rpu_core.scala 368:22]
  wire [3:0] _GEN_102 = _T_20 ? _GEN_98 : _GEN_100; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_103 = _T_17 ? _io_data_addr_T : _GEN_101; // @[Conditional.scala 40:58 rpu_core.scala 364:22]
  wire [6:0] _GEN_104 = _T_17 ? _io_data_be_T_1 : {{3'd0}, _GEN_102}; // @[Conditional.scala 40:58 rpu_core.scala 365:20]
  wire [6:0] _GEN_108 = exmm_stage_regs_mem_write ? _GEN_104 : 7'h0; // @[rpu_core.scala 357:36 rpu_core.scala 383:16]
  wire  _T_27 = 4'h1 == exmm_stage_regs_mem_op; // @[Conditional.scala 37:30]
  wire [23:0] mmwb_stage_regs_mem_result_hi = io_data_rdata[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [7:0] mmwb_stage_regs_mem_result_lo = io_data_rdata[7:0]; // @[rpu_core.scala 396:84]
  wire [31:0] _mmwb_stage_regs_mem_result_T_2 = {mmwb_stage_regs_mem_result_hi,mmwb_stage_regs_mem_result_lo}; // @[Cat.scala 30:58]
  wire  _T_30 = 4'h4 == exmm_stage_regs_mem_op; // @[Conditional.scala 37:30]
  wire [31:0] _mmwb_stage_regs_mem_result_T_3 = {24'h0,mmwb_stage_regs_mem_result_lo}; // @[Cat.scala 30:58]
  wire  _T_33 = 4'h2 == exmm_stage_regs_mem_op; // @[Conditional.scala 37:30]
  wire [15:0] mmwb_stage_regs_mem_result_hi_1 = io_data_rdata[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 72:12]
  wire [15:0] mmwb_stage_regs_mem_result_lo_2 = io_data_rdata[15:0]; // @[rpu_core.scala 402:85]
  wire [31:0] _mmwb_stage_regs_mem_result_T_6 = {mmwb_stage_regs_mem_result_hi_1,mmwb_stage_regs_mem_result_lo_2}; // @[Cat.scala 30:58]
  wire  _T_36 = 4'h5 == exmm_stage_regs_mem_op; // @[Conditional.scala 37:30]
  wire [31:0] _mmwb_stage_regs_mem_result_T_7 = {16'h0,mmwb_stage_regs_mem_result_lo_2}; // @[Cat.scala 30:58]
  wire  _T_39 = 4'h3 == exmm_stage_regs_mem_op; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_109 = _T_39 ? io_data_rdata : 32'h0; // @[Conditional.scala 39:67 rpu_core.scala 408:36 rpu_core.scala 393:32]
  wire [31:0] _GEN_110 = _T_36 ? _mmwb_stage_regs_mem_result_T_7 : _GEN_109; // @[Conditional.scala 39:67 rpu_core.scala 405:36]
  wire [31:0] _GEN_111 = _T_33 ? _mmwb_stage_regs_mem_result_T_6 : _GEN_110; // @[Conditional.scala 39:67 rpu_core.scala 402:36]
  wire [31:0] _GEN_112 = _T_30 ? _mmwb_stage_regs_mem_result_T_3 : _GEN_111; // @[Conditional.scala 39:67 rpu_core.scala 399:36]
  wire  _T_42 = 2'h0 == mmwb_stage_regs_reg_write_src; // @[Conditional.scala 37:30]
  wire  _T_45 = 2'h1 == mmwb_stage_regs_reg_write_src; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_129 = _T_45 ? mmwb_stage_regs_alu_result : mmwb_stage_regs_npc; // @[Conditional.scala 39:67 rpu_core.scala 427:25]
  wire [31:0] _GEN_130 = _T_42 ? mmwb_stage_regs_mem_result : _GEN_129; // @[Conditional.scala 40:58 rpu_core.scala 424:25]
  rpu_thread_control tc ( // @[rpu_core.scala 98:18]
    .clock(tc_clock),
    .reset(tc_reset),
    .io_data_stall(tc_io_data_stall),
    .io_control_stall(tc_io_control_stall),
    .io_tkend(tc_io_tkend),
    .io_addtk(tc_io_addtk),
    .io_time(tc_io_time),
    .io_tid(tc_io_tid),
    .io_ti(tc_io_ti),
    .io_wb_pc(tc_io_wb_pc),
    .io_pc_we(tc_io_pc_we),
    .io_ifid_clear(tc_io_ifid_clear),
    .io_ifid_we(tc_io_ifid_we),
    .io_idex_clear(tc_io_idex_clear),
    .io_idex_we(tc_io_idex_we),
    .io_exmm_clear(tc_io_exmm_clear),
    .io_exmm_we(tc_io_exmm_we),
    .io_mmwb_clear(tc_io_mmwb_clear),
    .io_mmwb_we(tc_io_mmwb_we),
    .io_thread_id_we(tc_io_thread_id_we),
    .io_thread_id_wdata(tc_io_thread_id_wdata)
  );
  rpu_pc_group pcg ( // @[rpu_core.scala 100:19]
    .clock(pcg_clock),
    .reset(pcg_reset),
    .io_boot_addr_0(pcg_io_boot_addr_0),
    .io_boot_addr_1(pcg_io_boot_addr_1),
    .io_boot_addr_2(pcg_io_boot_addr_2),
    .io_boot_addr_3(pcg_io_boot_addr_3),
    .io_thread_id_we(pcg_io_thread_id_we),
    .io_thread_id_wdata(pcg_io_thread_id_wdata),
    .io_npc_we(pcg_io_npc_we),
    .io_npc_wdata(pcg_io_npc_wdata),
    .io_pc(pcg_io_pc)
  );
  rpu_register_file_group regg ( // @[rpu_core.scala 102:20]
    .clock(regg_clock),
    .io_thread_id_we(regg_io_thread_id_we),
    .io_thread_id_wdata(regg_io_thread_id_wdata),
    .io_raddr_a(regg_io_raddr_a),
    .io_rdata_a(regg_io_rdata_a),
    .io_raddr_b(regg_io_raddr_b),
    .io_rdata_b(regg_io_rdata_b),
    .io_raddr_c(regg_io_raddr_c),
    .io_rdata_c(regg_io_rdata_c),
    .io_waddr_a(regg_io_waddr_a),
    .io_wdata_a(regg_io_wdata_a),
    .io_we_a(regg_io_we_a)
  );
  rpu_decoder decoder ( // @[rpu_core.scala 104:23]
    .io_ir(decoder_io_ir),
    .io_instr_type(decoder_io_instr_type),
    .io_rs1(decoder_io_rs1),
    .io_rs2(decoder_io_rs2),
    .io_rs3(decoder_io_rs3),
    .io_rd(decoder_io_rd),
    .io_imm(decoder_io_imm)
  );
  rpu_control control ( // @[rpu_core.scala 106:23]
    .io_instr_type(control_io_instr_type),
    .io_jump(control_io_jump),
    .io_branch(control_io_branch),
    .io_alu_op1_src(control_io_alu_op1_src),
    .io_alu_op2_src(control_io_alu_op2_src),
    .io_alu_op(control_io_alu_op),
    .io_alu_result_src(control_io_alu_result_src),
    .io_comp_op(control_io_comp_op),
    .io_r2_src(control_io_r2_src),
    .io_tg_we(control_io_tg_we),
    .io_ti_we(control_io_ti_we),
    .io_to(control_io_to),
    .io_addtk(control_io_addtk),
    .io_tkend(control_io_tkend),
    .io_mem_write(control_io_mem_write),
    .io_mem_op(control_io_mem_op),
    .io_reg_write(control_io_reg_write),
    .io_reg_write_src(control_io_reg_write_src)
  );
  rpu_alu alu ( // @[rpu_core.scala 108:19]
    .io_op_a(alu_io_op_a),
    .io_op_b(alu_io_op_b),
    .io_operation(alu_io_operation),
    .io_result(alu_io_result)
  );
  rpu_comp comp ( // @[rpu_core.scala 110:20]
    .io_comp_op(comp_io_comp_op),
    .io_op_a(comp_io_op_a),
    .io_op_b(comp_io_op_b),
    .io_result(comp_io_result)
  );
  rpu_time_unit tu ( // @[rpu_core.scala 112:18]
    .clock(tu_clock),
    .reset(tu_reset),
    .io_std_clk(tu_io_std_clk),
    .io_ti_we(tu_io_ti_we),
    .io_ti_wdata(tu_io_ti_wdata),
    .io_tg_we(tu_io_tg_we),
    .io_tg_wdata(tu_io_tg_wdata),
    .io_ti(tu_io_ti)
  );
  assign io_instr_addr = pcg_io_pc; // @[rpu_core.scala 211:17]
  assign io_data_we = exmm_stage_regs_mem_write; // @[rpu_core.scala 357:36 rpu_core.scala 358:16 rpu_core.scala 381:16]
  assign io_data_be = _GEN_108[3:0];
  assign io_data_addr = exmm_stage_regs_mem_write ? _GEN_103 : _io_data_addr_T; // @[rpu_core.scala 357:36 rpu_core.scala 384:18]
  assign io_data_wdata = exmm_stage_regs_mem_write ? exmm_stage_regs_r2 : 32'h0; // @[rpu_core.scala 357:36 rpu_core.scala 359:19 rpu_core.scala 382:19]
  assign tc_clock = clock;
  assign tc_reset = reset;
  assign tc_io_data_stall = _data_stall_T_16 | _data_stall_T_24; // @[rpu_core.scala 306:72]
  assign tc_io_control_stall = idex_stage_regs_jump | _T; // @[rpu_core.scala 312:41]
  assign tc_io_tkend = idex_stage_regs_tkend; // @[rpu_core.scala 319:15]
  assign tc_io_addtk = idex_stage_regs_addtk; // @[rpu_core.scala 320:15]
  assign tc_io_time = idex_stage_regs_r1; // @[rpu_core.scala 321:14]
  assign tc_io_tid = idex_stage_regs_r2; // @[rpu_core.scala 322:13]
  assign tc_io_ti = tu_io_ti; // @[rpu_core.scala 314:12]
  assign pcg_clock = clock;
  assign pcg_reset = reset;
  assign pcg_io_boot_addr_0 = io_boot_addr_0; // @[rpu_core.scala 180:20]
  assign pcg_io_boot_addr_1 = io_boot_addr_1; // @[rpu_core.scala 180:20]
  assign pcg_io_boot_addr_2 = io_boot_addr_2; // @[rpu_core.scala 180:20]
  assign pcg_io_boot_addr_3 = io_boot_addr_3; // @[rpu_core.scala 180:20]
  assign pcg_io_thread_id_we = tc_io_thread_id_we; // @[rpu_core.scala 183:23]
  assign pcg_io_thread_id_wdata = tc_io_thread_id_wdata; // @[rpu_core.scala 184:26]
  assign pcg_io_npc_we = tc_io_wb_pc | _GEN_3; // @[rpu_core.scala 189:22 rpu_core.scala 190:19]
  assign pcg_io_npc_wdata = tc_io_wb_pc ? _GEN_1 : _GEN_4; // @[rpu_core.scala 189:22]
  assign regg_clock = clock;
  assign regg_io_thread_id_we = tc_io_thread_id_we; // @[rpu_core.scala 185:24]
  assign regg_io_thread_id_wdata = tc_io_thread_id_wdata; // @[rpu_core.scala 186:27]
  assign regg_io_raddr_a = decoder_io_rs1; // @[rpu_core.scala 227:19]
  assign regg_io_raddr_b = decoder_io_rs2; // @[rpu_core.scala 228:19]
  assign regg_io_raddr_c = decoder_io_rs3; // @[rpu_core.scala 229:19]
  assign regg_io_waddr_a = mmwb_stage_regs_reg_write_addr; // @[rpu_core.scala 419:19]
  assign regg_io_wdata_a = mmwb_stage_regs_reg_write ? _GEN_130 : mmwb_stage_regs_npc; // @[rpu_core.scala 421:36 rpu_core.scala 420:19]
  assign regg_io_we_a = mmwb_stage_regs_reg_write; // @[rpu_core.scala 418:16]
  assign decoder_io_ir = ifid_stage_regs_ir; // @[rpu_core.scala 225:17]
  assign control_io_instr_type = decoder_io_instr_type; // @[rpu_core.scala 226:25]
  assign alu_io_op_a = idex_stage_regs_alu_op1_src ? idex_stage_regs_pc : idex_stage_regs_r1; // @[rpu_core.scala 271:59 rpu_core.scala 272:17 rpu_core.scala 274:17]
  assign alu_io_op_b = idex_stage_regs_alu_op2_src ? idex_stage_regs_imm : idex_stage_regs_r2; // @[rpu_core.scala 276:60 rpu_core.scala 277:17 rpu_core.scala 279:17]
  assign alu_io_operation = idex_stage_regs_alu_op; // @[rpu_core.scala 281:20]
  assign comp_io_comp_op = idex_stage_regs_comp_op; // @[rpu_core.scala 269:19]
  assign comp_io_op_a = idex_stage_regs_r1; // @[rpu_core.scala 267:16]
  assign comp_io_op_b = idex_stage_regs_r2; // @[rpu_core.scala 268:16]
  assign tu_clock = clock;
  assign tu_reset = reset;
  assign tu_io_std_clk = io_std_clk; // @[rpu_core.scala 283:17]
  assign tu_io_ti_we = idex_stage_regs_ti_we; // @[rpu_core.scala 284:15]
  assign tu_io_ti_wdata = idex_stage_regs_r1; // @[rpu_core.scala 285:18]
  assign tu_io_tg_we = idex_stage_regs_tg_we; // @[rpu_core.scala 286:15]
  assign tu_io_tg_wdata = idex_stage_regs_r1; // @[rpu_core.scala 287:18]
  always @(posedge clock) begin
    if (reset) begin // @[rpu_core.scala 120:32]
      ifid_stage_regs_valid <= 1'h0; // @[rpu_core.scala 120:32]
    end else if (tc_io_ifid_clear) begin // @[rpu_core.scala 213:27]
      ifid_stage_regs_valid <= 1'h0; // @[rpu_core.scala 214:21]
    end else begin
      ifid_stage_regs_valid <= _GEN_7;
    end
    if (reset) begin // @[rpu_core.scala 120:32]
      ifid_stage_regs_pc <= 32'h0; // @[rpu_core.scala 120:32]
    end else if (tc_io_ifid_clear) begin // @[rpu_core.scala 213:27]
      ifid_stage_regs_pc <= 32'h0; // @[rpu_core.scala 214:21]
    end else if (tc_io_ifid_we) begin // @[rpu_core.scala 215:31]
      ifid_stage_regs_pc <= pcg_io_pc; // @[rpu_core.scala 217:24]
    end
    if (reset) begin // @[rpu_core.scala 120:32]
      ifid_stage_regs_npc <= 32'h0; // @[rpu_core.scala 120:32]
    end else if (tc_io_ifid_clear) begin // @[rpu_core.scala 213:27]
      ifid_stage_regs_npc <= 32'h0; // @[rpu_core.scala 214:21]
    end else if (tc_io_ifid_we) begin // @[rpu_core.scala 215:31]
      ifid_stage_regs_npc <= _pcg_io_npc_wdata_T_1; // @[rpu_core.scala 218:25]
    end
    if (reset) begin // @[rpu_core.scala 120:32]
      ifid_stage_regs_ir <= 32'h0; // @[rpu_core.scala 120:32]
    end else if (tc_io_ifid_clear) begin // @[rpu_core.scala 213:27]
      ifid_stage_regs_ir <= 32'h0; // @[rpu_core.scala 214:21]
    end else if (tc_io_ifid_we) begin // @[rpu_core.scala 215:31]
      ifid_stage_regs_ir <= io_instr_data; // @[rpu_core.scala 219:24]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_valid <= 1'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_valid <= 1'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_valid <= ifid_stage_regs_valid; // @[rpu_core.scala 234:27]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_pc <= 32'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_pc <= 32'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_pc <= ifid_stage_regs_pc; // @[rpu_core.scala 235:24]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_npc <= 32'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_npc <= 32'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_npc <= ifid_stage_regs_npc; // @[rpu_core.scala 236:25]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_r1 <= 32'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_r1 <= 32'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_r1 <= regg_io_rdata_a; // @[rpu_core.scala 237:24]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_r2 <= 32'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_r2 <= 32'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_r2 <= regg_io_rdata_b; // @[rpu_core.scala 238:24]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_r3 <= 32'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_r3 <= 32'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_r3 <= regg_io_rdata_c; // @[rpu_core.scala 239:24]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_imm <= 32'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_imm <= 32'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_imm <= decoder_io_imm; // @[rpu_core.scala 240:25]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_reg_write <= 1'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_reg_write <= 1'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_reg_write <= control_io_reg_write; // @[rpu_core.scala 244:31]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_reg_write_src <= 2'h1; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_reg_write_src <= 2'h1; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_reg_write_src <= control_io_reg_write_src; // @[rpu_core.scala 245:35]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_reg_write_addr <= 5'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_reg_write_addr <= 5'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_reg_write_addr <= decoder_io_rd; // @[rpu_core.scala 246:36]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_mem_write <= 1'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_mem_write <= 1'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_mem_write <= control_io_mem_write; // @[rpu_core.scala 247:31]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_mem_op <= 4'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_mem_op <= 4'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_mem_op <= control_io_mem_op; // @[rpu_core.scala 248:28]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_jump <= 1'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_jump <= 1'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_jump <= control_io_jump; // @[rpu_core.scala 249:26]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_branch <= 1'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_branch <= 1'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_branch <= control_io_branch; // @[rpu_core.scala 250:28]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_alu_op1_src <= 1'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_alu_op1_src <= 1'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_alu_op1_src <= control_io_alu_op1_src; // @[rpu_core.scala 251:33]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_alu_op2_src <= 1'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_alu_op2_src <= 1'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_alu_op2_src <= control_io_alu_op2_src; // @[rpu_core.scala 252:33]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_alu_op <= 4'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_alu_op <= 4'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_alu_op <= control_io_alu_op; // @[rpu_core.scala 253:28]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_comp_op <= 3'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_comp_op <= 3'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_comp_op <= control_io_comp_op; // @[rpu_core.scala 254:29]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_alu_result_src <= idex_stage_reset_alu_result_src; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_alu_result_src <= idex_stage_reset_alu_result_src; // @[rpu_core.scala 232:21]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_r2_src <= 1'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_r2_src <= 1'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_r2_src <= control_io_r2_src; // @[rpu_core.scala 256:28]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_tg_we <= 1'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_tg_we <= 1'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_tg_we <= control_io_tg_we; // @[rpu_core.scala 257:27]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_ti_we <= 1'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_ti_we <= 1'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_ti_we <= control_io_ti_we; // @[rpu_core.scala 258:27]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_to <= 1'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_to <= 1'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_to <= control_io_to; // @[rpu_core.scala 259:24]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_addtk <= 1'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_addtk <= 1'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_addtk <= control_io_addtk; // @[rpu_core.scala 260:27]
    end
    if (reset) begin // @[rpu_core.scala 152:32]
      idex_stage_regs_tkend <= 1'h0; // @[rpu_core.scala 152:32]
    end else if (tc_io_idex_clear) begin // @[rpu_core.scala 231:27]
      idex_stage_regs_tkend <= 1'h0; // @[rpu_core.scala 232:21]
    end else if (tc_io_idex_we) begin // @[rpu_core.scala 233:31]
      idex_stage_regs_tkend <= control_io_tkend; // @[rpu_core.scala 261:27]
    end
    if (reset) begin // @[rpu_core.scala 165:32]
      exmm_stage_regs_npc <= 32'h0; // @[rpu_core.scala 165:32]
    end else if (tc_io_exmm_clear) begin // @[rpu_core.scala 324:27]
      exmm_stage_regs_npc <= 32'h0; // @[rpu_core.scala 325:21]
    end else if (tc_io_exmm_we) begin // @[rpu_core.scala 326:31]
      exmm_stage_regs_npc <= idex_stage_regs_npc; // @[rpu_core.scala 328:25]
    end
    if (reset) begin // @[rpu_core.scala 165:32]
      exmm_stage_regs_alu_result <= 32'h0; // @[rpu_core.scala 165:32]
    end else if (tc_io_exmm_clear) begin // @[rpu_core.scala 324:27]
      exmm_stage_regs_alu_result <= 32'h0; // @[rpu_core.scala 325:21]
    end else if (tc_io_exmm_we) begin // @[rpu_core.scala 326:31]
      if (_T_7) begin // @[Conditional.scala 40:58]
        exmm_stage_regs_alu_result <= alu_io_result; // @[rpu_core.scala 331:36]
      end else begin
        exmm_stage_regs_alu_result <= _GEN_77;
      end
    end
    if (reset) begin // @[rpu_core.scala 165:32]
      exmm_stage_regs_r2 <= 32'h0; // @[rpu_core.scala 165:32]
    end else if (tc_io_exmm_clear) begin // @[rpu_core.scala 324:27]
      exmm_stage_regs_r2 <= 32'h0; // @[rpu_core.scala 325:21]
    end else if (tc_io_exmm_we) begin // @[rpu_core.scala 326:31]
      if (idex_stage_regs_r2_src) begin // @[rpu_core.scala 340:51]
        exmm_stage_regs_r2 <= idex_stage_regs_r3; // @[rpu_core.scala 341:26]
      end else begin
        exmm_stage_regs_r2 <= idex_stage_regs_r2; // @[rpu_core.scala 343:26]
      end
    end
    if (reset) begin // @[rpu_core.scala 165:32]
      exmm_stage_regs_mem_write <= 1'h0; // @[rpu_core.scala 165:32]
    end else if (tc_io_exmm_clear) begin // @[rpu_core.scala 324:27]
      exmm_stage_regs_mem_write <= 1'h0; // @[rpu_core.scala 325:21]
    end else if (tc_io_exmm_we) begin // @[rpu_core.scala 326:31]
      exmm_stage_regs_mem_write <= idex_stage_regs_mem_write; // @[rpu_core.scala 345:31]
    end
    if (reset) begin // @[rpu_core.scala 165:32]
      exmm_stage_regs_mem_op <= 4'h0; // @[rpu_core.scala 165:32]
    end else if (tc_io_exmm_clear) begin // @[rpu_core.scala 324:27]
      exmm_stage_regs_mem_op <= 4'h0; // @[rpu_core.scala 325:21]
    end else if (tc_io_exmm_we) begin // @[rpu_core.scala 326:31]
      exmm_stage_regs_mem_op <= idex_stage_regs_mem_op; // @[rpu_core.scala 346:28]
    end
    if (reset) begin // @[rpu_core.scala 165:32]
      exmm_stage_regs_reg_write <= 1'h0; // @[rpu_core.scala 165:32]
    end else if (tc_io_exmm_clear) begin // @[rpu_core.scala 324:27]
      exmm_stage_regs_reg_write <= 1'h0; // @[rpu_core.scala 325:21]
    end else if (tc_io_exmm_we) begin // @[rpu_core.scala 326:31]
      exmm_stage_regs_reg_write <= idex_stage_regs_reg_write; // @[rpu_core.scala 347:31]
    end
    if (reset) begin // @[rpu_core.scala 165:32]
      exmm_stage_regs_reg_write_src <= 2'h1; // @[rpu_core.scala 165:32]
    end else if (tc_io_exmm_clear) begin // @[rpu_core.scala 324:27]
      exmm_stage_regs_reg_write_src <= 2'h1; // @[rpu_core.scala 325:21]
    end else if (tc_io_exmm_we) begin // @[rpu_core.scala 326:31]
      exmm_stage_regs_reg_write_src <= idex_stage_regs_reg_write_src; // @[rpu_core.scala 348:35]
    end
    if (reset) begin // @[rpu_core.scala 165:32]
      exmm_stage_regs_reg_write_addr <= 5'h0; // @[rpu_core.scala 165:32]
    end else if (tc_io_exmm_clear) begin // @[rpu_core.scala 324:27]
      exmm_stage_regs_reg_write_addr <= 5'h0; // @[rpu_core.scala 325:21]
    end else if (tc_io_exmm_we) begin // @[rpu_core.scala 326:31]
      exmm_stage_regs_reg_write_addr <= idex_stage_regs_reg_write_addr; // @[rpu_core.scala 349:36]
    end
    if (reset) begin // @[rpu_core.scala 176:32]
      mmwb_stage_regs_npc <= 32'h0; // @[rpu_core.scala 176:32]
    end else if (tc_io_mmwb_clear) begin // @[rpu_core.scala 387:27]
      mmwb_stage_regs_npc <= 32'h0; // @[rpu_core.scala 388:21]
    end else if (tc_io_mmwb_we) begin // @[rpu_core.scala 389:31]
      mmwb_stage_regs_npc <= exmm_stage_regs_npc; // @[rpu_core.scala 391:25]
    end
    if (reset) begin // @[rpu_core.scala 176:32]
      mmwb_stage_regs_alu_result <= 32'h0; // @[rpu_core.scala 176:32]
    end else if (tc_io_mmwb_clear) begin // @[rpu_core.scala 387:27]
      mmwb_stage_regs_alu_result <= 32'h0; // @[rpu_core.scala 388:21]
    end else if (tc_io_mmwb_we) begin // @[rpu_core.scala 389:31]
      mmwb_stage_regs_alu_result <= exmm_stage_regs_alu_result; // @[rpu_core.scala 392:32]
    end
    if (reset) begin // @[rpu_core.scala 176:32]
      mmwb_stage_regs_mem_result <= 32'h0; // @[rpu_core.scala 176:32]
    end else if (tc_io_mmwb_clear) begin // @[rpu_core.scala 387:27]
      mmwb_stage_regs_mem_result <= 32'h0; // @[rpu_core.scala 388:21]
    end else if (tc_io_mmwb_we) begin // @[rpu_core.scala 389:31]
      if (_T_27) begin // @[Conditional.scala 40:58]
        mmwb_stage_regs_mem_result <= _mmwb_stage_regs_mem_result_T_2; // @[rpu_core.scala 396:36]
      end else begin
        mmwb_stage_regs_mem_result <= _GEN_112;
      end
    end
    if (reset) begin // @[rpu_core.scala 176:32]
      mmwb_stage_regs_reg_write <= 1'h0; // @[rpu_core.scala 176:32]
    end else if (tc_io_mmwb_clear) begin // @[rpu_core.scala 387:27]
      mmwb_stage_regs_reg_write <= 1'h0; // @[rpu_core.scala 388:21]
    end else if (tc_io_mmwb_we) begin // @[rpu_core.scala 389:31]
      mmwb_stage_regs_reg_write <= exmm_stage_regs_reg_write; // @[rpu_core.scala 411:31]
    end
    if (reset) begin // @[rpu_core.scala 176:32]
      mmwb_stage_regs_reg_write_src <= 2'h1; // @[rpu_core.scala 176:32]
    end else if (tc_io_mmwb_clear) begin // @[rpu_core.scala 387:27]
      mmwb_stage_regs_reg_write_src <= 2'h1; // @[rpu_core.scala 388:21]
    end else if (tc_io_mmwb_we) begin // @[rpu_core.scala 389:31]
      mmwb_stage_regs_reg_write_src <= exmm_stage_regs_reg_write_src; // @[rpu_core.scala 412:35]
    end
    if (reset) begin // @[rpu_core.scala 176:32]
      mmwb_stage_regs_reg_write_addr <= 5'h0; // @[rpu_core.scala 176:32]
    end else if (tc_io_mmwb_clear) begin // @[rpu_core.scala 387:27]
      mmwb_stage_regs_reg_write_addr <= 5'h0; // @[rpu_core.scala 388:21]
    end else if (tc_io_mmwb_we) begin // @[rpu_core.scala 389:31]
      mmwb_stage_regs_reg_write_addr <= exmm_stage_regs_reg_write_addr; // @[rpu_core.scala 413:36]
    end
    if (reset) begin // @[rpu_core.scala 289:19]
      ts <= 32'h0; // @[rpu_core.scala 289:19]
    end else if (idex_stage_regs_to & tc_io_exmm_we) begin // @[rpu_core.scala 290:46]
      ts <= tu_io_ti; // @[rpu_core.scala 291:8]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ifid_stage_regs_valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  ifid_stage_regs_pc = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  ifid_stage_regs_npc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  ifid_stage_regs_ir = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  idex_stage_regs_valid = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  idex_stage_regs_pc = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  idex_stage_regs_npc = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  idex_stage_regs_r1 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  idex_stage_regs_r2 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  idex_stage_regs_r3 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  idex_stage_regs_imm = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  idex_stage_regs_reg_write = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  idex_stage_regs_reg_write_src = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  idex_stage_regs_reg_write_addr = _RAND_13[4:0];
  _RAND_14 = {1{`RANDOM}};
  idex_stage_regs_mem_write = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  idex_stage_regs_mem_op = _RAND_15[3:0];
  _RAND_16 = {1{`RANDOM}};
  idex_stage_regs_jump = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  idex_stage_regs_branch = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  idex_stage_regs_alu_op1_src = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  idex_stage_regs_alu_op2_src = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  idex_stage_regs_alu_op = _RAND_20[3:0];
  _RAND_21 = {1{`RANDOM}};
  idex_stage_regs_comp_op = _RAND_21[2:0];
  _RAND_22 = {1{`RANDOM}};
  idex_stage_regs_alu_result_src = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  idex_stage_regs_r2_src = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  idex_stage_regs_tg_we = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  idex_stage_regs_ti_we = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  idex_stage_regs_to = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  idex_stage_regs_addtk = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  idex_stage_regs_tkend = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  exmm_stage_regs_npc = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  exmm_stage_regs_alu_result = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  exmm_stage_regs_r2 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  exmm_stage_regs_mem_write = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  exmm_stage_regs_mem_op = _RAND_33[3:0];
  _RAND_34 = {1{`RANDOM}};
  exmm_stage_regs_reg_write = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  exmm_stage_regs_reg_write_src = _RAND_35[1:0];
  _RAND_36 = {1{`RANDOM}};
  exmm_stage_regs_reg_write_addr = _RAND_36[4:0];
  _RAND_37 = {1{`RANDOM}};
  mmwb_stage_regs_npc = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  mmwb_stage_regs_alu_result = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  mmwb_stage_regs_mem_result = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  mmwb_stage_regs_reg_write = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  mmwb_stage_regs_reg_write_src = _RAND_41[1:0];
  _RAND_42 = {1{`RANDOM}};
  mmwb_stage_regs_reg_write_addr = _RAND_42[4:0];
  _RAND_43 = {1{`RANDOM}};
  ts = _RAND_43[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
