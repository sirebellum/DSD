`timescale 1ns / 1ps
module Sync_4Counter(
    input clock_up, clock_down, mr, pl,
	 input [3:0] in,
     output reg [3:0] out = 0,
	 output reg carry = 1, borrow = 1
    );

	always  @ (posedge clock_up, posedge clock_down, negedge mr, negedge pl)
	  begin
	  
		if(!mr)
			out <= 4'b0000;
			
		else if(!pl)
			out <= in;
			
		else if(clock_down)
		begin
            carry <= 1;
            if (out == 4'b1111)
            begin
                carry <= 0;
                out <= 4'b0000;
            end
            else
                out <= out + 1;
        end
                    
        else if(clock_up)
        begin
            borrow <= 1;
            if (out == 4'b0000)
            begin
                borrow <= 0;
                out <= 4'b1111;
            end
            else
                out <= out - 1;
        end
		
	  end

endmodule
