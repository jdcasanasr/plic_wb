module plic_wb_v2_tb ();

    localparam NUMBER_OF_SOURCES    = 2;
    localparam NUMBER_OF_TARGETS    = 1;
    localparam NUMBER_OF_PRIORITIES = NUMBER_OF_SOURCES;
    localparam PRIORITY_LENGTH      = $clog2(NUMBER_OF_PRIORITIES + 1); // Avoid using only one bit when NUMBER_OF_SOURCES = 2.
    localparam ID_LENGTH            = $clog2(NUMBER_OF_SOURCES + 1);    // Same as above.

    // Inputs.
    logic rst_nr;
    logic clk_r;

    logic [NUMBER_OF_TARGETS - 1:0] claim_r;
    logic [NUMBER_OF_TARGETS - 1:0] complete_r;

    logic [NUMBER_OF_SOURCES - 1:0] src_r;
    logic [NUMBER_OF_SOURCES - 1:0] el_r;

    logic [NUMBER_OF_SOURCES - 1:0] ie_r        [NUMBER_OF_TARGETS - 1:0];
    logic [PRIORITY_LENGTH - 1:0]   ipriority_r [NUMBER_OF_SOURCES - 1:0];
    logic [PRIORITY_LENGTH - 1:0]   threshold_r [NUMBER_OF_TARGETS - 1:0];

    // Outputs.
    logic [NUMBER_OF_SOURCES - 1:0] ip_w;
    logic [NUMBER_OF_TARGETS - 1:0] ireq_w;
    logic [ID_LENGTH - 1:0]         id_w;

    initial
        begin
            #0 rst_nr = '1;
            #5 rst_nr = '0;
            #5 rst_nr = '1;
        end

    always
        #10 clk_r = ~clk_r;

    // Set initial state.
    initial
        begin
            #0  el_r = '1;                      // Edge-sensitive inputs.

                for(int i = 0; i < NUMBER_OF_TARGETS; i++)
                    for(int j = 0; j < NUMBER_OF_SOURCES; j++)
                        ie_r[i][j] = '1;        // All interrupts are enabled.

                for(int i = 0; i < NUMBER_OF_SOURCES; i++)
                    ipriority_r[i] = i + 'd1;   // Assign priorities in device order.

                for(int i = 0; i < NUMBER_OF_TARGETS; i++)
                    threshold_r[i] = '0;        // Targerts are not thresholded.

                for(int i = 0; i < NUMBER_OF_TARGETS; i++)
                    claim_r[i] = '0;

                for(int i = 0; i < NUMBER_OF_TARGETS; i++)
                    complete_r[i] = '0;
                    
            #20     ;
            #500    $stop;
        end

    // Send random requests.
    always
        #20 src_r = $random(42) | ip_w;

    // Simulate hand-shake with Lagarto.
     always @ (ireq_w)
        if(|ireq_w)
            begin
                #20 claim_r     = '1;
                #20 claim_r     = '0;

                #40 complete_r  = '1;
                #20 complete_r  = '0;
            end

    plic_core
    #(
        .SOURCES    (NUMBER_OF_SOURCES),
        .TARGETS    (NUMBER_OF_TARGETS),
        .PRIORITIES (NUMBER_OF_PRIORITIES)
    )
    plic_core_instance
    (
        // Inputs.
        .rst_n      (rst_nr),
        .clk        (clk_r),

        // Target-side inputs.
        .claim      (claim_r),
        .complete   (complete_r),

        // Source-side inputs.
        .src        (src_r),
        .el         (el_r),

        .ie         (ie_r),
        .ipriority  (ipriority_r),
        .threshold  (threshold_r),

        // Outputs.
        .ip         (ip_w), // Where does this go?
        .ireq       (ireq_w),
        .id         (id_w)
    );

endmodule