// TOP MODULE //
module game(
	input BTNC, BTND, CLK,
	input [15:0]SW,
	output reg [15:0]LED,
	output [7:0]SSEG_CA,
	output [7:0]SSEG_AN
	);
	
	wire CLK_1K;
	Clock_1k CLK1K(CLK, CLK_1K);
	
	wire CLK_Slow;
	Clock_Slow CLKSLOW(CLK_1K, CLK_Slow);
	
	wire [3:0] randgen[3:0];
	reg [3:0] randstore[3:0];
	random RANDOM(CLK_Slow, CLK, randgen[0], randgen[1], randgen[2], randgen[3]);

	reg [7:0] digit1, digit2, digit3, digit4, digit6, digit7, digit8;
	Display_7seg display(digit1, digit2, digit3, digit4, digit5, digit6, digit7, digit8, CLK_1K, SSEG_CA, SSEG_AN);
	
	reg [2:0] state;
	
	reg [1:0] guessNum; //increments after each guess
	reg [3:0] guessDig; //The number pulled from the switches used for guessing
	reg [1:0] randNum;  //current random number being guessed
	
	reg [3:0] i;
		

    initial begin
	state = 3'b000;
	
    guessNum = 2'b00;
    randNum = 2'b00;
    end
    
	always @ (posedge CLK) begin
		case (state)
		
			3'b000: begin //Initial state, wait for button, scroll and proceed once pressed
				randstore[0] = randgen[0];
				randstore[1] = randgen[1];
				randstore[2] = randgen[2];
				randstore[3] = randgen[3];
				
				if (BTNC) begin
					//SCROLL RANDOM NUMBERS//
					state = 3'b001;
				end
			end
			
			3'b001: begin //Waiting for and checking player guesses
				if (BTND) begin
					for (i=0 ; i <= 4'b1111 ; i = i + 4'b0001) begin
						if(SW[i]) 
						guessDig = i;
						//ERROR Handling would be nice here
					end
					guessNum = guessNum + 1;
				
					if (guessDig == randstore[randNum])
						state = 3'b100;
					else
						state = 3'b010;
				end
			end
			
			3'b010: begin //Wrong guess
			
				//SCROLL VALUE TO NEXT EMPTY SLOT USING guessNum//
				
				// led for higher or lower
				if (guessNum < randstore[randNum]) begin
					LED[0] = 1;
					LED[15] = 0;
				end
				else begin
					LED[0] = 0;
					LED[15] = 1;
				end //end higher or lower
				
				if (guessNum == 4)
					state = 3'b011;
				else
					state = 3'b001;
			end
			
			3'b011: begin //4 wrong guesses	
				//SHOW ACTUAL RANDOM NUMBERS IN LOWER 4//
				//WAIT 3 SECONDS AND CHANGE UPPER 4 TO F000//
				state = 3'b000;
			end
			
			3'b100: begin //Correct guess

				LED = 16'b1111111111111111;
			
				//SCROLL VALUE TO CORRECT SLOT USING randNum
				
				LED <= 16'b0000000000000000;
				
				randNum = randNum + 1;
				guessNum = 2'b00;
				if (randNum == 4)
					state = 3'b101;
				else
					state = 3'b001;
			end
			
			3'b101: begin //4 correct guesses
				//SHOW WINNING FLASHES 1 SEC ON OFF//
				
				if (BTNC)
					state = 3'b000;
			end
			
		endcase
	end	
	
	
endmodule // END TOP MODULE //



// RANDOM NUMBER MODULE //
module random(
	input CLK_Slow, CLK,
	output reg [3:0]Randy0,
	output reg [3:0]Randy1,
	output reg [3:0]Randy2,
	output reg [3:0]Randy3
	);
		
	reg [31:0]counter;
	
	always @(posedge CLK) begin
	counter <= counter + 32'h00A03001;
	end
	
	always @(posedge CLK_Slow) begin

        Randy0 = {counter[2],counter[17],1'b1,counter[3]};
        Randy1 = {counter[6],counter[7],counter[19],1'b0};
        Randy2 = {counter[5],1'b1,counter[13],counter[20]};
        Randy3 = {counter[8],counter[11],counter[16],counter[12]};

	end
	
endmodule // END RANDOM NUMBER MODULE //


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

// 7 SEGMENT STATE DISPLAY MODULE //
module Display_7seg(
    input [7:0] digit1, //Leftmost digit
	input [7:0] digit2, 
	input [7:0] digit3,
	input [7:0] digit4,
	input [7:0] digit5,
	input [7:0] digit6,
	input [7:0] digit7,
	input [7:0] digit8, //Rightmost digit
    input clock,
    output reg [7:0] cathode,
    output reg [7:0] annode);

	
    always @ (posedge clock) begin

		case(annode) //scroll through 7-seg digits
			8'b01111111 : annode = 8'b10111111;
			8'b10111111 : annode = 8'b11011111;
			8'b11011111 : annode = 8'b11101111;
			8'b11101111 : annode = 8'b11110111;
			8'b11110111 : annode = 8'b11111011;
			8'b11111011 : annode = 8'b11111101;
			8'b11111101 : annode = 8'b11111110;
			8'b11111110 : annode = 8'b01111111;
			default : annode = 8'b01111111;
		endcase

		//Set non-blank digits
		if (annode == 8'b01111111)
			cathode = digit1;
		if (annode == 8'b10111111)
			cathode = digit2;
		if (annode == 8'b11011111)
			cathode = digit3;
		if (annode == 8'b11101111)
			cathode = digit4;
		if (annode == 8'b11110111)
			cathode = digit5;
		if (annode == 8'b11111011)
			cathode = digit6;
		if (annode == 8'b11111101)
			cathode = digit7;
		if (annode == 8'b11111110)
			cathode = digit8;
		
	end
	
endmodule //END DISPLAY MODULE



// 1K CLOCK MODULE //
module Clock_1k(
    input clock,
    output reg CLK_1k);

        reg [31:0] counter_out, k_count;
        initial begin
                counter_out<= 32'h00000000;
                k_count<= 32'h00000000;
        end

        always @(posedge clock) begin
                counter_out<=    counter_out + 32'h00000001;
                if(counter_out > 32'h000186A0)
                begin
                        counter_out<= 32'h00000000;
                        CLK_1k <= !CLK_1k;
                        end
                end

endmodule //END 1K CLOCK MODULE


// SLOW CLOCK MODULE. TAKES INPUT FROM CLK_1k //
module Clock_Slow(
	input CLK_1k,
	output reg CLK_Slow);
	
reg [31:0] counter_out, k_count;
initial begin
	counter_out<= 32'h00000000;
	k_count<= 32'h00000000;
	CLK_Slow <=0;
end
	
always @(posedge CLK_1k) begin
	k_count = k_count + 32'h00000001;
	if( k_count > 32'h000000E8) begin
		k_count <= 32'h00000000;
		CLK_Slow <= ! CLK_Slow;
	end
end

endmodule //END SLOW CLOCK MODULE