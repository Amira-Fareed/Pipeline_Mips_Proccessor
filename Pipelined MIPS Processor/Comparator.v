module Comparator (In1 , In2 , Output);

input [31:0] In1 , In2 ;
output reg Output ;
reg [31:0] XOR_output ;

always@ (In1 or In2)
begin
XOR_output <= In1 ^ In2;
#5
if(XOR_output == 0)
Output <= 1;

else 
Output <= 0;
end 
endmodule 