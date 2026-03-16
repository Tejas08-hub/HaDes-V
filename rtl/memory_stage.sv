/*
 * Copyright (c) 2024 Tobias Scheipel, David Beikircher, Florian Riedl
 * Embedded Architectures & Systems Group, Graz University of Technology
 * SPDX-License-Identifier: MIT
 *
 * File: memory_stage.sv
 */

module memory_stage (
    input logic clk,
    input logic rst,

    // Memory interface
    wishbone_interface.master wb,

    // Inputs
    input logic [31:0] source_data_in,
    input logic [31:0] rd_data_in,
    input instruction::t instruction_in,
    input logic [31:0] program_counter_in,
    input logic [31:0] next_program_counter_in,

    // Outputs
    output logic [31:0] source_data_reg_out,
    output logic [31:0] rd_data_reg_out,
    output instruction::t instruction_reg_out,
    output logic [31:0] program_counter_reg_out,
    output logic [31:0] next_program_counter_reg_out,
    output forwarding::t forwarding_out,

    // Pipeline control
    input pipeline_status::forwards_t status_forwards_in,
    output pipeline_status::forwards_t status_forwards_out,
    input pipeline_status::backwards_t status_backwards_in,
    output pipeline_status::backwards_t status_backwards_out,
    input logic [31:0] jump_address_backwards_in,
    output logic [31:0] jump_address_backwards_out
);

    // Pipeline registers
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            source_data_reg_out <= 32'b0;
            rd_data_reg_out <= 32'b0;
            instruction_reg_out <= '0;
            program_counter_reg_out <= 32'b0;
            next_program_counter_reg_out <= 32'b0;
            jump_address_backwards_out <= 32'b0;
        end
        else begin
            source_data_reg_out <= source_data_in;
            rd_data_reg_out <= rd_data_in;
            instruction_reg_out <= instruction_in;
            program_counter_reg_out <= program_counter_in;
            next_program_counter_reg_out <= next_program_counter_in;
            jump_address_backwards_out <= jump_address_backwards_in;
        end
    end

    // Pass pipeline status
    assign status_forwards_out = status_forwards_in;
    assign status_backwards_out = status_backwards_in;

    // Disable forwarding for now
    assign forwarding_out = '0;

endmodule
