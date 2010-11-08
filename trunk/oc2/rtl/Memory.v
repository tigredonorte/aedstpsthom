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

	wire [31:0] loadval;
	wire [31:0] mux_loadregb;
	wire [31:0] mux_ldrbexval;

	// MC, GDM
	assign mem_mc_rw = (~ex_mem_readmem & ex_mem_writemem);
	assign mem_mc_en = (ex_mem_readmem | ex_mem_writemem);
	assign mem_mc_addr = ex_mem_aluout;

	assign mem_mc_data[07:00] = 
		// SB  Z Z Z B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3))
		? (ex_mem_regb[07:00]) :
		// SH  Z Z B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? (ex_mem_regb[07:00]) :

		// SWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 0))
		? ex_mem_regb[07:00] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 1))
		? ex_mem_regb[15:08] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 2))
		? ex_mem_regb[23:16] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 3))
		? ex_mem_regb[31:24] :

		// SWR A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 3))
		? ex_mem_regb[07:00] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? 8'bx :

		// Default
		(ex_mem_writemem == 1) ? (ex_mem_regb[07:00]) : (8'bz);
	
	assign mem_mc_data[15:08] = 
		// SB  Z Z Z B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3))
		? 8'bx :
		// SH  Z Z B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? (ex_mem_regb[15:08]) :
		
		// SWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 0))
		? ex_mem_regb[15:08] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 1))
		? ex_mem_regb[23:16] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 2))
		? ex_mem_regb[31:24] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1))
		? 8'bx :

		// SWR A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 2))
		? ex_mem_regb[07:00] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 3))
		? ex_mem_regb[15:08] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? 8'bx :

		// Default
		(ex_mem_writemem == 1) ? (ex_mem_regb[15:08]) : (8'bz);

	assign mem_mc_data[23:16] = 
		// SB  Z Z Z B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3))
		? 8'bx :
		// SH  Z Z B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? 8'bx :

		// SWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 0))
		? ex_mem_regb[23:16] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 1))
		? ex_mem_regb[31:24] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1))
		? 8'bx :

		// SWR A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 1))
		? ex_mem_regb[07:00] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 2))
		? ex_mem_regb[15:08] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 3))
		? ex_mem_regb[23:16] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? 8'bx :

		// Default
		(ex_mem_writemem == 1) ? (ex_mem_regb[23:16]) : (8'bz);


	assign mem_mc_data[31:24] = 
		// SB  Z Z Z B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3))
		? 8'bx :
		// SH  Z Z B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? 8'bx :
		
		// SWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 0))
		? ex_mem_regb[31:24] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1))
		? 8'bx :
		

		// SWR A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 0))
		? ex_mem_regb[07:00] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 1))
		? ex_mem_regb[15:08] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 2))
		? ex_mem_regb[23:16] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 3))
		? ex_mem_regb[31:24] :

		// Default
		(ex_mem_writemem == 1) ? (ex_mem_regb[31:24]) : (8'bz);


	assign mem_mc_en1h = 
		// SB  Z Z Z B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3)) |
		// SH  Z Z B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? 1'b0 :
		// LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1))
		? (ex_mem_aluout[1:0] == 3) :
		// SWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1))
		? (ex_mem_aluout[1:0] == 0) :
		// others
		1'b1;

	assign mem_mc_en1l = 
		// SB  Z Z Z B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3)) |
		// SH  Z Z B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? 1'b0 :
		// LWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? (ex_mem_aluout[1:0] != 3) :
		// LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1))
		? (ex_mem_aluout[1:0] >= 2) :
		// SWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1))
		? (ex_mem_aluout[1:0] <= 1) :
		// SWR A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? (ex_mem_aluout[1:0] != 0) :
		// others
		1'b1;

	assign mem_mc_en2h = 
		// SB  Z Z Z B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3))
		? 1'b0 :
		// LWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? (ex_mem_aluout[1:0] <= 1) :
		// LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1))
		? (ex_mem_aluout[1:0] != 0) :
		// SWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1))
		? (ex_mem_aluout[1:0] != 3) :
		// SWR A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? (ex_mem_aluout[1:0] >= 2) :
		// others
		1'b1;

	assign mem_mc_en2l = 
		// LWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? (ex_mem_aluout[1:0] == 0) :
		// SWR A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0))
		? (ex_mem_aluout[1:0] == 3) :
		// others
		1'b1;

	// FW
	assign mem_fw_wbvalue = (ex_mem_writemem == 1) ? 32'bz : mux_ldrbexval;
//	assign mem_fw_wbvalue = mux_ldrbexval;
	assign mem_fw_writereg =
		// SC
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2))
//		? 1'b1 :
		// others
		ex_mem_writereg;


	// WB
	always@(negedge clock)
    begin
		// Writeback
		mem_wb_regdest	 = ex_mem_regdest;
		mem_wb_writereg	 = ex_mem_writereg;
		mem_wb_wbvalue	 = (ex_mem_writemem == 1) ? 32'bz : mux_ldrbexval;	
	end

	always@(posedge reset)
	begin
		//sinais propagados para o estagio de escrita
		mem_wb_regdest  = 5'd0;
		mem_wb_writereg = 1'd0;
		mem_wb_wbvalue  = 32'd0;
	end
	
	// MUX INTERNO
