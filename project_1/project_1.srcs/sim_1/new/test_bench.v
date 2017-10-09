`timescale 1ns / 1ps
module pract_tb();
    
    //Inputs as reg
    reg A, B, C, D;
    
    //Outputs as wire
    wire F;
        
    arbitrary dut(A, B, C, D, F);
    
    initial begin
    A = 1'b0; B = 1'b0; C = 1'b0; D =1'b0;      // 
    #200;
    A = 1'b0; B = 1'b0; C = 1'b0; D =1'b1;      // 
    #200;
    A = 1'b0; B = 1'b0; C = 1'b1; D =1'b0;
    #200;
    A = 1'b0; B = 1'b0; C = 1'b1; D =1'b1;
    #200;
    A = 1'b0; B = 1'b1; C = 1'b0; D =1'b0;
    #200;
    A = 1'b0; B = 1'b1; C = 1'b0; D =1'b1;
    #200;
    A = 1'b0; B = 1'b1; C = 1'b1; D =1'b0;
    #200;
    A = 1'b0; B = 1'b1; C = 1'b1; D =1'b1;
    #200;
    A = 1'b1; B = 1'b0; C = 1'b0; D =1'b0;
    #200;
    A = 1'b1; B = 1'b0; C = 1'b0; D =1'b1;
    #200;
    A = 1'b1; B = 1'b0; C = 1'b1; D =1'b0;
    #200;
    A = 1'b1; B = 1'b0; C = 1'b1; D =1'b1;
    #200;                                                        
    A = 1'b1; B = 1'b1; C = 1'b0; D =1'b0;
    #200;
    A = 1'b1; B = 1'b1; C = 1'b0; D =1'b1;
    #200;
    A = 1'b1; B = 1'b1; C = 1'b1; D =1'b0;
    #200;
    A = 1'b1; B = 1'b1; C = 1'b1; D =1'b1;
    #200;            
    end

endmodule
