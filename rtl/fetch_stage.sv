/*
 * Copyright (c) 2024 Tobias Scheipel, David Beikircher, Florian Riedl
 * Embedded Architectures & Systems Group, Graz University of Technology
 * SPDX-License-Identifier: MIT
 */

module fetch_stage (
    input  logic clk,
    input  logic rst,

    // Memory interface
    wishbone_interface.master wb,

    // Output data
    output logic [31:0] instruction_reg_out,
    output logic [31:0] program_counter_reg_out,

    // Pipeline control
    output pipeline_status::forwards_t  status_forwards_out,
    input  pipeline_status::backwards_t status_backwards_in,
    input  logic [31:0] jump_address_backwards_in
);

    // Program Counter register
    logic [31:0] pc;

    // Program Counter update logic
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 32'b0;
        else
            pc <= pc + 4;
    end

    // Send address to memory via Wishbone
    assign wb.adr = pc;
    assign wb.cyc = 1'b1;
    assign wb.stb = 1'b1;
    assign wb.we  = 1'b0;

    // Forward PC to next stage
    always_ff @(posedge clk) begin
        program_counter_reg_out <= pc;
        instruction_reg_out <= 32'b0;
    end

endmodule
