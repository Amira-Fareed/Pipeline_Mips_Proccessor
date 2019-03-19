
module Reg_File ( RR1 , RR2 , WR , WD , RegWrite , clk , RD1 , RD2); 

input [4:0] RR1 , RR2 , WR ; // Addresses :)
input [31:0] WD ; // WriteData
input RegWrite ,clk ;  // Control
output reg [31:0] RD1,RD2 ; // ReadData
reg [31:0] RF [0:31];

always @(RR1 or RR2)
begin
RD1 <= RF[RR1];
RD2 <= RF[RR2];
end

always @(negedge clk)
begin

if(RegWrite)
RF[WR] <= WD;

end
endmodule 