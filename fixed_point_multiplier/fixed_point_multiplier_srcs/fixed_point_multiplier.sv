`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 03:59:54 PM
// Design Name: 
// Module Name: fixed_point_multiplier
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


module fixed_point_multiplier#(
    parameter n1 = 3,
    parameter n2 = 5,
    parameter m1 = 5,
    parameter m2 = 3
)(
        input logic [n1+m1-1:0] A,
        input logic [n2+m2-1:0] B,
        output logic [$bits(A) + $bits(B) - 1:0] Y
    );
        
        assign Y = A * B;
    
endmodule