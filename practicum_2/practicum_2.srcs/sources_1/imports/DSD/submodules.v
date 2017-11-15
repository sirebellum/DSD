// 7 SEGMENT STATE DISPLAY MODULE //
module Display_7seg(
    input [7:0] digit1, //Leftmost digit
	input [7:0] digit2, 
	input [7:0] digit3,
	input [7:0] digit4,
	input [7:0] digit5,
	input [7:0] digit6,
	input [7:0] digit7,
	input [7:0] digit8, //Rightmost digit
    input clock,
    output reg [7:0] cathode,
    output reg [7:0] annode);

	
    always @ (posedge clock) begin

		case(annode) //scroll through 7-seg digits
			8'b01111111 : annode = 8'b10111111;
			8'b10111111 : annode = 8'b11011111;
			8'b11011111 : annode = 8'b11101111;
			8'b11101111 : annode = 8'b11110111;
			8'b11110111 : annode = 8'b11111011;
			8'b11111011 : annode = 8'b11111101;
			8'b11111101 : annode = 8'b11111110;
			8'b11111110 : annode = 8'b01111111;
			default : annode = 8'b01111111;
		endcase

		//Set non-blank digits
		if (annode == 8'b01111111)
			cathode = digit1;
		if (annode == 8'b10111111)
			cathode = digit2;
		if (annode == 8'b11011111)
			cathode = digit3;
		if (annode == 8'b11101111)
			cathode = digit4;
		if (annode == 8'b11110111)
			cathode = digit5;
		if (annode == 8'b11111011)
			cathode = digit6;
		if (annode == 8'b11111101)
			cathode = digit7;
		if (annode == 8'b11111110)
			cathode = digit8;
		
	end
	
endmodule //END DISPLAY MODULE

// 1K CLOCK MODULE //
module Clock_1k(
    input clock,
    output reg CLK_1k);

        reg [31:0] counter_out, k_count;
        initial begin
                counter_out<= 32'h00000000;
                k_count<= 32'h00000000;
        end

        always @(posedge clock) begin
                counter_out<=    counter_out + 32'h00000001;
                if(counter_out > 32'h000186A0)
                begin
                        counter_out<= 32'h00000000;
                        CLK_1k <= !CLK_1k;
                        end
                end

endmodule //END 1K CLOCK MODULE

// SLOW CLOCK MODULE. TAKES INPUT FROM CLK_1k //
module Clock_Slow(
	input CLK_1k,
	output reg CLK_Slow);
	
reg [31:0] counter_out, k_count;
initial begin
	counter_out<= 32'h00000000;
	k_count<= 32'h00000000;
	CLK_Slow <=0;
end
	
always @(posedge CLK_1k) begin
	k_count = k_count + 32'h00000001;
	if( k_count > 32'h000000E8) begin
		k_count <= 32'h00000000;
		CLK_Slow <= ! CLK_Slow;
	end
end

endmodule //END SLOW CLOCK MODULE