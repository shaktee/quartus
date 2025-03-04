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

//a Module riscv_i32_pipeline_control_fetch_req
module riscv_i32_pipeline_control_fetch_req
(

    pipeline_response__decode__valid,
    pipeline_response__decode__blocked,
    pipeline_response__decode__branch_target,
    pipeline_response__decode__idecode__rs1,
    pipeline_response__decode__idecode__rs1_valid,
    pipeline_response__decode__idecode__rs2,
    pipeline_response__decode__idecode__rs2_valid,
    pipeline_response__decode__idecode__rd,
    pipeline_response__decode__idecode__rd_written,
    pipeline_response__decode__idecode__csr_access__access_cancelled,
    pipeline_response__decode__idecode__csr_access__access,
    pipeline_response__decode__idecode__csr_access__address,
    pipeline_response__decode__idecode__csr_access__write_data,
    pipeline_response__decode__idecode__immediate,
    pipeline_response__decode__idecode__immediate_shift,
    pipeline_response__decode__idecode__immediate_valid,
    pipeline_response__decode__idecode__op,
    pipeline_response__decode__idecode__subop,
    pipeline_response__decode__idecode__requires_machine_mode,
    pipeline_response__decode__idecode__memory_read_unsigned,
    pipeline_response__decode__idecode__memory_width,
    pipeline_response__decode__idecode__illegal,
    pipeline_response__decode__idecode__illegal_pc,
    pipeline_response__decode__idecode__is_compressed,
    pipeline_response__decode__idecode__ext__dummy,
    pipeline_response__decode__enable_branch_prediction,
    pipeline_response__exec__valid,
    pipeline_response__exec__cannot_start,
    pipeline_response__exec__cannot_complete,
    pipeline_response__exec__interrupt_ack,
    pipeline_response__exec__branch_taken,
    pipeline_response__exec__trap__valid,
    pipeline_response__exec__trap__to_mode,
    pipeline_response__exec__trap__cause,
    pipeline_response__exec__trap__pc,
    pipeline_response__exec__trap__value,
    pipeline_response__exec__trap__ret,
    pipeline_response__exec__trap__vector,
    pipeline_response__exec__trap__ebreak_to_dbg,
    pipeline_response__exec__is_compressed,
    pipeline_response__exec__instruction__data,
    pipeline_response__exec__instruction__debug__valid,
    pipeline_response__exec__instruction__debug__debug_op,
    pipeline_response__exec__instruction__debug__data,
    pipeline_response__exec__rs1,
    pipeline_response__exec__rs2,
    pipeline_response__exec__pc,
    pipeline_response__exec__predicted_branch,
    pipeline_response__exec__pc_if_mispredicted,
    pipeline_response__rfw__valid,
    pipeline_response__rfw__rd_written,
    pipeline_response__rfw__rd,
    pipeline_response__rfw__data,
    pipeline_response__pipeline_empty,
    pipeline_control__valid,
    pipeline_control__fetch_action,
    pipeline_control__decode_pc,
    pipeline_control__mode,
    pipeline_control__error,
    pipeline_control__tag,
    pipeline_control__halt,
    pipeline_control__ebreak_to_dbg,
    pipeline_control__interrupt_req,
    pipeline_control__interrupt_number,
    pipeline_control__interrupt_to_mode,
    pipeline_control__instruction_data,
    pipeline_control__instruction_debug__valid,
    pipeline_control__instruction_debug__debug_op,
    pipeline_control__instruction_debug__data,

    ifetch_req__flush_pipeline,
    ifetch_req__req_type,
    ifetch_req__debug_fetch,
    ifetch_req__address,
    ifetch_req__mode,
    ifetch_req__predicted_branch,
    ifetch_req__pc_if_mispredicted
);

    //b Clocks

    //b Inputs
    input pipeline_response__decode__valid;
    input pipeline_response__decode__blocked;
    input [31:0]pipeline_response__decode__branch_target;
    input [4:0]pipeline_response__decode__idecode__rs1;
    input pipeline_response__decode__idecode__rs1_valid;
    input [4:0]pipeline_response__decode__idecode__rs2;
    input pipeline_response__decode__idecode__rs2_valid;
    input [4:0]pipeline_response__decode__idecode__rd;
    input pipeline_response__decode__idecode__rd_written;
    input pipeline_response__decode__idecode__csr_access__access_cancelled;
    input [2:0]pipeline_response__decode__idecode__csr_access__access;
    input [11:0]pipeline_response__decode__idecode__csr_access__address;
    input [31:0]pipeline_response__decode__idecode__csr_access__write_data;
    input [31:0]pipeline_response__decode__idecode__immediate;
    input [4:0]pipeline_response__decode__idecode__immediate_shift;
    input pipeline_response__decode__idecode__immediate_valid;
    input [3:0]pipeline_response__decode__idecode__op;
    input [3:0]pipeline_response__decode__idecode__subop;
    input pipeline_response__decode__idecode__requires_machine_mode;
    input pipeline_response__decode__idecode__memory_read_unsigned;
    input [1:0]pipeline_response__decode__idecode__memory_width;
    input pipeline_response__decode__idecode__illegal;
    input pipeline_response__decode__idecode__illegal_pc;
    input pipeline_response__decode__idecode__is_compressed;
    input pipeline_response__decode__idecode__ext__dummy;
    input pipeline_response__decode__enable_branch_prediction;
    input pipeline_response__exec__valid;
    input pipeline_response__exec__cannot_start;
    input pipeline_response__exec__cannot_complete;
    input pipeline_response__exec__interrupt_ack;
    input pipeline_response__exec__branch_taken;
    input pipeline_response__exec__trap__valid;
    input [2:0]pipeline_response__exec__trap__to_mode;
    input [3:0]pipeline_response__exec__trap__cause;
    input [31:0]pipeline_response__exec__trap__pc;
    input [31:0]pipeline_response__exec__trap__value;
    input pipeline_response__exec__trap__ret;
    input pipeline_response__exec__trap__vector;
    input pipeline_response__exec__trap__ebreak_to_dbg;
    input pipeline_response__exec__is_compressed;
    input [31:0]pipeline_response__exec__instruction__data;
    input pipeline_response__exec__instruction__debug__valid;
    input [1:0]pipeline_response__exec__instruction__debug__debug_op;
    input [15:0]pipeline_response__exec__instruction__debug__data;
    input [31:0]pipeline_response__exec__rs1;
    input [31:0]pipeline_response__exec__rs2;
    input [31:0]pipeline_response__exec__pc;
    input pipeline_response__exec__predicted_branch;
    input [31:0]pipeline_response__exec__pc_if_mispredicted;
    input pipeline_response__rfw__valid;
    input pipeline_response__rfw__rd_written;
    input [4:0]pipeline_response__rfw__rd;
    input [31:0]pipeline_response__rfw__data;
    input pipeline_response__pipeline_empty;
    input pipeline_control__valid;
    input [2:0]pipeline_control__fetch_action;
    input [31:0]pipeline_control__decode_pc;
    input [2:0]pipeline_control__mode;
    input pipeline_control__error;
    input [1:0]pipeline_control__tag;
    input pipeline_control__halt;
    input pipeline_control__ebreak_to_dbg;
    input pipeline_control__interrupt_req;
    input [3:0]pipeline_control__interrupt_number;
    input [2:0]pipeline_control__interrupt_to_mode;
    input [31:0]pipeline_control__instruction_data;
    input pipeline_control__instruction_debug__valid;
    input [1:0]pipeline_control__instruction_debug__debug_op;
    input [15:0]pipeline_control__instruction_debug__data;

    //b Outputs
    output ifetch_req__flush_pipeline;
    output [2:0]ifetch_req__req_type;
    output ifetch_req__debug_fetch;
    output [31:0]ifetch_req__address;
    output [2:0]ifetch_req__mode;
    output ifetch_req__predicted_branch;
    output [31:0]ifetch_req__pc_if_mispredicted;

