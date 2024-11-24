`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 03:08:15 PM
// Design Name: 
// Module Name: tb_fixed_point_adder
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


module tb_fixed_point_adder;
    logic [7:0] A;
    logic [7:0] B;
    logic [9:0] S;
    
    fixed_point_adder #(.n1(3), .n2(5), .m1(5), .m2(3)) dut (
        .A(A),
        .B(B),
        .S(S)
    );
    
    initial begin
    
        A = 8'b01110111;
        B = 8'b00101010; #10
        
        A = 8'b11000100;
        B = 8'b01101000; #10
        
        $finish;
    end

endmodule
