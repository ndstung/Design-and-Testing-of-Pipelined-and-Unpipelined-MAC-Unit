`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2024 01:32:28 PM
// Design Name: 
// Module Name: fp_multipiler
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


module fp_multiplier(
    input [15:0] A,   // First 16-bit floating-point input
    input [15:0] B,   // Second 16-bit floating-point input
    output reg [15:0] Product  // 16-bit floating-point product
);

// Extract sign, exponent, and mantissa from inputs
wire sign_A, sign_B, sign_P;
wire [4:0] exp_A, exp_B, exp_P;
wire [10:0] mantissa_A, mantissa_B;
wire [21:0] mantissa_P;
reg [4:0] exp_P_reg;
reg [10:0] mantissa_P_reg;

assign sign_A = A[15];
assign exp_A = A[14:10];
assign mantissa_A = {1'b1, A[9:0]};  // Implicit leading 1 in mantissa

assign sign_B = B[15];
assign exp_B = B[14:10];
assign mantissa_B = {1'b1, B[9:0]};  // Implicit leading 1 in mantissa

// Determine the sign of the product
assign sign_P = sign_A ^ sign_B;

// Multiply mantissas
assign mantissa_P = mantissa_A * mantissa_B;

// Add exponents and adjust for bias
assign exp_P = exp_A + exp_B - 15;  // Bias correction (half-precision bias is 15)

// Normalize the product and adjust the exponent
always @(*) begin
    if (mantissa_P[21]) begin
        // Shift and adjust exponent
        mantissa_P_reg = mantissa_P[21:11];
        exp_P_reg = exp_P + 1;
    end else begin
        mantissa_P_reg = mantissa_P[20:10];
        exp_P_reg = exp_P;
    end
end

// Compose the product
always @(*) begin
    if (exp_P_reg == 0 || exp_P_reg == 31)  // Handle special cases like overflow/underflow
        Product = 16'b0;  // Overflow or underflow results in zero
    else
        Product = {sign_P, exp_P_reg, mantissa_P_reg[9:0]};
end

endmodule