//	assign mux_loadregb[31:16] = (ex_mem_mshw)? loadval[31:16]: ex_mem_regb[31:16];
//	assign mux_loadregb[15:00] = (ex_mem_lshw)? loadval[15:00]: ex_mem_regb[15:00];
	assign mux_loadregb[31:16] = loadval[31:16];
	assign mux_loadregb[15:00] = loadval[15:00];
	
	assign mux_ldrbexval =
		// SC
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2))
		? 32'd1 :
		// others write
		(ex_mem_writemem == 1)
		? 32'bz :
		// others
		(~ex_mem_selwsource[2] & ~ex_mem_selwsource[1] & ex_mem_selwsource[0]) ? mux_loadregb : ex_mem_wbvalue;


	assign loadval[07:00] = 
		// LB  S S S B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 3)) |
		// LH  S S B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 1)) |
		// LW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) |
		// LBU 0 0 0 B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 4)) |
		// LHU 0 0 B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) |
		// SB  Z Z Z B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3)) |
		// SH  Z Z B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0)) |
		// SW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) |
		// LL  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) |
		// SC  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2))
		? mem_mc_data[07:00] :

		// LWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 0))
		? mem_mc_data[07:00] :

		// LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 0))
		? mem_mc_data[31:24] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 1))
		? mem_mc_data[23:16] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 2))
		? mem_mc_data[15:08] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 3))
		? mem_mc_data[07:00] :

		// SWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 0))
		? mem_mc_data[07:00] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 1))
		? mem_mc_data[15:08] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 2))
		? mem_mc_data[23:16] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 3))
		? mem_mc_data[31:24] :

		// SWR A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 3))
		? mem_mc_data[07:00] :
		
		// Default
		ex_mem_regb[07:00];


	assign loadval[15:08] =
		// LH  S S B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 1)) |
		// LW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) |
		// LHU B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1)) |
		// SB  Z Z Z B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3)) |
		// SH  Z Z B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0)) |
		// SW  B B B B 
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) |
		// LL  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) |
		// SC  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2))   
		? mem_mc_data[15:08] :

		// LB  S S S B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 3))
		? {8{mem_mc_data[07]}} :

		// LBU 0 0 0 B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 4))
//		? 8'd0 :

		// LWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 0))
		? mem_mc_data[15:08] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 1))
		? mem_mc_data[07:00] :

		// LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 1))
		? mem_mc_data[31:24] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 2))
		? mem_mc_data[23:16] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 3))
		? mem_mc_data[15:08] :

		// SWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 0))
		? mem_mc_data[15:08] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 1))
		? mem_mc_data[23:16] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 2))
		? mem_mc_data[31:24] :

		// SWR A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 2))
		? mem_mc_data[07:00] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 3))
		? mem_mc_data[15:08] :
		
		// Default
		ex_mem_regb[15:08];

	assign loadval[23:16] =
		// LW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) |
		// SB  Z Z Z B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3)) |
		// SH  Z Z B B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0)) |
		// SW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) |
		// LL  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) |
		// SC  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2))
		? mem_mc_data[23:16]:

		// LB  S S S B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 3))
		? {8{mem_mc_data[07]}}:

		// LH  S S B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 1))
		? {8{mem_mc_data[15]}}:

		// LBU 0 0 0 B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 4)) |
		// LHU 0 0 B B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1))
//		? 8'd0 :

		// LWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 0))
		? mem_mc_data[23:16] :		
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 1))
		? mem_mc_data[15:08] :		
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 2))
		? mem_mc_data[07:00] :		
		
		// LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 2))
		? mem_mc_data[31:24] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 3))
		? mem_mc_data[23:16] :

		// SWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 0))
		? mem_mc_data[23:16] :
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 1))
		? mem_mc_data[31:24] :

		// SWR A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 1))
		? mem_mc_data[07:00] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 2))
		? mem_mc_data[15:08] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 3))
		? mem_mc_data[23:16] :
		
		// Default
		ex_mem_regb[23:16];


	assign loadval[31:24] =
		// LW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) |
		// SB  Z Z Z B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 4) & (ex_mem_msl == 3)) |
		// SH  Z Z B B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0)) |
		// SW  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) |
		// LL  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 1) & (ex_mem_msl == 2)) |
		// SC  B B B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 1) & (ex_mem_msl == 2))
		? mem_mc_data[31:24]:

		// LB  S S S B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 3))
		? {8{mem_mc_data[07]}}:

		// LH  S S B B
		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 3) & (ex_mem_msl == 1))
		? {8{mem_mc_data[15]}}:

		// LBU 0 0 0 B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 4)) |
		// LHU 0 0 B B
//		((ex_mem_mshw == 1) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1))
//		? 8'd0 :

		// LWL A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 0))
		? mem_mc_data[31:24] :		
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 1))
		? mem_mc_data[23:16] :		
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 2))
		? mem_mc_data[15:08] :		
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 3))
		? mem_mc_data[07:00] :		

		// LWR A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 1) & (ex_mem_writemem == 0) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 3))
		? mem_mc_data[31:24] :

		// SWL A A A A
		((ex_mem_mshw == 0) & (ex_mem_lshw == 1) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 0) & (ex_mem_msl == 1) & (ex_mem_aluout[1:0] == 0))
		? mem_mc_data[31:24] :

		// SWR A A A A
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 0))
		? mem_mc_data[07:00] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 1))
		? mem_mc_data[15:08] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 2))
		? mem_mc_data[23:16] :
		((ex_mem_mshw == 1) & (ex_mem_lshw == 0) & (ex_mem_readmem == 0) & (ex_mem_writemem == 1) & (ex_mem_msm == 2) & (ex_mem_msl == 0) & (ex_mem_aluout[1:0] == 3))
		? mem_mc_data[31:24] :
		
		// Default
		ex_mem_regb[31:24];

endmodule
