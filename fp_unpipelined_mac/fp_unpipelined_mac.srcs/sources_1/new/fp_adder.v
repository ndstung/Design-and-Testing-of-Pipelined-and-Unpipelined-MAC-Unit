`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2024 01:32:04 PM
// Design Name: 
// Module Name: fp_adder
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


module fp_adder(
    input [15:0] A,   // First 16-bit floating-point input
    input [15:0] B,   // Second 16-bit floating-point input
    output reg [15:0] Sum  // 16-bit floating-point sum
);

// Extract sign, exponent, and mantissa from inputs
wire sign_A, sign_B, sign_S;
wire [4:0] exp_A, exp_B, exp_S;
wire [10:0] mantissa_A, mantissa_B;
reg [10:0] mantissa_S;
wire [10:0] mantissa_A_shifted, mantissa_B_shifted;
wire [4:0] larger_exp, exp_diff;
reg [4:0] exp_S_reg;

assign sign_A = A[15];
assign exp_A = A[14:10];
assign mantissa_A = {1'b1, A[9:0]};  // Implicit leading 1 in mantissa

assign sign_B = B[15];
assign exp_B = B[14:10];
assign mantissa_B = {1'b1, B[9:0]};  // Implicit leading 1 in mantissa

// Compare exponents and shift mantissas
assign exp_diff = (exp_A > exp_B) ? exp_A - exp_B : exp_B - exp_A;
assign larger_exp = (exp_A > exp_B) ? exp_A : exp_B;

assign mantissa_A_shifted = (exp_A > exp_B) ? mantissa_A : mantissa_A >> exp_diff;
assign mantissa_B_shifted = (exp_B > exp_A) ? mantissa_B : mantissa_B >> exp_diff;

// Add or subtract mantissas based on the sign
always @(*) begin
    if (sign_A == sign_B) begin
        mantissa_S = mantissa_A_shifted + mantissa_B_shifted;
        exp_S_reg = larger_exp;
    end else begin
        if (mantissa_A_shifted > mantissa_B_shifted) begin
            mantissa_S = mantissa_A_shifted - mantissa_B_shifted;
            exp_S_reg = larger_exp;
        end else begin
            mantissa_S = mantissa_B_shifted - mantissa_A_shifted;
            exp_S_reg = larger_exp;
        end
    end
end

// Normalize the result and assign final sum
always @(*) begin
    if (mantissa_S[10]) begin
        exp_S_reg = exp_S_reg + 1;
        mantissa_S = mantissa_S >> 1;
    end
    Sum = {sign_A, exp_S_reg, mantissa_S[9:0]};
end

endmodule

