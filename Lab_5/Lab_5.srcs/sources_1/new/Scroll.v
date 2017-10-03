`timescale 1ns / 1ps
// This code slows down the 100 Mhz clock to a 1 second period.
module Seven_Seg(
    input [3:0] SW,
    input CLK,
    output reg [7:0] SSEG_CA,
    output reg [7:0] SSEG_AN,
    output [3:0] LED
    );
reg [7:0] digits;   
reg [31:0] counter_out;
reg Clk_Slow;
	initial begin
	counter_out<= 32'h00000000;
	Clk_Slow <=0;
	digits <= 8'b00000000;
	end	
//this always block runs on the fast 100MHz clock
always @(posedge CLK) begin
	counter_out<=    counter_out + 32'h00000001;		
	if (counter_out  > 32'h02F5E100) begin
		counter_out<= 32'h00000000;
		Clk_Slow <= !Clk_Slow;
		end
	end
	
	
assign LED = SW;

always @(posedge Clk_Slow) begin
	
	digits = digits << 1;
    if (digits == 8'b00000000) begin
        digits = 8'b00000001;
    end
    SSEG_AN = ~digits;
	
	case(SW)
	   4'b0000 : SSEG_CA = 8'b11000000;
	   4'b0001 : SSEG_CA = 8'b11111001;
	   4'b0010 : SSEG_CA = 8'b10100100;
	   4'b0011 : SSEG_CA = 8'b10110000;
	   4'b0100 : SSEG_CA = 8'b10011001;
	   4'b0101 : SSEG_CA = 8'b10010010;
	   4'b0110 : SSEG_CA = 8'b10000010;
	   4'b0111 : SSEG_CA = 8'b11111000;
	   4'b1000 : SSEG_CA = 8'b10000000;
	   4'b1001 : SSEG_CA = 8'b10011000;
	   4'b1010 : SSEG_CA = 8'b10001000;
	   4'b1011 : SSEG_CA = 8'b10000011;
	   4'b1100 : SSEG_CA = 8'b11000110;
	   4'b1101 : SSEG_CA = 8'b10100001;
	   4'b1110 : SSEG_CA = 8'b10000110;
	   4'b1111 : SSEG_CA = 8'b10001110;
	endcase
	
end
	
endmodule


//  Note the segments areSSEG_CAthodes a,b,c,d,e,f,g,dp  (but not in this order, see below)       
//SSEG_CA format {g, f, e, d, c, b, a}
//  the SSEG_ANodes select which digit is selected
