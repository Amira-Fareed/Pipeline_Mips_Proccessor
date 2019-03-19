module MEM (clk , WB_EX ,MEM_EX ,ALUOutE ,WriteDataE ,WriteRegE ,WB_M ,WriteRegM  ,ReadDataM );

input clk ;
input [1:0] WB_EX , MEM_EX;
input [31:0] ALUOutE ,WriteDataE ;
input [4:0] WriteRegE ;

output reg [1:0] WB_M;
output reg [4:0] WriteRegM ;
output reg [31:0] ReadDataM ;

reg [31:0] dMemory [0:1023];

always @(posedge clk)
begin

WB_M <= WB_EX ;

if (WB_EX[0])
ReadDataM <= dMemory [ALUOutE];

else if (WB_EX[1])
dMemory[ALUOutE] = WriteDataE ;

end

endmodule

