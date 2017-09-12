`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2017 01:43:05 PM
// Design Name: 
// Module Name: counter_tb
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


module counter_tb(
    );
	reg [3:0] value = 4'b0000;
	wire [3:0] valueout;
	reg clk = 0;
	integer i;
	counter count1(.Cstart(value), .CLK(clk), .Count(valueout));
	 
    initial
    begin
        for (i=0; i < 100; i=i+1)
        begin
            #10 clk = ~clk;
            $display(value);
			value = valueout;
        end
    end
      
endmodule
