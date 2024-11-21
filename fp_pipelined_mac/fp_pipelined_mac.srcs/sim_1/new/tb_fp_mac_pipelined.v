`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2024 02:12:12 PM
// Design Name: 
// Module Name: tb_fp_mac_pipelined
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


module tb_fp_mac_pipelined;

    // Inputs
    reg clk;
    reg reset;
    reg [15:0] A;
    reg [15:0] B;
    reg [15:0] C;

    // Output
    wire [15:0] Result;

    // Instantiate the pipelined MAC unit
    fp_mac_pipelined uut (
        .clk(clk),
        .reset(reset),
        .A(A),
        .B(B),
        .C(C),
        .Result(Result)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        
        // Hold reset for a short duration
        #10 reset = 0;

        // Test case 1: 0.25 + 1.125
        A = 16'h3400;  // 0.25 in half-precision
        B = 16'h0000;  // No multiplication needed
        C = 16'h3A00;  // 1.125 in half-precision
        #50;  // Wait for pipeline stages
        $display("Test case 1: 0.25 + 1.125 -> Result = %h", Result);

        // Test case 2: 150 - 250
        A = 16'h56C0;  // 150 in half-precision
        B = 16'h0000;  // No multiplication needed
        C = 16'hE2C0;  // -250 in half-precision
        #50;
        $display("Test case 2: 150 - 250 -> Result = %h", Result);

        // Test case 3: -2.5 × -7.25
        A = 16'hC020;  // -2.5 in half-precision
        B = 16'hC740;  // -7.25 in half-precision
        C = 16'h0000;  // No addition, just multiplication
        #50;
        $display("Test case 3: -2.5 × -7.25 -> Result = %h", Result);

        // Test case 4: 0.0001 + 0.00000001
        A = 16'h1A5A;  // 0.0001 in half-precision
        B = 16'h0000;  // No multiplication needed
        C = 16'h04B0;  // 0.00000001 in half-precision
        #50;
        $display("Test case 4: 0.0001 + 0.00000001 -> Result = %h", Result);

        // Test case 5: 1024 - 8075
        A = 16'h4A00;  // 1024 in half-precision
        B = 16'h0000;  // No multiplication needed
        C = 16'hDFA3;  // -8075 in half-precision
        #50;
        $display("Test case 5: 1024 - 8075 -> Result = %h", Result);

        // Test case 6: 2014 × 3.75
        A = 16'h5797;  // 2014 in half-precision
        B = 16'h40C0;  // 3.75 in half-precision
        C = 16'h0000;  // No addition, just multiplication
        #50;
        $display("Test case 6: 2014 × 3.75 -> Result = %h", Result);

        // End simulation
        #100 $finish;
    end

    // Monitor the outputs
    initial begin
        $monitor("At time %0dns: A = %h, B = %h, C = %h, Result = %h", $time, A, B, C, Result);
    end

endmodule

