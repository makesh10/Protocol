`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2025 05:46:37 PM
// Design Name: 
// Module Name: apb_protocol
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


module apb_protocol(
    input  wire        pclk,
    input  wire        presetn,
    input  wire        transfer,
    input  wire        pwrite_in,       
    input  wire [7:0]  pwdata_in,
    input  wire [7:0]  padd_in,
    output wire [7:0]  read_data_out
    );
    
    wire        psel;
    wire        penable;
    wire        pwrite;
    wire [7:0]  paddr;
    wire [7:0]  pwdata;
    wire [7:0]  prdata;
    wire        pready;
    
    apb_protocol_master uut1(
        .pclk       (pclk),
        .presetn    (presetn),
        .transfer   (transfer),
        .pwrite_in  (pwrite_in),
        .pwdata_in  (pwdata_in),
        .padd_in    (padd_in),
        .pready     (pready),
        .prdata     (prdata),
        .psel       (psel),
        .penable    (penable),
        .pwrite     (pwrite),
        .padd       (padd),
        .pwdata     (pwdata),
        .read_data  (read_data_out)
        );

    apb_protocol_slave uut2(
        .pclk    (pclk),
        .presetn (presetn),
        .psel    (psel),
        .penable (penable),
        .pwrite  (pwrite),
        .padd    (padd),
        .pwdata  (pwdata),
        .prdata  (prdata),
        .pready  (pready)
        );
        
endmodule

