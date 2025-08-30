`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.08.2025 09:16:56
// Design Name: 
// Module Name: wptr_full
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


module wptr_full#(
parameter data_width = 8,
add_width = 4)(
input winc,
input wclk,
input wrst_n,
input [add_width:0] wq2_rptr,
output reg wfull,
output [add_width-1:0]w_addr,
output reg [add_width:0] w_ptr
);

reg [add_width:0] wbin;
wire [add_width:0] wgraynext, wbinnext;
wire wfull_val;

always @(posedge wclk or negedge wrst_n)
if(!wrst_n) {wbin, w_ptr} <= 0;
else {wbin, w_ptr} <= {wbinnext,wgraynext};

assign w_addr = wbin[add_width-1:0];
assign wbinnext = wbin + (winc & ~wfull);
assign wgraynext = (wbinnext>>1) ^ (wbinnext);
assign wfull_val = (wgraynext == {~wq2_rptr[add_width:add_width-1],
                                  wq2_rptr[add_width-2:0]});

always @(posedge wclk or negedge wrst_n)
if(!wrst_n) wfull <= 1'b0;
else wfull <= wfull_val;
endmodule
