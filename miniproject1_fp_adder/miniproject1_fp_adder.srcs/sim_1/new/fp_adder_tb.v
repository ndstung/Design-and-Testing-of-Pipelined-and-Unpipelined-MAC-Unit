`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 11:30:14 PM
// Design Name: 
// Module Name: fp_adder_tb
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


module tb_fp_adder;

    // Inputs
    reg clk;
    reg reset;
    reg [15:0] A;
    reg [15:0] B;

    // Output
    wire [15:0] Sum;

    // Instantiate the Unit Under Test (UUT)
    fp_adder uut (
        .clk(clk),
        .reset(reset),
        .A(A),
        .B(B),
        .Sum(Sum)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        A = 16'b0;
        B = 16'b0;

        // Wait 10 ns for global reset
        #10;
        reset = 0;

        // Test case 1: Add 0.25 and 1.125 in floating-point format
        #10;
        A = 16'b0011110100000000;  // 0.25 in 16-bit floating-point
        B = 16'b0011110010000000;  // 1.125 in 16-bit floating-point
        #20;

        // Test case 2: Add -2.5 and -7.25 in floating-point format
        #10;
        A = 16'b1100000001000000;  // -2.5 in 16-bit floating-point
        B = 16'b1100001110010000;  // -7.25 in 16-bit floating-point
        #20;

        // Test case 3: Add 1024 and 8075 in floating-point format
        #10;
        A = 16'b0100010000000000;  // 1024 in 16-bit floating-point
        B = 16'b0100100000001011;  // 8075 in 16-bit floating-point
        #20;

        // Test case 4: Add 0.0001 and 0.00000001 in floating-point format
        #10;
        A = 16'b0010101101001001;  // 0.0001 in 16-bit floating-point
        B = 16'b0000111100001101;  // 0.00000001 in 16-bit floating-point
        #20;

        // End simulation
        #50 $finish;
    end

    // Monitor changes in the output
    initial begin
        $monitor("Time: %0d ns, A = %h, B = %h, Sum = %h", $time, A, B, Sum);
    end

endmodule
