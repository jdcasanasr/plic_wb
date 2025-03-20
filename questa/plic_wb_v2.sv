module plic_wb_v2 ();

    localparam NUMBER_OF_SOURCES    = 2;
    localparam NUMBER_OF_TARGETS    = 1;
    localparam NUMBER_OF_PRIORITIES = NUMBER_OF_SOURCES;
    localparam PRIORITY_LENGTH      = $clog2(NUMBER_OF_PRIORITIES + 1); // Avoid using only one bit when NUMBER_OF_SOURCES = 2.
    localparam ID_LENGTH            = $clog2(NUMBER_OF_SOURCES + 1);    // Same as above.

    // Inputs.
    logic rst_nr;
    logic clk;

    logic [NUMBER_OF_TARGETS - 1:0] claim_r;
    logic [NUMBER_OF_TARGETS - 1:0] complete_r;

    logic [NUMBER_OF_SOURCES - 1:0] src_r;
    logic [NUMBER_OF_SOURCES - 1_0] el_r;

    logic [NUMBER_OF_SOURCES - 1:0] ie_r        [NUMBER_OF_TARGETS - 1:0];
    logic [PRIORITY_LENGTH - 1:0]   ipriority_r [NUMBER_OF_SOURCES - 1:0];
    logic [PRIORITY_LENGTH - 1:0]   threshold_r [NUMBER_OF_TARGETS - 1:0];

    // Outputs.
    logic [NUMBER_OF_SOURCES - 1:0] ip_w;
    logic [NUMBER_OF_TARGETS - 1:0] ireq_w;
    logic [ID_LENGTH - 1:0]         id_w;

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