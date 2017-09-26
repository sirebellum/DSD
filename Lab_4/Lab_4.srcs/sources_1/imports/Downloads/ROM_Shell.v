`timescale 1ns / 1ps

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
        for(i = 0; i < 32; i=i+1)
        begin
            Store[i] <= 8'b00000000;
        end
    end

//put your code here, use an always block to check for load & clear at addressed location

assign Ao = A;
assign LED = Store[A];

always @ (Clear, Load)
begin

    if (Clear) begin
        Store[A] <= 8'b00000000;
    end
    
    else if (Load & !Clear) begin
        Store[A] <= D;
    end
    
    else begin
    end
        
end

endmodule