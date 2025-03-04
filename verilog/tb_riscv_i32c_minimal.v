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

//a Module tb_riscv_i32c_minimal
module tb_riscv_i32c_minimal
(
    jtag_tck,
    jtag_tck__enable,
    clk,
    clk__enable,

    reset_n

);

    //b Clocks
    input jtag_tck;
    input jtag_tck__enable;
    wire jtag_tck_gated; // Gated version of clock 'jtag_tck' enabled by 'tck_enable_fix'
    wire jtag_tck_gated__enable;
    input clk;
    input clk__enable;

    //b Inputs
    input reset_n;

    //b Outputs

// output components here

    //b Output combinatorials

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials
    reg tck_enable_fix;
    reg irqs__nmi;
    reg irqs__meip;
    reg irqs__seip;
    reg irqs__ueip;
    reg irqs__mtip;
    reg irqs__msip;
    reg [63:0]irqs__time;
    reg timer_control__reset_counter;
    reg timer_control__enable_counter;
    reg timer_control__block_writes;
    reg [7:0]timer_control__bonus_subfraction_numer;
    reg [7:0]timer_control__bonus_subfraction_denom;
    reg [3:0]timer_control__fractional_adder;
    reg [7:0]timer_control__integer_adder;
    reg [31:0]jtag_apb_response__prdata;
    reg jtag_apb_response__pready;
    reg jtag_apb_response__perr;
    reg [31:0]mux_apb_response__prdata;
    reg mux_apb_response__pready;
    reg mux_apb_response__perr;
    reg [31:0]debug_apb_request__paddr;
    reg debug_apb_request__penable;
    reg debug_apb_request__psel;
    reg debug_apb_request__pwrite;
    reg [31:0]debug_apb_request__pwdata;
    reg [31:0]sram_apb_request__paddr;
    reg sram_apb_request__penable;
    reg sram_apb_request__psel;
    reg sram_apb_request__pwrite;
    reg [31:0]sram_apb_request__pwdata;
    reg [31:0]timer_apb_request__paddr;
    reg timer_apb_request__penable;
    reg timer_apb_request__psel;
    reg timer_apb_request__pwrite;
    reg [31:0]timer_apb_request__pwdata;
    reg [31:0]th_apb_request__paddr;
    reg th_apb_request__penable;
    reg th_apb_request__psel;
    reg th_apb_request__pwrite;
    reg [31:0]th_apb_request__pwdata;
    reg riscv_config__i32c;
    reg riscv_config__e32;
    reg riscv_config__i32m;
    reg riscv_config__i32m_fuse;
    reg riscv_config__debug_enable;
    reg riscv_config__coproc_disable;
    reg riscv_config__unaligned_mem;

    //b Internal nets
    wire debug_tgt__valid;
    wire [5:0]debug_tgt__selected;
    wire debug_tgt__halted;
    wire debug_tgt__resumed;
    wire debug_tgt__hit_breakpoint;
    wire debug_tgt__op_was_none;
    wire [1:0]debug_tgt__resp;
    wire [31:0]debug_tgt__data;
    wire debug_tgt__attention;
    wire debug_mst__valid;
    wire [5:0]debug_mst__select;
    wire [5:0]debug_mst__mask;
    wire [3:0]debug_mst__op;
    wire [15:0]debug_mst__arg;
    wire [31:0]debug_mst__data;
    wire tck_enable;
    wire [49:0]dr_out;
    wire [49:0]dr_tdi_mask;
    wire [49:0]dr_in;
    wire [1:0]dr_action;
    wire [4:0]ir;
    wire tdo;
    wire jtag__ntrst;
    wire jtag__tms;
    wire jtag__tdi;
    wire trace__instr_valid;
    wire [31:0]trace__instr_pc;
    wire [31:0]trace__instruction__data;
    wire trace__instruction__debug__valid;
    wire [1:0]trace__instruction__debug__debug_op;
    wire [15:0]trace__instruction__debug__data;
    wire trace__rfw_retire;
    wire trace__rfw_data_valid;
    wire [4:0]trace__rfw_rd;
    wire [31:0]trace__rfw_data;
    wire trace__branch_taken;
    wire [31:0]trace__branch_target;
    wire trace__trap;
    wire debug_enable;
    wire timer_value__irq;
    wire [63:0]timer_value__value;
    wire [31:0]th_apb_response__prdata;
    wire th_apb_response__pready;
    wire th_apb_response__perr;
    wire [31:0]data_access_apb_response__prdata;
    wire data_access_apb_response__pready;
    wire data_access_apb_response__perr;
    wire [31:0]debug_apb_response__prdata;
    wire debug_apb_response__pready;
    wire debug_apb_response__perr;
    wire [31:0]sram_apb_response__prdata;
    wire sram_apb_response__pready;
    wire sram_apb_response__perr;
    wire [31:0]timer_apb_response__prdata;
    wire timer_apb_response__pready;
    wire timer_apb_response__perr;
    wire [31:0]mux_apb_request__paddr;
    wire mux_apb_request__penable;
    wire mux_apb_request__psel;
    wire mux_apb_request__pwrite;
    wire [31:0]mux_apb_request__pwdata;
    wire [31:0]data_access_apb_request__paddr;
    wire data_access_apb_request__penable;
    wire data_access_apb_request__psel;
    wire data_access_apb_request__pwrite;
    wire [31:0]data_access_apb_request__pwdata;
    wire [31:0]jtag_apb_request__paddr;
    wire jtag_apb_request__penable;
    wire jtag_apb_request__psel;
    wire jtag_apb_request__pwrite;
    wire [31:0]jtag_apb_request__pwdata;
    wire [31:0]sram_ctrl;
    wire [31:0]data_access_req__address;
    wire [3:0]data_access_req__byte_enable;
    wire data_access_req__write_enable;
    wire data_access_req__read_enable;
    wire [31:0]data_access_req__write_data;
    wire data_access_resp__wait;
    wire [31:0]data_access_resp__read_data;
    wire sram_access_req__valid;
    wire [3:0]sram_access_req__id;
    wire sram_access_req__read_not_write;
    wire [7:0]sram_access_req__byte_enable;
    wire [31:0]sram_access_req__address;
    wire [63:0]sram_access_req__write_data;
    wire sram_access_resp__ack;
    wire sram_access_resp__valid;
    wire [3:0]sram_access_resp__id;
    wire [63:0]sram_access_resp__data;

    //b Clock gating module instances
    assign jtag_tck_gated__enable = (jtag_tck__enable && tck_enable_fix);
    //b Module instances
    riscv_i32_minimal_apb rv_apb(
        .clk(clk),
        .clk__enable(1'b1),
        .apb_response__perr(data_access_apb_response__perr),
        .apb_response__pready(data_access_apb_response__pready),
        .apb_response__prdata(data_access_apb_response__prdata),
        .data_access_req__write_data(data_access_req__write_data),
        .data_access_req__read_enable(data_access_req__read_enable),
        .data_access_req__write_enable(data_access_req__write_enable),
        .data_access_req__byte_enable(data_access_req__byte_enable),
        .data_access_req__address(data_access_req__address),
        .reset_n(reset_n),
        .apb_request__pwdata(            data_access_apb_request__pwdata),
        .apb_request__pwrite(            data_access_apb_request__pwrite),
        .apb_request__psel(            data_access_apb_request__psel),
        .apb_request__penable(            data_access_apb_request__penable),
        .apb_request__paddr(            data_access_apb_request__paddr),
        .data_access_resp__read_data(            data_access_resp__read_data),
        .data_access_resp__wait(            data_access_resp__wait)         );
    apb_master_mux apbmux(
        .clk(clk),
        .clk__enable(1'b1),
        .apb_response__perr(mux_apb_response__perr),
        .apb_response__pready(mux_apb_response__pready),
        .apb_response__prdata(mux_apb_response__prdata),
        .apb_request_1__pwdata(th_apb_request__pwdata),
        .apb_request_1__pwrite(th_apb_request__pwrite),
        .apb_request_1__psel(th_apb_request__psel),
        .apb_request_1__penable(th_apb_request__penable),
        .apb_request_1__paddr(th_apb_request__paddr),
        .apb_request_0__pwdata(data_access_apb_request__pwdata),
        .apb_request_0__pwrite(data_access_apb_request__pwrite),
        .apb_request_0__psel(data_access_apb_request__psel),
        .apb_request_0__penable(data_access_apb_request__penable),
        .apb_request_0__paddr(data_access_apb_request__paddr),
        .reset_n(reset_n),
        .apb_request__pwdata(            mux_apb_request__pwdata),
        .apb_request__pwrite(            mux_apb_request__pwrite),
        .apb_request__psel(            mux_apb_request__psel),
        .apb_request__penable(            mux_apb_request__penable),
        .apb_request__paddr(            mux_apb_request__paddr),
        .apb_response_1__perr(            th_apb_response__perr),
        .apb_response_1__pready(            th_apb_response__pready),
        .apb_response_1__prdata(            th_apb_response__prdata),
        .apb_response_0__perr(            data_access_apb_response__perr),
        .apb_response_0__pready(            data_access_apb_response__pready),
        .apb_response_0__prdata(            data_access_apb_response__prdata)         );
    apb_target_rv_timer timer(
        .clk(clk),
        .clk__enable(1'b1),
        .apb_request__pwdata(timer_apb_request__pwdata),
        .apb_request__pwrite(timer_apb_request__pwrite),
        .apb_request__psel(timer_apb_request__psel),
        .apb_request__penable(timer_apb_request__penable),
        .apb_request__paddr(timer_apb_request__paddr),
        .timer_control__integer_adder(timer_control__integer_adder),
        .timer_control__fractional_adder(timer_control__fractional_adder),
        .timer_control__bonus_subfraction_denom(timer_control__bonus_subfraction_denom),
        .timer_control__bonus_subfraction_numer(timer_control__bonus_subfraction_numer),
        .timer_control__block_writes(timer_control__block_writes),
        .timer_control__enable_counter(timer_control__enable_counter),
        .timer_control__reset_counter(timer_control__reset_counter),
        .reset_n(reset_n),
        .timer_value__value(            timer_value__value),
        .timer_value__irq(            timer_value__irq),
        .apb_response__perr(            timer_apb_response__perr),
        .apb_response__pready(            timer_apb_response__pready),
        .apb_response__prdata(            timer_apb_response__prdata)         );
    apb_target_sram_interface sram_if(
        .clk(clk),
        .clk__enable(1'b1),
        .sram_access_resp__data(sram_access_resp__data),
        .sram_access_resp__id(sram_access_resp__id),
        .sram_access_resp__valid(sram_access_resp__valid),
        .sram_access_resp__ack(sram_access_resp__ack),
        .apb_request__pwdata(sram_apb_request__pwdata),
        .apb_request__pwrite(sram_apb_request__pwrite),
        .apb_request__psel(sram_apb_request__psel),
        .apb_request__penable(sram_apb_request__penable),
        .apb_request__paddr(sram_apb_request__paddr),
        .reset_n(reset_n),
        .sram_access_req__write_data(            sram_access_req__write_data),
        .sram_access_req__address(            sram_access_req__address),
        .sram_access_req__byte_enable(            sram_access_req__byte_enable),
        .sram_access_req__read_not_write(            sram_access_req__read_not_write),
        .sram_access_req__id(            sram_access_req__id),
        .sram_access_req__valid(            sram_access_req__valid),
        .sram_ctrl(            sram_ctrl),
        .apb_response__perr(            sram_apb_response__perr),
        .apb_response__pready(            sram_apb_response__pready),
        .apb_response__prdata(            sram_apb_response__prdata)         );
    se_test_harness th(
        .clk(jtag_tck),
        .clk__enable(1'b1),
        .tdo(tdo),
        .tck_enable(            tck_enable),
        .jtag__tdi(            jtag__tdi),
        .jtag__tms(            jtag__tms),
        .jtag__ntrst(            jtag__ntrst),
        .debug_enable(            debug_enable)         );
    jtag_tap tap(
        .jtag_tck(jtag_tck),
        .jtag_tck__enable(jtag_tck_gated__enable),
        .dr_out(dr_out),
        .dr_tdi_mask(dr_tdi_mask),
        .jtag__tdi(jtag__tdi),
        .jtag__tms(jtag__tms),
        .jtag__ntrst(jtag__ntrst),
        .reset_n(reset_n),
        .dr_in(            dr_in),
        .dr_action(            dr_action),
        .ir(            ir),
        .tdo(            tdo)         );
    riscv_jtag_apb_dm dm_apb(
        .apb_clock(clk),
        .apb_clock__enable(1'b1),
        .jtag_tck(jtag_tck),
        .jtag_tck__enable(jtag_tck_gated__enable),
        .apb_response__perr(jtag_apb_response__perr),
        .apb_response__pready(jtag_apb_response__pready),
        .apb_response__prdata(jtag_apb_response__prdata),
        .dr_in(dr_in),
        .dr_action(dr_action),
        .ir(ir),
        .reset_n(reset_n),
        .apb_request__pwdata(            jtag_apb_request__pwdata),
        .apb_request__pwrite(            jtag_apb_request__pwrite),
        .apb_request__psel(            jtag_apb_request__psel),
        .apb_request__penable(            jtag_apb_request__penable),
        .apb_request__paddr(            jtag_apb_request__paddr),
        .dr_out(            dr_out),
        .dr_tdi_mask(            dr_tdi_mask)         );
    riscv_i32_debug dm(
        .clk(clk),
        .clk__enable(1'b1),
        .debug_tgt__attention(debug_tgt__attention),
        .debug_tgt__data(debug_tgt__data),
        .debug_tgt__resp(debug_tgt__resp),
        .debug_tgt__op_was_none(debug_tgt__op_was_none),
        .debug_tgt__hit_breakpoint(debug_tgt__hit_breakpoint),
        .debug_tgt__resumed(debug_tgt__resumed),
        .debug_tgt__halted(debug_tgt__halted),
        .debug_tgt__selected(debug_tgt__selected),
        .debug_tgt__valid(debug_tgt__valid),
        .apb_request__pwdata(debug_apb_request__pwdata),
        .apb_request__pwrite(debug_apb_request__pwrite),
        .apb_request__psel(debug_apb_request__psel),
        .apb_request__penable(debug_apb_request__penable),
        .apb_request__paddr(debug_apb_request__paddr),
        .reset_n(reset_n),
        .debug_mst__data(            debug_mst__data),
        .debug_mst__arg(            debug_mst__arg),
        .debug_mst__op(            debug_mst__op),
        .debug_mst__mask(            debug_mst__mask),
        .debug_mst__select(            debug_mst__select),
        .debug_mst__valid(            debug_mst__valid),
        .apb_response__perr(            debug_apb_response__perr),
        .apb_response__pready(            debug_apb_response__pready),
        .apb_response__prdata(            debug_apb_response__prdata)         );
    riscv_i32_minimal dut(
        .clk(clk),
        .clk__enable(1'b1),
        .riscv_config__unaligned_mem(riscv_config__unaligned_mem),
        .riscv_config__coproc_disable(riscv_config__coproc_disable),
        .riscv_config__debug_enable(riscv_config__debug_enable),
        .riscv_config__i32m_fuse(riscv_config__i32m_fuse),
        .riscv_config__i32m(riscv_config__i32m),
        .riscv_config__e32(riscv_config__e32),
        .riscv_config__i32c(riscv_config__i32c),
        .debug_mst__data(debug_mst__data),
        .debug_mst__arg(debug_mst__arg),
        .debug_mst__op(debug_mst__op),
        .debug_mst__mask(debug_mst__mask),
        .debug_mst__select(debug_mst__select),
        .debug_mst__valid(debug_mst__valid),
        .sram_access_req__write_data(sram_access_req__write_data),
        .sram_access_req__address(sram_access_req__address),
        .sram_access_req__byte_enable(sram_access_req__byte_enable),
        .sram_access_req__read_not_write(sram_access_req__read_not_write),
        .sram_access_req__id(sram_access_req__id),
        .sram_access_req__valid(sram_access_req__valid),
        .data_access_resp__read_data(data_access_resp__read_data),
        .data_access_resp__wait(data_access_resp__wait),
        .irqs__time(irqs__time),
        .irqs__msip(irqs__msip),
        .irqs__mtip(irqs__mtip),
        .irqs__ueip(irqs__ueip),
        .irqs__seip(irqs__seip),
        .irqs__meip(irqs__meip),
        .irqs__nmi(irqs__nmi),
        .reset_n(reset_n),
        .proc_reset_n((reset_n & !(sram_ctrl[0]!=1'h0))),
        .trace__trap(            trace__trap),
        .trace__branch_target(            trace__branch_target),
        .trace__branch_taken(            trace__branch_taken),
        .trace__rfw_data(            trace__rfw_data),
        .trace__rfw_rd(            trace__rfw_rd),
        .trace__rfw_data_valid(            trace__rfw_data_valid),
        .trace__rfw_retire(            trace__rfw_retire),
        .trace__instruction__debug__data(            trace__instruction__debug__data),
        .trace__instruction__debug__debug_op(            trace__instruction__debug__debug_op),
        .trace__instruction__debug__valid(            trace__instruction__debug__valid),
        .trace__instruction__data(            trace__instruction__data),
        .trace__instr_pc(            trace__instr_pc),
        .trace__instr_valid(            trace__instr_valid),
        .debug_tgt__attention(            debug_tgt__attention),
        .debug_tgt__data(            debug_tgt__data),
        .debug_tgt__resp(            debug_tgt__resp),
        .debug_tgt__op_was_none(            debug_tgt__op_was_none),
        .debug_tgt__hit_breakpoint(            debug_tgt__hit_breakpoint),
        .debug_tgt__resumed(            debug_tgt__resumed),
        .debug_tgt__halted(            debug_tgt__halted),
        .debug_tgt__selected(            debug_tgt__selected),
        .debug_tgt__valid(            debug_tgt__valid),
        .sram_access_resp__data(            sram_access_resp__data),
        .sram_access_resp__id(            sram_access_resp__id),
        .sram_access_resp__valid(            sram_access_resp__valid),
        .sram_access_resp__ack(            sram_access_resp__ack),
        .data_access_req__write_data(            data_access_req__write_data),
        .data_access_req__read_enable(            data_access_req__read_enable),
        .data_access_req__write_enable(            data_access_req__write_enable),
        .data_access_req__byte_enable(            data_access_req__byte_enable),
        .data_access_req__address(            data_access_req__address)         );
    riscv_i32_trace trace(
        .clk(clk),
        .clk__enable(1'b1),
        .trace__trap(trace__trap),
        .trace__branch_target(trace__branch_target),
        .trace__branch_taken(trace__branch_taken),
        .trace__rfw_data(trace__rfw_data),
        .trace__rfw_rd(trace__rfw_rd),
        .trace__rfw_data_valid(trace__rfw_data_valid),
        .trace__rfw_retire(trace__rfw_retire),
        .trace__instruction__debug__data(trace__instruction__debug__data),
        .trace__instruction__debug__debug_op(trace__instruction__debug__debug_op),
        .trace__instruction__debug__valid(trace__instruction__debug__valid),
        .trace__instruction__data(trace__instruction__data),
        .trace__instr_pc(trace__instr_pc),
        .trace__instr_valid(trace__instr_valid),
        .riscv_clk_enable(1'h1),
        .reset_n(reset_n)         );
    //b riscv_instance combinatorial process
    always @ ( * )//riscv_instance
    begin: riscv_instance__comb_code
    reg riscv_config__i32c__var;
    reg riscv_config__e32__var;
    reg riscv_config__debug_enable__var;
    reg irqs__mtip__var;
    reg [31:0]th_apb_request__paddr__var;
        riscv_config__i32c__var = 1'h0;
        riscv_config__e32__var = 1'h0;
        riscv_config__i32m = 1'h0;
        riscv_config__i32m_fuse = 1'h0;
        riscv_config__debug_enable__var = 1'h0;
        riscv_config__coproc_disable = 1'h0;
        riscv_config__unaligned_mem = 1'h0;
        riscv_config__e32__var = 1'h0;
        riscv_config__i32c__var = 1'h1;
        riscv_config__debug_enable__var = debug_enable;
        irqs__nmi = 1'h0;
        irqs__meip = 1'h0;
        irqs__seip = 1'h0;
        irqs__ueip = 1'h0;
        irqs__mtip__var = 1'h0;
        irqs__msip = 1'h0;
        irqs__time = 64'h0;
        irqs__mtip__var = timer_value__irq;
        th_apb_request__paddr__var = jtag_apb_request__paddr;
        th_apb_request__penable = jtag_apb_request__penable;
        th_apb_request__psel = jtag_apb_request__psel;
        th_apb_request__pwrite = jtag_apb_request__pwrite;
        th_apb_request__pwdata = jtag_apb_request__pwdata;
        th_apb_request__paddr__var = {{{16'h0,4'h2},jtag_apb_request__paddr[9:0]},2'h0};
        jtag_apb_response__prdata = th_apb_response__prdata;
        jtag_apb_response__pready = th_apb_response__pready;
        jtag_apb_response__perr = th_apb_response__perr;
        riscv_config__i32c = riscv_config__i32c__var;
        riscv_config__e32 = riscv_config__e32__var;
        riscv_config__debug_enable = riscv_config__debug_enable__var;
        irqs__mtip = irqs__mtip__var;
        th_apb_request__paddr = th_apb_request__paddr__var;
    end //always

    //b apb_peripherals combinatorial process
    always @ ( * )//apb_peripherals
    begin: apb_peripherals__comb_code
    reg timer_control__enable_counter__var;
    reg [3:0]timer_control__fractional_adder__var;
    reg [7:0]timer_control__integer_adder__var;
    reg [31:0]timer_apb_request__paddr__var;
    reg timer_apb_request__psel__var;
    reg [31:0]sram_apb_request__paddr__var;
    reg sram_apb_request__psel__var;
    reg [31:0]debug_apb_request__paddr__var;
    reg debug_apb_request__psel__var;
    reg [31:0]mux_apb_response__prdata__var;
    reg mux_apb_response__pready__var;
    reg mux_apb_response__perr__var;
        tck_enable_fix = tck_enable;
        timer_control__reset_counter = 1'h0;
        timer_control__enable_counter__var = 1'h0;
        timer_control__block_writes = 1'h0;
        timer_control__bonus_subfraction_numer = 8'h0;
        timer_control__bonus_subfraction_denom = 8'h0;
        timer_control__fractional_adder__var = 4'h0;
        timer_control__integer_adder__var = 8'h0;
        timer_control__enable_counter__var = 1'h1;
        timer_control__fractional_adder__var = 4'h2;
        timer_control__integer_adder__var = 8'h0;
        timer_apb_request__paddr__var = mux_apb_request__paddr;
        timer_apb_request__penable = mux_apb_request__penable;
        timer_apb_request__psel__var = mux_apb_request__psel;
        timer_apb_request__pwrite = mux_apb_request__pwrite;
        timer_apb_request__pwdata = mux_apb_request__pwdata;
        sram_apb_request__paddr__var = mux_apb_request__paddr;
        sram_apb_request__penable = mux_apb_request__penable;
        sram_apb_request__psel__var = mux_apb_request__psel;
        sram_apb_request__pwrite = mux_apb_request__pwrite;
        sram_apb_request__pwdata = mux_apb_request__pwdata;
        debug_apb_request__paddr__var = mux_apb_request__paddr;
        debug_apb_request__penable = mux_apb_request__penable;
        debug_apb_request__psel__var = mux_apb_request__psel;
        debug_apb_request__pwrite = mux_apb_request__pwrite;
        debug_apb_request__pwdata = mux_apb_request__pwdata;
        timer_apb_request__psel__var = ((mux_apb_request__psel!=1'h0)&&(mux_apb_request__paddr[15:12]==4'h0));
        sram_apb_request__psel__var = ((mux_apb_request__psel!=1'h0)&&(mux_apb_request__paddr[15:12]==4'h1));
        debug_apb_request__psel__var = ((mux_apb_request__psel!=1'h0)&&(mux_apb_request__paddr[15:12]==4'h2));
        timer_apb_request__paddr__var = (mux_apb_request__paddr>>64'h2);
        sram_apb_request__paddr__var = (mux_apb_request__paddr>>64'h2);
        debug_apb_request__paddr__var = (mux_apb_request__paddr>>64'h2);
        mux_apb_response__prdata__var = timer_apb_response__prdata;
        mux_apb_response__pready__var = timer_apb_response__pready;
        mux_apb_response__perr__var = timer_apb_response__perr;
        if ((sram_apb_request__psel__var!=1'h0))
        begin
            mux_apb_response__prdata__var = sram_apb_response__prdata;
            mux_apb_response__pready__var = sram_apb_response__pready;
            mux_apb_response__perr__var = sram_apb_response__perr;
        end //if
        if ((debug_apb_request__psel__var!=1'h0))
        begin
            mux_apb_response__prdata__var = debug_apb_response__prdata;
            mux_apb_response__pready__var = debug_apb_response__pready;
            mux_apb_response__perr__var = debug_apb_response__perr;
        end //if
        timer_control__enable_counter = timer_control__enable_counter__var;
        timer_control__fractional_adder = timer_control__fractional_adder__var;
        timer_control__integer_adder = timer_control__integer_adder__var;
        timer_apb_request__paddr = timer_apb_request__paddr__var;
        timer_apb_request__psel = timer_apb_request__psel__var;
        sram_apb_request__paddr = sram_apb_request__paddr__var;
        sram_apb_request__psel = sram_apb_request__psel__var;
        debug_apb_request__paddr = debug_apb_request__paddr__var;
        debug_apb_request__psel = debug_apb_request__psel__var;
        mux_apb_response__prdata = mux_apb_response__prdata__var;
        mux_apb_response__pready = mux_apb_response__pready__var;
        mux_apb_response__perr = mux_apb_response__perr__var;
    end //always

endmodule // tb_riscv_i32c_minimal
