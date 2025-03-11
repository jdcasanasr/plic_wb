`timescale 1ns / 1ns

module plic_wb_tb ();
    // PLIC configuration.
    localparam sources          = 16;
    localparam targets          = 1;
    
    // How can I make this a constant expression?
    //localparam priorities       = 16;

    localparam pending_requests = 4;

    // These definitions are copied from plic_core.
    localparam sources_bits     = $clog2(sources + 1);
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

    initial
        begin
            #0      clk_r   = '1;
                    rst_nr  = '1;

                    src_r   = '0;   // No interrupt requests.
                    el_r    = '1;   // Edge-sensitive inputs.

                    for (int i = 0; i < targets; i++)
                        for (int j = 0; j < sources; j++)
                            ie_r[i][j] = '1; // All interrupts are enabled.

                    for (int i = 0; i < targets; i++)
                        for (int j = 0; j < sources; j++)
                            ipriority_r[i][j] = j + 'd1; // Assign priorities in device order.

            #5      rst_nr  = '0;
            #5      rst_nr  = '1;

            #40     ;
            #20     src_r[5]        = 'd1;
            #20     claim_r[0]      = 'd1;
            #5      claim_r[0]      = 'd0;
            #100    complete_r[0]   = 'd1;
            #5      complete_r[0]   = 'd0;

            #20     ;
            #20     $stop;
        end

    always
        #10 clk_r = ~clk_r;

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