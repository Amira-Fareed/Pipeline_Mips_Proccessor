module PC (inputAddress , clk ,reset ,flush, PC_hold, ReadAddress);

input [31:0] inputAddress;
input clk ,reset,PC_hold , flush ;

output reg [31:0] ReadAddress ;

always @(posedge clk or posedge reset)
begin

if(reset)
ReadAddress <= 0 ;

else if( PC_hold || flush )
ReadAddress  <= inputAddress - 1 ;

else
ReadAddress <= inputAddress ;

end
endmodule
