//a Note: created by CDL 1.4 - do not hand edit without recognizing it will be out of sync with the source
// Output mode 0 (VMOD=1, standard verilog=0)
// Verilog option comb reg suffix '__var'
// Verilog option include_displays 0
// Verilog option include_assertions 1
// Verilog option sv_assertions 0
// Verilog option assert delay string '<NULL>'
// Verilog option include_coverage 0
// Verilog option clock_gate_module_instance_type 'banana'
// Verilog option clock_gate_module_instance_extra_ports ''
// Verilog option use_always_at_star 1
// Verilog option clocks_must_have_enables 1

//a Module riscv_i32_minimal
    //   
    //   An instantiation of the single stage pipeline RISC-V with RV32I with a single SRAM
    //   
    //   Compressed instructions are supported IF i32c_force_disable is 0 and riscv_config.i32c is 1
    //   
    //   A single memory is used for instruction and data, at address 0
    //   
    //   Any access outside of the bottom 1MB is passed as a request out of this module.
    //   
module riscv_i32_minimal
(
    clk,
    clk__enable,

    riscv_config__i32c,
    riscv_config__e32,
    riscv_config__i32m,
    riscv_config__i32m_fuse,
    riscv_config__debug_enable,
    riscv_config__coproc_disable,
    riscv_config__unaligned_mem,
    debug_mst__valid,
    debug_mst__select,
    debug_mst__mask,
    debug_mst__op,
    debug_mst__arg,
    debug_mst__data,
    sram_access_req__valid,
    sram_access_req__id,
    sram_access_req__read_not_write,
    sram_access_req__byte_enable,
    sram_access_req__address,
    sram_access_req__write_data,
    data_access_resp__wait,
    data_access_resp__read_data,
    irqs__nmi,
    irqs__meip,
    irqs__seip,
    irqs__ueip,
    irqs__mtip,
    irqs__msip,
    irqs__time,
    proc_reset_n,
    reset_n,

    sram_access_resp__ack,
    sram_access_resp__valid,
    sram_access_resp__id,
    sram_access_resp__data,
    data_access_req__address,
    data_access_req__byte_enable,
    data_access_req__write_enable,
    data_access_req__read_enable,
    data_access_req__write_data,
    trace__instr_valid,
    trace__instr_pc,
    trace__instruction__data,
    trace__instruction__debug__valid,
    trace__instruction__debug__debug_op,
    trace__instruction__debug__data,
    trace__rfw_retire,
    trace__rfw_data_valid,
    trace__rfw_rd,
    trace__rfw_data,
    trace__branch_taken,
    trace__branch_target,
    trace__trap,
    debug_tgt__valid,
    debug_tgt__selected,
    debug_tgt__halted,
    debug_tgt__resumed,
    debug_tgt__hit_breakpoint,
    debug_tgt__op_was_none,
    debug_tgt__resp,
    debug_tgt__data,
    debug_tgt__attention
);

    //b Clocks
    input clk;
    input clk__enable;
    wire riscv_clk; // Gated version of clock 'clk' enabled by 'riscv_clk_enable'
    wire riscv_clk__enable;

    //b Inputs
    input riscv_config__i32c;
    input riscv_config__e32;
    input riscv_config__i32m;
    input riscv_config__i32m_fuse;
    input riscv_config__debug_enable;
    input riscv_config__coproc_disable;
    input riscv_config__unaligned_mem;
    input debug_mst__valid;
    input [5:0]debug_mst__select;
    input [5:0]debug_mst__mask;
    input [3:0]debug_mst__op;
    input [15:0]debug_mst__arg;
    input [31:0]debug_mst__data;
    input sram_access_req__valid;
    input [3:0]sram_access_req__id;
    input sram_access_req__read_not_write;
    input [7:0]sram_access_req__byte_enable;
    input [31:0]sram_access_req__address;
    input [63:0]sram_access_req__write_data;
    input data_access_resp__wait;
    input [31:0]data_access_resp__read_data;
        //   Interrupts in to the CPU
    input irqs__nmi;
    input irqs__meip;
    input irqs__seip;
    input irqs__ueip;
    input irqs__mtip;
    input irqs__msip;
    input [63:0]irqs__time;
    input proc_reset_n;
    input reset_n;

    //b Outputs
    output sram_access_resp__ack;
    output sram_access_resp__valid;
    output [3:0]sram_access_resp__id;
    output [63:0]sram_access_resp__data;
    output [31:0]data_access_req__address;
    output [3:0]data_access_req__byte_enable;
    output data_access_req__write_enable;
    output data_access_req__read_enable;
    output [31:0]data_access_req__write_data;
    output trace__instr_valid;
    output [31:0]trace__instr_pc;
    output [31:0]trace__instruction__data;
    output trace__instruction__debug__valid;
    output [1:0]trace__instruction__debug__debug_op;
    output [15:0]trace__instruction__debug__data;
    output trace__rfw_retire;
    output trace__rfw_data_valid;
    output [4:0]trace__rfw_rd;
    output [31:0]trace__rfw_data;
    output trace__branch_taken;
    output [31:0]trace__branch_target;
    output trace__trap;
    output debug_tgt__valid;
    output [5:0]debug_tgt__selected;
    output debug_tgt__halted;
    output debug_tgt__resumed;
    output debug_tgt__hit_breakpoint;
    output debug_tgt__op_was_none;
    output [1:0]debug_tgt__resp;
    output [31:0]debug_tgt__data;
    output debug_tgt__attention;

