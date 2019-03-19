module Data_Memory (Address , WD , MemRead , MemWrite , clk , RD);

input [31:0] Address , WD ;
input MemRead , MemWrite , clk;
output reg [31:0] RD ;
reg [31:0] dMemory [0:1023];

always@(Address or WD or MemRead)
begin
if (MemRead)
RD <= dMemory [Address];
end

always @(negedge clk)
begin
if(MemWrite)
dMemory [Address] <= WD ;
end

endmodule

