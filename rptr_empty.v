`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.08.2025 09:16:56
// Design Name: 
// Module Name: rptr_empty
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


module rptr_empty#(
parameter data_width = 8,
add_width = 4)(
input rclk,
input rrst_n,
input r_inc,
input [add_width:0]r2q_wptr,
output reg r_empty,
output [add_width-1:0]r_add,
output reg [add_width:0]r_ptr
    );
    
  reg [add_width:0] rbin;
  wire [add_width:0] rgraynext, rbinnext;
  wire rempty_val;
  
  always @(posedge rclk or negedge rrst_n)begin
  if(!rrst_n) {rbin, r_ptr} <= 0;
  else {rbin, r_ptr} <= {rbinnext, rgraynext}; 
  end
  
  assign r_add = rbin[add_width-1:0];
  assign rbinnext = rbin + (r_inc & ~r_empty);
  assign rgraynext = (rbinnext>>1) ^ rbinnext;
  
  assign rempty_val = (rgraynext == r2q_wptr);
  always @(posedge rclk or negedge rrst_n)
  if(!rrst_n) r_empty <= 1'b1;
  else r_empty <= rempty_val;
  endmodule
  
