`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.08.2025 09:11:34
// Design Name: 
// Module Name: top_module
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


module top_module#(
parameter data_width = 8,
add_width = 4)(
input winc,
input wclk,
input wrst_n,
input rinc,
input rclk,
input rrst_n,
input [data_width-1:0] w_data,
output  wfull,
output  rempty,
output [data_width-1 : 0]r_data
);

wire [add_width-1:0] w_add, r_add;
wire [add_width:0] w_ptr, r_ptr, wq2_rptr, rq2_wptr;

dual_fifo_mem#(
data_width,
add_width) memmory (
.wclk(wclk),
.wfull(wfull),
.w_data(w_data),
.wclk_en(winc),
.w_add(w_add),
.r_add(r_add),
.r_data(r_data)
    );
    
 two_ff_sync #(add_width+1) syncr_w( 
    .q2(wq2_rptr),   // Output of the second flip-flop
    .din(r_ptr),       // Input data
    .clk(rclk),
     .rst_n(rrst_n)            // Clock and reset
    );
    
     two_ff_sync #(add_width+1)syncw_r( 
    .q2(rq2_wptr),   // Output of the second flip-flop
    .din(w_ptr),       // Input data
    .clk(wclk), 
    .rst_n(rrst_n)            // Clock and reset
    
    );

wptr_full#(
data_width ,
add_width) wptrfull(
.winc(winc),
.wclk(wclk),
.wrst_n(wrst_n),
.wq2_rptr(wq2_rptr),
.wfull(wfull),
.w_addr(w_add),
.w_ptr(w_ptr)
);

rptr_empty#(
data_width,
add_width) pointer_r(
.rclk(rclk),
.rrst_n(rrst_n),
.r_inc(rinc),
.r2q_wptr(rq2_wptr),
.r_empty(rempty),
.r_add(r_add),
.r_ptr(r_ptr)
    );
endmodule
