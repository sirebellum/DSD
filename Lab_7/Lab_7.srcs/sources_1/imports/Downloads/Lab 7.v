`timescale 1ns / 1ps

// D FLIP-FLOP MODULE //
module D_FF(
	input latch,
	input D,
	output reg Q);
	
	always @ (posedge latch)
		Q = D;
		
endmodule //END D FLIP-FLOP MODULE


// 1K CLOCK MODULE //
module Clock_1k(
    input CLK,
    output reg CLK_1k);

	reg [31:0] counter_out, k_count;
	initial begin
		counter_out<= 32'h00000000;
		k_count<= 32'h00000000;
	end

	always @(posedge CLK) begin
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
	input clock,
	output reg [7:0] cathode,
	output reg [7:0] annode);

	reg [1:0] state;
	
	always @ (posedge clock) begin

    annode = 8'b11111110;

	state = {q1, q0};

    case(state)
	   2'b00   : cathode = 8'b11000000; // 0
	   2'b01   : cathode = 8'b11111001; // 1
	   2'b10   : cathode = 8'b10100100; // 2
	   default : cathode = 8'b10000110; // E
	endcase
	
	end

endmodule //END DISPLAY MODULE


// ROM for state machine //
module ROM (
    input q0,
    input q1,
    input X1,
    input X2,
    input X3,
    output aplus,
    output bplus,
    output Z1,
    output Z2,
    output Z3);
    
reg [4:0] rom [31:0];

initial begin
    rom[0] = 5'b01101;
    rom[1] = 5'b01101;
    rom[2] = 5'b10110;
    rom[3] = 5'b00101;
    rom[4] = 5'b01101;
    rom[5] = 5'b01101;
    rom[6] = 5'b10110;
    rom[7] = 5'b00110;
    rom[8] = 5'b00101;
    rom[9] = 5'b00101;
    rom[10] = 5'b00110;
    rom[11] = 5'b00110;
    rom[12] = 5'b00101;
    rom[13] = 5'b00101;
    rom[14] = 5'b00110;
    rom[15] = 5'b00101;
    rom[16] = 5'b00101;
    rom[17] = 5'b00000;
    rom[18] = 5'b00101;
    rom[19] = 5'b00000;
    rom[20] = 5'b00101;
    rom[21] = 5'b00000;
    rom[22] = 5'b00101;
    rom[23] = 5'b00000;
    
    rom[24] = 5'b00000;
    rom[25] = 5'b00000;
    rom[26] = 5'b00000;
    rom[27] = 5'b00000;
    rom[28] = 5'b00000;
    rom[29] = 5'b00000;
    rom[30] = 5'b00000;
    rom[31] = 5'b00000;
end

assign Z3    = rom[{q1, q0, X3, X2, X1}][4];
assign Z2    = rom[{q1, q0, X3, X2, X1}][3];
assign Z1    = rom[{q1, q0, X3, X2, X1}][2];
assign aplus = rom[{q1, q0, X3, X2, X1}][1];
assign bplus = rom[{q1, q0, X3, X2, X1}][0];

endmodule //END ROM

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

/*
assign aplus = !q1&q0&X2 | !q1&!q0&X2&!X1|!q1&!q0&X2&X1&X3;
assign bplus = !q1&!q0&!X2 | !q1&!q0&!X3&X2&X1 | q1&!q0&!X1 | !q1&q0&!X2;

assign Z1 = q1&!q0 | !q1&q0;
assign Z2 = !q1 & q0 & !X2;
assign Z3 = q1&!q0&!X1;
*/

ROM rom(q0, q1, X1, X2, X3, aplus, bplus, Z1, Z2, Z3);

    
endmodule