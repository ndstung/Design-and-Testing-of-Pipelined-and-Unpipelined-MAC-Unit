`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2024 01:33:07 PM
// Design Name: 
// Module Name: fp_mac
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


module fp_mac(
    input [15:0] A,   // First 16-bit floating-point input
    input [15:0] B,   // Second 16-bit floating-point input
    input [15:0] C,   // Accumulator input
    output [15:0] Result  // Final MAC result
);

// Intermediate wires for multiplication and addition
wire [15:0] product;
wire [15:0] sum;

// Instantiate the multiplier
fp_multiplier multiplier (
    .A(A),
    .B(B),
    .Product(product)
);

// Instantiate the adder (adds product to accumulator C)
fp_adder adder (
    .A(product),
    .B(C),
    .Sum(sum)
);

// Final output is the sum
assign Result = sum;

endmodule

