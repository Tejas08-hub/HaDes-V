module writeback_stage (
    input logic clk,
    input logic rst,

    // Inputs
    input logic [31:0] source_data_in,
    input logic [31:0] rd_data_in,
    input instruction::t instruction_in,
    input logic [31:0] program_counter_in,
    input logic [31:0] next_program_counter_in,

    // Interrupt signals
    input logic external_interrupt_in,
    input logic timer_interrupt_in,

    // Outputs
    output forwarding::t forwarding_out,

    // Pipeline control
    input pipeline_status::forwards_t status_forwards_in,
    output pipeline_status::backwards_t status_backwards_out,
    output logic [31:0] jump_address_backwards_out
);

    // Forwarding disabled for now
    assign forwarding_out = '0;

    // Pass pipeline control backwards
    assign status_backwards_out = '0;

    // No jump generated in writeback stage
    assign jump_address_backwards_out = 32'b0;

endmodule
