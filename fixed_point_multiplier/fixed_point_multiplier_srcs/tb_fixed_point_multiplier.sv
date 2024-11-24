`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 04:45:05 PM
// Design Name: 
// Module Name: tb_fixed_point_multiplier
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


module tb_fixed_point_multiplier;
    logic [7:0] A;
    logic [7:0] B;
    logic [15:0] Y;
    
    fixed_point_multiplier #(.n1(3), .n2(5), .m1(5), .m2(3)) dut (
        .A(A),
        .B(B),
        .Y(Y)
    );
    
    initial begin
    
        A = 8'b01110111;
        B = 8'b00101010; #10
        
        A = 8'b11000100;
        B = 8'b01101000; #10
        
        $finish;
    end

endmodule
