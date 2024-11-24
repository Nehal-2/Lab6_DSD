`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 07:40:15 PM
// Design Name: 
// Module Name: tb_FIR_filter
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


module FIR_filter_tb;

    localparam n_in = 4;
    localparam m_in = 4;
    localparam n_out = 8;
    localparam m_out = 4;

    logic clk;
    logic reset_n;
    logic [n_in+m_in-1:0] x;      // Q4.4 input
    logic [n_out+m_out-1:0] y;    // Q8.4 output

    FIR_filter #(
        .n_in(n_in),
        .m_in(m_in),
        .n_out(n_out),
        .m_out(m_out)
    ) dut (
        .clk(clk),
        .reset_n(reset_n),
        .x(x),
        .y(y)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize reset
        reset_n = 0;
        x = 0;
        #15 reset_n = 1;

        // Apply test inputs
        #10 x = 8'b00010100; // Q4.4 value 1.25
        #10 x = 8'b00101000; // Q4.4 value 2.5
        #10 x = 8'b01000000; // Q4.4 value 4.0
        #10 x = 8'b00101000; // Q4.4 value 2.5
        #10 x = 8'b00010100; // Q4.4 value 1.25

        // Wait for outputs to stabilize
        #50;
        
        // Stop the simulation
        $stop;
    end

    // Monitor the outputs
    initial begin
        $monitor("Time: %t | Reset: %b | x: %b | y: %b",
                 $time, reset_n, x, y);
    end
endmodule
