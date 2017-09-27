`timescale 1ns / 1ps
module full_adder(
    input a,
    input b,
    input cin,
    output out,
    output cout
    );
	wire init, post, carryinit;
	
	assign init = a ^ b;
	assign carryinit = a & b;
	assign post = init & cin;
	
	assign out = init ^ cin;
	assign cout = carryinit | post;

endmodule

module ripple_4bit(
    input [3:0] a,
    input [3:0] b,
    output [3:0] out,
    output cout
    );
	wire [3:0] carries;
    
    full_adder a1(a[0], b[0], 0         , out[0], carries[0]);
    full_adder a2(a[1], b[1], carries[0], out[1], carries[1]);
    full_adder a3(a[2], b[2], carries[1], out[2], carries[2]);
    full_adder a4(a[3], b[3], carries[2], out[3], carries[3]);
    
    assign cout = carries[3];
    
endmodule
