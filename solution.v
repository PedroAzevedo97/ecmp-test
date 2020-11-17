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
   `OUTPUT(y,W)
   );

   `SIGNAL(cnt, 7) //7-bit counter as iterator
   
   `SIGNAL(y_int, W) //internal y
   `SIGNAL(y_int_n_1, W) //y(n-1)
   `SIGNAL(y_int_n_2, W) //y(n-2)
   `SIGNAL2OUT(y, y_int) //connect internal y to output

   //y shift register 
   `REG_ARE(clk, rst, 1'b0, en & (cnt!=99), y_int_n_1, y_int)
   `REG_ARE(clk, rst, 1'b0, en & (cnt!=99), y_int_n_2, y_int_n_1)

   //iteration counter
   `COUNTER_ARE(clk, rst, cnt!=99, cnt)

   //compute next why
   `COMB y_int = y_int_n_1 + y_int_n_2 + (cnt == 1'b1);
   
   
endmodule