// output components here

    //b Output combinatorials
    reg trace__instr_valid;
    reg [31:0]trace__instr_pc;
    reg [31:0]trace__instruction__data;
    reg trace__instruction__debug__valid;
    reg [1:0]trace__instruction__debug__debug_op;
    reg [15:0]trace__instruction__debug__data;
    reg trace__rfw_retire;
    reg trace__rfw_data_valid;
    reg [4:0]trace__rfw_rd;
    reg [31:0]trace__rfw_data;
    reg trace__branch_taken;
    reg [31:0]trace__branch_target;
    reg trace__trap;

    //b Output nets
    wire debug_tgt__valid;
    wire [5:0]debug_tgt__selected;
    wire debug_tgt__halted;
    wire debug_tgt__resumed;
    wire debug_tgt__hit_breakpoint;
    wire debug_tgt__op_was_none;
    wire [1:0]debug_tgt__resp;
    wire [31:0]debug_tgt__data;
    wire debug_tgt__attention;

    //b Internal and output registers
    reg riscv_clk_high;
    reg [2:0]riscv_clock_phase;
    reg sram_access_req_r__valid;
    reg [3:0]sram_access_req_r__id;
    reg sram_access_req_r__read_not_write;
    reg [7:0]sram_access_req_r__byte_enable;
    reg [31:0]sram_access_req_r__address;
    reg [63:0]sram_access_req_r__write_data;
        //   Only used if RV32IC is enabled and configured
    reg [31:0]data_access_read_reg;
        //   Only used if RV32IC is enabled and configured
    reg [15:0]ifetch_last16_reg;
    reg [31:0]ifetch_reg;
    reg riscv_config_pipe__i32c;
    reg riscv_config_pipe__e32;
    reg riscv_config_pipe__i32m;
    reg riscv_config_pipe__i32m_fuse;
    reg riscv_config_pipe__debug_enable;
    reg riscv_config_pipe__coproc_disable;
    reg riscv_config_pipe__unaligned_mem;
    reg sram_access_resp__ack;
    reg sram_access_resp__valid;
    reg [3:0]sram_access_resp__id;
    reg [63:0]sram_access_resp__data;
    reg [31:0]data_access_req__address;
    reg [3:0]data_access_req__byte_enable;
    reg data_access_req__write_enable;
    reg data_access_req__read_enable;
    reg [31:0]data_access_req__write_data;

    //b Internal combinatorials
    reg [2:0]riscv_clock_action;
    reg riscv_clk_enable;
    reg sram_access_ack;
    reg [1:0]data_src;
    reg [1:0]ifetch_src;
    reg [31:0]mem_access_req__address;
    reg [3:0]mem_access_req__byte_enable;
    reg mem_access_req__write_enable;
    reg mem_access_req__read_enable;
    reg [31:0]mem_access_req__write_data;
        //   Asserted if either data_access read or write and the response wait is asserted
    reg data_access_wait;
        //   Asserted if either data_access read or write and the response wait is deasserted
    reg data_access_completing;
    reg [31:0]data_sram_access_req__address;
    reg [3:0]data_sram_access_req__byte_enable;
    reg data_sram_access_req__write_enable;
    reg data_sram_access_req__read_enable;
    reg [31:0]data_sram_access_req__write_data;
    reg dmem_access_resp__wait;
    reg [31:0]dmem_access_resp__read_data;
    reg coproc_response__cannot_start;
    reg [31:0]coproc_response__result;
    reg coproc_response__result_valid;
    reg coproc_response__cannot_complete;
    reg ifetch_resp__valid;
    reg ifetch_resp__debug;
    reg [31:0]ifetch_resp__data;
    reg [2:0]ifetch_resp__mode;
    reg ifetch_resp__error;
    reg [1:0]ifetch_resp__tag;

    //b Internal nets
    wire [31:0]mem_read_data;
    wire [63:0]csrs__cycles;
    wire [63:0]csrs__instret;
    wire [63:0]csrs__time;
    wire [31:0]csrs__mscratch;
    wire [31:0]csrs__mepc;
    wire [31:0]csrs__mcause;
    wire [31:0]csrs__mtval;
    wire [29:0]csrs__mtvec__base;
    wire csrs__mtvec__vectored;
    wire csrs__mstatus__sd;
    wire csrs__mstatus__tsr;
    wire csrs__mstatus__tw;
    wire csrs__mstatus__tvm;
    wire csrs__mstatus__mxr;
    wire csrs__mstatus__sum;
    wire csrs__mstatus__mprv;
    wire [1:0]csrs__mstatus__xs;
    wire [1:0]csrs__mstatus__fs;
    wire [1:0]csrs__mstatus__mpp;
    wire csrs__mstatus__spp;
    wire csrs__mstatus__mpie;
    wire csrs__mstatus__spie;
    wire csrs__mstatus__upie;
    wire csrs__mstatus__mie;
    wire csrs__mstatus__sie;
    wire csrs__mstatus__uie;
    wire csrs__mip__meip;
    wire csrs__mip__seip;
    wire csrs__mip__ueip;
    wire csrs__mip__seip_sw;
    wire csrs__mip__ueip_sw;
    wire csrs__mip__mtip;
    wire csrs__mip__stip;
    wire csrs__mip__utip;
    wire csrs__mip__msip;
    wire csrs__mip__ssip;
    wire csrs__mip__usip;
    wire csrs__mie__meip;
    wire csrs__mie__seip;
    wire csrs__mie__ueip;
    wire csrs__mie__mtip;
    wire csrs__mie__stip;
    wire csrs__mie__utip;
    wire csrs__mie__msip;
    wire csrs__mie__ssip;
    wire csrs__mie__usip;
    wire [3:0]csrs__dcsr__xdebug_ver;
    wire csrs__dcsr__ebreakm;
    wire csrs__dcsr__ebreaks;
    wire csrs__dcsr__ebreaku;
    wire csrs__dcsr__stepie;
    wire csrs__dcsr__stopcount;
    wire csrs__dcsr__stoptime;
    wire [2:0]csrs__dcsr__cause;
    wire csrs__dcsr__mprven;
    wire csrs__dcsr__nmip;
    wire csrs__dcsr__step;
    wire [1:0]csrs__dcsr__prv;
    wire [31:0]csrs__depc;
    wire [31:0]csrs__dscratch0;
    wire [31:0]csrs__dscratch1;
    wire pipeline_fetch_data__valid;
    wire [31:0]pipeline_fetch_data__pc;
    wire [31:0]pipeline_fetch_data__instruction__data;
    wire pipeline_fetch_data__instruction__debug__valid;
    wire [1:0]pipeline_fetch_data__instruction__debug__debug_op;
    wire [15:0]pipeline_fetch_data__instruction__debug__data;
    wire pipeline_fetch_data__dec_flush_pipeline;
    wire pipeline_fetch_data__dec_predicted_branch;
    wire [31:0]pipeline_fetch_data__dec_pc_if_mispredicted;
    wire pipeline_response__decode__valid;
    wire pipeline_response__decode__blocked;
    wire [31:0]pipeline_response__decode__branch_target;
    wire [4:0]pipeline_response__decode__idecode__rs1;
    wire pipeline_response__decode__idecode__rs1_valid;
    wire [4:0]pipeline_response__decode__idecode__rs2;
    wire pipeline_response__decode__idecode__rs2_valid;
    wire [4:0]pipeline_response__decode__idecode__rd;
    wire pipeline_response__decode__idecode__rd_written;
    wire pipeline_response__decode__idecode__csr_access__access_cancelled;
    wire [2:0]pipeline_response__decode__idecode__csr_access__access;
    wire [11:0]pipeline_response__decode__idecode__csr_access__address;
    wire [31:0]pipeline_response__decode__idecode__csr_access__write_data;
    wire [31:0]pipeline_response__decode__idecode__immediate;
    wire [4:0]pipeline_response__decode__idecode__immediate_shift;
    wire pipeline_response__decode__idecode__immediate_valid;
    wire [3:0]pipeline_response__decode__idecode__op;
    wire [3:0]pipeline_response__decode__idecode__subop;
    wire pipeline_response__decode__idecode__requires_machine_mode;
    wire pipeline_response__decode__idecode__memory_read_unsigned;
    wire [1:0]pipeline_response__decode__idecode__memory_width;
    wire pipeline_response__decode__idecode__illegal;
    wire pipeline_response__decode__idecode__illegal_pc;
    wire pipeline_response__decode__idecode__is_compressed;
    wire pipeline_response__decode__idecode__ext__dummy;
    wire pipeline_response__decode__enable_branch_prediction;
    wire pipeline_response__exec__valid;
    wire pipeline_response__exec__cannot_start;
    wire pipeline_response__exec__cannot_complete;
    wire pipeline_response__exec__interrupt_ack;
    wire pipeline_response__exec__branch_taken;
    wire pipeline_response__exec__trap__valid;
    wire [2:0]pipeline_response__exec__trap__to_mode;
    wire [3:0]pipeline_response__exec__trap__cause;
    wire [31:0]pipeline_response__exec__trap__pc;
    wire [31:0]pipeline_response__exec__trap__value;
    wire pipeline_response__exec__trap__ret;
    wire pipeline_response__exec__trap__vector;
    wire pipeline_response__exec__trap__ebreak_to_dbg;
    wire pipeline_response__exec__is_compressed;
    wire [31:0]pipeline_response__exec__instruction__data;
    wire pipeline_response__exec__instruction__debug__valid;
    wire [1:0]pipeline_response__exec__instruction__debug__debug_op;
    wire [15:0]pipeline_response__exec__instruction__debug__data;
    wire [31:0]pipeline_response__exec__rs1;
    wire [31:0]pipeline_response__exec__rs2;
    wire [31:0]pipeline_response__exec__pc;
    wire pipeline_response__exec__predicted_branch;
    wire [31:0]pipeline_response__exec__pc_if_mispredicted;
    wire pipeline_response__rfw__valid;
    wire pipeline_response__rfw__rd_written;
    wire [4:0]pipeline_response__rfw__rd;
    wire [31:0]pipeline_response__rfw__data;
    wire pipeline_response__pipeline_empty;
    wire pipeline_control__valid;
    wire [2:0]pipeline_control__fetch_action;
    wire [31:0]pipeline_control__decode_pc;
    wire [2:0]pipeline_control__mode;
    wire pipeline_control__error;
    wire [1:0]pipeline_control__tag;
    wire pipeline_control__halt;
    wire pipeline_control__ebreak_to_dbg;
    wire pipeline_control__interrupt_req;
    wire [3:0]pipeline_control__interrupt_number;
    wire [2:0]pipeline_control__interrupt_to_mode;
    wire [31:0]pipeline_control__instruction_data;
    wire pipeline_control__instruction_debug__valid;
    wire [1:0]pipeline_control__instruction_debug__debug_op;
    wire [15:0]pipeline_control__instruction_debug__data;
    wire [31:0]dmem_access_req__address;
    wire [3:0]dmem_access_req__byte_enable;
    wire dmem_access_req__write_enable;
    wire dmem_access_req__read_enable;
    wire [31:0]dmem_access_req__write_data;
    wire csr_access__access_cancelled;
    wire [2:0]csr_access__access;
    wire [11:0]csr_access__address;
    wire [31:0]csr_access__write_data;
    wire [31:0]csr_data__read_data;
    wire csr_data__take_interrupt;
    wire [2:0]csr_data__interrupt_mode;
    wire [3:0]csr_data__interrupt_cause;
    wire csr_data__illegal_access;
    wire [2:0]csr_controls__exec_mode;
    wire csr_controls__retire;
    wire [63:0]csr_controls__timer_value;
    wire csr_controls__trap__valid;
    wire [2:0]csr_controls__trap__to_mode;
    wire [3:0]csr_controls__trap__cause;
    wire [31:0]csr_controls__trap__pc;
    wire [31:0]csr_controls__trap__value;
    wire csr_controls__trap__ret;
    wire csr_controls__trap__vector;
    wire csr_controls__trap__ebreak_to_dbg;
    wire coproc_controls__dec_idecode_valid;
    wire [4:0]coproc_controls__dec_idecode__rs1;
    wire coproc_controls__dec_idecode__rs1_valid;
    wire [4:0]coproc_controls__dec_idecode__rs2;
    wire coproc_controls__dec_idecode__rs2_valid;
    wire [4:0]coproc_controls__dec_idecode__rd;
    wire coproc_controls__dec_idecode__rd_written;
    wire coproc_controls__dec_idecode__csr_access__access_cancelled;
    wire [2:0]coproc_controls__dec_idecode__csr_access__access;
    wire [11:0]coproc_controls__dec_idecode__csr_access__address;
    wire [31:0]coproc_controls__dec_idecode__csr_access__write_data;
    wire [31:0]coproc_controls__dec_idecode__immediate;
    wire [4:0]coproc_controls__dec_idecode__immediate_shift;
    wire coproc_controls__dec_idecode__immediate_valid;
    wire [3:0]coproc_controls__dec_idecode__op;
    wire [3:0]coproc_controls__dec_idecode__subop;
    wire coproc_controls__dec_idecode__requires_machine_mode;
    wire coproc_controls__dec_idecode__memory_read_unsigned;
    wire [1:0]coproc_controls__dec_idecode__memory_width;
    wire coproc_controls__dec_idecode__illegal;
    wire coproc_controls__dec_idecode__illegal_pc;
    wire coproc_controls__dec_idecode__is_compressed;
    wire coproc_controls__dec_idecode__ext__dummy;
    wire coproc_controls__dec_to_alu_blocked;
    wire [31:0]coproc_controls__alu_rs1;
    wire [31:0]coproc_controls__alu_rs2;
    wire coproc_controls__alu_flush_pipeline;
    wire coproc_controls__alu_cannot_start;
    wire coproc_controls__alu_cannot_complete;
    wire trace_pipe__instr_valid;
    wire [31:0]trace_pipe__instr_pc;
    wire [31:0]trace_pipe__instruction__data;
    wire trace_pipe__instruction__debug__valid;
    wire [1:0]trace_pipe__instruction__debug__debug_op;
    wire [15:0]trace_pipe__instruction__debug__data;
    wire trace_pipe__rfw_retire;
    wire trace_pipe__rfw_data_valid;
    wire [4:0]trace_pipe__rfw_rd;
    wire [31:0]trace_pipe__rfw_data;
    wire trace_pipe__branch_taken;
    wire [31:0]trace_pipe__branch_target;
    wire trace_pipe__trap;
    wire ifetch_req__flush_pipeline;
    wire [2:0]ifetch_req__req_type;
    wire ifetch_req__debug_fetch;
    wire [31:0]ifetch_req__address;
    wire [2:0]ifetch_req__mode;
    wire ifetch_req__predicted_branch;
    wire [31:0]ifetch_req__pc_if_mispredicted;

    //b Clock gating module instances
    assign riscv_clk__enable = (clk__enable && riscv_clk_enable);
    //b Module instances
    se_sram_srw_16384x32_we8 mem(
        .sram_clock(clk),
        .sram_clock__enable(1'b1),
        .write_data(mem_access_req__write_data),
        .address(mem_access_req__address[15:2]),
        .write_enable(((mem_access_req__write_enable!=1'h0)?mem_access_req__byte_enable:4'h0)),
        .read_not_write(mem_access_req__read_enable),
        .select(((mem_access_req__read_enable!=1'h0)||(mem_access_req__write_enable!=1'h0))),
        .data_out(            mem_read_data)         );
    riscv_i32_pipeline_control pc(
        .clk(clk),
        .clk__enable(1'b1),
        .rv_select(6'h0),
        .debug_mst__data(debug_mst__data),
        .debug_mst__arg(debug_mst__arg),
        .debug_mst__op(debug_mst__op),
        .debug_mst__mask(debug_mst__mask),
        .debug_mst__select(debug_mst__select),
        .debug_mst__valid(debug_mst__valid),
        .trace__trap(trace_pipe__trap),
        .trace__branch_target(trace_pipe__branch_target),
        .trace__branch_taken(trace_pipe__branch_taken),
        .trace__rfw_data(trace_pipe__rfw_data),
        .trace__rfw_rd(trace_pipe__rfw_rd),
        .trace__rfw_data_valid(trace_pipe__rfw_data_valid),
        .trace__rfw_retire(trace_pipe__rfw_retire),
        .trace__instruction__debug__data(trace_pipe__instruction__debug__data),
        .trace__instruction__debug__debug_op(trace_pipe__instruction__debug__debug_op),
        .trace__instruction__debug__valid(trace_pipe__instruction__debug__valid),
        .trace__instruction__data(trace_pipe__instruction__data),
        .trace__instr_pc(trace_pipe__instr_pc),
        .trace__instr_valid(trace_pipe__instr_valid),
        .riscv_config__unaligned_mem(riscv_config_pipe__unaligned_mem),
        .riscv_config__coproc_disable(riscv_config_pipe__coproc_disable),
        .riscv_config__debug_enable(riscv_config_pipe__debug_enable),
        .riscv_config__i32m_fuse(riscv_config_pipe__i32m_fuse),
        .riscv_config__i32m(riscv_config_pipe__i32m),
        .riscv_config__e32(riscv_config_pipe__e32),
        .riscv_config__i32c(riscv_config_pipe__i32c),
        .pipeline_fetch_data__dec_pc_if_mispredicted(pipeline_fetch_data__dec_pc_if_mispredicted),
        .pipeline_fetch_data__dec_predicted_branch(pipeline_fetch_data__dec_predicted_branch),
        .pipeline_fetch_data__dec_flush_pipeline(pipeline_fetch_data__dec_flush_pipeline),
        .pipeline_fetch_data__instruction__debug__data(pipeline_fetch_data__instruction__debug__data),
        .pipeline_fetch_data__instruction__debug__debug_op(pipeline_fetch_data__instruction__debug__debug_op),
        .pipeline_fetch_data__instruction__debug__valid(pipeline_fetch_data__instruction__debug__valid),
        .pipeline_fetch_data__instruction__data(pipeline_fetch_data__instruction__data),
        .pipeline_fetch_data__pc(pipeline_fetch_data__pc),
        .pipeline_fetch_data__valid(pipeline_fetch_data__valid),
        .pipeline_response__pipeline_empty(pipeline_response__pipeline_empty),
        .pipeline_response__rfw__data(pipeline_response__rfw__data),
        .pipeline_response__rfw__rd(pipeline_response__rfw__rd),
        .pipeline_response__rfw__rd_written(pipeline_response__rfw__rd_written),
        .pipeline_response__rfw__valid(pipeline_response__rfw__valid),
        .pipeline_response__exec__pc_if_mispredicted(pipeline_response__exec__pc_if_mispredicted),
        .pipeline_response__exec__predicted_branch(pipeline_response__exec__predicted_branch),
        .pipeline_response__exec__pc(pipeline_response__exec__pc),
        .pipeline_response__exec__rs2(pipeline_response__exec__rs2),
        .pipeline_response__exec__rs1(pipeline_response__exec__rs1),
        .pipeline_response__exec__instruction__debug__data(pipeline_response__exec__instruction__debug__data),
        .pipeline_response__exec__instruction__debug__debug_op(pipeline_response__exec__instruction__debug__debug_op),
        .pipeline_response__exec__instruction__debug__valid(pipeline_response__exec__instruction__debug__valid),
        .pipeline_response__exec__instruction__data(pipeline_response__exec__instruction__data),
        .pipeline_response__exec__is_compressed(pipeline_response__exec__is_compressed),
        .pipeline_response__exec__trap__ebreak_to_dbg(pipeline_response__exec__trap__ebreak_to_dbg),
        .pipeline_response__exec__trap__vector(pipeline_response__exec__trap__vector),
        .pipeline_response__exec__trap__ret(pipeline_response__exec__trap__ret),
        .pipeline_response__exec__trap__value(pipeline_response__exec__trap__value),
        .pipeline_response__exec__trap__pc(pipeline_response__exec__trap__pc),
        .pipeline_response__exec__trap__cause(pipeline_response__exec__trap__cause),
        .pipeline_response__exec__trap__to_mode(pipeline_response__exec__trap__to_mode),
        .pipeline_response__exec__trap__valid(pipeline_response__exec__trap__valid),
        .pipeline_response__exec__branch_taken(pipeline_response__exec__branch_taken),
        .pipeline_response__exec__interrupt_ack(pipeline_response__exec__interrupt_ack),
        .pipeline_response__exec__cannot_complete(pipeline_response__exec__cannot_complete),
        .pipeline_response__exec__cannot_start(pipeline_response__exec__cannot_start),
        .pipeline_response__exec__valid(pipeline_response__exec__valid),
        .pipeline_response__decode__enable_branch_prediction(pipeline_response__decode__enable_branch_prediction),
        .pipeline_response__decode__idecode__ext__dummy(pipeline_response__decode__idecode__ext__dummy),
        .pipeline_response__decode__idecode__is_compressed(pipeline_response__decode__idecode__is_compressed),
        .pipeline_response__decode__idecode__illegal_pc(pipeline_response__decode__idecode__illegal_pc),
        .pipeline_response__decode__idecode__illegal(pipeline_response__decode__idecode__illegal),
        .pipeline_response__decode__idecode__memory_width(pipeline_response__decode__idecode__memory_width),
        .pipeline_response__decode__idecode__memory_read_unsigned(pipeline_response__decode__idecode__memory_read_unsigned),
        .pipeline_response__decode__idecode__requires_machine_mode(pipeline_response__decode__idecode__requires_machine_mode),
        .pipeline_response__decode__idecode__subop(pipeline_response__decode__idecode__subop),
        .pipeline_response__decode__idecode__op(pipeline_response__decode__idecode__op),
        .pipeline_response__decode__idecode__immediate_valid(pipeline_response__decode__idecode__immediate_valid),
        .pipeline_response__decode__idecode__immediate_shift(pipeline_response__decode__idecode__immediate_shift),
        .pipeline_response__decode__idecode__immediate(pipeline_response__decode__idecode__immediate),
        .pipeline_response__decode__idecode__csr_access__write_data(pipeline_response__decode__idecode__csr_access__write_data),
        .pipeline_response__decode__idecode__csr_access__address(pipeline_response__decode__idecode__csr_access__address),
        .pipeline_response__decode__idecode__csr_access__access(pipeline_response__decode__idecode__csr_access__access),
        .pipeline_response__decode__idecode__csr_access__access_cancelled(pipeline_response__decode__idecode__csr_access__access_cancelled),
        .pipeline_response__decode__idecode__rd_written(pipeline_response__decode__idecode__rd_written),
        .pipeline_response__decode__idecode__rd(pipeline_response__decode__idecode__rd),
        .pipeline_response__decode__idecode__rs2_valid(pipeline_response__decode__idecode__rs2_valid),
        .pipeline_response__decode__idecode__rs2(pipeline_response__decode__idecode__rs2),
        .pipeline_response__decode__idecode__rs1_valid(pipeline_response__decode__idecode__rs1_valid),
        .pipeline_response__decode__idecode__rs1(pipeline_response__decode__idecode__rs1),
        .pipeline_response__decode__branch_target(pipeline_response__decode__branch_target),
        .pipeline_response__decode__blocked(pipeline_response__decode__blocked),
        .pipeline_response__decode__valid(pipeline_response__decode__valid),
        .csrs__dscratch1(csrs__dscratch1),
        .csrs__dscratch0(csrs__dscratch0),
        .csrs__depc(csrs__depc),
        .csrs__dcsr__prv(csrs__dcsr__prv),
        .csrs__dcsr__step(csrs__dcsr__step),
        .csrs__dcsr__nmip(csrs__dcsr__nmip),
        .csrs__dcsr__mprven(csrs__dcsr__mprven),
        .csrs__dcsr__cause(csrs__dcsr__cause),
        .csrs__dcsr__stoptime(csrs__dcsr__stoptime),
        .csrs__dcsr__stopcount(csrs__dcsr__stopcount),
        .csrs__dcsr__stepie(csrs__dcsr__stepie),
        .csrs__dcsr__ebreaku(csrs__dcsr__ebreaku),
        .csrs__dcsr__ebreaks(csrs__dcsr__ebreaks),
        .csrs__dcsr__ebreakm(csrs__dcsr__ebreakm),
        .csrs__dcsr__xdebug_ver(csrs__dcsr__xdebug_ver),
        .csrs__mie__usip(csrs__mie__usip),
        .csrs__mie__ssip(csrs__mie__ssip),
        .csrs__mie__msip(csrs__mie__msip),
        .csrs__mie__utip(csrs__mie__utip),
        .csrs__mie__stip(csrs__mie__stip),
        .csrs__mie__mtip(csrs__mie__mtip),
        .csrs__mie__ueip(csrs__mie__ueip),
        .csrs__mie__seip(csrs__mie__seip),
        .csrs__mie__meip(csrs__mie__meip),
        .csrs__mip__usip(csrs__mip__usip),
        .csrs__mip__ssip(csrs__mip__ssip),
        .csrs__mip__msip(csrs__mip__msip),
        .csrs__mip__utip(csrs__mip__utip),
        .csrs__mip__stip(csrs__mip__stip),
        .csrs__mip__mtip(csrs__mip__mtip),
        .csrs__mip__ueip_sw(csrs__mip__ueip_sw),
        .csrs__mip__seip_sw(csrs__mip__seip_sw),
        .csrs__mip__ueip(csrs__mip__ueip),
        .csrs__mip__seip(csrs__mip__seip),
        .csrs__mip__meip(csrs__mip__meip),
        .csrs__mstatus__uie(csrs__mstatus__uie),
        .csrs__mstatus__sie(csrs__mstatus__sie),
        .csrs__mstatus__mie(csrs__mstatus__mie),
        .csrs__mstatus__upie(csrs__mstatus__upie),
        .csrs__mstatus__spie(csrs__mstatus__spie),
        .csrs__mstatus__mpie(csrs__mstatus__mpie),
        .csrs__mstatus__spp(csrs__mstatus__spp),
        .csrs__mstatus__mpp(csrs__mstatus__mpp),
        .csrs__mstatus__fs(csrs__mstatus__fs),
        .csrs__mstatus__xs(csrs__mstatus__xs),
        .csrs__mstatus__mprv(csrs__mstatus__mprv),
        .csrs__mstatus__sum(csrs__mstatus__sum),
        .csrs__mstatus__mxr(csrs__mstatus__mxr),
        .csrs__mstatus__tvm(csrs__mstatus__tvm),
        .csrs__mstatus__tw(csrs__mstatus__tw),
        .csrs__mstatus__tsr(csrs__mstatus__tsr),
        .csrs__mstatus__sd(csrs__mstatus__sd),
        .csrs__mtvec__vectored(csrs__mtvec__vectored),
        .csrs__mtvec__base(csrs__mtvec__base),
        .csrs__mtval(csrs__mtval),
        .csrs__mcause(csrs__mcause),
        .csrs__mepc(csrs__mepc),
        .csrs__mscratch(csrs__mscratch),
        .csrs__time(csrs__time),
        .csrs__instret(csrs__instret),
        .csrs__cycles(csrs__cycles),
        .riscv_clk_enable(riscv_clk_enable),
        .reset_n(proc_reset_n),
        .debug_tgt__attention(            debug_tgt__attention),
        .debug_tgt__data(            debug_tgt__data),
        .debug_tgt__resp(            debug_tgt__resp),
        .debug_tgt__op_was_none(            debug_tgt__op_was_none),
        .debug_tgt__hit_breakpoint(            debug_tgt__hit_breakpoint),
        .debug_tgt__resumed(            debug_tgt__resumed),
        .debug_tgt__halted(            debug_tgt__halted),
        .debug_tgt__selected(            debug_tgt__selected),
        .debug_tgt__valid(            debug_tgt__valid),
        .pipeline_control__instruction_debug__data(            pipeline_control__instruction_debug__data),
        .pipeline_control__instruction_debug__debug_op(            pipeline_control__instruction_debug__debug_op),
        .pipeline_control__instruction_debug__valid(            pipeline_control__instruction_debug__valid),
        .pipeline_control__instruction_data(            pipeline_control__instruction_data),
        .pipeline_control__interrupt_to_mode(            pipeline_control__interrupt_to_mode),
        .pipeline_control__interrupt_number(            pipeline_control__interrupt_number),
        .pipeline_control__interrupt_req(            pipeline_control__interrupt_req),
        .pipeline_control__ebreak_to_dbg(            pipeline_control__ebreak_to_dbg),
        .pipeline_control__halt(            pipeline_control__halt),
        .pipeline_control__tag(            pipeline_control__tag),
        .pipeline_control__error(            pipeline_control__error),
        .pipeline_control__mode(            pipeline_control__mode),
        .pipeline_control__decode_pc(            pipeline_control__decode_pc),
        .pipeline_control__fetch_action(            pipeline_control__fetch_action),
        .pipeline_control__valid(            pipeline_control__valid)         );
    riscv_i32_pipeline_control_fetch_req pc_fetch_req(
        .pipeline_response__pipeline_empty(pipeline_response__pipeline_empty),
        .pipeline_response__rfw__data(pipeline_response__rfw__data),
        .pipeline_response__rfw__rd(pipeline_response__rfw__rd),
        .pipeline_response__rfw__rd_written(pipeline_response__rfw__rd_written),
        .pipeline_response__rfw__valid(pipeline_response__rfw__valid),
        .pipeline_response__exec__pc_if_mispredicted(pipeline_response__exec__pc_if_mispredicted),
        .pipeline_response__exec__predicted_branch(pipeline_response__exec__predicted_branch),
        .pipeline_response__exec__pc(pipeline_response__exec__pc),
        .pipeline_response__exec__rs2(pipeline_response__exec__rs2),
        .pipeline_response__exec__rs1(pipeline_response__exec__rs1),
        .pipeline_response__exec__instruction__debug__data(pipeline_response__exec__instruction__debug__data),
        .pipeline_response__exec__instruction__debug__debug_op(pipeline_response__exec__instruction__debug__debug_op),
        .pipeline_response__exec__instruction__debug__valid(pipeline_response__exec__instruction__debug__valid),
        .pipeline_response__exec__instruction__data(pipeline_response__exec__instruction__data),
        .pipeline_response__exec__is_compressed(pipeline_response__exec__is_compressed),
        .pipeline_response__exec__trap__ebreak_to_dbg(pipeline_response__exec__trap__ebreak_to_dbg),
        .pipeline_response__exec__trap__vector(pipeline_response__exec__trap__vector),
        .pipeline_response__exec__trap__ret(pipeline_response__exec__trap__ret),
        .pipeline_response__exec__trap__value(pipeline_response__exec__trap__value),
        .pipeline_response__exec__trap__pc(pipeline_response__exec__trap__pc),
        .pipeline_response__exec__trap__cause(pipeline_response__exec__trap__cause),
        .pipeline_response__exec__trap__to_mode(pipeline_response__exec__trap__to_mode),
        .pipeline_response__exec__trap__valid(pipeline_response__exec__trap__valid),
        .pipeline_response__exec__branch_taken(pipeline_response__exec__branch_taken),
        .pipeline_response__exec__interrupt_ack(pipeline_response__exec__interrupt_ack),
        .pipeline_response__exec__cannot_complete(pipeline_response__exec__cannot_complete),
        .pipeline_response__exec__cannot_start(pipeline_response__exec__cannot_start),
        .pipeline_response__exec__valid(pipeline_response__exec__valid),
        .pipeline_response__decode__enable_branch_prediction(pipeline_response__decode__enable_branch_prediction),
        .pipeline_response__decode__idecode__ext__dummy(pipeline_response__decode__idecode__ext__dummy),
        .pipeline_response__decode__idecode__is_compressed(pipeline_response__decode__idecode__is_compressed),
        .pipeline_response__decode__idecode__illegal_pc(pipeline_response__decode__idecode__illegal_pc),
        .pipeline_response__decode__idecode__illegal(pipeline_response__decode__idecode__illegal),
        .pipeline_response__decode__idecode__memory_width(pipeline_response__decode__idecode__memory_width),
        .pipeline_response__decode__idecode__memory_read_unsigned(pipeline_response__decode__idecode__memory_read_unsigned),
        .pipeline_response__decode__idecode__requires_machine_mode(pipeline_response__decode__idecode__requires_machine_mode),
        .pipeline_response__decode__idecode__subop(pipeline_response__decode__idecode__subop),
        .pipeline_response__decode__idecode__op(pipeline_response__decode__idecode__op),
        .pipeline_response__decode__idecode__immediate_valid(pipeline_response__decode__idecode__immediate_valid),
        .pipeline_response__decode__idecode__immediate_shift(pipeline_response__decode__idecode__immediate_shift),
        .pipeline_response__decode__idecode__immediate(pipeline_response__decode__idecode__immediate),
        .pipeline_response__decode__idecode__csr_access__write_data(pipeline_response__decode__idecode__csr_access__write_data),
        .pipeline_response__decode__idecode__csr_access__address(pipeline_response__decode__idecode__csr_access__address),
        .pipeline_response__decode__idecode__csr_access__access(pipeline_response__decode__idecode__csr_access__access),
        .pipeline_response__decode__idecode__csr_access__access_cancelled(pipeline_response__decode__idecode__csr_access__access_cancelled),
        .pipeline_response__decode__idecode__rd_written(pipeline_response__decode__idecode__rd_written),
        .pipeline_response__decode__idecode__rd(pipeline_response__decode__idecode__rd),
        .pipeline_response__decode__idecode__rs2_valid(pipeline_response__decode__idecode__rs2_valid),
        .pipeline_response__decode__idecode__rs2(pipeline_response__decode__idecode__rs2),
        .pipeline_response__decode__idecode__rs1_valid(pipeline_response__decode__idecode__rs1_valid),
        .pipeline_response__decode__idecode__rs1(pipeline_response__decode__idecode__rs1),
        .pipeline_response__decode__branch_target(pipeline_response__decode__branch_target),
        .pipeline_response__decode__blocked(pipeline_response__decode__blocked),
        .pipeline_response__decode__valid(pipeline_response__decode__valid),
        .pipeline_control__instruction_debug__data(pipeline_control__instruction_debug__data),
        .pipeline_control__instruction_debug__debug_op(pipeline_control__instruction_debug__debug_op),
        .pipeline_control__instruction_debug__valid(pipeline_control__instruction_debug__valid),
        .pipeline_control__instruction_data(pipeline_control__instruction_data),
        .pipeline_control__interrupt_to_mode(pipeline_control__interrupt_to_mode),
        .pipeline_control__interrupt_number(pipeline_control__interrupt_number),
        .pipeline_control__interrupt_req(pipeline_control__interrupt_req),
        .pipeline_control__ebreak_to_dbg(pipeline_control__ebreak_to_dbg),
        .pipeline_control__halt(pipeline_control__halt),
        .pipeline_control__tag(pipeline_control__tag),
        .pipeline_control__error(pipeline_control__error),
        .pipeline_control__mode(pipeline_control__mode),
        .pipeline_control__decode_pc(pipeline_control__decode_pc),
        .pipeline_control__fetch_action(pipeline_control__fetch_action),
        .pipeline_control__valid(pipeline_control__valid),
        .ifetch_req__pc_if_mispredicted(            ifetch_req__pc_if_mispredicted),
        .ifetch_req__predicted_branch(            ifetch_req__predicted_branch),
        .ifetch_req__mode(            ifetch_req__mode),
        .ifetch_req__address(            ifetch_req__address),
        .ifetch_req__debug_fetch(            ifetch_req__debug_fetch),
        .ifetch_req__req_type(            ifetch_req__req_type),
        .ifetch_req__flush_pipeline(            ifetch_req__flush_pipeline)         );
    riscv_i32_pipeline_control_fetch_data pc_fetch_data(
        .pipeline_response__pipeline_empty(pipeline_response__pipeline_empty),
        .pipeline_response__rfw__data(pipeline_response__rfw__data),
        .pipeline_response__rfw__rd(pipeline_response__rfw__rd),
        .pipeline_response__rfw__rd_written(pipeline_response__rfw__rd_written),
        .pipeline_response__rfw__valid(pipeline_response__rfw__valid),
        .pipeline_response__exec__pc_if_mispredicted(pipeline_response__exec__pc_if_mispredicted),
        .pipeline_response__exec__predicted_branch(pipeline_response__exec__predicted_branch),
        .pipeline_response__exec__pc(pipeline_response__exec__pc),
        .pipeline_response__exec__rs2(pipeline_response__exec__rs2),
        .pipeline_response__exec__rs1(pipeline_response__exec__rs1),
        .pipeline_response__exec__instruction__debug__data(pipeline_response__exec__instruction__debug__data),
        .pipeline_response__exec__instruction__debug__debug_op(pipeline_response__exec__instruction__debug__debug_op),
        .pipeline_response__exec__instruction__debug__valid(pipeline_response__exec__instruction__debug__valid),
        .pipeline_response__exec__instruction__data(pipeline_response__exec__instruction__data),
        .pipeline_response__exec__is_compressed(pipeline_response__exec__is_compressed),
        .pipeline_response__exec__trap__ebreak_to_dbg(pipeline_response__exec__trap__ebreak_to_dbg),
        .pipeline_response__exec__trap__vector(pipeline_response__exec__trap__vector),
        .pipeline_response__exec__trap__ret(pipeline_response__exec__trap__ret),
        .pipeline_response__exec__trap__value(pipeline_response__exec__trap__value),
        .pipeline_response__exec__trap__pc(pipeline_response__exec__trap__pc),
        .pipeline_response__exec__trap__cause(pipeline_response__exec__trap__cause),
        .pipeline_response__exec__trap__to_mode(pipeline_response__exec__trap__to_mode),
        .pipeline_response__exec__trap__valid(pipeline_response__exec__trap__valid),
        .pipeline_response__exec__branch_taken(pipeline_response__exec__branch_taken),
        .pipeline_response__exec__interrupt_ack(pipeline_response__exec__interrupt_ack),
        .pipeline_response__exec__cannot_complete(pipeline_response__exec__cannot_complete),
        .pipeline_response__exec__cannot_start(pipeline_response__exec__cannot_start),
        .pipeline_response__exec__valid(pipeline_response__exec__valid),
        .pipeline_response__decode__enable_branch_prediction(pipeline_response__decode__enable_branch_prediction),
        .pipeline_response__decode__idecode__ext__dummy(pipeline_response__decode__idecode__ext__dummy),
        .pipeline_response__decode__idecode__is_compressed(pipeline_response__decode__idecode__is_compressed),
        .pipeline_response__decode__idecode__illegal_pc(pipeline_response__decode__idecode__illegal_pc),
        .pipeline_response__decode__idecode__illegal(pipeline_response__decode__idecode__illegal),
        .pipeline_response__decode__idecode__memory_width(pipeline_response__decode__idecode__memory_width),
        .pipeline_response__decode__idecode__memory_read_unsigned(pipeline_response__decode__idecode__memory_read_unsigned),
        .pipeline_response__decode__idecode__requires_machine_mode(pipeline_response__decode__idecode__requires_machine_mode),
        .pipeline_response__decode__idecode__subop(pipeline_response__decode__idecode__subop),
        .pipeline_response__decode__idecode__op(pipeline_response__decode__idecode__op),
        .pipeline_response__decode__idecode__immediate_valid(pipeline_response__decode__idecode__immediate_valid),
        .pipeline_response__decode__idecode__immediate_shift(pipeline_response__decode__idecode__immediate_shift),
        .pipeline_response__decode__idecode__immediate(pipeline_response__decode__idecode__immediate),
        .pipeline_response__decode__idecode__csr_access__write_data(pipeline_response__decode__idecode__csr_access__write_data),
        .pipeline_response__decode__idecode__csr_access__address(pipeline_response__decode__idecode__csr_access__address),
        .pipeline_response__decode__idecode__csr_access__access(pipeline_response__decode__idecode__csr_access__access),
        .pipeline_response__decode__idecode__csr_access__access_cancelled(pipeline_response__decode__idecode__csr_access__access_cancelled),
        .pipeline_response__decode__idecode__rd_written(pipeline_response__decode__idecode__rd_written),
        .pipeline_response__decode__idecode__rd(pipeline_response__decode__idecode__rd),
        .pipeline_response__decode__idecode__rs2_valid(pipeline_response__decode__idecode__rs2_valid),
        .pipeline_response__decode__idecode__rs2(pipeline_response__decode__idecode__rs2),
        .pipeline_response__decode__idecode__rs1_valid(pipeline_response__decode__idecode__rs1_valid),
        .pipeline_response__decode__idecode__rs1(pipeline_response__decode__idecode__rs1),
        .pipeline_response__decode__branch_target(pipeline_response__decode__branch_target),
        .pipeline_response__decode__blocked(pipeline_response__decode__blocked),
        .pipeline_response__decode__valid(pipeline_response__decode__valid),
        .ifetch_resp__tag(ifetch_resp__tag),
        .ifetch_resp__error(ifetch_resp__error),
        .ifetch_resp__mode(ifetch_resp__mode),
        .ifetch_resp__data(ifetch_resp__data),
        .ifetch_resp__debug(ifetch_resp__debug),
        .ifetch_resp__valid(ifetch_resp__valid),
        .ifetch_req__pc_if_mispredicted(ifetch_req__pc_if_mispredicted),
        .ifetch_req__predicted_branch(ifetch_req__predicted_branch),
        .ifetch_req__mode(ifetch_req__mode),
        .ifetch_req__address(ifetch_req__address),
        .ifetch_req__debug_fetch(ifetch_req__debug_fetch),
        .ifetch_req__req_type(ifetch_req__req_type),
        .ifetch_req__flush_pipeline(ifetch_req__flush_pipeline),
        .pipeline_control__instruction_debug__data(pipeline_control__instruction_debug__data),
        .pipeline_control__instruction_debug__debug_op(pipeline_control__instruction_debug__debug_op),
        .pipeline_control__instruction_debug__valid(pipeline_control__instruction_debug__valid),
        .pipeline_control__instruction_data(pipeline_control__instruction_data),
        .pipeline_control__interrupt_to_mode(pipeline_control__interrupt_to_mode),
        .pipeline_control__interrupt_number(pipeline_control__interrupt_number),
        .pipeline_control__interrupt_req(pipeline_control__interrupt_req),
        .pipeline_control__ebreak_to_dbg(pipeline_control__ebreak_to_dbg),
        .pipeline_control__halt(pipeline_control__halt),
        .pipeline_control__tag(pipeline_control__tag),
        .pipeline_control__error(pipeline_control__error),
        .pipeline_control__mode(pipeline_control__mode),
        .pipeline_control__decode_pc(pipeline_control__decode_pc),
        .pipeline_control__fetch_action(pipeline_control__fetch_action),
        .pipeline_control__valid(pipeline_control__valid),
        .pipeline_fetch_data__dec_pc_if_mispredicted(            pipeline_fetch_data__dec_pc_if_mispredicted),
        .pipeline_fetch_data__dec_predicted_branch(            pipeline_fetch_data__dec_predicted_branch),
        .pipeline_fetch_data__dec_flush_pipeline(            pipeline_fetch_data__dec_flush_pipeline),
        .pipeline_fetch_data__instruction__debug__data(            pipeline_fetch_data__instruction__debug__data),
        .pipeline_fetch_data__instruction__debug__debug_op(            pipeline_fetch_data__instruction__debug__debug_op),
        .pipeline_fetch_data__instruction__debug__valid(            pipeline_fetch_data__instruction__debug__valid),
        .pipeline_fetch_data__instruction__data(            pipeline_fetch_data__instruction__data),
        .pipeline_fetch_data__pc(            pipeline_fetch_data__pc),
        .pipeline_fetch_data__valid(            pipeline_fetch_data__valid)         );
    riscv_i32_pipeline_control_csr_trace pc_csr_trace(
        .coproc_response__cannot_complete(coproc_response__cannot_complete),
        .coproc_response__result_valid(coproc_response__result_valid),
        .coproc_response__result(coproc_response__result),
        .coproc_response__cannot_start(coproc_response__cannot_start),
        .riscv_config__unaligned_mem(riscv_config_pipe__unaligned_mem),
        .riscv_config__coproc_disable(riscv_config_pipe__coproc_disable),
        .riscv_config__debug_enable(riscv_config_pipe__debug_enable),
        .riscv_config__i32m_fuse(riscv_config_pipe__i32m_fuse),
        .riscv_config__i32m(riscv_config_pipe__i32m),
        .riscv_config__e32(riscv_config_pipe__e32),
        .riscv_config__i32c(riscv_config_pipe__i32c),
        .pipeline_fetch_data__dec_pc_if_mispredicted(pipeline_fetch_data__dec_pc_if_mispredicted),
        .pipeline_fetch_data__dec_predicted_branch(pipeline_fetch_data__dec_predicted_branch),
        .pipeline_fetch_data__dec_flush_pipeline(pipeline_fetch_data__dec_flush_pipeline),
        .pipeline_fetch_data__instruction__debug__data(pipeline_fetch_data__instruction__debug__data),
        .pipeline_fetch_data__instruction__debug__debug_op(pipeline_fetch_data__instruction__debug__debug_op),
        .pipeline_fetch_data__instruction__debug__valid(pipeline_fetch_data__instruction__debug__valid),
        .pipeline_fetch_data__instruction__data(pipeline_fetch_data__instruction__data),
        .pipeline_fetch_data__pc(pipeline_fetch_data__pc),
        .pipeline_fetch_data__valid(pipeline_fetch_data__valid),
        .pipeline_response__pipeline_empty(pipeline_response__pipeline_empty),
        .pipeline_response__rfw__data(pipeline_response__rfw__data),
        .pipeline_response__rfw__rd(pipeline_response__rfw__rd),
        .pipeline_response__rfw__rd_written(pipeline_response__rfw__rd_written),
        .pipeline_response__rfw__valid(pipeline_response__rfw__valid),
        .pipeline_response__exec__pc_if_mispredicted(pipeline_response__exec__pc_if_mispredicted),
        .pipeline_response__exec__predicted_branch(pipeline_response__exec__predicted_branch),
        .pipeline_response__exec__pc(pipeline_response__exec__pc),
        .pipeline_response__exec__rs2(pipeline_response__exec__rs2),
        .pipeline_response__exec__rs1(pipeline_response__exec__rs1),
        .pipeline_response__exec__instruction__debug__data(pipeline_response__exec__instruction__debug__data),
        .pipeline_response__exec__instruction__debug__debug_op(pipeline_response__exec__instruction__debug__debug_op),
        .pipeline_response__exec__instruction__debug__valid(pipeline_response__exec__instruction__debug__valid),
        .pipeline_response__exec__instruction__data(pipeline_response__exec__instruction__data),
        .pipeline_response__exec__is_compressed(pipeline_response__exec__is_compressed),
        .pipeline_response__exec__trap__ebreak_to_dbg(pipeline_response__exec__trap__ebreak_to_dbg),
        .pipeline_response__exec__trap__vector(pipeline_response__exec__trap__vector),
        .pipeline_response__exec__trap__ret(pipeline_response__exec__trap__ret),
        .pipeline_response__exec__trap__value(pipeline_response__exec__trap__value),
        .pipeline_response__exec__trap__pc(pipeline_response__exec__trap__pc),
        .pipeline_response__exec__trap__cause(pipeline_response__exec__trap__cause),
        .pipeline_response__exec__trap__to_mode(pipeline_response__exec__trap__to_mode),
        .pipeline_response__exec__trap__valid(pipeline_response__exec__trap__valid),
        .pipeline_response__exec__branch_taken(pipeline_response__exec__branch_taken),
        .pipeline_response__exec__interrupt_ack(pipeline_response__exec__interrupt_ack),
        .pipeline_response__exec__cannot_complete(pipeline_response__exec__cannot_complete),
        .pipeline_response__exec__cannot_start(pipeline_response__exec__cannot_start),
        .pipeline_response__exec__valid(pipeline_response__exec__valid),
        .pipeline_response__decode__enable_branch_prediction(pipeline_response__decode__enable_branch_prediction),
        .pipeline_response__decode__idecode__ext__dummy(pipeline_response__decode__idecode__ext__dummy),
        .pipeline_response__decode__idecode__is_compressed(pipeline_response__decode__idecode__is_compressed),
        .pipeline_response__decode__idecode__illegal_pc(pipeline_response__decode__idecode__illegal_pc),
        .pipeline_response__decode__idecode__illegal(pipeline_response__decode__idecode__illegal),
        .pipeline_response__decode__idecode__memory_width(pipeline_response__decode__idecode__memory_width),
        .pipeline_response__decode__idecode__memory_read_unsigned(pipeline_response__decode__idecode__memory_read_unsigned),
        .pipeline_response__decode__idecode__requires_machine_mode(pipeline_response__decode__idecode__requires_machine_mode),
        .pipeline_response__decode__idecode__subop(pipeline_response__decode__idecode__subop),
        .pipeline_response__decode__idecode__op(pipeline_response__decode__idecode__op),
        .pipeline_response__decode__idecode__immediate_valid(pipeline_response__decode__idecode__immediate_valid),
        .pipeline_response__decode__idecode__immediate_shift(pipeline_response__decode__idecode__immediate_shift),
        .pipeline_response__decode__idecode__immediate(pipeline_response__decode__idecode__immediate),
        .pipeline_response__decode__idecode__csr_access__write_data(pipeline_response__decode__idecode__csr_access__write_data),
        .pipeline_response__decode__idecode__csr_access__address(pipeline_response__decode__idecode__csr_access__address),
        .pipeline_response__decode__idecode__csr_access__access(pipeline_response__decode__idecode__csr_access__access),
        .pipeline_response__decode__idecode__csr_access__access_cancelled(pipeline_response__decode__idecode__csr_access__access_cancelled),
        .pipeline_response__decode__idecode__rd_written(pipeline_response__decode__idecode__rd_written),
        .pipeline_response__decode__idecode__rd(pipeline_response__decode__idecode__rd),
        .pipeline_response__decode__idecode__rs2_valid(pipeline_response__decode__idecode__rs2_valid),
        .pipeline_response__decode__idecode__rs2(pipeline_response__decode__idecode__rs2),
        .pipeline_response__decode__idecode__rs1_valid(pipeline_response__decode__idecode__rs1_valid),
        .pipeline_response__decode__idecode__rs1(pipeline_response__decode__idecode__rs1),
        .pipeline_response__decode__branch_target(pipeline_response__decode__branch_target),
        .pipeline_response__decode__blocked(pipeline_response__decode__blocked),
        .pipeline_response__decode__valid(pipeline_response__decode__valid),
        .pipeline_control__instruction_debug__data(pipeline_control__instruction_debug__data),
        .pipeline_control__instruction_debug__debug_op(pipeline_control__instruction_debug__debug_op),
        .pipeline_control__instruction_debug__valid(pipeline_control__instruction_debug__valid),
        .pipeline_control__instruction_data(pipeline_control__instruction_data),
        .pipeline_control__interrupt_to_mode(pipeline_control__interrupt_to_mode),
        .pipeline_control__interrupt_number(pipeline_control__interrupt_number),
        .pipeline_control__interrupt_req(pipeline_control__interrupt_req),
        .pipeline_control__ebreak_to_dbg(pipeline_control__ebreak_to_dbg),
        .pipeline_control__halt(pipeline_control__halt),
        .pipeline_control__tag(pipeline_control__tag),
        .pipeline_control__error(pipeline_control__error),
        .pipeline_control__mode(pipeline_control__mode),
        .pipeline_control__decode_pc(pipeline_control__decode_pc),
        .pipeline_control__fetch_action(pipeline_control__fetch_action),
        .pipeline_control__valid(pipeline_control__valid),
        .trace__trap(            trace_pipe__trap),
        .trace__branch_target(            trace_pipe__branch_target),
        .trace__branch_taken(            trace_pipe__branch_taken),
        .trace__rfw_data(            trace_pipe__rfw_data),
        .trace__rfw_rd(            trace_pipe__rfw_rd),
        .trace__rfw_data_valid(            trace_pipe__rfw_data_valid),
        .trace__rfw_retire(            trace_pipe__rfw_retire),
        .trace__instruction__debug__data(            trace_pipe__instruction__debug__data),
        .trace__instruction__debug__debug_op(            trace_pipe__instruction__debug__debug_op),
        .trace__instruction__debug__valid(            trace_pipe__instruction__debug__valid),
        .trace__instruction__data(            trace_pipe__instruction__data),
        .trace__instr_pc(            trace_pipe__instr_pc),
        .trace__instr_valid(            trace_pipe__instr_valid),
        .csr_controls__trap__ebreak_to_dbg(            csr_controls__trap__ebreak_to_dbg),
        .csr_controls__trap__vector(            csr_controls__trap__vector),
        .csr_controls__trap__ret(            csr_controls__trap__ret),
        .csr_controls__trap__value(            csr_controls__trap__value),
        .csr_controls__trap__pc(            csr_controls__trap__pc),
        .csr_controls__trap__cause(            csr_controls__trap__cause),
        .csr_controls__trap__to_mode(            csr_controls__trap__to_mode),
        .csr_controls__trap__valid(            csr_controls__trap__valid),
        .csr_controls__timer_value(            csr_controls__timer_value),
        .csr_controls__retire(            csr_controls__retire),
        .csr_controls__exec_mode(            csr_controls__exec_mode),
        .coproc_controls__alu_cannot_complete(            coproc_controls__alu_cannot_complete),
        .coproc_controls__alu_cannot_start(            coproc_controls__alu_cannot_start),
        .coproc_controls__alu_flush_pipeline(            coproc_controls__alu_flush_pipeline),
        .coproc_controls__alu_rs2(            coproc_controls__alu_rs2),
        .coproc_controls__alu_rs1(            coproc_controls__alu_rs1),
        .coproc_controls__dec_to_alu_blocked(            coproc_controls__dec_to_alu_blocked),
        .coproc_controls__dec_idecode__ext__dummy(            coproc_controls__dec_idecode__ext__dummy),
        .coproc_controls__dec_idecode__is_compressed(            coproc_controls__dec_idecode__is_compressed),
        .coproc_controls__dec_idecode__illegal_pc(            coproc_controls__dec_idecode__illegal_pc),
        .coproc_controls__dec_idecode__illegal(            coproc_controls__dec_idecode__illegal),
        .coproc_controls__dec_idecode__memory_width(            coproc_controls__dec_idecode__memory_width),
        .coproc_controls__dec_idecode__memory_read_unsigned(            coproc_controls__dec_idecode__memory_read_unsigned),
        .coproc_controls__dec_idecode__requires_machine_mode(            coproc_controls__dec_idecode__requires_machine_mode),
        .coproc_controls__dec_idecode__subop(            coproc_controls__dec_idecode__subop),
        .coproc_controls__dec_idecode__op(            coproc_controls__dec_idecode__op),
        .coproc_controls__dec_idecode__immediate_valid(            coproc_controls__dec_idecode__immediate_valid),
        .coproc_controls__dec_idecode__immediate_shift(            coproc_controls__dec_idecode__immediate_shift),
        .coproc_controls__dec_idecode__immediate(            coproc_controls__dec_idecode__immediate),
        .coproc_controls__dec_idecode__csr_access__write_data(            coproc_controls__dec_idecode__csr_access__write_data),
        .coproc_controls__dec_idecode__csr_access__address(            coproc_controls__dec_idecode__csr_access__address),
        .coproc_controls__dec_idecode__csr_access__access(            coproc_controls__dec_idecode__csr_access__access),
        .coproc_controls__dec_idecode__csr_access__access_cancelled(            coproc_controls__dec_idecode__csr_access__access_cancelled),
        .coproc_controls__dec_idecode__rd_written(            coproc_controls__dec_idecode__rd_written),
        .coproc_controls__dec_idecode__rd(            coproc_controls__dec_idecode__rd),
        .coproc_controls__dec_idecode__rs2_valid(            coproc_controls__dec_idecode__rs2_valid),
        .coproc_controls__dec_idecode__rs2(            coproc_controls__dec_idecode__rs2),
        .coproc_controls__dec_idecode__rs1_valid(            coproc_controls__dec_idecode__rs1_valid),
        .coproc_controls__dec_idecode__rs1(            coproc_controls__dec_idecode__rs1),
        .coproc_controls__dec_idecode_valid(            coproc_controls__dec_idecode_valid)         );
    riscv_i32c_pipeline pipeline(
        .clk(clk),
        .clk__enable(riscv_clk__enable),
        .csr_read_data(csr_data__read_data),
        .riscv_config__unaligned_mem(riscv_config_pipe__unaligned_mem),
        .riscv_config__coproc_disable(riscv_config_pipe__coproc_disable),
        .riscv_config__debug_enable(riscv_config_pipe__debug_enable),
        .riscv_config__i32m_fuse(riscv_config_pipe__i32m_fuse),
        .riscv_config__i32m(riscv_config_pipe__i32m),
        .riscv_config__e32(riscv_config_pipe__e32),
        .riscv_config__i32c(riscv_config_pipe__i32c),
        .coproc_response__cannot_complete(coproc_response__cannot_complete),
        .coproc_response__result_valid(coproc_response__result_valid),
        .coproc_response__result(coproc_response__result),
        .coproc_response__cannot_start(coproc_response__cannot_start),
        .dmem_access_resp__read_data(dmem_access_resp__read_data),
        .dmem_access_resp__wait(dmem_access_resp__wait),
        .pipeline_fetch_data__dec_pc_if_mispredicted(pipeline_fetch_data__dec_pc_if_mispredicted),
        .pipeline_fetch_data__dec_predicted_branch(pipeline_fetch_data__dec_predicted_branch),
        .pipeline_fetch_data__dec_flush_pipeline(pipeline_fetch_data__dec_flush_pipeline),
        .pipeline_fetch_data__instruction__debug__data(pipeline_fetch_data__instruction__debug__data),
        .pipeline_fetch_data__instruction__debug__debug_op(pipeline_fetch_data__instruction__debug__debug_op),
        .pipeline_fetch_data__instruction__debug__valid(pipeline_fetch_data__instruction__debug__valid),
        .pipeline_fetch_data__instruction__data(pipeline_fetch_data__instruction__data),
        .pipeline_fetch_data__pc(pipeline_fetch_data__pc),
        .pipeline_fetch_data__valid(pipeline_fetch_data__valid),
        .pipeline_control__instruction_debug__data(pipeline_control__instruction_debug__data),
        .pipeline_control__instruction_debug__debug_op(pipeline_control__instruction_debug__debug_op),
        .pipeline_control__instruction_debug__valid(pipeline_control__instruction_debug__valid),
        .pipeline_control__instruction_data(pipeline_control__instruction_data),
        .pipeline_control__interrupt_to_mode(pipeline_control__interrupt_to_mode),
        .pipeline_control__interrupt_number(pipeline_control__interrupt_number),
        .pipeline_control__interrupt_req(pipeline_control__interrupt_req),
        .pipeline_control__ebreak_to_dbg(pipeline_control__ebreak_to_dbg),
        .pipeline_control__halt(pipeline_control__halt),
        .pipeline_control__tag(pipeline_control__tag),
        .pipeline_control__error(pipeline_control__error),
        .pipeline_control__mode(pipeline_control__mode),
        .pipeline_control__decode_pc(pipeline_control__decode_pc),
        .pipeline_control__fetch_action(pipeline_control__fetch_action),
        .pipeline_control__valid(pipeline_control__valid),
        .reset_n(proc_reset_n),
        .csr_access__write_data(            csr_access__write_data),
        .csr_access__address(            csr_access__address),
        .csr_access__access(            csr_access__access),
        .csr_access__access_cancelled(            csr_access__access_cancelled),
        .dmem_access_req__write_data(            dmem_access_req__write_data),
        .dmem_access_req__read_enable(            dmem_access_req__read_enable),
        .dmem_access_req__write_enable(            dmem_access_req__write_enable),
        .dmem_access_req__byte_enable(            dmem_access_req__byte_enable),
        .dmem_access_req__address(            dmem_access_req__address),
        .pipeline_response__pipeline_empty(            pipeline_response__pipeline_empty),
        .pipeline_response__rfw__data(            pipeline_response__rfw__data),
        .pipeline_response__rfw__rd(            pipeline_response__rfw__rd),
        .pipeline_response__rfw__rd_written(            pipeline_response__rfw__rd_written),
        .pipeline_response__rfw__valid(            pipeline_response__rfw__valid),
        .pipeline_response__exec__pc_if_mispredicted(            pipeline_response__exec__pc_if_mispredicted),
        .pipeline_response__exec__predicted_branch(            pipeline_response__exec__predicted_branch),
        .pipeline_response__exec__pc(            pipeline_response__exec__pc),
        .pipeline_response__exec__rs2(            pipeline_response__exec__rs2),
        .pipeline_response__exec__rs1(            pipeline_response__exec__rs1),
        .pipeline_response__exec__instruction__debug__data(            pipeline_response__exec__instruction__debug__data),
        .pipeline_response__exec__instruction__debug__debug_op(            pipeline_response__exec__instruction__debug__debug_op),
        .pipeline_response__exec__instruction__debug__valid(            pipeline_response__exec__instruction__debug__valid),
        .pipeline_response__exec__instruction__data(            pipeline_response__exec__instruction__data),
        .pipeline_response__exec__is_compressed(            pipeline_response__exec__is_compressed),
        .pipeline_response__exec__trap__ebreak_to_dbg(            pipeline_response__exec__trap__ebreak_to_dbg),
        .pipeline_response__exec__trap__vector(            pipeline_response__exec__trap__vector),
        .pipeline_response__exec__trap__ret(            pipeline_response__exec__trap__ret),
        .pipeline_response__exec__trap__value(            pipeline_response__exec__trap__value),
        .pipeline_response__exec__trap__pc(            pipeline_response__exec__trap__pc),
        .pipeline_response__exec__trap__cause(            pipeline_response__exec__trap__cause),
        .pipeline_response__exec__trap__to_mode(            pipeline_response__exec__trap__to_mode),
        .pipeline_response__exec__trap__valid(            pipeline_response__exec__trap__valid),
        .pipeline_response__exec__branch_taken(            pipeline_response__exec__branch_taken),
        .pipeline_response__exec__interrupt_ack(            pipeline_response__exec__interrupt_ack),
        .pipeline_response__exec__cannot_complete(            pipeline_response__exec__cannot_complete),
        .pipeline_response__exec__cannot_start(            pipeline_response__exec__cannot_start),
        .pipeline_response__exec__valid(            pipeline_response__exec__valid),
        .pipeline_response__decode__enable_branch_prediction(            pipeline_response__decode__enable_branch_prediction),
        .pipeline_response__decode__idecode__ext__dummy(            pipeline_response__decode__idecode__ext__dummy),
        .pipeline_response__decode__idecode__is_compressed(            pipeline_response__decode__idecode__is_compressed),
        .pipeline_response__decode__idecode__illegal_pc(            pipeline_response__decode__idecode__illegal_pc),
        .pipeline_response__decode__idecode__illegal(            pipeline_response__decode__idecode__illegal),
        .pipeline_response__decode__idecode__memory_width(            pipeline_response__decode__idecode__memory_width),
        .pipeline_response__decode__idecode__memory_read_unsigned(            pipeline_response__decode__idecode__memory_read_unsigned),
        .pipeline_response__decode__idecode__requires_machine_mode(            pipeline_response__decode__idecode__requires_machine_mode),
        .pipeline_response__decode__idecode__subop(            pipeline_response__decode__idecode__subop),
        .pipeline_response__decode__idecode__op(            pipeline_response__decode__idecode__op),
        .pipeline_response__decode__idecode__immediate_valid(            pipeline_response__decode__idecode__immediate_valid),
        .pipeline_response__decode__idecode__immediate_shift(            pipeline_response__decode__idecode__immediate_shift),
        .pipeline_response__decode__idecode__immediate(            pipeline_response__decode__idecode__immediate),
        .pipeline_response__decode__idecode__csr_access__write_data(            pipeline_response__decode__idecode__csr_access__write_data),
        .pipeline_response__decode__idecode__csr_access__address(            pipeline_response__decode__idecode__csr_access__address),
        .pipeline_response__decode__idecode__csr_access__access(            pipeline_response__decode__idecode__csr_access__access),
        .pipeline_response__decode__idecode__csr_access__access_cancelled(            pipeline_response__decode__idecode__csr_access__access_cancelled),
        .pipeline_response__decode__idecode__rd_written(            pipeline_response__decode__idecode__rd_written),
        .pipeline_response__decode__idecode__rd(            pipeline_response__decode__idecode__rd),
        .pipeline_response__decode__idecode__rs2_valid(            pipeline_response__decode__idecode__rs2_valid),
        .pipeline_response__decode__idecode__rs2(            pipeline_response__decode__idecode__rs2),
        .pipeline_response__decode__idecode__rs1_valid(            pipeline_response__decode__idecode__rs1_valid),
        .pipeline_response__decode__idecode__rs1(            pipeline_response__decode__idecode__rs1),
        .pipeline_response__decode__branch_target(            pipeline_response__decode__branch_target),
        .pipeline_response__decode__blocked(            pipeline_response__decode__blocked),
        .pipeline_response__decode__valid(            pipeline_response__decode__valid)         );
    riscv_csrs_minimal csrs(
        .clk(clk),
        .clk__enable(riscv_clk__enable),
        .csr_controls__trap__ebreak_to_dbg(csr_controls__trap__ebreak_to_dbg),
        .csr_controls__trap__vector(csr_controls__trap__vector),
        .csr_controls__trap__ret(csr_controls__trap__ret),
        .csr_controls__trap__value(csr_controls__trap__value),
        .csr_controls__trap__pc(csr_controls__trap__pc),
        .csr_controls__trap__cause(csr_controls__trap__cause),
        .csr_controls__trap__to_mode(csr_controls__trap__to_mode),
        .csr_controls__trap__valid(csr_controls__trap__valid),
        .csr_controls__timer_value(csr_controls__timer_value),
        .csr_controls__retire(csr_controls__retire),
        .csr_controls__exec_mode(csr_controls__exec_mode),
        .csr_access__write_data(csr_access__write_data),
        .csr_access__address(csr_access__address),
        .csr_access__access(csr_access__access),
        .csr_access__access_cancelled(csr_access__access_cancelled),
        .irqs__time(irqs__time),
        .irqs__msip(irqs__msip),
        .irqs__mtip(irqs__mtip),
        .irqs__ueip(irqs__ueip),
        .irqs__seip(irqs__seip),
        .irqs__meip(irqs__meip),
        .irqs__nmi(irqs__nmi),
        .riscv_clk_enable(1'h1),
        .reset_n(reset_n),
        .csrs__dscratch1(            csrs__dscratch1),
        .csrs__dscratch0(            csrs__dscratch0),
        .csrs__depc(            csrs__depc),
        .csrs__dcsr__prv(            csrs__dcsr__prv),
        .csrs__dcsr__step(            csrs__dcsr__step),
        .csrs__dcsr__nmip(            csrs__dcsr__nmip),
        .csrs__dcsr__mprven(            csrs__dcsr__mprven),
        .csrs__dcsr__cause(            csrs__dcsr__cause),
        .csrs__dcsr__stoptime(            csrs__dcsr__stoptime),
        .csrs__dcsr__stopcount(            csrs__dcsr__stopcount),
        .csrs__dcsr__stepie(            csrs__dcsr__stepie),
        .csrs__dcsr__ebreaku(            csrs__dcsr__ebreaku),
        .csrs__dcsr__ebreaks(            csrs__dcsr__ebreaks),
        .csrs__dcsr__ebreakm(            csrs__dcsr__ebreakm),
        .csrs__dcsr__xdebug_ver(            csrs__dcsr__xdebug_ver),
        .csrs__mie__usip(            csrs__mie__usip),
        .csrs__mie__ssip(            csrs__mie__ssip),
        .csrs__mie__msip(            csrs__mie__msip),
        .csrs__mie__utip(            csrs__mie__utip),
        .csrs__mie__stip(            csrs__mie__stip),
        .csrs__mie__mtip(            csrs__mie__mtip),
        .csrs__mie__ueip(            csrs__mie__ueip),
        .csrs__mie__seip(            csrs__mie__seip),
        .csrs__mie__meip(            csrs__mie__meip),
        .csrs__mip__usip(            csrs__mip__usip),
        .csrs__mip__ssip(            csrs__mip__ssip),
        .csrs__mip__msip(            csrs__mip__msip),
        .csrs__mip__utip(            csrs__mip__utip),
        .csrs__mip__stip(            csrs__mip__stip),
        .csrs__mip__mtip(            csrs__mip__mtip),
        .csrs__mip__ueip_sw(            csrs__mip__ueip_sw),
        .csrs__mip__seip_sw(            csrs__mip__seip_sw),
        .csrs__mip__ueip(            csrs__mip__ueip),
        .csrs__mip__seip(            csrs__mip__seip),
        .csrs__mip__meip(            csrs__mip__meip),
        .csrs__mstatus__uie(            csrs__mstatus__uie),
        .csrs__mstatus__sie(            csrs__mstatus__sie),
        .csrs__mstatus__mie(            csrs__mstatus__mie),
        .csrs__mstatus__upie(            csrs__mstatus__upie),
        .csrs__mstatus__spie(            csrs__mstatus__spie),
        .csrs__mstatus__mpie(            csrs__mstatus__mpie),
        .csrs__mstatus__spp(            csrs__mstatus__spp),
        .csrs__mstatus__mpp(            csrs__mstatus__mpp),
        .csrs__mstatus__fs(            csrs__mstatus__fs),
        .csrs__mstatus__xs(            csrs__mstatus__xs),
        .csrs__mstatus__mprv(            csrs__mstatus__mprv),
        .csrs__mstatus__sum(            csrs__mstatus__sum),
        .csrs__mstatus__mxr(            csrs__mstatus__mxr),
        .csrs__mstatus__tvm(            csrs__mstatus__tvm),
        .csrs__mstatus__tw(            csrs__mstatus__tw),
        .csrs__mstatus__tsr(            csrs__mstatus__tsr),
        .csrs__mstatus__sd(            csrs__mstatus__sd),
        .csrs__mtvec__vectored(            csrs__mtvec__vectored),
        .csrs__mtvec__base(            csrs__mtvec__base),
        .csrs__mtval(            csrs__mtval),
        .csrs__mcause(            csrs__mcause),
        .csrs__mepc(            csrs__mepc),
        .csrs__mscratch(            csrs__mscratch),
        .csrs__time(            csrs__time),
        .csrs__instret(            csrs__instret),
        .csrs__cycles(            csrs__cycles),
        .csr_data__illegal_access(            csr_data__illegal_access),
        .csr_data__interrupt_cause(            csr_data__interrupt_cause),
        .csr_data__interrupt_mode(            csr_data__interrupt_mode),
        .csr_data__take_interrupt(            csr_data__take_interrupt),
        .csr_data__read_data(            csr_data__read_data)         );
    //b data_decode__comb combinatorial process
        //   
        //       Decode a data access. A data access may decode into an SRAM access
        //       request, which remains stable in a riscv_clk period *after* the
        //       first clock cycle riscv_clk_high; or it may decode into a data
        //       access request, which is a registered request that is guaranteed
        //       to be 0 in riscv_clk_high, and may be set for subsequent clock
        //       cycles, until it has completed.
        //       
    always @ ( * )//data_decode__comb
    begin: data_decode__comb_code
    reg data_sram_access_req__write_enable__var;
    reg data_sram_access_req__read_enable__var;
        data_sram_access_req__address = dmem_access_req__address;
        data_sram_access_req__byte_enable = dmem_access_req__byte_enable;
        data_sram_access_req__write_enable__var = dmem_access_req__write_enable;
        data_sram_access_req__read_enable__var = dmem_access_req__read_enable;
        data_sram_access_req__write_data = dmem_access_req__write_data;
        if ((dmem_access_req__address[31:20]!=12'h0))
        begin
            data_sram_access_req__read_enable__var = 1'h0;
            data_sram_access_req__write_enable__var = 1'h0;
        end //if
        data_access_completing = (((data_access_req__read_enable!=1'h0)||(data_access_req__write_enable!=1'h0))&&!(data_access_resp__wait!=1'h0));
        data_access_wait = (((data_access_req__read_enable!=1'h0)||(data_access_req__write_enable!=1'h0))&&(data_access_resp__wait!=1'h0));
        data_sram_access_req__write_enable = data_sram_access_req__write_enable__var;
        data_sram_access_req__read_enable = data_sram_access_req__read_enable__var;
    end //always

    //b data_decode__posedge_clk_active_low_reset_n clock process
        //   
        //       Decode a data access. A data access may decode into an SRAM access
        //       request, which remains stable in a riscv_clk period *after* the
        //       first clock cycle riscv_clk_high; or it may decode into a data
        //       access request, which is a registered request that is guaranteed
        //       to be 0 in riscv_clk_high, and may be set for subsequent clock
        //       cycles, until it has completed.
        //       
    always @( posedge clk or negedge reset_n)
    begin : data_decode__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            data_access_req__read_enable <= 1'h0;
            data_access_req__write_enable <= 1'h0;
            data_access_req__address <= 32'h0;
            data_access_req__byte_enable <= 4'h0;
            data_access_req__write_data <= 32'h0;
        end
        else if (clk__enable)
        begin
            if ((riscv_clk_high!=1'h0))
            begin
                data_access_req__read_enable <= 1'h0;
                data_access_req__write_enable <= 1'h0;
                if (((dmem_access_req__read_enable!=1'h0)||(dmem_access_req__write_enable!=1'h0)))
                begin
                    data_access_req__address <= dmem_access_req__address;
                    data_access_req__byte_enable <= dmem_access_req__byte_enable;
                    data_access_req__write_enable <= dmem_access_req__write_enable;
                    data_access_req__read_enable <= dmem_access_req__read_enable;
                    data_access_req__write_data <= dmem_access_req__write_data;
                end //if
                if ((dmem_access_req__address[31:20]==12'h0))
                begin
                    data_access_req__read_enable <= 1'h0;
                    data_access_req__write_enable <= 1'h0;
                end //if
            end //if
            else
            
            begin
                if ((data_access_completing!=1'h0))
                begin
                    data_access_req__read_enable <= 1'h0;
                    data_access_req__write_enable <= 1'h0;
                end //if
            end //else
        end //if
    end //always

    //b clock_control__comb combinatorial process
        //   
        //       The clock control for a single SRAM implementation could be
        //       performed with three high speed clocks for each RISC-V
        //       clock. However, this is a slightly more sophisticated design.
        //   
        //       A minimal RISC-V clock cycle requires at most one instruction fetch and at
        //       most one of data read or data write.
        //   
        //       With a synchronous memory, a memory read must be presented to the
        //       SRAM at high speed clock cycle n-1 if the data is to be valid at
        //       the end of high speed clock cycle n.
        //   
        //       So if just an instruction fetch is required then a first high
        //       speed cycle is used to present the ifetch, and a second high speed
        //       cycle is the instruction being read. This is presented directly to
        //       the RISC-V core.
        //   
        //       If an instruction fetch and data read/write are required then a
        //       first high speed cycle is used to present the instruction fetch, a
        //       second to present the data read/write and perform the ifetch -
        //       with the data out registered at the start of a third high speed
        //       cycle while the data is being read (for data reads). This is
        //       presented directly to the RISC-V core; the instruction fetched is
        //       presented from its stored register
        //   
        //       If only a data read/write is required then that is presented in
        //       riscv_clk_high, with the data valid (on reads) at the end of the
        //       subsequent cycle.
        //   
        //       
    always @ ( * )//clock_control__comb
    begin: clock_control__comb_code
    reg [2:0]riscv_clock_action__var;
    reg [1:0]ifetch_src__var;
    reg [1:0]data_src__var;
    reg riscv_clk_enable__var;
        riscv_clock_action__var = 3'h0;
        ifetch_src__var = 2'h0;
        data_src__var = 2'h2;
        case (riscv_clock_phase) //synopsys parallel_case
        3'h0: // req 1
            begin
            riscv_clock_action__var = 3'h1;
            if ((ifetch_req__req_type!=3'h0))
            begin
                riscv_clock_action__var = 3'h2;
                if ((1'h1||(riscv_config__i32c!=1'h0)))
                begin
                    if ((ifetch_req__address[1]!=1'h0))
                    begin
                        if ((ifetch_req__req_type!=3'h1))
                        begin
                            riscv_clock_action__var = 3'h7;
                        end //if
                        else
                        
                        begin
                            riscv_clock_action__var = 3'h6;
                        end //else
                    end //if
                end //if
            end //if
            else
            
            begin
                if ((data_sram_access_req__read_enable!=1'h0))
                begin
                    riscv_clock_action__var = 3'h3;
                end //if
                else
                
                begin
                    if ((data_sram_access_req__write_enable!=1'h0))
                    begin
                        riscv_clock_action__var = 3'h4;
                    end //if
                end //else
            end //else
            end
        3'h4: // req 1
            begin
            ifetch_src__var = 2'h1;
            riscv_clock_action__var = 3'h0;
            if ((data_access_wait!=1'h0))
            begin
                riscv_clock_action__var = 3'h5;
            end //if
            end
        3'h3: // req 1
            begin
            riscv_clock_action__var = 3'h0;
            if ((data_access_wait!=1'h0))
            begin
                riscv_clock_action__var = 3'h5;
            end //if
            if ((data_sram_access_req__read_enable!=1'h0))
            begin
                riscv_clock_action__var = 3'h3;
            end //if
            else
            
            begin
                if ((data_sram_access_req__write_enable!=1'h0))
                begin
                    riscv_clock_action__var = 3'h4;
                end //if
            end //else
            end
        3'h5: // req 1
            begin
            riscv_clock_action__var = 3'h7;
            end
        3'h6: // req 1
            begin
            data_src__var = 2'h1;
            if ((data_access_completing!=1'h0))
            begin
                data_src__var = 2'h2;
            end //if
            riscv_clock_action__var = 3'h0;
            ifetch_src__var = 2'h2;
            if ((data_access_wait!=1'h0))
            begin
                riscv_clock_action__var = 3'h5;
            end //if
            if ((data_sram_access_req__read_enable!=1'h0))
            begin
                riscv_clock_action__var = 3'h3;
            end //if
            else
            
            begin
                if ((data_sram_access_req__write_enable!=1'h0))
                begin
                    riscv_clock_action__var = 3'h4;
                end //if
            end //else
            end
        3'h2: // req 1
            begin
            riscv_clock_action__var = 3'h0;
            ifetch_src__var = 2'h1;
            end
        3'h1: // req 1
            begin
            riscv_clock_action__var = 3'h0;
            ifetch_src__var = 2'h1;
            data_src__var = 2'h0;
            end
    //synopsys  translate_off
    //pragma coverage off
        default:
            begin
                if (1)
                begin
                    $display("%t *********CDL ASSERTION FAILURE:riscv_i32_minimal:clock_control: Full switch statement did not cover all values", $time);
                end
            end
    //pragma coverage on
    //synopsys  translate_on
        endcase
        riscv_clk_enable__var = 1'h0;
        case (riscv_clock_action__var) //synopsys parallel_case
        3'h1: // req 1
            begin
            end
        3'h0: // req 1
            begin
            riscv_clk_enable__var = 1'h1;
            end
        3'h5: // req 1
            begin
            end
        3'h2: // req 1
            begin
            end
        3'h6: // req 1
            begin
            end
        3'h7: // req 1
            begin
            end
        3'h3: // req 1
            begin
            end
        3'h4: // req 1
            begin
            end
    //synopsys  translate_off
    //pragma coverage off
        default:
            begin
                if (1)
                begin
                    $display("%t *********CDL ASSERTION FAILURE:riscv_i32_minimal:clock_control: Full switch statement did not cover all values", $time);
                end
            end
    //pragma coverage on
    //synopsys  translate_on
        endcase
        riscv_clock_action = riscv_clock_action__var;
        ifetch_src = ifetch_src__var;
        data_src = data_src__var;
        riscv_clk_enable = riscv_clk_enable__var;
    end //always

    //b clock_control__posedge_clk_active_low_reset_n clock process
        //   
        //       The clock control for a single SRAM implementation could be
        //       performed with three high speed clocks for each RISC-V
        //       clock. However, this is a slightly more sophisticated design.
        //   
        //       A minimal RISC-V clock cycle requires at most one instruction fetch and at
        //       most one of data read or data write.
        //   
        //       With a synchronous memory, a memory read must be presented to the
        //       SRAM at high speed clock cycle n-1 if the data is to be valid at
        //       the end of high speed clock cycle n.
        //   
        //       So if just an instruction fetch is required then a first high
        //       speed cycle is used to present the ifetch, and a second high speed
        //       cycle is the instruction being read. This is presented directly to
        //       the RISC-V core.
        //   
        //       If an instruction fetch and data read/write are required then a
        //       first high speed cycle is used to present the instruction fetch, a
        //       second to present the data read/write and perform the ifetch -
        //       with the data out registered at the start of a third high speed
        //       cycle while the data is being read (for data reads). This is
        //       presented directly to the RISC-V core; the instruction fetched is
        //       presented from its stored register
        //   
        //       If only a data read/write is required then that is presented in
        //       riscv_clk_high, with the data valid (on reads) at the end of the
        //       subsequent cycle.
        //   
        //       
    always @( posedge clk or negedge reset_n)
    begin : clock_control__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            riscv_clock_phase <= 3'h0;
            riscv_clk_high <= 1'h0;
        end
        else if (clk__enable)
        begin
            case (riscv_clock_action) //synopsys parallel_case
            3'h1: // req 1
                begin
                riscv_clock_phase <= 3'h4;
                end
            3'h0: // req 1
                begin
                riscv_clock_phase <= 3'h0;
                end
            3'h5: // req 1
                begin
                riscv_clock_phase <= 3'h4;
                end
            3'h2: // req 1
                begin
                riscv_clock_phase <= 3'h3;
                end
            3'h6: // req 1
                begin
                riscv_clock_phase <= 3'h5;
                end
            3'h7: // req 1
                begin
                riscv_clock_phase <= 3'h6;
                end
            3'h3: // req 1
                begin
                riscv_clock_phase <= 3'h1;
                end
            3'h4: // req 1
                begin
                riscv_clock_phase <= 3'h2;
                end
    //synopsys  translate_off
    //pragma coverage off
            default:
                begin
                    if (1)
                    begin
                        $display("%t *********CDL ASSERTION FAILURE:riscv_i32_minimal:clock_control: Full switch statement did not cover all values", $time);
                    end
                end
    //pragma coverage on
    //synopsys  translate_on
            endcase
            riscv_clk_high <= riscv_clk_enable;
        end //if
    end //always

    //b srams__comb combinatorial process
    always @ ( * )//srams__comb
    begin: srams__comb_code
    reg sram_access_ack__var;
    reg [31:0]mem_access_req__address__var;
    reg [3:0]mem_access_req__byte_enable__var;
    reg mem_access_req__write_enable__var;
    reg mem_access_req__read_enable__var;
    reg [31:0]mem_access_req__write_data__var;
    reg ifetch_resp__valid__var;
    reg [31:0]ifetch_resp__data__var;
    reg [31:0]dmem_access_resp__read_data__var;
        sram_access_ack__var = 1'h0;
        mem_access_req__address__var = 32'h0;
        mem_access_req__byte_enable__var = 4'h0;
        mem_access_req__write_enable__var = 1'h0;
        mem_access_req__read_enable__var = 1'h0;
        mem_access_req__write_data__var = 32'h0;
        mem_access_req__address__var = data_sram_access_req__address;
        mem_access_req__byte_enable__var = data_sram_access_req__byte_enable;
        mem_access_req__write_data__var = data_sram_access_req__write_data;
        case (riscv_clock_action) //synopsys parallel_case
        3'h3: // req 1
            begin
            mem_access_req__read_enable__var = 1'h1;
            mem_access_req__address__var = data_sram_access_req__address;
            end
        3'h4: // req 1
            begin
            mem_access_req__write_enable__var = 1'h1;
            mem_access_req__byte_enable__var = data_sram_access_req__byte_enable;
            mem_access_req__address__var = data_sram_access_req__address;
            mem_access_req__write_data__var = data_sram_access_req__write_data;
            end
        3'h2: // req 1
            begin
            mem_access_req__read_enable__var = 1'h1;
            mem_access_req__address__var = ifetch_req__address;
            end
        3'h6: // req 1
            begin
            mem_access_req__read_enable__var = 1'h1;
            mem_access_req__address__var = ifetch_req__address;
            end
        3'h7: // req 1
            begin
            mem_access_req__read_enable__var = 1'h1;
            mem_access_req__address__var = (ifetch_req__address+32'h4);
            end
        default: // req 1
            begin
            if ((sram_access_req_r__valid!=1'h0))
            begin
                mem_access_req__read_enable__var = sram_access_req_r__read_not_write;
                mem_access_req__write_enable__var = !(sram_access_req_r__read_not_write!=1'h0);
                mem_access_req__address__var = {sram_access_req_r__address[29:0],2'h0};
                mem_access_req__byte_enable__var = sram_access_req_r__byte_enable[3:0];
                mem_access_req__write_data__var = sram_access_req_r__write_data[31:0];
                sram_access_ack__var = 1'h1;
            end //if
            end
        endcase
        ifetch_resp__valid__var = 1'h0;
        ifetch_resp__debug = 1'h0;
        ifetch_resp__data__var = 32'h0;
        ifetch_resp__mode = 3'h0;
        ifetch_resp__error = 1'h0;
        ifetch_resp__tag = 2'h0;
        ifetch_resp__valid__var = (ifetch_req__req_type!=3'h0);
        ifetch_resp__data__var = mem_read_data;
        if ((ifetch_src==2'h1))
        begin
            ifetch_resp__data__var = ifetch_reg;
        end //if
        if (1'h1)
        begin
            if ((ifetch_src==2'h2))
            begin
                ifetch_resp__data__var = {mem_read_data[15:0],ifetch_reg[31:16]};
                if ((ifetch_req__req_type!=3'h1))
                begin
                    ifetch_resp__data__var = {mem_read_data[15:0],ifetch_last16_reg};
                end //if
            end //if
        end //if
        dmem_access_resp__wait = 1'h0;
        dmem_access_resp__read_data__var = data_access_resp__read_data;
        case (data_src) //synopsys parallel_case
        2'h1: // req 1
            begin
            dmem_access_resp__read_data__var = data_access_read_reg;
            end
        2'h0: // req 1
            begin
            dmem_access_resp__read_data__var = mem_read_data;
            end
        default: // req 1
            begin
            dmem_access_resp__read_data__var = data_access_resp__read_data;
            end
        endcase
        sram_access_ack = sram_access_ack__var;
        mem_access_req__address = mem_access_req__address__var;
        mem_access_req__byte_enable = mem_access_req__byte_enable__var;
        mem_access_req__write_enable = mem_access_req__write_enable__var;
        mem_access_req__read_enable = mem_access_req__read_enable__var;
        mem_access_req__write_data = mem_access_req__write_data__var;
        ifetch_resp__valid = ifetch_resp__valid__var;
        ifetch_resp__data = ifetch_resp__data__var;
        dmem_access_resp__read_data = dmem_access_resp__read_data__var;
    end //always

    //b srams__posedge_clk_active_low_reset_n clock process
    always @( posedge clk or negedge reset_n)
    begin : srams__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            sram_access_resp__valid <= 1'h0;
            sram_access_resp__id <= 4'h0;
            sram_access_resp__data <= 64'h0;
            sram_access_req_r__valid <= 1'h0;
            sram_access_req_r__id <= 4'h0;
            sram_access_req_r__read_not_write <= 1'h0;
            sram_access_req_r__byte_enable <= 8'h0;
            sram_access_req_r__address <= 32'h0;
            sram_access_req_r__write_data <= 64'h0;
            sram_access_resp__ack <= 1'h0;
            ifetch_reg <= 32'h0;
            ifetch_last16_reg <= 16'h0;
            data_access_read_reg <= 32'h0;
        end
        else if (clk__enable)
        begin
            if ((sram_access_resp__valid!=1'h0))
            begin
                sram_access_resp__valid <= 1'h0;
            end //if
            if ((sram_access_resp__ack!=1'h0))
            begin
                sram_access_resp__valid <= 1'h1;
                sram_access_resp__id <= sram_access_req_r__id;
                sram_access_resp__data[31:0] <= mem_read_data;
            end //if
            if ((sram_access_req__valid!=1'h0))
            begin
                sram_access_req_r__valid <= sram_access_req__valid;
                sram_access_req_r__id <= sram_access_req__id;
                sram_access_req_r__read_not_write <= sram_access_req__read_not_write;
                sram_access_req_r__byte_enable <= sram_access_req__byte_enable;
                sram_access_req_r__address <= sram_access_req__address;
                sram_access_req_r__write_data <= sram_access_req__write_data;
            end //if
            if (((sram_access_ack!=1'h0)||(sram_access_resp__ack!=1'h0)))
            begin
                sram_access_req_r__valid <= 1'h0;
            end //if
            if (((sram_access_resp__ack!=1'h0)||(sram_access_ack!=1'h0)))
            begin
                sram_access_resp__ack <= sram_access_ack;
            end //if
            if ((riscv_clock_phase==3'h3))
            begin
                ifetch_reg <= mem_read_data;
            end //if
            if (1'h1)
            begin
                if ((riscv_clock_phase==3'h3))
                begin
                    ifetch_last16_reg <= mem_read_data[31:16];
                end //if
                if ((riscv_clock_phase==3'h5))
                begin
                    ifetch_reg <= mem_read_data;
                end //if
                if ((riscv_clock_phase==3'h6))
                begin
                    ifetch_reg <= {mem_read_data[15:0],ifetch_reg[31:16]};
                    if ((ifetch_req__req_type!=3'h1))
                    begin
                        ifetch_reg <= {mem_read_data[15:0],ifetch_last16_reg};
                    end //if
                    ifetch_last16_reg <= mem_read_data[31:16];
                end //if
            end //if
            if ((1'h1&&(riscv_config__i32c!=1'h0)))
            begin
                if ((data_access_completing!=1'h0))
                begin
                    data_access_read_reg <= data_access_resp__read_data;
                end //if
            end //if
        end //if
    end //always

    //b pipeline__comb combinatorial process
    always @ ( * )//pipeline__comb
    begin: pipeline__comb_code
    reg trace__instr_valid__var;
    reg trace__rfw_data_valid__var;
        coproc_response__cannot_start = 1'h0;
        coproc_response__result = 32'h0;
        coproc_response__result_valid = 1'h0;
        coproc_response__cannot_complete = 1'h0;
        trace__instr_valid__var = trace_pipe__instr_valid;
        trace__instr_pc = trace_pipe__instr_pc;
        trace__instruction__data = trace_pipe__instruction__data;
        trace__instruction__debug__valid = trace_pipe__instruction__debug__valid;
        trace__instruction__debug__debug_op = trace_pipe__instruction__debug__debug_op;
        trace__instruction__debug__data = trace_pipe__instruction__debug__data;
        trace__rfw_retire = trace_pipe__rfw_retire;
        trace__rfw_data_valid__var = trace_pipe__rfw_data_valid;
        trace__rfw_rd = trace_pipe__rfw_rd;
        trace__rfw_data = trace_pipe__rfw_data;
        trace__branch_taken = trace_pipe__branch_taken;
        trace__branch_target = trace_pipe__branch_target;
        trace__trap = trace_pipe__trap;
        trace__instr_valid__var = ((trace_pipe__instr_valid!=1'h0)&&(riscv_clk_enable!=1'h0));
        trace__rfw_data_valid__var = ((trace_pipe__rfw_data_valid!=1'h0)&&(riscv_clk_enable!=1'h0));
        trace__instr_valid = trace__instr_valid__var;
        trace__rfw_data_valid = trace__rfw_data_valid__var;
    end //always

    //b pipeline__posedge_clk_active_low_reset_n clock process
    always @( posedge clk or negedge reset_n)
    begin : pipeline__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            riscv_config_pipe__i32c <= 1'h0;
            riscv_config_pipe__e32 <= 1'h0;
            riscv_config_pipe__i32m <= 1'h0;
            riscv_config_pipe__i32m_fuse <= 1'h0;
            riscv_config_pipe__debug_enable <= 1'h0;
            riscv_config_pipe__coproc_disable <= 1'h0;
            riscv_config_pipe__unaligned_mem <= 1'h0;
        end
        else if (clk__enable)
        begin
            riscv_config_pipe__i32c <= riscv_config__i32c;
            riscv_config_pipe__e32 <= riscv_config__e32;
            riscv_config_pipe__i32m <= riscv_config__i32m;
            riscv_config_pipe__i32m_fuse <= riscv_config__i32m_fuse;
            riscv_config_pipe__debug_enable <= riscv_config__debug_enable;
            riscv_config_pipe__coproc_disable <= riscv_config__coproc_disable;
            riscv_config_pipe__unaligned_mem <= riscv_config__unaligned_mem;
            riscv_config_pipe__i32m <= 1'h0;
        end //if
    end //always

endmodule // riscv_i32_minimal
