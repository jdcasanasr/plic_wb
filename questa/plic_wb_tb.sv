module plic_wb_tb.sv ();
    // PLIC configuration.
    localparam sources          = 16;
    localparam targets          = 1;
    localparam priorities       = 16;
    localparam pending_requests = 4;

    // PLIC inputs.
    logic rst_nr;
    logic clk_r;


    // PLIC outputs.


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

        .src                (),
        .el                 (),
        .ip                 (),

        .ie                 (),
        .ipriority          (),
        .threshold          (),

        .ireq               (),
        .id                 (),
        .claim              (),
        .complete           ()
    );

endmodule