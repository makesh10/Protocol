`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2025 12:20:04 PM
// Design Name: 
// Module Name: apb_protocol_master_tb
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


module apb_protocol_master_tb();
reg presetn;
reg pclk;
reg transfer;
reg pwrite_in;
//reg read;
reg [7:0] padd_in;
reg [7:0] pwdata_in;
reg [7:0] prdata_in;
reg pready;

wire penable;
wire psel;
wire [7:0] padd;
wire [7:0] pwdata;
wire [7:0] prdata;
wire pwrite;

apb_protocol_master uut(
.presetn(presetn),
.pclk(pclk),
.transfer(transfer),
.pwrite_in(pwrite_in),
.padd_in(padd_in),
.pwdata_in(pwdata_in),
.prdata_in(prdata_in),
.pready(pready),
.penable(penable),
.psel(psel),
.padd(padd),
.pwdata(pwdata),
.prdata(prdata),
.pwrite(pwrite)
);

initial begin
pclk=0;
forever #5 pclk=~pclk;
end

initial begin
presetn=0;
transfer=0;
pwrite_in=0;
padd_in=0;
pwdata_in=0;
pready=0;

//reset
#10 presetn=1;
#10 transfer=1;
pwrite_in=1; //write
padd_in=8'b1010101010;
pwdata_in=8'hA5; //slave ready
#10 pready=1;
#30 transfer=0;

//READ transaction
#10 transfer=1;
pwrite_in=0; //read
padd_in=8'b11001100;
#10 pready=1; //slave ready
prdata_in=8'h5A5; //data from slave
#10 pready=1;
#10 transfer=0;
#20 $finish;
end
endmodule
