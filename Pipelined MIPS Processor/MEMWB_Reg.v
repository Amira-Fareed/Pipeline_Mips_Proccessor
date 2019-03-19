module MEM_WB_Reg ( RD_M , Alu_Result_M , WR_M , WB_Control , clk , RegWrite , MemtoReg , RD , Alu_Result , WR ) ;

input [4:0] WR_M ;
input [31:0] RD_M , Alu_Result_M ;
input [1:0] WB_Control ;
input clk ;

output reg [4:0] WR ;
output reg [31:0] RD , Alu_Result ;
output reg RegWrite , MemtoReg ;

always @(posedge clk)
begin

RD <= RD_M ;
Alu_Result <= Alu_Result_M ;
WR <= WR_M ;
RegWrite <= WB_Control[0];
MemtoReg <= WB_Control[1];

end


endmodule
