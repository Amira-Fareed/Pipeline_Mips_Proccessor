
module MUX_2x1_8bits (In1,In2,Sel,Output);

input [7:0] In1 , In2 ;
input Sel;
output reg [7:0] Output ;
 
always @(In1 or In2 or Sel)
begin

if(Sel)
Output <= In2 ;
else 
Output <= In1 ;
end


endmodule 

//================================================================================================================================

module Mux3x1_32 ( muxOut, in0, in1, in2, muxSel );
input [31:0] in0, in1, in2;
input [1:0] muxSel;

output reg [31:0] muxOut;

always@ (in0 or in1 or in2 or muxSel)
begin 

muxOut<= ( muxSel==0 )? in0 :
         ( muxSel==1 )? in1 :
         ( muxSel==2 )? in2 :
          32'bx;

end

endmodule

//================================================================================================================================

module MUX_2x1_32bit (In1,In2,Sel,Output);

input signed [31:0] In1 , In2 ;
input Sel;
output reg signed [31:0] Output;

always @(In1 or In2 or Sel)
begin

if(Sel)
Output <= In2 ;

else 
Output <= In1 ;

end
endmodule 

//================================================================================================================================

module MUX_2x1_5bit (In1,In2,Sel,Output);

input signed [4:0] In1 , In2 ;
input Sel;
output reg signed [4:0] Output;

always @(In1 or In2 or Sel)
begin

if(Sel)
Output <= In2 ;

else 
Output <= In1 ;

end
endmodule 
