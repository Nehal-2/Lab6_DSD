`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 02:50:39 PM
// Design Name: 
// Module Name: fixed_point_adder
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


module fixed_point_adder#(
    parameter n1 = 3,
    parameter n2 = 5,
    parameter m1 = 5,
    parameter m2 = 3
)(
        input logic [n1+m1-1:0] A,
        input logic [n2+m2-1:0] B,
        output logic [((n1 > n2) ? n1 : n2) + ((m1 > m2) ? m1 : m2) - 1:0] S
    );
    
    logic [((n1 > n2) ? n1 : n2) + m1 - 1:0] A_n_padded;
    logic [((n1 > n2) ? n1 : n2) + m2 - 1:0] B_n_padded;
    logic [((n1 > n2) ? n1 : n2) + ((m1 > m2) ? m1 : m2) - 1:0] A_ext, B_ext;
    
    always@(*) begin
        if (n1 > n2) begin
            A_n_padded = A;
            B_n_padded = {{(n1-n2){1'b0}}, B};
        end else begin
            A_n_padded = {{(n2-n1){1'b0}}, A};
            B_n_padded = B;
            end
            
        if (m1 > m2) begin
            A_ext = A_n_padded;
            B_ext = {B_n_padded, {(m1-m2){1'b0}}};
        end else begin
            A_ext = {A_n_padded, {(m2-m1){1'b0}}};
            B_ext = B_n_padded;
            end
            
        S = A_ext + B_ext;
        
    end
endmodule
