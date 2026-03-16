module decode_stage (
    input logic clk,
    input logic rst,

    // Inputs
    input logic [31:0] instruction_in,
    input logic [31:0] program_counter_in,
    input forwarding::t exe_forwarding_in,
    input forwarding::t mem_forwarding_in,
    input forwarding::t wb_forwarding_in,

    // Output Registers
    output logic [31:0] rs1_data_reg_out,
    output logic [31:0] rs2_data_reg_out,
    output logic [31:0] program_counter_reg_out,
    output instruction::t instruction_reg_out,

    // Pipeline control
    input pipeline_status::forwards_t status_forwards_in,
    output pipeline_status::forwards_t status_forwards_out,
    input pipeline_status::backwards_t status_backwards_in,
    output pipeline_status::backwards_t status_backwards_out,
    input logic [31:0] jump_address_backwards_in,
    output logic [31:0] jump_address_backwards_out
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            program_counter_reg_out <= 32'b0;
            instruction_reg_out <= '0;
            rs1_data_reg_out <= 32'b0;
            rs2_data_reg_out <= 32'b0;
            jump_address_backwards_out <= 32'b0;
        end
        else begin
            program_counter_reg_out <= program_counter_in;
            instruction_reg_out <= instruction_in;
            rs1_data_reg_out <= 32'b0;
            rs2_data_reg_out <= 32'b0;
            jump_address_backwards_out <= jump_address_backwards_in;
        end
    end

    assign status_forwards_out = status_forwards_in;
    assign status_backwards_out = status_backwards_in;

endmodule
