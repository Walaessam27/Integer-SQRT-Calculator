`timescale 1 ns / 1ns

module testbench;
  
 reg Clock; 
 reg Reset; 
 reg S; 
 reg [7:0] X; 
 reg [7:0] sqrt;
 integer W,E;
  
  Int_SQRT_Calculator intt(Clock, Reset, S, X, sqrt);
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(1);
    Clock=0;
    Reset =0;
    S=0;
    X=0;
    #20 Reset=1;
    for(W=1; W<256 ;W=W+1)
      begin     
        #20 S=1;
         X=W;
        #400;
         S=0;
      end
    end
      
  initial begin 
    for(E=0; E<21544 ;E=E+1)
      begin
      #5  Clock <= ~ Clock;
      end
  end
  
 initial begin 
   $monitor ("X=%d, sqrt=%d",X,sqrt );
  end
   
endmodule

