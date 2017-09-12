`timescale 1ns / 1ps

// Module for Mux 4:1
module Mux4 (y,In,Sel_A,Sel_B);
output y;
input [3:0] In;
input  Sel_A,Sel_B;
wire [1:0] out;

// Instantiate Mux2 module 3 times to create a 4:1 Mux
//Put Your code here

Mux2 m1(Sel_A, In[0], In[1], out[0]);
Mux2 m2(Sel_B&Sel_A, In[2], In[3], out[1]);

Mux2 m3(Sel_B, out[0], out[1], y);


endmodule



// 2:1 Mux module
module Mux2 (
    input wire sel,
     I0,
     I1,
    output reg Y
    );
always  @ (I0, I1, sel)
  begin
    if (sel == 0)
    begin
      Y = I0;
    end 
    else 
    begin
      Y = I1;
    end
  end
endmodule
