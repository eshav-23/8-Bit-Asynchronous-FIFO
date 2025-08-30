`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.08.2025 09:16:56
// Design Name: 
// Module Name: fifo_mem
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


module dual_fifo_mem#(
parameter data_width = 8,
add_width = 4)(
input wclk,
input wfull,
input [data_width-1:0]w_data,
input wclk_en,
input [add_width-1:0]w_add,
input [add_width-1:0]r_add,
output [data_width-1:0]r_data
    );
 
 localparam depth = 1<<add_width;
 reg [data_width-1 : 0] dual_mem [0:depth-1];
 
 assign r_data = dual_mem[r_add];
 
 always @(posedge wclk)begin
 if(wclk_en && !wfull) 
 dual_mem[w_add] <= w_data;  
 end   
endmodule
