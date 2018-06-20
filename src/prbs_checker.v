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
    
    output  [3:0]       err_num;
    output              lock;
  
    input   [7:0]       prbs;
    input               clk, en, reset;
  
    reg     [3:0]       err_num;
    reg                 lock;
    reg     [30:0]      d; 
    reg     [7:0]       check, prbs_lat;   
    reg                 load; 
    integer             i;
    
    
    
   always @ (posedge clk)
      if (reset) begin  // on reset
        check       <= 0;
        d           <= 31'b101_1001_0111_1001_0101_0111_1010_0000;
        err_num     <= 0;
        i           <= 0;
        lock        <= 0;
        load        <= 1;
        prbs_lat    <= 0;
      end  
      else              // after reset
        if (en) begin
           prbs_lat = {  d[30]^d[27],
                         d[29]^d[26],
                         d[28]^d[25],
                         d[27]^d[24],
                         d[26]^d[23],
                         d[25]^d[22],
                         d[26]^d[21],
                         d[23]^d[20]};
                        
           d[30:0] <= (load) ? {d[22:0],prbs}: {d[22:0], prbs_lat}; // shift or reload

           check <= prbs ^ prbs_lat; //compare
           
           err_num = 0;
           for (i=0; i<7; i=i+1)
             err_num =  err_num + check[i];  // bit error count
             
           load <= err_num > 2; //error rate to reload
           lock <= !err_num;
        end // else: !if(reset)    
    
    
endmodule



