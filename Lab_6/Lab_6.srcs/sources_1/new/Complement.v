`timescale 1ns / 1ps
module Complement(

    input CLK,

    input [15:0] SW,

    output wire [15:0] LED,

    output reg [7:0] SSEG_CA,

    output reg [7:0] SSEG_AN);

//  Note the segments areSSEG_CAthodes dp,g,f,e,d,c,b,a
//  the SSEG_ANodes select which digit is selected       
//SSEG_CA format {dp,g, f, e, d, c, b, a}
//Remember that both the cathodes and the anodes are actually driven by FETs.

// CLOCK SLOW DOWN CODE //
reg [31:0] counter_out, k_count;
reg Clk_Slow, Clk_1K;
initial begin
	counter_out<= 32'h00000000;
k_count<= 32'h00000000;
	Clk_Slow <=0;
	
	end	
always @(posedge CLK) begin
	counter_out<=    counter_out + 32'h00000001;	
	if(counter_out > 32'h000186A0) 	
	begin
		counter_out<= 32'h00000000;
		Clk_1K <= !Clk_1K;
		end
	end
always @(posedge Clk_1K) begin
	k_count = k_count + 32'h00000001;
	if( k_count > 32'h000003E8) 
	begin
		k_count <= 32'h00000000;
		Clk_Slow <= ! Clk_Slow;
		end
	end
// END CLOCK SLOW DOWN //

assign LED = SW;

always @ (posedge Clk_1K) begin

    case(SSEG_AN)
        8'b11111011 : SSEG_AN = 8'b11110111;
        8'b11110111 : SSEG_AN = 8'b10111111;
        8'b10111111 : SSEG_AN = 8'b01111111;
        8'b01111111 : SSEG_AN = 8'b11111011;
        default : SSEG_AN = 8'b11111011;
    endcase
    
    if (SSEG_AN == 8'b10111111) begin
    case(SW[3:0])
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
	
	else if (SSEG_AN == 8'b01111111) begin
	case(SW[7:4])
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

    else if (SSEG_AN == 8'b11110111) begin
	case(SW[7:4])
       4'b0000 : SSEG_CA = 8'b11000000;
       4'b0001 : SSEG_CA = 8'b10001110;
       4'b0010 : SSEG_CA = 8'b10000110;
       4'b0011 : SSEG_CA = 8'b10100001;
       4'b0100 : SSEG_CA = 8'b11000110;
       4'b0101 : SSEG_CA = 8'b10000011;
       4'b0110 : SSEG_CA = 8'b10001000;
       4'b0111 : SSEG_CA = 8'b10011000;
       4'b1000 : SSEG_CA = 8'b10000000;
       4'b1001 : SSEG_CA = 8'b11111000;
       4'b1010 : SSEG_CA = 8'b10000010;
       4'b1011 : SSEG_CA = 8'b10010010;
       4'b1100 : SSEG_CA = 8'b10011001;
       4'b1101 : SSEG_CA = 8'b10110000;
       4'b1110 : SSEG_CA = 8'b10100100;
       4'b1111 : SSEG_CA = 8'b11111001;
    endcase
    end

    else if (SSEG_AN == 8'b11111011) begin
	case(SW[3:0])
       4'b0000 : SSEG_CA = 8'b11000000;
       4'b0001 : SSEG_CA = 8'b10001110;
       4'b0010 : SSEG_CA = 8'b10000110;
       4'b0011 : SSEG_CA = 8'b10100001;
       4'b0100 : SSEG_CA = 8'b11000110;
       4'b0101 : SSEG_CA = 8'b10000011;
       4'b0110 : SSEG_CA = 8'b10001000;
       4'b0111 : SSEG_CA = 8'b10011000;
       4'b1000 : SSEG_CA = 8'b10000000;
       4'b1001 : SSEG_CA = 8'b11111000;
       4'b1010 : SSEG_CA = 8'b10000010;
       4'b1011 : SSEG_CA = 8'b10010010;
       4'b1100 : SSEG_CA = 8'b10011001;
       4'b1101 : SSEG_CA = 8'b10110000;
       4'b1110 : SSEG_CA = 8'b10100100;
       4'b1111 : SSEG_CA = 8'b11111001;
    endcase
    end
    
end

endmodule