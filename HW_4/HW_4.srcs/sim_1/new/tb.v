`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2017 10:09:45 PM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb(

    );
    
reg clock_up = 0, clock_down = 1, reset = 1, load = 1;
wire carry, borrow;
reg [3:0] in = 4'b0000;
wire [3:0] out;

integer i;

Sync_4Counter counter(clock_up, clock_down, reset, load, in, out, carry, borrow);

initial
    begin
    load <= 0;
    #5 load <= 1;
        for (i=0; i < 40; i=i+1)
            #10 clock_up <= ~clock_up;
        
        clock_up <= 1;
        for (i=0; i< 20; i=i+1)
            #10 clock_down <= ~clock_down;
        
        reset <= 0;
        #5 reset <= 1;
        for (i=0; i< 15; i=i+1)
            #10 clock_down <= ~clock_down;
    end

endmodule
