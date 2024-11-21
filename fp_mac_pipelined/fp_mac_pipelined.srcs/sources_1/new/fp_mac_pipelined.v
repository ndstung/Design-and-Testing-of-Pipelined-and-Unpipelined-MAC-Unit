`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2024 01:50:36 PM
// Design Name: 
// Module Name: fp_mac_pipelined
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


module fp_mac_pipelined(
    input clk,
    input reset,
    input [15:0] A,
    input [15:0] B,
    input [15:0] C,  // Accumulator input
    output reg [15:0] Result
);

// Intermediate pipeline registers
wire [15:0] product;
wire [15:0] sum;

// Instantiate the 3-stage multiplier
fp_multiplier_pipelined multiplier (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .Product(product)
);

// Instantiate the 3-stage adder
fp_adder_pipelined adder (
    .clk(clk),
    .reset(reset),
    .A(product),
    .B(C),
    .Sum(sum)
);

// Final result
always @(posedge clk or posedge reset) begin
    if (reset) begin
        Result <= 0;
    end else begin
        Result <= sum;
    end
end

endmodule
