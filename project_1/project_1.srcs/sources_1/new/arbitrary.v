`timescale 1ns / 1ps
module arbitrary(
	input A, B, C, D,
	output reg F);

reg X, Y, Z, W;

always @(*) begin

	X = !A|C|D;
	Y = !B&C&D;
	Z = B&!C&!D;
	W = Y | Z;

	F = X & W;
	
	if (F>0)
	   F = 1'b1;

end

endmodule