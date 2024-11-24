`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 05:08:44 PM
// Design Name: 
// Module Name: FIR_filter
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


module FIR_filter#(
    parameter n_in = 4,
    parameter m_in = 4,
    parameter n_out = 8,
    parameter m_out = 4
)(
        input logic clk,
        input logic reset_n,
        input logic [n_in+m_in-1:0] x, // Q4.4
        output logic [n_out+m_out-1:0] y // Q6.4
    );
    
    localparam n_h = 1;
    localparam m_h = 7;
    
    logic [n_h+m_h-1:0] h [0:4]; // Q2.6
    
    assign h[0] = 8'b00000011; // 0.0243
    assign h[1] = 8'b00000001; // 0.0115
    assign h[2] = 8'b10000000; // 1.0
    assign h[3] = 8'b00000001; // 0.0115
    assign h[4] = 8'b00000011; // 0.0243
    
    logic [n_in+m_in-1:0] x_delayed [0:4];
    
    generate
        genvar i;
        for (i = 0; i < 5; i++) begin
            if (i == 0) begin
                register_nbit #(.n(n_in+m_in)) reg_0 (
                    .clk(clk),
                    .areset(reset_n),
                    .en(1'b1), 
                    .d(x),
                    .q(x_delayed[0]) 
                );
             end else begin
                register_nbit #(.n(n_in+m_in)) reg_i (
                    .clk(clk),
                    .areset(reset_n),
                    .en(1'b1), 
                    .d(x_delayed[i-1]),
                    .q(x_delayed[i]) 
                );
             end
         end
    endgenerate
    
    // Multiplication
    
    logic [n_in+m_in+n_h+m_h-1:0] mult_out [0:4];
    
    generate
        for (i = 0; i < 5; i++) begin
            fixed_point_multiplier #(.n1(n_in), .n2(n_h), .m1(m_in), .m2(m_h)) b_i (
                .A(x_delayed[i]),
                .B(h[i]),
                .Y(mult_out[i])
            );
        end
    endgenerate
    
    // Addition
    
    logic [n_in+m_in+n_h+m_h-1:0] sig1, sig2, sig3, sig4;
    
//    logic [9:0] mult1_reduced, mult2_reduced, mult3_reduced, mult4_reduced, mult5_reduced;
    
//    assign mult1_reduced = mult1[15:6];
//    assign mult2_reduced = mult2[15:6];
//    assign mult3_reduced = mult3[15:6];
//    assign mult4_reduced = mult4[15:6];
//    assign mult5_reduced = mult5[15:6];
    
   
    
    fixed_point_adder #(.n1(n_in+m_in+n_h+m_h), .n2(n_in+m_in+n_h+m_h), .m1(0), .m2(0)) add1 (
        .A(mult_out[0]),
        .B(mult_out[1]),
        .S(sig1)
    );
    
    fixed_point_adder #(.n1(n_in+m_in+n_h+m_h), .n2(n_in+m_in+n_h+m_h), .m1(0), .m2(0)) add2 (
        .A(sig1),
        .B(mult_out[2]),
        .S(sig2)
    );
    
    fixed_point_adder #(.n1(n_in+m_in+n_h+m_h), .n2(n_in+m_in+n_h+m_h), .m1(0), .m2(0)) add3 (
        .A(sig2),
        .B(mult_out[3]),
        .S(sig3)
    );
    
    fixed_point_adder #(.n1(n_in+m_in+n_h+m_h), .n2(n_in+m_in+n_h+m_h), .m1(0), .m2(0)) add4 (
        .A(sig3),
        .B(mult_out[4]),
        .S(sig4)
    );
    
    assign y = sig4[n_out+m_out-1:0];
    
endmodule
