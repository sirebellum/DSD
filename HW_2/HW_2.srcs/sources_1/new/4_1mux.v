`timescale 1ns / 1ps
module mux1_4(
    input [3:0] in, [1:0] sel,
     output out, [3:0] led
    );
    
	wire a, b, c, d;
	
    assign a = (in[0] & ~sel[0] & ~sel[1]);
	assign b = (in[1] & ~sel[0] & sel[1]);
	assign c = (in[2] & sel[0] & ~sel[1]);
	assign d = (in[3] & sel[0] & sel[1]);

	assign out = (a | b | c | d);
	
	assign led[0] = in[0];
    assign led[1] = in[1];
    assign led[2] = in[2];
    assign led[3] = in[3];
	
endmodule