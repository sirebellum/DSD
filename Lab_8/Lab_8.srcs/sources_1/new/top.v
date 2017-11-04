`timescale 1ns / 1ps
module nonseq_count(
    input CLK, 
    input Start,
    output [3:0]LED, 
    output reg [7:0]SSEG_AN,
    output reg [7:0]SSEG_CA
    );
    
    // This code slows down the 100 Mhz clock to a 1 second period.
    reg A, B, C, D;
    wire [3:0]State;
    reg [31:0] counter_out;
    reg Clk_Slow;
        initial begin
        counter_out<= 32'h00000000;
        Clk_Slow <= 0;
        end    
    //this always block runs on the fast 100MHz clock
    always @(posedge CLK) begin
        counter_out<=    counter_out + 32'h00000001;        
        if (counter_out  > 32'h02F5E100) begin
            counter_out<= 32'h00000000;
            Clk_Slow <= !Clk_Slow;
            end
        end
    
    initial begin
        A <= 1'b1;
        B <= 1'b1;
        C <= 1'b0;
        D <= 1'b0;
    end
    
    assign State = {A,B,C,D};
    //
    always @(posedge Clk_Slow) begin
    A <= (!A & !B & C & D)|
		 (!A & B & C & !D)|
		 (A & !B & !C & D)|
		 (A & B & !C & !D & Start)|
		 (A & B & !C & !D & !Start);
		 
    B <= (A & !B & C & !D)|
		 (!A & B & !C & !D)|
		 (!A & B & !C & D)|
		 (!A & !B & C & D)|
		 (A & B & C & D)|
		 (A & !B & !C & D)|
		 (A & B & !C & !D & !Start);
		 
    C <= (A & B & !C & !D & Start)|
		 (!A & B & !C & D)|
		 (!A & B & C & D)|
		 (!A & !B & C & D)|
		 (A & B & C & D);
		 
    D <= (!A & B & !C & !D)|
		 (!A & B & !C & D)|
		 (!A & B & C & D)|
		 (!A & !B & C & D)|
		 (!A & B & C & !D);
    end
    //
    assign LED = State;
    
    always @(State) begin
    SSEG_AN = 8'b11111110;
    
    //LED = SW;
    case (State)
    4'b1100: begin
            SSEG_CA <= 8'b11000110;
           // A <= 1'b1;
            //B <= 1'b0;
           // C <= 1'b1;
            //D <= 1'b0;
          end
    4'b1010: begin
            SSEG_CA <= 8'b10001000;
            //A <= 1'b0;
            //B <= 1'b1;
            //C <= 1'b0;
            //D <= 1'b0;
            end
    4'b0100: begin
            SSEG_CA <= 8'b10011001;
            //A <= 1'b0;
            //B <= 1'b1;
            //C <= 1'b0;
            //D <= 1'b1;
            end
    4'b0101: begin
            SSEG_CA <= 8'b10010010;
            //A <= 1'b0;
            //B <= 1'b1;
            //C <= 1'b1;
            //D <= 1'b1;
            end
    4'b0111: begin
            SSEG_CA <= 8'b11111000;
            //A <= 1'b0;
            //B <= 1'b0;
            //C <= 1'b1;
            //D <= 1'b1;
            end
    4'b0011: begin
            SSEG_CA <= 8'b10110000;
            //A <= 1'b1;
            //B <= 1'b1;
            //C <= 1'b1;
            //D <= 1'b1;
            end
    4'b1111: begin
            SSEG_CA <= 8'b10001110;
            //A <= 1'b0;
            //B <= 1'b1;
            //C <= 1'b1;
            //D <= 1'b0;
            end
    4'b0110: begin
            SSEG_CA <= 8'b10000010;
            //A <= 1'b1;
            //B <= 1'b0;
            //C <= 1'b0;
            //D <= 1'b1;
            end
    4'b1001: begin
            SSEG_CA <= 8'b10010000;
            //A <= 1'b1;
            //B <= 1'b1;
            //C <= 1'b0;
            //D <= 1'b0;
            end        
    endcase                                                              
    end    
    
endmodule