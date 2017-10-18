`timescale 1ns / 1ps

// D FLIP-FLOP MODULE //
module D_FF(
	input CLK,
	input D,
	output reg Q);
	
	always @ (posedge CLK)
		Q = D;
		
endmodule //END D FLIP-FLOP MODULE


// 1K CLOCK MODULE //
module Clock_1k(
    input CLK,
    output CLK_1k);

	reg [31:0] counter_out, k_count;
	reg CLK_Slow, CLK_1K;
	initial begin
		counter_out<= 32'h00000000;
		k_count<= 32'h00000000;
		CLK_Slow <=0;
	end

	always @(posedge CLK) begin
		counter_out<=    counter_out + 32'h00000001;	
		if(counter_out > 32'h000186A0) 	
		begin
			counter_out<= 32'h00000000;
			CLK_1K <= !CLK_1K;
			end
		end
		
endmodule //END 1K CLOCK MODULE


// SLOW CLOCK MODULE. TAKES INPUT FROM CLK_1k //
module Clock_Slow(
	input CLK_1k,
	output CLK_Slow);
	
reg [31:0] counter_out, k_count;
reg CLK_Slow, CLK_1K;
initial begin
	counter_out<= 32'h00000000;
	k_count<= 32'h00000000;
	CLK_Slow <=0;
end
	
always @(posedge CLK_1K) begin
	k_count = k_count + 32'h00000001;
	if( k_count > 32'h000003E8) begin
		k_count <= 32'h00000000;
		CLK_Slow <= ! CLK_Slow;
	end
end

endmodule //END SLOW CLOCK MODULE


// 7 SEGMENT STATE DISPLAY MODULE //
module Display_7seg(
	input q1,
	input q0,
	input CLK,
	output reg SSEG_CA,
	output reg SSEG_AN);

	reg [1:0] state;
	
	always @ (posedge CLK) begin

    SSEG_AN = 8'b11111110;

	state = {q1, q0};

    case(state)
	   2'b00   : SSEG_CA = 8'b11000000; // 0
	   2'b01   : SSEG_CA = 8'b11111001; // 1
	   2'b10   : SSEG_CA = 8'b10100100; // 2
	   default : SSEG_CA = 8'b10000110; // E
	endcase
	
	end

endmodule //END DISPLAY MODULE


// TOP LEVEL MODULE //
module SM (
	input CLK,
	input X3,
	input X2,
	input X1,
	input PBC,
	input CLK_Speed,
	output Z3,
	output Z2,
	output Z1,
	output q1,
	output q0,
	output [7:0] SSEG_CA,
	output [7:0] SSEG_AN );

wire aplus, bplus;
wire CLK_1k;

D_FF ffq1(PBC, aplus, q1);
D_FF ffq0(PBC, bplus, q0);

Clock_1k CLK1k(CLK, CLK_1k);
Display_7seg display7(q1, q0, CLK_1k, SSEG_CA, SSEG_AN);

assign aplus = !q1&!q0&!X1&X2 | !q1&!q0&X1&X2&X3 | !q1&q0&X2 | q1&q0;
assign bplus = q1&q0 | q1&!X1 | !q1&!q0&X1&!X3 | !q1&!X2;
assign Z1 = q0 | q1 | X2;
assign Z2 = !q1&!q0&!X2;
assign Z3 = !q1&!q0&X2&!X1;
    
endmodule