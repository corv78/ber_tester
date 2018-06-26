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
// Revision 0.1 - pipelined version
// Additional Comments:
// TODO: antisleeping
//////////////////////////////////////////////////////////////////////////////////


module prbs_checker(
    // Outputs
    err_num, lock,valid,
    // Inputs
    prbs, clk, en, reset
    );
    
    parameter       ERR_THRSHLD = 2,
                    LOCK_CNT = 8;
    
    output  [8:0]       err_num;
    output              lock;
    output              valid;
  
    input   [7:0]       prbs;
    input               clk, en, reset;
  
    reg     [8:0]       err_num;
    wire                lock;
    wire                valid;
    reg     [30:0]      d; 
    reg     [7:0]       prbs_lat, prbs_xor;   
    reg     [7:0]       check;
    reg                 load; 
    reg     [7:0]       lock_count;
    reg                 en_reg, en_reg_reg, en_reg_reg_reg;
    integer             i;
    
    
    
   always @ (posedge clk)
      if (reset) begin  // on reset
        check       <= 8'hFF;
        d           <= 1;//31'b101_1001_0111_1001_0101_0111_1010_0000;
        err_num     <= 8'hFF;
        i           <= 0;
        load        <= 1;
        prbs_lat    <= 0;
        prbs_xor    <= 8'hFF;
        lock_count  <= 0;
      end  
      else begin         // after reset
        en_reg      <= en;
        en_reg_reg  <= en_reg;
        en_reg_reg_reg  <= en_reg_reg;
        
        if (en)
           prbs_lat <= prbs;   //relatch data on input
           
        if (en_reg) begin   
           prbs_xor = {  d[30]^d[27],
                         d[29]^d[26],
                         d[28]^d[25],
                         d[27]^d[24],
                         d[26]^d[23],
                         d[25]^d[22],
                         d[26]^d[21],
                         d[23]^d[20]};
                        
           d[30:0] <= (load) ? {d[22:0],prbs_lat}: {d[22:0], prbs_xor}; // shift or reload


           check <= prbs_lat ^ prbs_xor; //compare
        end
        
        if (en_reg_reg) begin   
           err_num = 0;
           for (i=0; i<7; i=i+1)
             err_num =  err_num + check[i];  // bit error count
             

            if (err_num < ERR_THRSHLD) begin
                if (lock_count  < LOCK_CNT)
                    lock_count <= lock_count + 1;
                else
                    load <= 1'b0;        
            end    
            else begin              // drop lock and load on first error > threshold
                lock_count  <= 0;
                load        <= 1'b1;        
            end    
             
        end // else: !if(en)    
    end // else: !if(reset)
    
    assign lock = ~load;
    assign valid = en_reg_reg_reg & lock;
endmodule



