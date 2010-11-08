/*
	Módulo Memory.
	
	Desenvolvido por Cássio Elias e Gerley Machado
*/


module Memory(

	input             clock,
	input             reset,

	// Execute	
	input       [2:0] ex_mem_msm,
	input       [2:0] ex_mem_msl,
	input             ex_mem_readmem,    
	input             ex_mem_writemem,
	input             ex_mem_mshw,
	input             ex_mem_lshw,
	input      [31:0] ex_mem_regb,
	input       [2:0] ex_mem_selwsource,
	input       [4:0] ex_mem_regdest,
	input             ex_mem_writereg,
	input      [31:0] ex_mem_aluout,
	input      [31:0] ex_mem_wbvalue,

	// GDM
	output            mem_mc_rw,        
	output            mem_mc_en,        
	output     [31:0] mem_mc_addr,      
	inout      [31:0] mem_mc_data,      
	output            mem_mc_en1h,
	output            mem_mc_en1l,
	output            mem_mc_en2h,
	output            mem_mc_en2l,

	// Forwarding
	output     [31:0] mem_fw_wbvalue,
	output            mem_fw_writereg,

	// Writeback
	output reg  [4:0] mem_wb_regdest,
	output reg        mem_wb_writereg,
	output reg [31:0] mem_wb_wbvalue

	);
	
	//GDM
	assign mem_mc_rw = (~ex_mem_readmem & ex_mem_writemem);
	assign mem_mc_en = (ex_mem_readmem | ex_mem_writemem);
	assign mem_mc_addr = ex_mem_aluout;

	//dados para escrita


	assign mem_mc_data[07:00] =
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 3)) | // LB  S S S B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 1)) | // LH  S S B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) | // LW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 4)) | // LBU B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // LHU B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3)) | // SB  Z Z Z B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0)) | // SH  Z Z B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) | // SW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) | // LL  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2))   // SC  B B B B
		? ex_mem_regb[07:00]:
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 0)) | // LWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1)                          ) | // LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1)                          ) | // SWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 3))   // SWR A A A A
		? ex_mem_regb[07:00]: 8'bz;

	assign mem_mc_data[15:08] =
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 1)) | // LH  S S B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) | // LW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 4)) | // LBU B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // LHU B B B B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3)) | // SB  Z Z Z B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0)) | // SH  Z Z B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) | // SW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) | // LL  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2))   // SC  B B B B
		? ex_mem_regb[15:08]:
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 3))   // LB  S S S B
		? {8{ex_mem_regb[07]}}:
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] <= 1)) | // LWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] != 0)) | // LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] != 3)) | // SWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] >= 2))   // SWR A A A A
		? ex_mem_regb[15:08]: 8'bz;

	assign mem_mc_data[23:16] =
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) | // LW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 4)) | // LBU B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // LHU B B B B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3)) | // SB  Z Z Z B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0)) | // SH  Z Z B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) | // SW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) | // LL  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2))   // SC  B B B B
		? ex_mem_regb[23:16]:
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 3))   // LB  S S S B
		? {8{ex_mem_regb[07]}}:
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 1))   // LH  S S B B
		? {8{ex_mem_regb[15]}}:
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] != 3)) | // LWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] >= 2)) | // LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] <= 1)) | // SWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] != 0))   // SWR A A A A
		? ex_mem_regb[23:16]: 8'bz;

	assign mem_mc_data[31:24] =
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) | // LW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 4)) | // LBU B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // LHU B B B B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3)) | // SB  Z Z Z B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0)) | // SH  Z Z B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) | // SW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) | // LL  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2))   // SC  B B B B
		? ex_mem_regb[31:24]:
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 3))   // LB  S S S B
		? {8{ex_mem_regb[07]}}:
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 1))   // LH  S S B B
		? {8{ex_mem_regb[15]}}:
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0)) | // LWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // SWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))   // SWR A A A A
		? ex_mem_regb[31:24]: 8'bz;
		
	assign mem_mc_en2h = 
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3)) | // SB  Z Z Z B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))   // SH  Z Z B B
		? 1'b0 :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0)) | // LWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // SWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))   // SWR A A A A
		?
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) ) | // LWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 3)) | // LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 0)) | // SWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) )   // SWR A A A A
		: 1'b1;

	assign mem_mc_en2l = 
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3)) | // SB  Z Z Z B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))   // SH  Z Z B B
		? 1'b0 :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0)) | // LWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // SWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))   // SWR A A A A
		?
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] != 3)) | // LWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] >= 2)) | // LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] <= 1)) | // SWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] != 0))   // SWR A A A A
		: 1'b1;

	assign mem_mc_en1h = 
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3))   // SB  Z Z Z B
		? 1'b0 :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0)) | // LWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // SWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))   // SWR A A A A
		?
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] <= 1)) | // LWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] != 0)) | // LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] != 3)) | // SWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] >= 2))   // SWR A A A A
		: 1'b1;
		
	assign mem_mc_en1l = 
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0)) | // LWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) | // SWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))   // SWR A A A A
		?
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 0)) | // LWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1)                          ) | // LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1)                          ) | // SWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 3))   // SWR A A A A
		: 1'b1;
		
	//variaveis auxiliares
	wire [31:0] loadval;
	assign loadval[31:16] = (ex_mem_msm == 0)? 16'b0:
							(ex_mem_msm == 1)? mem_mc_data[31:16]:
							(ex_mem_msm == 2)? mem_mc_data[15:0]:
							(ex_mem_msm == 3)? {16{mem_mc_data[31]}}: 16'bz;
							
	assign loadval[15:0] = 	(ex_mem_msl == 0)? 16'b0:
							(ex_mem_msl == 1)? mem_mc_data[31:16]:
							(ex_mem_msl == 2)? mem_mc_data[15:0]:
							(ex_mem_msl == 3)? {{8{mem_mc_data[31]}}, mem_mc_data[31:24]}:
							(ex_mem_msl == 4)? {{8'b0}, mem_mc_data[31:24]}:16'bz;
	
	wire [31:0] mux_loadregb;
	assign mux_loadregb[31:16] = (ex_mem_mshw)? loadval[31:16]: ex_mem_regb[31:16];
	assign mux_loadregb[15:0] = (ex_mem_lshw)? loadval[15:0]: ex_mem_regb[15:0];
	
	wire [31:0] mux_ldrbexval;
	assign mux_ldrbexval = (~ex_mem_selwsource[2] & ~ex_mem_selwsource[1] & ex_mem_selwsource[0])? mux_loadregb: ex_mem_wbvalue;
	
	// Forwarding
	assign mem_fw_wbvalue = mux_ldrbexval;
	assign mem_fw_writereg = ((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) ? 1'b1 : ex_mem_writereg;
	
	always@(negedge clock)
    begin
		// Writeback
		mem_wb_regdest = ex_mem_regdest;
		mem_wb_writereg = ex_mem_writereg;
		mem_wb_wbvalue = mux_ldrbexval;
	
	end
	
	always@(posedge reset)
	begin
		//sinais propagados para o estagio de escrita
		mem_wb_regdest = 5'b0;
		mem_wb_writereg = 0;
		mem_wb_wbvalue = 32'b0;
		
	end

endmodule
