module Sign_Extend (In,Out);

input signed [15:0] In ;
output reg signed [31:0] Out;

always @(In)
begin
Out <= {{16{In[15]}},In};
end

endmodule 
