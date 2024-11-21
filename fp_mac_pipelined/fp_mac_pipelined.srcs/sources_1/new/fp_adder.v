`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2024 01:41:58 PM
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


module fp_adder_pipelined(
    input clk,
    input reset,
    input [15:0] A,
    input [15:0] B,
    output reg [15:0] Sum
);

// Pipeline registers
reg [4:0] exp_A_stage1, exp_B_stage1, exp_S_stage2, exp_S_stage3;
reg [10:0] mantissa_A_stage1, mantissa_B_stage1;
reg [10:0] mantissa_S_stage2, mantissa_S_stage3;
reg sign_A_stage1, sign_B_stage1, sign_S_stage2, sign_S_stage3;

// Stage 1: Compare exponents and shift mantissas
always @(posedge clk or posedge reset) begin
    if (reset) begin
        exp_A_stage1 <= 0;
        exp_B_stage1 <= 0;
        mantissa_A_stage1 <= 0;
        mantissa_B_stage1 <= 0;
        sign_A_stage1 <= 0;
        sign_B_stage1 <= 0;
    end else begin
        exp_A_stage1 <= A[14:10];
        exp_B_stage1 <= B[14:10];
        sign_A_stage1 <= A[15];
        sign_B_stage1 <= B[15];

        if (A[14:10] > B[14:10]) begin
            mantissa_A_stage1 <= {1'b1, A[9:0]};
            mantissa_B_stage1 <= {1'b1, B[9:0]} >> (A[14:10] - B[14:10]);
        end else begin
            mantissa_A_stage1 <= {1'b1, A[9:0]} >> (B[14:10] - A[14:10]);
            mantissa_B_stage1 <= {1'b1, B[9:0]};
        end
    end
end

// Stage 2: Perform addition/subtraction based on the sign
always @(posedge clk or posedge reset) begin
    if (reset) begin
        mantissa_S_stage2 <= 0;
        sign_S_stage2 <= 0;
        exp_S_stage2 <= 0;
    end else begin
        if (sign_A_stage1 == sign_B_stage1) begin
            mantissa_S_stage2 <= mantissa_A_stage1 + mantissa_B_stage1;
            sign_S_stage2 <= sign_A_stage1;
        end else begin
            if (mantissa_A_stage1 >= mantissa_B_stage1) begin
                mantissa_S_stage2 <= mantissa_A_stage1 - mantissa_B_stage1;
                sign_S_stage2 <= sign_A_stage1;
            end else begin
                mantissa_S_stage2 <= mantissa_B_stage1 - mantissa_A_stage1;
                sign_S_stage2 <= sign_B_stage1;
            end
        end
        exp_S_stage2 <= (A[14:10] > B[14:10]) ? A[14:10] : B[14:10];
    end
end

// Stage 3: Normalize the result
always @(posedge clk or posedge reset) begin
    if (reset) begin
        mantissa_S_stage3 <= 0;
        exp_S_stage3 <= 0;
        sign_S_stage3 <= 0;
    end else begin
        if (mantissa_S_stage2[10]) begin
            mantissa_S_stage3 <= mantissa_S_stage2 >> 1;
            exp_S_stage3 <= exp_S_stage2 + 1;
        end else begin
            mantissa_S_stage3 <= mantissa_S_stage2;
            exp_S_stage3 <= exp_S_stage2;
        end
        sign_S_stage3 <= sign_S_stage2;
    end
end

// Final output
always @(posedge clk or posedge reset) begin
    if (reset) begin
        Sum <= 0;
    end else begin
        Sum <= {sign_S_stage3, exp_S_stage3, mantissa_S_stage3[9:0]};
    end
end

endmodule
