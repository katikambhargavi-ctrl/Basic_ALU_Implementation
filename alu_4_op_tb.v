`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2026 20:43:35
// Design Name: 
// Module Name: alu_4_op_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_4_op_tb;

reg  [31:0] A, B;
reg  [1:0]  alu_control;
wire [31:0] result;
wire carry_flag;
wire sign_flag;
wire zero_flag;
wire overflow_flag;

alu_4_op uut (
    .A(A),
    .B(B),
    .alu_control(alu_control),
    .result(result),
    .carry_flag(carry_flag),
    .sign_flag(sign_flag),
    .zero_flag(zero_flag),
    .overflow_flag(overflow_flag)
);

initial begin
    $monitor("A=%h B=%h ctrl=%b result=%h C=%b S=%b Z=%b V=%b",
              A, B, alu_control, result,
              carry_flag, sign_flag, zero_flag, overflow_flag);

    // ADD
    A=32'h56711234; B=32'h56711234; alu_control=2'b00; #10;

    // SUB
    A=32'h56711234; B=32'h56711234; alu_control=2'b01; #10;

    // AND
    A=32'h00001234; B=32'h00005678; alu_control=2'b10; #10;

    // OR
    A=32'h00001234; B=32'h00005678; alu_control=2'b11; #10;

    // ADD overflow: +2147483647 + 1
    A=32'h7fffffff; B=32'h00000001; alu_control=2'b00; #10;

    // ADD no overflow: 5 + 3
    A=32'h00000005; B=32'h00000003; alu_control=2'b00; #10;

    // ADD overflow: -2147483648 + (-1)
    A=32'h80000000; B=32'hffffffff; alu_control=2'b00; #10;

    // SUB overflow: +2147483647 - (-1)
    A=32'h7fffffff; B=32'hffffffff; alu_control=2'b01; #10;

    $finish;
end

endmodule