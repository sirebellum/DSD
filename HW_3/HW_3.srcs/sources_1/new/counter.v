`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2017 01:40:29 PM
// Design Name: 
// Module Name: counter
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


module counter(
    input [3:0] Cstart,
     input CLK,
     output reg [3:0] Count
    );

  always @ (CLK, Cstart) 
    case(Cstart) 
      4'b0000: Count = 4'b0101; 
      4'b0101: Count = 4'b1010;
      4'b1010: Count = 4'b0100;
      4'b0100: Count = 4'b0010;
      4'b0010: Count = 4'b1101;
      4'b1101: Count = 4'b0111;
      4'b0111: Count = 4'b0011;
      4'b0011: Count = 4'b1100;
      4'b1100: Count = 4'b0000;
    endcase
    
endmodule

