`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2025 04:45:48 PM
// Design Name: 
// Module Name: apb_protocol_master
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


module apb_protocol_master(
input wire presetn,
input wire pclk,
input wire transfer,
input wire pwrite_in,
//input wire read,
input wire [7:0] padd_in,
input wire [7:0] pwdata_in,
input wire [7:0] prdata_in,
input wire pready,

output reg penable,
output reg psel,
output reg [7:0] padd,
output reg [7:0] pwdata,
output reg [7:0] prdata,
output wire pwrite
);
 
 assign pwrite=pwrite_in;

 localparam
 IDLE = 2'b00,
 SETUP = 2'b01,
 ACCESS = 2'b10;
 
 reg [1:0]state;
 reg [1:0]next_state;
 
 always@(posedge pclk or negedge presetn)begin
 if (!presetn)
 state<=IDLE; 
 else
 state<=next_state;
 end
 
 always@(*)begin
 psel=1'b0;
 penable=1'b0;
 padd=8'b0;
 prdata=32'b0;
 pwdata=32'b0;
 next_state=state;
 
 case(state)
 IDLE:begin
 padd=8'b0;
 pwdata=8'b0;
 if (transfer)
 next_state=SETUP;
 else
 state=IDLE;
 end
 
 SETUP:begin
 psel=1'b1;
 penable=1'b0;
 padd=padd_in;
 prdata=prdata_in;
 next_state=ACCESS;
 end
 
 ACCESS:begin
 psel=1'b1;
 penable=1'b1;
 if (pready) begin
    if (pwrite) begin
        pwdata=pwdata_in;
        end
        else begin
        prdata=prdata_in;
        end
        next_state=(transfer)?SETUP:IDLE;
        end
        end
 endcase
 end
endmodule