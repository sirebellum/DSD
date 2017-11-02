`timescale 1ns / 1ps
module Disp_7seg(Data, DP, SSEG_CA, SSEG_AN, Clk);
	input [4:0] Data [0:7]; //Ports cannot be declared as an array; so, the top module would
	input [7:0] DP;         //have to concatenate into a single dimension before passing in
	input Clk;
	output [7:0] SSEG_CA;
	output [7:0] SSEG_AN;

    // Code to slow down clock for digit incrementation
    reg [31:0] counter_out;
    reg Clk_1K;
    initial begin
	   counter_out<= 32'h00000000;
	end

    always @(posedge Clk) begin
	   counter_out <= counter_out + 32'h00000001;	
	   if(counter_out > 32'h000186A0) 	
	   begin
		  counter_out<= 32'h00000000;
		  Clk_1K <= !Clk_1K;
		  end
	   end // End clock slow


    reg [2:0] digit_select;
    always @(posedge Clk_1K) begin //Iterate through contents of Data
        digit_select <= digit_select + 3'b001;
    end
    

    wire [0:7] to_display;
    assign to_display = {Data[digit_select][1],
                         Data[digit_select][2],
                         Data[digit_select][3],
                         Data[digit_select][4]}; //Remove digit enable bit and correct order of bits for case
    
    
    reg [7:0] cathode;
    assign SSEG_CA = cathode;
    assign SSEG_AN = 8'b00000001; //Only use one digit


    always @(posedge Clk) begin
	if (Data[digit_select][0]) begin //if digit enable bit is high, display contents of Data
	   case(to_display)
	       4'b0000 : cathode = {!DP[digit_select], 7'b1000000};
	       4'b0001 : cathode = {!DP[digit_select], 7'b1111001};
	       4'b0010 : cathode = {!DP[digit_select], 7'b0100100};
	       4'b0011 : cathode = {!DP[digit_select], 7'b0110000};
	       4'b0100 : cathode = {!DP[digit_select], 7'b0011001};
	       4'b0101 : cathode = {!DP[digit_select], 7'b0010010};
	       4'b0110 : cathode = {!DP[digit_select], 7'b0000010};
	       4'b0111 : cathode = {!DP[digit_select], 7'b1111000};
	       4'b1000 : cathode = {!DP[digit_select], 7'b0000000};
	       4'b1001 : cathode = {!DP[digit_select], 7'b0011000};
	       4'b1010 : cathode = {!DP[digit_select], 7'b0001000};
	       4'b1011 : cathode = {!DP[digit_select], 7'b0000011};
	       4'b1100 : cathode = {!DP[digit_select], 7'b1000110};
	       4'b1101 : cathode = {!DP[digit_select], 7'b0100001};
	       4'b1110 : cathode = {!DP[digit_select], 7'b0000110};
	       4'b1111 : cathode = {!DP[digit_select], 7'b0001110};
	   endcase
	end
    end

endmodule