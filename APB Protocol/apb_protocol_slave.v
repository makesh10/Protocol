`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2025 05:40:28 PM
// Design Name: 
// Module Name: apb_protocol_slave
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

module apb_protocol_slave(
    input  wire        pclk,
    input  wire        presetn, 
    input  wire        psel,
    input  wire        penable,
    input  wire        pwrite,  
    input  wire [7:0]  padd,
    input  wire [7:0]  pwdata,
    output reg  [7:0]  prdata,
    output reg         pready
);

// 16 x 8 bit memory
reg[7:0] mem[15:0];
always@(posedge pclk or negedge presetn) begin
        if (!presetn) begin
            pready<=0;
            prdata<=0;
        end else begin
            pready<=1;  
            if (psel && penable) begin 
                if (pwrite) begin
                    mem[padd[5:0]]<=pwdata;
                    pready<=0;
                end else begin
                pready<=1;
                    prdata<=mem[padd[5:0]];
                end
            end
        end
end
endmodule