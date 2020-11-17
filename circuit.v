`timescale 1ns / 1ps
`include "iob_lib.vh"

module circuit
#(
    parameter W=32
    )
  (
   `INPUT(rst,1),
   `INPUT(clk,1),
   `INPUT(en,1),
   `INPUT(x,W),
   `OUTPUT(y,W)
   );
   
   `SIGNAL(cnt, 7) //7-bit counter as iterator
   
   `SIGNAL(y_int, W) //internal y
   `SIGNAL(A, W) //A
   `SIGNAL(B, W) //B
   `SIGNAL2OUT(y, y_int) //connect internal y to output
   
   //y shift register 
   `REG_ARE(clk, rst, 1'b0, en & (cnt!=99), A, y_int)
   `REG_ARE(clk, rst, 1'b0, en & (cnt!=99), B, x)
   
    //iteration counter
   `COUNTER_ARE(clk, rst, cnt!=99, cnt)

   //compute next why
   `COMB 
    if(A>B) 
      y_int=A; 
    else 
      y_int=B;
   
endmodule
