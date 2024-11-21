`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2024 01:39:19 PM
// Design Name: 
// Module Name: fp_mulitiplier
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


module fp_multiplier_pipelined(
    input clk,
    input reset,
    input [15:0] A,
    input [15:0] B,
    output reg [15:0] Product
);

// Pipeline registers
reg [21:0] mantissa_P_stage1, mantissa_P_stage2, mantissa_P_stage3;
reg [4:0] exp_P_stage1, exp_P_stage2, exp_P_stage3;
reg sign_P_stage1, sign_P_stage2, sign_P_stage3;

// Stage 1: Multiply mantissas
always @(posedge clk or posedge reset) begin
    if (reset) begin
        mantissa_P_stage1 <= 0;
        sign_P_stage1 <= 0;
    end else begin
        mantissa_P_stage1 <= {1'b1, A[9:0]} * {1'b1, B[9:0]};
        sign_P_stage1 <= A[15] ^ B[15];
    end
end

// Stage 2: Add exponents
always @(posedge clk or posedge reset) begin
    if (reset) begin
        exp_P_stage2 <= 0;
        mantissa_P_stage2 <= 0;
        sign_P_stage2 <= 0;
    end else begin
        exp_P_stage2 <= A[14:10] + B[14:10] - 5'd15;
        mantissa_P_stage2 <= mantissa_P_stage1;
        sign_P_stage2 <= sign_P_stage1;
    end
end

// Stage 3: Normalize the product and adjust the exponent
always @(posedge clk or posedge reset) begin
    if (reset) begin
        mantissa_P_stage3 <= 0;
        exp_P_stage3 <= 0;
        sign_P_stage3 <= 0;
    end else begin
        if (mantissa_P_stage2[21]) begin
            mantissa_P_stage3 <= mantissa_P_stage2 >> 1;
            exp_P_stage3 <= exp_P_stage2 + 1;
        end else begin
            mantissa_P_stage3 <= mantissa_P_stage2;
            exp_P_stage3 <= exp_P_stage2;
        end
        sign_P_stage3 <= sign_P_stage2;
    end
end

// Final output
always @(posedge clk or posedge reset) begin
    if (reset) begin
        Product <= 0;
    end else begin
        Product <= {sign_P_stage3, exp_P_stage3, mantissa_P_stage3[9:0]};
    end
end

endmodule

