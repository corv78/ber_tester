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


//module prbs_gen# (
//	parameter        			SEED              = 31'b1101111011110110011100011101101
//)(
//    input                       clk_in,
//	input						arstn_in,
//    input   [3:0]               byte_ctrl_in,                       
//    output  [31:0]              data_out             // Pulse at every FD symbol
//);

//	reg   	[30:0]				lfrgdata;  

//	//-------------------------------------------------------
//	// Signal Declarations: Registers
//	//-------------------------------------------------------

//	genvar i;
 
 module prbs_wide_generate (
       // Outputs
       prbs,
       // Inputs
       clk, reset
       );
    
      parameter       WIDTH = 32,
                      TAP1 = 30,
                      TAP2 = 27;
    
       output [WIDTH-1:0] prbs;
       input               clk, reset;
    
       reg [WIDTH-1:0]      prbs;
       reg [WIDTH-1:0]      d;//d is a temp variable
     
    
       always @ (posedge clk)
         if (reset)
            begin
            prbs     <= 1; //anything but teh all 0s case is fine.
            d        <= 0;
            end
         else
           begin
              d = prbs; //blocking assignment used on purpose here
              repeat (WIDTH) d = {d,d[TAP1]^d[TAP2]};//again blocking is intentional
              prbs <= d;
           end // else: !if(reset)
    endmodule // prbs_wide_generate
 
 
 
// always @(posedge clk_in or negedge arstn_in)
//  begin
//    if(!arstn_in)
//		begin
//		lfrgdata	<= SEED;
//		end
//    else
//		begin
//		 if (byte_ctrl_in(0) == 1'b1)
//			lfrgdata(30 downto 0) <= lfrgdata(22 downto 0)  & (lfrgdata(30) xor lfrgdata(27))
//															& (lfrgdata(29) xor lfrgdata(26))
//															& (lfrgdata(28) xor lfrgdata(25))
//															& (lfrgdata(27) xor lfrgdata(24))
//															& (lfrgdata(26) xor lfrgdata(23))
//															& (lfrgdata(25) xor lfrgdata(22))
//															& (lfrgdata(24) xor lfrgdata(21))                                                                                                                                                                                                                     
//															& (lfrgdata(23) xor lfrgdata(20));
//		-- Output Port
//		tdata(7 downto 0) <= lfrgdata(30 downto 23) after 1 ns;

//		end
//  end
  
 
//endmodule
