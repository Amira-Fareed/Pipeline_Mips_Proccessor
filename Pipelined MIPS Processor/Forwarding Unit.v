module forwardingUnit ( forwardA, forwardB, 
                        IDEX_rs, IDEX_rt, EXMEM_desReg,EXMEM_regWrite, MEMWB_regWrite, MEMWB_desReg );

input [4:0] IDEX_rs, IDEX_rt, EXMEM_desReg, MEMWB_desReg;
input EXMEM_regWrite, MEMWB_regWrite;

output reg [1:0] forwardA, forwardB;

always @ ( IDEX_rs or IDEX_rt or EXMEM_desReg or EXMEM_regWrite or MEMWB_regWrite or MEMWB_desReg )
begin

// Rd=RS & instruction before me is writing & instruction before me not writing in register $0 
if ( (EXMEM_regWrite) && (EXMEM_desReg != 0)  && (EXMEM_desReg == IDEX_rs) )
begin
forwardA<=2'b10;
end

// if instruction (-2) is writing but in $0  &&  instruction (-1) in not writing  && destination of instruction (-1) != Rs of instruction (0)  && destination of instruction (-2) == RS
else if ( (MEMWB_regWrite) &&( MEMWB_desReg != 0 ) && ( MEMWB_desReg == IDEX_rs ) && (EXMEM_desReg != IDEX_rs) )
begin
forwardA<=2'b01;
end

// no hazards
else 
begin
forwardA<=2'b00;
end

// Rd=Rt & instruction before me is writing & instruction before me not writing in register $0 
if ( (EXMEM_regWrite) && (EXMEM_desReg != 0)  && (EXMEM_desReg == IDEX_rt) )
begin
forwardB<=2'b10;
end 

// if instruction (-2) is writing but in $0  &&  instruction (-1) in not writing  && destination of instruction (-1) != Rt of instruction (0)  && destination of instruction (-2) == Rt
else if ( (MEMWB_regWrite) && ( MEMWB_desReg != 0 ) && ( MEMWB_desReg == IDEX_rt )&&(EXMEM_desReg != IDEX_rt) )
begin
forwardB<=2'b01;
end

//no hazards
else
begin
forwardB<=2'b00;
end
end
endmodule
