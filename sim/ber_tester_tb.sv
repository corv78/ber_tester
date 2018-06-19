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
    
    parameter       WIDTH = 8;

    
    logic [WIDTH-1:0]    prbs;
    logic                clk;
    logic                reset;
    logic                en;
    logic [WIDTH:0]      err_num;
    logic                lock;
    
    
    
    prbs_wide_generate  prbs_7 (
      .clk      ( clk       ),
      .reset    ( reset     ),
      .en       ( en        ),
      .prbs     ( prbs      )
    );

    prbs_checker  prbs_checker_7 (
      .clk      ( clk       ),
      .reset    ( reset     ),
      .en       ( 1'b1      ),
      .prbs     ( prbs      ),
      .lock     ( lock      ),
      .err_num  ( err_num   )
    );
    
    
    initial
     begin
     reset  <= 1; en <= 0; #10;
     reset  <= 0; #10;
     en     <= 1; #500
     en     <= 0; #50
     en     <= 1;
     end
        
    always
     begin
     clk <=1; #5;
     clk <=0; #5;
     end
    
endmodule
