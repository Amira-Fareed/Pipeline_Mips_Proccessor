module Instruction_Memory ( ReadAddress , Instruction );

input [31:0] ReadAddress ;

output reg [31:0] Instruction ;

reg [31:0] iMemory [0:1023];

always@(ReadAddress)
begin

Instruction <= iMemory[ReadAddress];

end

endmodule
