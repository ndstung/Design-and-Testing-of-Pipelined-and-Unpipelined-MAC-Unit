`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2024 01:36:00 PM
// Design Name: 
// Module Name: tb_fp_mac_unpipelined
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


module tb_fp_mac;

    // Inputs
    reg [15:0] A;
    reg [15:0] B;
    reg [15:0] C;
    
    // Output
    wire [15:0] Result;

    // Instantiate the MAC module
    fp_mac uut (
        .A(A),
        .B(B),
        .C(C),
        .Result(Result)
    );

    initial begin
        // Test case 1: 0.25 + 1.125
        #10;
        A = 16'h3400;  // 0.25 in half-precision
        B = 16'h0000;  // No multiplication needed (set B = 0)
        C = 16'h3A00;  // 1.125 in half-precision
        #10;
        $display("Result of 0.25 + 1.125 = %h", Result);
        
        // Test case 2: 150 - 250
        #10;
        A = 16'h56C0;  // 150 in half-precision
        B = 16'h0000;  // No multiplication needed (set B = 0)
        C = 16'hE2C0;  // -250 in half-precision
        #10;
        $display("Result of 150 - 250 = %h", Result);
        
        // Test case 3: -2.5 × -7.25
        #10;
        A = 16'hC020;  // -2.5 in half-precision
        B = 16'hC740;  // -7.25 in half-precision
        C = 16'h0000;  // No addition, just multiplication
        #10;
        $display("Result of -2.5 × -7.25 = %h", Result);
        
        // Test case 4: 0.0001 + 0.00000001
        #10;
        A = 16'h1A5A;  // 0.0001 in half-precision
        B = 16'h0000;  // No multiplication needed (set B = 0)
        C = 16'h04B0;  // 0.00000001 in half-precision
        #10;
        $display("Result of 0.0001 + 0.00000001 = %h", Result);
        
        // Test case 5: 1024 - 8075
        #10;
        A = 16'h4A00;  // 1024 in half-precision
        B = 16'h0000;  // No multiplication needed (set B = 0)
        C = 16'hDFA3;  // -8075 in half-precision
        #10;
        $display("Result of 1024 - 8075 = %h", Result);
        
        // Test case 6: 2014 × 3.75
        #10;
        A = 16'h5797;  // 2014 in half-precision
        B = 16'h40C0;  // 3.75 in half-precision
        C = 16'h0000;  // No addition, just multiplication
        #10;
        $display("Result of 2014 × 3.75 = %h", Result);

        // Finish simulation
        #20;
        $finish;
    end

endmodule

