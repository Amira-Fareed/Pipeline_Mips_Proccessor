module Adder_flush ( In1 , In2 , flush , Out ) ;

input flush ;
input [31:0] In1 , In2 ;
output reg [31:0] Out ;

always @ (In1 or In2)
begin

if(flush==1)
Out <= Out ;

else 
Out <= In1 + In2 ;
end
endmodule
