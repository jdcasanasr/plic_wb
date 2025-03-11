module plic_wb_tb ();
    // PLIC configuration.
    localparam sources          = 16;
    localparam targets          = 1;
    localparam priorities       = 16;
    localparam pending_requests = 4;

    // These definitions are copied from plic_core.
    localparam sources_bits     = $clog2(sources + 1);
    localparam priority_bits    = $clog2(priorities);

    // PLIC inputs.
    logic                       rst_nr;
    logic                       clk_r;

    logic [sources - 1:0]       src_r;
    logic [sources - 1:0]       el_r;

    logic [sources - 1:0]       ie_r        [targets];
    logic [sources_bits - 1:0]  ipriority_r [sources];
    logic [sources_bits - 1:0]  threshold_r [targets];

    logic [targets - 1:0]       claim_r;
    logic [targets - 1:0]       complete_r;

    // PLIC outputs.
    logic [sources - 1:0]       ip_w;
    logic [targets - 1:0]       ireq_w;
    logic [sources_bits - 1:0]  id_w [targets];

    initial
        begin
            #0  clk_r   = '1;
                rst_nr  = '1;

                src_r   = '0;   // No interrupt requests.
                el_r    = '1;   // Edge-sensitive inputs.

                for (int i = 0; i < targets; i = i + 1)
                    for (int j = 0; j < sources; j = j + 1)
                        ie_r[i][j] = '1; // All interrupts are enabled.

                ipriority_r[0][0]     = 'd1;
                ipriority_r[0][1]     = 'd2;
                ipriority_r[0][2]     = 'd3;
                ipriority_r[0][3]     = 'd4;
                ipriority_r[0][4]     = 'd5;
                ipriority_r[0][5]     = 'd6;
                ipriority_r[0][6]     = 'd7;
                ipriority_r[0][7]     = 'd8;
                ipriority_r[0][8]     = 'd9;
                ipriority_r[0][9]     = 'd10;
                ipriority_r[0][10]    = 'd11;
                ipriority_r[0][11]    = 'd12;
                ipriority_r[0][12]    = 'd13;
                ipriority_r[0][13]    = 'd14;
                ipriority_r[0][14]    = 'd15;
                ipriority_r[0][15]    = 'd16;


            #5  rst_nr  = '0;
            #5  rst_nr  = '1;
        end

    always
        #10 clk_r = ~clk_r;

    // Module Instances.
    plic_core plic_core_instance
    #(
        .SOURCES            (sources),
        .TARGETS            (targets),
        .PRIORITIES         (priorites),
        .MAX_PENDING_COUNT  (pending_requests)
    )
    (
        .rst_n              (rst_nr),
        .clk                (clk_r),

        .src                (src_w),
        .el                 (el_w),
        .ip                 (ip_w),

        .ie                 (ie_w),
        .ipriority          (ipriority_w),
        .threshold          (threshold_w),

        .ireq               (ireq_w),
        .id                 (id_w),
        .claim              (claim_w),
        .complete           (complete_w)
    );

endmodule