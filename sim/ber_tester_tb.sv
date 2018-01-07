`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2017 03:11:22 PM
// Design Name: 
// Module Name: ber_tester_tb
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


module ber_tester_tb(

    );
    
    parameter       WIDTH = 32;

    
    logic [WIDTH-1:0]    prbs;
    logic                clk;
    logic                reset;
    
    
    
    prbs_wide_generate #(
    .DATA_WIDTH(WIDTH)
    ) prbs_120_generate (
      .clk      ( clk       ),
      .reset    ( reset     ),
      .prbs     ( prbs )
    );
    
    
    initial
     begin
     reset <= 1; #10;
     reset <= 0; #10;
     end
        
    always
     begin
     clk <=1; #5;
     clk <=0; #5;
     end
    
endmodule
