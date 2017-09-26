`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Company:
 
// Engineer: Paul Morton

//
 
// Create Date: 10/12/2014 10:50:11 PM

// Design Name: 

// Module Name: ROM

// Project Name:
 
// Target Devices: NEXYS-4 Board

// Tool Versions:

// Description: 

//
 
// Dependencies:
 
//
 
// Revision:

// Revision 0.01 - File Created
// Additional Comments:  A is slide switch 15,14,13,12,11,  LED 7:0 are the outputs

// Outputs are always displayed for the current address in A using LED's 7:0  D is slide switch 7:0
//////////////////////////////////////////////////////////////////////////////////



module ROM(
    output [7:0] LED,
    output [4:0] Ao,
    input [7:0] D,
    input [4:0] A,
    input Clear,
    input Load
    );
    
    reg [7:0] Store [0:31];
    integer i;
    
    initial begin     //Can make simpler with a for loop 
        for(i = 0; i <= 31; i=i+1)
        begin
            Store[i]<=8'b00000000;
        end
    end

//put your code here, use an always block to check for load & clear at addressed location

assign Ao = A;
assign LED = Store[A];

always @ (Clear, Load)
begin

    if (Clear == 1)
        Store[A] <= 8'b00000000;
    else if (Load == 1)
        Store[A] <= D;
    else
        Store[A] <= Store[A];
        
end

endmodule