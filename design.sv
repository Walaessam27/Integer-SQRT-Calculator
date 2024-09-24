module Int_SQRT_Calculator (
 input Clock, 
 input Reset, 
 input S, 
 input [7:0] X, 
 output reg [7:0] sqrt
);
 integer q,a,d;
  reg [2:0] Current_State, Next_State;
 parameter T0 = 3'b000, T1 = 3'b001, T2 = 3'b010, T3 = 3'b011, T4 = 3'b100;
   
  always @(S, Current_State)
case (Current_State)
  T0: if (S) Next_State <= T1;
      else Next_State <= T0;
  T1: Next_State = T2;
  T2: if (a < q) Next_State <= T3;
       else Next_State <= T1;
  T3: Next_State <= T4;
  T4: Next_State <= T0;
endcase
      
always @(negedge Reset, posedge Clock)
begin
  if (Reset == 0) Current_State <= T0;
else Current_State <= Next_State;
end

always @(posedge Clock)
begin
case (Current_State)
  T0: if (S == 1)
      begin 
       a <= X;
       q <= 1;
       d <= 3;
      end
  T1: q <= q + d;
  T2: d <= d + 2;
  T3: d <= d >> 1;
  T4: sqrt <= d - 1;
endcase
end
endmodule