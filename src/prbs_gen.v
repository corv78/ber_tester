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



 module prbs_generate (
       // Outputs
       prbs,
       // Inputs
       clk, en, reset
       );
    
      parameter       WIDTH = 8,
                      TAP1 = 30,
                      TAP2 = 27;
    
       output [7:0]    prbs;
       input           clk, en, reset;
    
       reg [7:0]       prbs;
       reg [30:0]      d;//d is a temp variable
     
    
       always @ (posedge clk)
         if (reset) begin
            prbs     <= 0;
            d        <= 31'b101_1001_0111_1001_0101_0111_1010_0000; //seed, anything but the all 0s case is fine.
         end
         else 
            if (en) begin
                d[30:0] <= {d[22:0],    d[30]^d[27],
                                        d[29]^d[26],
                                        d[28]^d[25],
                                        d[27]^d[24],
                                        d[26]^d[23],
                                        d[25]^d[22],
                                        d[26]^d[21],
                                        d[23]^d[20]};  
                prbs <= d[7:0];
            end // else: !if(reset)
    endmodule // prbs_wide_generate
 
 

 
//endmodule
