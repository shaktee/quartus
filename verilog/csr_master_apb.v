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

//a Module csr_master_apb
    //   
    //   The documentation of the CSR interface itself is in other files (at
    //   this time, csr_target_csr.cdl).
    //   
    //   This module drives a CSR interface in response to an incoming APB
    //   interface; it is an APB target presenting a CSR master interface.  Its
    //   purpose is to permit an extension of an APB bus through a CSR target
    //   pipelined chain, hence providing for a timing-friendly CSR interface
    //   in an FPGA or ASIC.
    //   
    //   The APB has a 32-bit @p paddr field, which is presented as 16 bits of
    //   CSR select and 16 bits of CSR address on the CSR interface. There is
    //   no timeout in this module on the CSR interface, so accesses to CSRs
    //   that have no responder on the bus will hang the module.
    //   
    //   It is therefore wise to add a CSR target that detects very long
    //   transactions, and which responds by acknowledging them, to the CSR
    //   chain.
    //   
    //   
module csr_master_apb
(
    clk,
    clk__enable,

    csr_response__acknowledge,
    csr_response__read_data_valid,
    csr_response__read_data_error,
    csr_response__read_data,
    apb_request__paddr,
    apb_request__penable,
    apb_request__psel,
    apb_request__pwrite,
    apb_request__pwdata,
    reset_n,

    csr_request__valid,
    csr_request__read_not_write,
    csr_request__select,
    csr_request__address,
    csr_request__data,
    apb_response__prdata,
    apb_response__pready,
    apb_response__perr
);

    //b Clocks
        //   Clock for the APB and CSR interface; must be a superset of all targets clock
    input clk;
    input clk__enable;

    //b Inputs
        //   Pipelined csr request interface response
    input csr_response__acknowledge;
    input csr_response__read_data_valid;
    input csr_response__read_data_error;
    input [31:0]csr_response__read_data;
        //   APB request from master
    input [31:0]apb_request__paddr;
    input apb_request__penable;
    input apb_request__psel;
    input apb_request__pwrite;
    input [31:0]apb_request__pwdata;
        //   Active low reset
    input reset_n;

    //b Outputs
        //   Pipelined csr request interface output
    output csr_request__valid;
    output csr_request__read_not_write;
    output [15:0]csr_request__select;
    output [15:0]csr_request__address;
    output [31:0]csr_request__data;
        //   APB response to master
    output [31:0]apb_response__prdata;
    output apb_response__pready;
    output apb_response__perr;

