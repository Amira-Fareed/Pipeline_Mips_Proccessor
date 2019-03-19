module Top_Module (clk , reset);

input clk ,reset ;

wire PC_hold , Instruction_hold , RegWrite_WB ,  Stall_Control , MemRead , MemWrite, MemtoReg, andOut, zeroFlag, Jump_D, Branch_D, IDEX_Branch, flush ;
wire [1:0] WB_D , WB_M ,WB_EX , MEM_D , MEM_EX , forwardA, forwardB;
wire [3:0] EX_D , EX_EX , OP;
wire [4:0] Rs_D , Rt_D , Rt_EX , Rs_EX, Rd_D , Rd_EX ,shamt_D , shamt_EX , WR_WB, WR_M , WR_EX;
wire [5:0] funct_EX;
wire [7:0] Control_D ;
wire [9:0] Control_Signals;
wire [31:0] PC4 , PC4_D , ReadAddress , Instruction , Instruction_D , WD_WB , RD1 , RD2 , Immediate_D ,
branch_Address , RD1_EX, RD2_EX, Immediate_EX ,Alu_In1 , Alu_In2 ,Alu_Result_EX,Alu_Result_WB, Alu_Result_M ,
M3_out , RD ,RD_WB ,WD, inputAddress;

/*=================================================================================================================================================*/
/*====================================================================Instruction Fetch===========================================================*/
/*=================================================================================================================================================*/


//MUX_2x1_32bit (In1,In2,Sel,Output);
MUX_2x1_32bit PCMux (PC4, branch_Address, andOut, inputAddress);

//PC (inputAddress , clk ,reset , PC_hold , ReadAddress);
PC pc (inputAddress , clk ,reset ,flush , PC_hold , ReadAddress);

//Adder ( In1 , In2 , Out ) ;
Adder A1 ( ReadAddress , 1 , PC4 ) ;

//Instruction_Memory (ReadAddress , Instruction)
Instruction_Memory IMemory (ReadAddress , Instruction);

/*=================================================================================================================================================*/
/*====================================================================Instruction Decode===========================================================*/
/*=================================================================================================================================================*/

//IFID_Reg (Instruction , PC4 , clk , Instruction_hold , PC4_D , Instruction_D );
IFID_Reg IFID (Instruction , PC4 , clk, flush, Instruction_hold , PC4_D , Instruction_D );

//Control (OP_Code ,Control_Signals)
Control control (Instruction_D[31:26] ,Control_Signals);

//Reg_File ( RR1 , RR2 , WR , WD , RegWrite , clk , RD1 , RD2);
Reg_File reg_file ( Rs_D , Rt_D , WR_WB , WD_WB , RegWrite_WB , clk , RD1 , 
RD2);

//Sign_Extend (In,Out);
Sign_Extend sign_extend (Instruction_D[15:0],Immediate_D);


//HazardDetection_Unit ( Rs_D , Rt_D , Rt_Ex , MemRead_Ex , PC_hold , andOut, Instruction_hold , Stall_Control, flush );
HazardDetection_Unit hazard_detector ( Rs_D , Rt_D , Rt_EX , MEM_EX[1]  , PC_hold ,Instruction_hold , Stall_Control);

//MUX_2x1_8bits (In1,In2,Sel,Output);
MUX_2x1_8bits M1 (Control_Signals[7:0] , 8'b 0 , Stall_Control , Control_D );

assign Rs_D = Instruction_D[25:21];
assign Rt_D = Instruction_D[20:16];
assign Rd_D = Instruction_D[15:11];
assign shamt_D = Instruction_D[10:6];
assign WB_D = Control_D [1:0] ;
assign MEM_D = Control_D [3:2] ;
assign EX_D = Control_D [7:4] ;
assign Branch_D = Control_Signals [8];
assign Jump_D = Control_Signals [9];
assign flush = Branch_D && andOut;

/*=================================================================================================================================================*/
/*====================================================================Execution===========================================================*/
/*=================================================================================================================================================*/

//IDEX_Reg (/*inputs*/ readData1, readData2, offset, rs, rt, rd, funct, memCtrl, exctrl, wbctrl,clk,shamt,
//              /*outputs*/IDEX_readData1, IDEX_readData2, IDEX_offset, IDEX_rs, IDEX_rt, IDEX_rd, IDEX_funct,
//	      IDEX_memCtrl, IDEX_exctrl, IDEX_wbctrl, IDEX_shamt );
IDEX_Reg IDEX (/*inputs*/ RD1 , RD2, Immediate_D, Rs_D , Rt_D , Rd_D,
              Instruction_D[5:0], MEM_D, EX_D, WB_D, clk, shamt_D, Branch_D,
              /*outputs*/ RD1_EX, RD2_EX, Immediate_EX, Rs_EX, Rt_EX, Rd_EX, funct_EX,
	      MEM_EX, EX_EX, WB_EX, shamt_EX, IDEX_Branch );

//Alu_Control (ALUOP , funct, OP);
Alu_Control alu_control (EX_EX[2:1], funct_EX, OP);

//ALU (In1 , In2 , OP ,shamt, Result);
ALU alu (Alu_In1 , Alu_In2 , OP ,shamt_EX, Alu_Result_EX, zeroFlag);

//Adder ( In1 , In2 , Out ) ;
 Adder A2 ( Immediate_EX , PC4_D , branch_Address) ;

//and(output, in1, in2)
and andGate (andOut, IDEX_Branch, zeroFlag);

//Mux3x1_32 ( muxOut, in0, in1, in2, muxSel );
Mux3x1_32 M2( Alu_In1 ,RD1_EX, WD_WB, Alu_Result_M, forwardA );

//Mux3x1_32 ( muxOut, in0, in1, in2, muxSel );
Mux3x1_32 M3( M3_out, RD2_EX, WD_WB , Alu_Result_M, forwardB );

//MUX_2x1_32bit (In1,In2,Sel,Output);
MUX_2x1_32bit M4 (M3_out, Immediate_EX, EX_EX[0],Alu_In2);

//MUX_2x1_5bit (In1,In2,Sel,Output);
MUX_2x1_5bit M5 (Rt_EX, Rd_EX,EX_EX[3],WR_EX);

//forwardingUnit ( forwardA, forwardB, IDEX_rs, IDEX_rt, EXMEM_desReg,EXMEM_regWrite, MEMWB_regWrite, MEMWB_desReg );
forwardingUnit forwarding_unit ( forwardA, forwardB, Rs_EX, Rt_EX, WR_M , WB_M[0], RegWrite_WB , WR_WB );


/*=================================================================================================================================================*/
/*====================================================================Memory==========================================================*/
/*=================================================================================================================================================*/

EXMEM_Reg EXMEM (WB_EX , MEM_EX , Alu_Result_EX , RD2_EX ,WR_EX, clk , WB_M , MemRead , MemWrite ,Alu_Result_M ,WD , WR_M );

Data_Memory DMemory (Alu_Result_M , WD , MemRead , MemWrite , clk , RD);


/*=================================================================================================================================================*/
/*====================================================================Write Back===========================================================*/
/*=================================================================================================================================================*/

MEM_WB_Reg MEMWB ( RD , Alu_Result_M , WR_M , WB_M , clk , RegWrite_WB , MemtoReg , RD_WB , Alu_Result_WB , WR_WB ) ;

MUX_2x1_32bit M6 (RD_WB , Alu_Result_WB ,MemtoReg,WD_WB);





endmodule
