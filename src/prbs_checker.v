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
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module prbs_checker(
    // Outputs
    err_num, lock,
    // Inputs
    prbs, clk, en, reset
    );
    
    parameter           WIDTH = 8,
                        TAP1 = 6,
                        TAP2 = 5;

    output  [WIDTH-1:0] err_num;
    output              lock;
  
    input   [WIDTH-1:0] prbs;
    input               clk, en, reset;
  
    reg     [WIDTH:0]   err_num;
    reg                 lock;
    reg     [WIDTH-1:0] prbs_state, check, d, prbs_lat;   
    reg                 load; 
    integer             i;
    
    
   always @ (posedge clk)
      if (reset) begin
        prbs_state <= 1; //anything but teh all 0s case is fine.
        check <= 0;
        d <= 0;
        err_num <= 0;
        i <= 0;
        lock <= 0;
        load <= 0;
        prbs_lat <= 0;
      end  
      else 
        if (en) begin
           d = prbs_state; //blocking assignment used on purpose here
           repeat (WIDTH) d = {d,d[TAP1]^d[TAP2]};//again blocking is intentional

           prbs_state <= (load) ? prbs : d;

           prbs_lat <= prbs;
           check <= prbs_lat ^ prbs_state;
           err_num = 0;
           for (i=0;i<WIDTH;i=i+1)
             err_num =  err_num + check[i];
           load <= err_num > 2; //error rate to reload
           lock <= !err_num;
        end // else: !if(reset)    
    
    
endmodule