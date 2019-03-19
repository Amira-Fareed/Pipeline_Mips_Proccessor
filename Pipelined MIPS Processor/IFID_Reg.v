module IFID_Reg (Instruction , PC4 , clk , flush , Instruction_hold , PC4_D , Instruction_D);

input [31:0] Instruction , PC4 ;
input  clk , Instruction_hold , flush;

output reg [31:0] PC4_D , Instruction_D ;


always @ (posedge clk)
begin 

if (flush)
begin
Instruction_D <= 0;
end

else if(Instruction_hold == 1)
begin
PC4_D <= PC4_D ;
Instruction_D <= Instruction_D;
end

else
begin
#1 PC4_D <= PC4 ;
#1 Instruction_D <= Instruction;
end

end
endmodule
