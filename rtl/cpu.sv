/* Copyright (c) 2024 Tobias Scheipel, David Beikircher, Florian Riedl
 * Embedded Architectures & Systems Group, Graz University of Technology
 * SPDX-License-Identifier: MIT
 * ---------------------------------------------------------------------
 * File: cpu.sv
 */
module cpu (
    input logic clk,
    input logic rst,

    wishbone_interface.master memory_fetch_port,
    wishbone_interface.master memory_mem_port,

    input logic external_interrupt_in,
    input logic timer_interrupt_in
);

fetch_stage fetch(
    .clk(clk),
    .rst(rst)
);

decode_stage decode(
    .clk(clk),
    .rst(rst)
);

execute_stage execute(
    .clk(clk),
    .rst(rst)
);

memory_stage memory(
    .clk(clk),
    .rst(rst)
);

writeback_stage writeback(
    .clk(clk),
    .rst(rst)
);

endmodule
