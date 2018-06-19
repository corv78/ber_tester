`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2017 11:30:02 AM
// Design Name: 
// Module Name: prbs_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.02 - 32-bit wide PSBS-31 taken from http://fpgasrus.com/prbs.html
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



 module prbs_wide_generate (
       // Outputs
       prbs,
       // Inputs
       clk, en, reset
       );
    
      parameter       WIDTH = 8,
                      TAP1 = 6,
                      TAP2 = 5;
    
       output [WIDTH-1:0] prbs;
       input               clk, en, reset;
    
       reg [WIDTH-1:0]      prbs;
       reg [WIDTH-1:0]      d;//d is a temp variable
     
    
       always @ (posedge clk)
         if (reset) begin
            prbs     <= 1; //seed, anything but the all 0s case is fine.
            d        <= 0;
         end
         else 
            if (en) begin
                d = prbs; //blocking assignment used on purpose here
                repeat (WIDTH) d = {d,d[TAP1]^d[TAP2]};//again blocking is intentional
                prbs <= d;
            end // else: !if(reset)
    endmodule // prbs_wide_generate
 
 
 

 
//endmodule