// output components here

    //b Output combinatorials
    reg ifetch_req__flush_pipeline;
    reg [2:0]ifetch_req__req_type;
    reg ifetch_req__debug_fetch;
    reg [31:0]ifetch_req__address;
    reg [2:0]ifetch_req__mode;
    reg ifetch_req__predicted_branch;
    reg [31:0]ifetch_req__pc_if_mispredicted;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials
    reg [31:0]ifetch_combs__pc_plus_4;
    reg [31:0]ifetch_combs__pc_plus_2;
    reg [31:0]ifetch_combs__pc_plus_inst;
    reg [31:0]ifetch_combs__pc_if_mispredicted;
    reg ifetch_combs__predict_branch;
    reg [31:0]ifetch_combs__fetch_next_pc;
    reg ifetch_combs__fetch_sequential;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b pipeline_control_logic combinatorial process
        //   
        //       The instruction fetch request derives from the
        //       decode/execute stage (the instruction address that is required
        //       next) and presents that to the outside world.
        //   
        //       This request may be for any 16-bit aligned address, and two
        //       successive 16-bit words from that request must be presented,
        //       aligned to bit 0.
        //   
        //       If the decode/execute stage is invalid (i.e. it does not have a
        //       valid instruction to decode) then the current PC is requested.
        //       
    always @ ( * )//pipeline_control_logic
    begin: pipeline_control_logic__comb_code
    reg [31:0]ifetch_combs__pc_plus_inst__var;
    reg ifetch_combs__predict_branch__var;
    reg [31:0]ifetch_combs__fetch_next_pc__var;
    reg ifetch_combs__fetch_sequential__var;
    reg [31:0]ifetch_combs__pc_if_mispredicted__var;
    reg ifetch_req__flush_pipeline__var;
    reg [2:0]ifetch_req__req_type__var;
    reg ifetch_req__debug_fetch__var;
    reg [31:0]ifetch_req__address__var;
    reg ifetch_req__predicted_branch__var;
    reg [31:0]ifetch_req__pc_if_mispredicted__var;
        ifetch_combs__pc_plus_4 = (pipeline_control__decode_pc+32'h4);
        ifetch_combs__pc_plus_2 = (pipeline_control__decode_pc+32'h2);
        ifetch_combs__pc_plus_inst__var = ifetch_combs__pc_plus_4;
        if ((pipeline_response__decode__idecode__is_compressed!=1'h0))
        begin
            ifetch_combs__pc_plus_inst__var = ifetch_combs__pc_plus_2;
        end //if
        ifetch_combs__predict_branch__var = 1'h0;
        case (pipeline_response__decode__idecode__op) //synopsys parallel_case
        4'h0: // req 1
            begin
            ifetch_combs__predict_branch__var = pipeline_response__decode__idecode__immediate[31];
            end
        4'h1: // req 1
            begin
            ifetch_combs__predict_branch__var = 1'h1;
            end
        //synopsys  translate_off
        //pragma coverage off
        //synopsys  translate_on
        default:
            begin
            //Need a default case to make Cadence Lint happy, even though this is not a full case
            end
        //synopsys  translate_off
        //pragma coverage on
        //synopsys  translate_on
        endcase
        if ((1'h0||!(pipeline_response__decode__enable_branch_prediction!=1'h0)))
        begin
            ifetch_combs__predict_branch__var = 1'h0;
        end //if
        ifetch_combs__fetch_next_pc__var = ifetch_combs__pc_plus_inst__var;
        ifetch_combs__fetch_sequential__var = 1'h1;
        ifetch_combs__pc_if_mispredicted__var = pipeline_response__decode__branch_target;
        if ((ifetch_combs__predict_branch__var!=1'h0))
        begin
            ifetch_combs__fetch_next_pc__var = pipeline_response__decode__branch_target;
            ifetch_combs__fetch_sequential__var = 1'h0;
            ifetch_combs__pc_if_mispredicted__var = ifetch_combs__pc_plus_inst__var;
        end //if
        ifetch_req__flush_pipeline__var = 1'h0;
        ifetch_req__req_type__var = 3'h0;
        ifetch_req__debug_fetch__var = 1'h0;
        ifetch_req__address__var = 32'h0;
        ifetch_req__mode = 3'h0;
        ifetch_req__predicted_branch__var = 1'h0;
        ifetch_req__pc_if_mispredicted__var = 32'h0;
        ifetch_req__predicted_branch__var = ifetch_combs__predict_branch__var;
        ifetch_req__pc_if_mispredicted__var = ifetch_combs__pc_if_mispredicted__var;
        ifetch_req__flush_pipeline__var = 1'h1;
        ifetch_req__req_type__var = 3'h0;
        case (pipeline_control__fetch_action) //synopsys parallel_case
        3'h2: // req 1
            begin
            ifetch_req__flush_pipeline__var = 1'h1;
            ifetch_req__req_type__var = 3'h1;
            ifetch_req__address__var = pipeline_control__decode_pc;
            end
        3'h3: // req 1
            begin
            ifetch_req__flush_pipeline__var = 1'h0;
            ifetch_req__req_type__var = 3'h3;
            ifetch_req__address__var = ifetch_combs__fetch_next_pc__var;
            end
        3'h4: // req 1
            begin
            ifetch_req__flush_pipeline__var = 1'h0;
            ifetch_req__req_type__var = 3'h1;
            if ((ifetch_combs__fetch_sequential__var!=1'h0))
            begin
                ifetch_req__req_type__var = ((pipeline_response__decode__idecode__is_compressed!=1'h0)?3'h6:3'h2);
            end //if
            ifetch_req__address__var = ifetch_combs__fetch_next_pc__var;
            end
        3'h1: // req 1
            begin
            ifetch_req__flush_pipeline__var = 1'h0;
            end
        default: // req 1
            begin
            ifetch_req__flush_pipeline__var = 1'h1;
            end
        endcase
        ifetch_req__debug_fetch__var = 1'h0;
        if ((pipeline_control__mode==3'h7))
        begin
            if ((((pipeline_control__fetch_action!=3'h0)&&(pipeline_control__fetch_action!=3'h1))&&(ifetch_req__address__var[31:8]==24'hffffff)))
            begin
                ifetch_req__req_type__var = 3'h0;
                ifetch_req__debug_fetch__var = 1'h1;
            end //if
        end //if
        ifetch_combs__pc_plus_inst = ifetch_combs__pc_plus_inst__var;
        ifetch_combs__predict_branch = ifetch_combs__predict_branch__var;
        ifetch_combs__fetch_next_pc = ifetch_combs__fetch_next_pc__var;
        ifetch_combs__fetch_sequential = ifetch_combs__fetch_sequential__var;
        ifetch_combs__pc_if_mispredicted = ifetch_combs__pc_if_mispredicted__var;
        ifetch_req__flush_pipeline = ifetch_req__flush_pipeline__var;
        ifetch_req__req_type = ifetch_req__req_type__var;
        ifetch_req__debug_fetch = ifetch_req__debug_fetch__var;
        ifetch_req__address = ifetch_req__address__var;
        ifetch_req__predicted_branch = ifetch_req__predicted_branch__var;
        ifetch_req__pc_if_mispredicted = ifetch_req__pc_if_mispredicted__var;
    end //always

endmodule // riscv_i32_pipeline_control_fetch_req
