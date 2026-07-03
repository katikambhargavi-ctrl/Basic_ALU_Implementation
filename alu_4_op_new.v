`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2026 17:52:09
// Design Name: 
// Module Name: alu_4_op
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


module alu_4_op (
    input  [31:0] A,
    input  [31:0] B,
    input  [1:0]  alu_control,

    output reg [31:0] result,
    output            carry_flag,
    output            sign_flag,
    output            zero_flag,
    output            overflow_flag
);

    // Internal signals
    wire [31:0] and_logic;
    wire [31:0] or_logic;
    wire [31:0] not_B;
    wire [31:0] mux_1;
    wire [31:0] sum;
    wire        cout;

    //------------------------------------------------------------
    // Logic operations
    //------------------------------------------------------------
    assign and_logic = A & B;
    assign or_logic  = A | B;

    //------------------------------------------------------------
    // Two's complement subtraction
    // If alu_control[0] = 1, use ~B and add 1
    //------------------------------------------------------------
    assign not_B = ~B;

    // Select between B and ~B
    assign mux_1 = (alu_control[0]) ? not_B : B;

    // Addition/Subtraction
    // alu_control[0] = 0 → A + B
    // alu_control[0] = 1 → A - B
    assign {cout, sum} = A + mux_1 + alu_control[0];

    //------------------------------------------------------------
    // ALU Operation Selection
    //------------------------------------------------------------
    always @(*) begin
        case (alu_control)

            2'b00: result = sum;        // Addition

            2'b01: result = sum;        // Subtraction

            2'b10: result = and_logic;  // AND

            2'b11: result = or_logic;   // OR

            default: result = 32'b0;

        endcase
    end

    //------------------------------------------------------------
    // Status Flags
    //------------------------------------------------------------

    // Zero Flag
    // Becomes 1 when result is zero
    assign zero_flag = &(~result);

    // Carry Flag
    // Valid only for arithmetic operations
    assign carry_flag = (~alu_control[1]) & cout;

    // Sign Flag
    // MSB of the result
    assign sign_flag = result[31];

    // Overflow Flag
    // Valid only for addition and subtraction
    assign overflow_flag =
           (~alu_control[1]) &
           (A[31] ^ sum[31]) &
           (~(A[31] ^ B[31] ^ alu_control[0]));

endmodule
