`timescale 1ns / 1ps

module test_bench(

    );
    
reg [3:0] switches;
reg clock;
wire [7:0] anode;
wire [7:0] cathode;
wire [3:0] leds;
integer i;
    
Seven_Seg thingy(switches, clock, anode, cathode, leds);

initial begin
    switches = 4'b0000;
    clock = 0;

    for (i = 0; i<50; i=i+1) begin
        switches = switches + 1;
        #10 clock = !clock;
    end
end

endmodule
