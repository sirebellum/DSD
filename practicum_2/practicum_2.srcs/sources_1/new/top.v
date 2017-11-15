`timescale 1ns / 1ps

/* Cathode dictionary:
0 : SSEG_CA = 8'b11000000;
1 : SSEG_CA = 8'b11111001;
2 : SSEG_CA = 8'b10100100;
3 : SSEG_CA = 8'b10110000;
4 : SSEG_CA = 8'b10011001;
5 : SSEG_CA = 8'b10010010;
6 : SSEG_CA = 8'b10000010;
7 : SSEG_CA = 8'b11111000;
8 : SSEG_CA = 8'b10000000;
9 : SSEG_CA = 8'b10011000;
A : SSEG_CA = 8'b10001000;
b : SSEG_CA = 8'b10000011;
C : SSEG_CA = 8'b11000110;
d : SSEG_CA = 8'b10100001;
E : SSEG_CA = 8'b10000110;
F : SSEG_CA = 8'b10001110;
q : SSEG_CA = 8'b10011000;
*/

module top(
    input CLK,
    input PBC,
    output [7:0]SSEG_AN,
    output [7:0]SSEG_CA
    );
    
    reg [7:0] digit1, digit2, digit3, digit4, digit5, digit6, digit7, digit8;
    wire CLK_1k, CLK_Slow;
    reg [3:0] state;
    
    Clock_1k k_clock(CLK, CLK_1k);
    Clock_Slow slow_clock(CLK_1k, CLK_Slow);
    
    Display_7seg display(digit1, digit2, digit3, digit4, digit5, digit6, digit7, digit8, CLK_1k, SSEG_CA, SSEG_AN);
    
    always @ (posedge CLK_Slow) begin
    
        if (PBC || state) begin
            case (state)
                4'b0000 : state = 4'b0001;
                4'b0001 : state = 4'b0010;
                4'b0010 : state = 4'b0011;
                4'b0011 : state = 4'b0100;
                4'b0100 : state = 4'b0101;
                4'b0101 : state = 4'b0110;
                4'b0110 : state = 4'b0111;
                4'b0111 : state = 4'b1000;
                4'b1000 : state = 4'b0000;
                default:  state = 4'b0000;
            endcase
        end
        
        
        case (state)
            4'b0000 : begin
                digit1 = 8'b11111111;
                digit2 = 8'b11111111;
                digit3 = 8'b11111111;
                digit4 = 8'b11111111;
                digit5 = 8'b11111111;
                digit6 = 8'b11111111;
                digit7 = 8'b11111111;
                digit8 = 8'b11111111;
            end
            4'b0001 : begin
                digit1 = 8'b10011000;
                digit2 = 8'b11111111;
                digit3 = 8'b11111111;
                digit4 = 8'b11111111;
                digit5 = 8'b11111111;
                digit6 = 8'b11111111;
                digit7 = 8'b11111111;
                digit8 = 8'b11111111;
            end
            4'b0010 : begin
                digit1 = 8'b10011001;
                digit2 = 8'b10011000;
                digit3 = 8'b11111111;
                digit4 = 8'b11111111;
                digit5 = 8'b11111111;
                digit6 = 8'b11111111;
                digit7 = 8'b11111111;
                digit8 = 8'b11111111;
            end
            4'b0011 : begin
                digit1 = 8'b11000000;
                digit2 = 8'b10011001;
                digit3 = 8'b10011000;
                digit4 = 8'b11111111;
                digit5 = 8'b11111111;
                digit6 = 8'b11111111;
                digit7 = 8'b11111111;
                digit8 = 8'b11111111;
            end
            4'b0100 : begin
                digit1 = 8'b11000110;
                digit2 = 8'b11000000;
                digit3 = 8'b10011001;
                digit4 = 8'b10011000;
                digit5 = 8'b11111111;
                digit6 = 8'b11111111;
                digit7 = 8'b11111111;
                digit8 = 8'b11111111;
            end
            4'b0101 : begin
                digit1 = 8'b10011000;
                digit2 = 8'b11000110;
                digit3 = 8'b11000000;
                digit4 = 8'b10011001;
                digit5 = 8'b10011000;
                digit6 = 8'b11111111;
                digit7 = 8'b11111111;
                digit8 = 8'b11111111;
            end
            4'b0110 : begin
                digit1 = 8'b10000110;
                digit2 = 8'b10011000;
                digit3 = 8'b11000110;
                digit4 = 8'b11000000;
                digit5 = 8'b10011001;
                digit6 = 8'b10011000;
                digit7 = 8'b11111111;
                digit8 = 8'b11111111;
            end
            4'b0111 : begin
                digit1 = 8'b11111111;
                digit2 = 8'b10000110;
                digit3 = 8'b10011000;
                digit4 = 8'b11000110;
                digit5 = 8'b11000000;
                digit6 = 8'b10011001;
                digit7 = 8'b10011000;
                digit8 = 8'b11111111;
            end
            4'b1000 : begin
                digit1 = 8'b11111111;
                digit2 = 8'b11111111;
                digit3 = 8'b10000110;
                digit4 = 8'b10011000;
                digit5 = 8'b11000110;
                digit6 = 8'b11000000;
                digit7 = 8'b10011001;
                digit8 = 8'b10011000;
            end
            default : begin
                digit1 = 8'b11111111;
                digit2 = 8'b11111111;
                digit3 = 8'b11111111;
                digit4 = 8'b11111111;
                digit5 = 8'b11111111;
                digit6 = 8'b11111111;
                digit7 = 8'b11111111;
                digit8 = 8'b11111111;
            end
        endcase
    
    end
    
    
endmodule
