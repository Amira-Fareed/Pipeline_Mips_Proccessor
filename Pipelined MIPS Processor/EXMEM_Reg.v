module EXMEM_Reg (WB_EX , MEM_EX , Alu_Result_EX , RD2_EX ,WR_EX, clk , WB_M , MemRead , MemWrite , Address ,WD , WR_M );

input  clk ;
input [1:0] WB_EX , MEM_EX ;
input [4:0] WR_EX;
input [31:0] Alu_Result_EX , RD2_EX ;

output reg MemRead , MemWrite;
output reg [1:0] WB_M;
output reg [4:0] WR_M;
output reg [31:0] Address ,WD;

always @ (posedge clk)
begin 

MemRead <= MEM_EX[1] ;
MemWrite <= MEM_EX[0] ;
WB_M <= WB_EX ;
WR_M <= WR_EX ;
Address <= Alu_Result_EX ;
WD <= RD2_EX ;

end
endmodule
