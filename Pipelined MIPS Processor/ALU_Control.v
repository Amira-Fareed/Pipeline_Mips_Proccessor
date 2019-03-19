module Alu_Control (ALUOP , funct, OP);

input [1:0] ALUOP ;
input [5:0] funct ;
output reg [3:0] OP ;

always@(ALUOP or funct )
begin 
case (ALUOP)

0: OP <= 2; // add (lw,sw) 
1: OP <= 3; // sub (beq)
2: // R-type
	begin
	OP <= (funct==36)? 0: //and
              (funct==37)? 1: //or
              (funct==32)? 2: //add
	      (funct==34)? 3: //sub
	      (funct==0) ? 4: //sll
	      (funct==42)? 5:4'bx ; //slt	 
	   end

default: OP <= 4'bx;
endcase
end
endmodule
