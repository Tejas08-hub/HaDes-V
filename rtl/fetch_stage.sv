module fetch_stage (
    input logic clk,
    input logic rst,

    wishbone_interface.master wb,

    output logic [31:0] instruction_reg_out,
    output logic [31:0] program_counter_reg_out,

    output pipeline_status::forwards_t status_forwards_out,
    input pipeline_status::backwards_t status_backwards_in,
    input logic [31:0] jump_address_backwards_in
);

logic [31:0] pc;

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        pc <= 32'b0;
    else
        pc <= pc + 4;
end

assign wb.adr = pc;
assign wb.cyc = 1'b1;
assign wb.stb = 1'b1;
assign wb.we  = 1'b0;

always_ff @(posedge clk) begin
    instruction_reg_out <= wb.dat_s;
    program_counter_reg_out <= pc;
end

endmodule
