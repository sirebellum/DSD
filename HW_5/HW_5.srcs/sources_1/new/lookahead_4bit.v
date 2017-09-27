`timescale 1ns / 1ps
module stage1(
    input a,
    input b,
    output orout,
    output andout
    );

	assign orout = !(a | b);
	assign andout = !(a & b);

endmodule

module lookahead_4bit(
    input [3:0] a,
    input [3:0] b,
	input cin,
    output [3:0] out,
    output cout
    );
	
	wire [3:0] orouts;
	wire [3:0] andouts;
	
	stage1 s1(a[0], b[0], orouts[0], andouts[0]);
	stage1 s2(a[1], b[1], orouts[1], andouts[1]);
	stage1 s3(a[2], b[2], orouts[2], andouts[2]);
	stage1 s4(a[3], b[3], orouts[3], andouts[3]);
	
	assign out[0] = cin ^ (!orouts[0] & andouts[0]);
	assign out[1] = !( (!cin & andouts[0]) | orouts[0] ) ^ (!orouts[1] & andouts[1]);
	assign out[2] = !( (!cin & andouts[0] & andouts[1]) | (andouts[1] & orouts[0]) | orouts[1] ) ^ (!orouts[2] & andouts[2]);
	assign out[3] = !( (!cin & andouts[0] & andouts[1] & andouts[2]) | (andouts[1] & andouts[2] & orouts[0]) | (andouts[2] & orouts[1]) | orouts[2] ) ^ (!orouts[3] & andouts[3]);
	
	assign cout = !( (!cin & andouts[0] & andouts[1] & andouts[2] & andouts[3]) | (andouts[1] & andouts[2] & andouts[3] & orouts[0]) | (andouts[2] & andouts[3] & orouts[1]) | (andouts[3] & orouts[2]) | orouts[3] );
    
endmodule