// output components here

    //b Output combinatorials

    //b Output nets

    //b Internal and output registers
        //   Asserted if a CSR request is in progress
    reg csr_request_in_progress;
        //   State of the APB interface
    reg [2:0]apb_state__fsm_state;
    reg csr_request__valid;
    reg csr_request__read_not_write;
    reg [15:0]csr_request__select;
    reg [15:0]csr_request__address;
    reg [31:0]csr_request__data;
    reg [31:0]apb_response__prdata;
    reg apb_response__pready;
    reg apb_response__perr;

    //b Internal combinatorials
        //   Decode of APB state and request to determine next action
    reg [2:0]apb_action;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b apb_target_logic__comb combinatorial process
        //   
        //       The APB target interface accepts an incoming request, holding it
        //       with @p pready low until the CSR request can start (i.e. until
        //       csr_request_in_progress is clear). It does this by the FSM staying
        //       in the state, waiting for previous CSR request.
        //   
        //       When an APB request can be taken, the APB will have either an
        //       action to start a CSR write or to start a CSR read. These will
        //       kick the state machines on appropriately, and drive the CSR
        //       request out with the required data.
        //   
        //       A write transaction completes at this point, asserting @p
        //       pready. If another APB transaction comes in before the CSR
        //       interface completes the current write (which occurs when the CSR
        //       @a acknowledge goes high and then low), then that transaction will be
        //       waited.
        //   
        //       A read transaction has to wait for read_data_valid from the
        //       target; hence it waits for the acknowledge, and the read_data_valid, and
        //       then presents @p prdata and @p pready high.
        //       
    always @ ( * )//apb_target_logic__comb
    begin: apb_target_logic__comb_code
    reg [2:0]apb_action__var;
        apb_action__var = 3'h0;
        case (apb_state__fsm_state) //synopsys parallel_case
        3'h0: // req 1
            begin
            if ((apb_request__psel!=1'h0))
            begin
                apb_action__var = ((apb_request__pwrite!=1'h0)?3'h2:3'h3);
                if (((csr_request_in_progress!=1'h0)||(csr_response__read_data_valid!=1'h0)))
                begin
                    apb_action__var = 3'h1;
                end //if
            end //if
            end
        3'h1: // req 1
            begin
            if ((!(csr_request_in_progress!=1'h0)&&!(csr_response__read_data_valid!=1'h0)))
            begin
                apb_action__var = ((apb_request__pwrite!=1'h0)?3'h2:3'h3);
            end //if
            end
        3'h2: // req 1
            begin
            apb_action__var = 3'h4;
            end
        3'h3: // req 1
            begin
            if ((csr_response__read_data_valid!=1'h0))
            begin
                apb_action__var = 3'h5;
            end //if
            end
        3'h4: // req 1
            begin
            apb_action__var = 3'h6;
            end
    //synopsys  translate_off
    //pragma coverage off
        default:
            begin
                if (1)
                begin
                    $display("%t *********CDL ASSERTION FAILURE:csr_master_apb:apb_target_logic: Full switch statement did not cover all values", $time);
                end
            end
    //pragma coverage on
    //synopsys  translate_on
        endcase
        apb_action = apb_action__var;
    end //always

    //b apb_target_logic__posedge_clk_active_low_reset_n clock process
        //   
        //       The APB target interface accepts an incoming request, holding it
        //       with @p pready low until the CSR request can start (i.e. until
        //       csr_request_in_progress is clear). It does this by the FSM staying
        //       in the state, waiting for previous CSR request.
        //   
        //       When an APB request can be taken, the APB will have either an
        //       action to start a CSR write or to start a CSR read. These will
        //       kick the state machines on appropriately, and drive the CSR
        //       request out with the required data.
        //   
        //       A write transaction completes at this point, asserting @p
        //       pready. If another APB transaction comes in before the CSR
        //       interface completes the current write (which occurs when the CSR
        //       @a acknowledge goes high and then low), then that transaction will be
        //       waited.
        //   
        //       A read transaction has to wait for read_data_valid from the
        //       target; hence it waits for the acknowledge, and the read_data_valid, and
        //       then presents @p prdata and @p pready high.
        //       
    always @( posedge clk or negedge reset_n)
    begin : apb_target_logic__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            apb_response__perr <= 1'h0;
            csr_request__valid <= 1'h0;
            csr_request_in_progress <= 1'h0;
            apb_response__pready <= 1'h0;
            apb_state__fsm_state <= 3'h0;
            apb_state__fsm_state <= 3'h0;
            csr_request__address <= 16'h0;
            csr_request__select <= 16'h0;
            csr_request__read_not_write <= 1'h0;
            csr_request__data <= 32'h0;
            apb_response__prdata <= 32'h0;
        end
        else if (clk__enable)
        begin
            apb_response__perr <= 1'h0;
            if (((csr_response__acknowledge!=1'h0)&&(csr_request__valid!=1'h0)))
            begin
                csr_request__valid <= 1'h0;
            end //if
            if ((csr_request_in_progress!=1'h0))
            begin
                if ((csr_request__read_not_write!=1'h0))
                begin
                    if ((csr_response__read_data_valid!=1'h0))
                    begin
                        csr_request_in_progress <= 1'h0;
                    end //if
                end //if
                else
                
                begin
                    if ((!(csr_request__valid!=1'h0)&&!(csr_response__acknowledge!=1'h0)))
                    begin
                        csr_request_in_progress <= 1'h0;
                    end //if
                end //else
            end //if
            case (apb_action) //synopsys parallel_case
            3'h2: // req 1
                begin
                apb_response__pready <= 1'h1;
                apb_state__fsm_state <= 3'h2;
                csr_request__valid <= 1'h1;
                csr_request__address <= apb_request__paddr[15:0];
                csr_request__select <= apb_request__paddr[31:16];
                csr_request__read_not_write <= 1'h0;
                csr_request__data <= apb_request__pwdata;
                csr_request_in_progress <= 1'h1;
                end
            3'h3: // req 1
                begin
                apb_response__pready <= 1'h0;
                apb_state__fsm_state <= 3'h3;
                csr_request__valid <= 1'h1;
                csr_request__address <= apb_request__paddr[15:0];
                csr_request__select <= apb_request__paddr[31:16];
                csr_request__read_not_write <= 1'h1;
                csr_request_in_progress <= 1'h1;
                end
            3'h1: // req 1
                begin
                apb_response__pready <= 1'h0;
                apb_state__fsm_state <= 3'h1;
                end
            3'h4: // req 1
                begin
                apb_response__pready <= 1'h1;
                apb_state__fsm_state <= 3'h0;
                end
            3'h5: // req 1
                begin
                apb_response__pready <= 1'h1;
                apb_response__prdata <= csr_response__read_data;
                apb_response__perr <= csr_response__read_data_error;
                apb_state__fsm_state <= 3'h4;
                end
            3'h6: // req 1
                begin
                apb_response__pready <= 1'h1;
                apb_state__fsm_state <= 3'h0;
                end
            3'h0: // req 1
                begin
                apb_state__fsm_state <= apb_state__fsm_state;
                end
    //synopsys  translate_off
    //pragma coverage off
            default:
                begin
                    if (1)
                    begin
                        $display("%t *********CDL ASSERTION FAILURE:csr_master_apb:apb_target_logic: Full switch statement did not cover all values", $time);
                    end
                end
    //pragma coverage on
    //synopsys  translate_on
            endcase
        end //if
    end //always

endmodule // csr_master_apb
