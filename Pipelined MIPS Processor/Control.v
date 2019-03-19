
module Control (OP_Code ,Control_Signals);

input [5:0] OP_Code;
output reg [9:0] Control_Signals;
/* 0 => RegWrite , 1 => MemtoReg , 2 => MemWrite , 3 => MemRead ,
 4 => AluSrc , 5:6 => AluOP , 7 => RegDst , 8 => branch , 9 => jump */

always @(OP_Code)
begin

case(OP_Code)

/* R format  */
0: Control_Signals <= 10'b 0011000011 ;             

/* jump */
2: Control_Signals <= 10'b 10xxxx00x0 ; 	       

/* beq */
4: Control_Signals <= 10'b 01001000x0 ; 			

/* LW */
35: Control_Signals <= 10'b 0000011001 ;			

/* SW */	
43: Control_Signals <= 10'b 00x00101x0 ;				
	
endcase
end
endmodule
