`timescale 1ns / 1ns

// Note: Interrupt request responds in two clock cycles

module plic_wb_tb ();
    // PLIC configuration.
    localparam sources          = 16;
    localparam targets          = 1;
    
    // How can I make this a constant expression?
    //localparam priorities       = 16;

    localparam pending_requests = 4;

    // These definitions are copied from plic_core.
    localparam sources_bits     = $clog2(sources);
    //localparam priority_bits    = $clog2(priorities);

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

    integer seed = 42;

    initial
        begin
            #0      rst_nr  = '1;
                    clk_r   = '1;

                    src_r   = '0;   // No interrupt requests.
                    el_r    = '1;   // Edge-sensitive inputs.

                    for(int i = 0; i < targets; i++)
                        for(int j = 0; j < sources; j++)
                            ie_r[i][j] = '1; // All interrupts are enabled.

                    for(int i = 0; i < sources; i++)
                        ipriority_r[i] = i + 'd1; // Assign priorities in device order.

                    for(int i = 0; i < targets; i++)
                        threshold_r[i] = '0;

                    for(int i = 0; i < targets; i++)
                        claim_r[i] = '0;

                    for(int i = 0; i < targets; i++)
                        complete_r[i] = '0;

            #5      rst_nr          = '0;
            #5      rst_nr          = '1;

            #20     ;
            #500    $stop;
        end

    always
        #10 clk_r = ~clk_r;

    always
        #20 src_r[15:0] = $random(seed);

    always @ (ireq_w)
        if(|ireq_w > 0)
            begin
                #20 claim_r     = '1;
                #20 claim_r     = '0;

                #40 complete_r  = '1;
                #20 complete_r  = '0;
            end

    // Module Instances.
    plic_core
    #(
        .SOURCES            (sources),
        .TARGETS            (targets),
        .PRIORITIES         (16),
        .MAX_PENDING_COUNT  (pending_requests)
    )

    plic_core_instance

    (
        .rst_n              (rst_nr),
        .clk                (clk_r),

        .src                (src_r),
        .el                 (el_r),
        .ip                 (ip_w),

        .ie                 (ie_r),
        .ipriority          (ipriority_r),
        .threshold          (threshold_r),

        .ireq               (ireq_w),
        .id                 (id_w),
        .claim              (claim_r),
        .complete           (complete_r)
    );

endmodule