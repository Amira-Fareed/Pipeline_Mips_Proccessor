module Sll_32bit (In , Out);

input [31:0] In;
output reg [31:0] Out ;

always @ (In)
begin
Out <= In << 2 ;
end
endmodule