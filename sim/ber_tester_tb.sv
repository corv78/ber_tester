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
    reg   [WIDTH-1:0]    prbs_reg;
    logic                clk;
    logic                reset;
    logic                en;
    reg                  en_reg;
    logic                inj_err;
    logic [WIDTH:0]      err_num;
    logic                lock;
    logic                valid;
    
    
    
    prbs_generate  prbs_31_generate (
      .clk      ( clk       ),
      .reset    ( reset     ),
      .en       ( en        ),
      .inj_err  ( inj_err   ),
      .prbs     ( prbs      )
    );

    prbs_checker  prbs_31_checker (
      .clk      ( clk       ),
      .reset    ( reset     ),
      .en       ( en_reg    ),
      .prbs     ( prbs_reg  ),
      .lock     ( lock      ),
      .valid    ( valid     ),
      .err_num  ( err_num   )
    );
    
    always @ (posedge clk) begin
        prbs_reg <= prbs;
        en_reg  <= en;
    end
    
    
    initial
     begin
     reset  <= 1; en <= 0; #10;
     reset  <= 0; #20;
     end
        
    always
     begin
     clk <=1; #5;
     clk <=0; #5;
     end
     
    always
     begin   
     en     <= 1;
     #(10ns * $urandom_range(10, 1));
     en     <= 0;
     #(10ns * $urandom_range(10, 1));     
     end

    always
     begin   
     inj_err   <= 1;
     #(10ns * $urandom_range(3, 1));
     inj_err   <= 0;
     #(10ns * $urandom_range(30, 8));     
     end

    
endmodule
