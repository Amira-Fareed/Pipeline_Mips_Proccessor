module HazardDetection_Unit ( Rs_D , Rt_D , Rt_Ex , MemRead_Ex , PC_hold , Instruction_hold , Stall_Control);

input [4:0] Rs_D , Rt_D , Rt_Ex ;
input MemRead_Ex ;

output reg PC_hold, Instruction_hold , Stall_Control;


always @ (Rs_D or Rt_D or Rt_Ex or MemRead_Ex)
begin

if( MemRead_Ex && (Rs_D == Rt_Ex || Rt_D == Rt_Ex))
begin
PC_hold <= 1;
Instruction_hold <= 1;
Stall_Control <= 1;

end

else
begin
PC_hold <= 0;
Instruction_hold <= 0;
Stall_Control <= 0;
end

end

endmodule
