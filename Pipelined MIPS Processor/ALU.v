module ALU (In1 , In2 , OP ,shamt, Result, zeroFlag);

input signed [31:0] In1 , In2 ;
input [3:0] OP ; 
input [4:0] shamt ;

output reg signed [31:0] Result ;
output reg zeroFlag;

always @(In1 or In2 or OP or shamt)
begin
    case (OP)
       0 : Result <= In1 & In2 ; // and
       1 : Result <= In1 | In2 ; // or
       2 : Result <= In1 + In2 ; // add
       3 : begin
	   Result = In1 - In2 ; 
           if(Result==32'b0) begin
		zeroFlag<=1; end
	   else begin
		zeroFlag<=1'b0; end
	   end
		
       4 : Result <= In2 << shamt ; //sll
       5 : Result <= (In1 < In2) ? 1 : 0 ; //slt
       default : Result <= 32'b x ; 
    endcase



end
endmodule
