module IDEX_Reg (/*inputs*/ readData1, readData2, offset, rs, rt, rd, funct, memCtrl, exctrl, wbctrl,clk,shamt, Branch_D,
              /*outputs*/IDEX_readData1, IDEX_readData2, IDEX_offset, IDEX_rs, IDEX_rt, IDEX_rd, IDEX_funct,
	      IDEX_memCtrl, IDEX_exctrl, IDEX_wbctrl, IDEX_shamt, IDEX_Branch );

input [31:0] readData1, readData2, offset;
input [5:0]  funct;
input [4:0] rs, rt, rd ,shamt;
input [3:0] exctrl;
input [1:0] memCtrl, wbctrl;
input clk, Branch_D;

output reg [31:0] IDEX_readData1, IDEX_readData2, IDEX_offset;
output reg [5:0]  IDEX_funct;
output reg [4:0] IDEX_rs, IDEX_rt, IDEX_rd, IDEX_shamt;
output reg [3:0] IDEX_exctrl;
output reg [1:0] IDEX_memCtrl, IDEX_wbctrl;
output reg IDEX_Branch;

always @ (posedge clk)
begin

IDEX_readData1<=readData1;
IDEX_readData2<=readData2;
IDEX_offset<=offset;
IDEX_funct<=funct;
IDEX_rs<=rs;
IDEX_rt<=rt;
IDEX_rd<=rd;
IDEX_exctrl<=exctrl;
IDEX_memCtrl<=memCtrl;
IDEX_wbctrl<=wbctrl;
IDEX_shamt <= shamt;
IDEX_Branch <= Branch_D;
end
endmodule
