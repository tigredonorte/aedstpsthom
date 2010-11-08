`include "../rtl/Fetch.v"
`include "../rtl/Decode.v"
`include "../rtl/Execute.v"
`include "../rtl/Memory.v"
`include "../rtl/Writeback.v"
`include "../rtl/Registers.v"
`include "../rtl/Forwarding.v"

module Mips(

	input             clock,
	input             reset,

	// Fetch <-> mc
	output            if_mc_en,	
	output     [31:0] if_mc_addr,	
	input      [31:0] mc_if_data,

	// Memory <-> mc
	output            mem_mc_rw,
	output            mem_mc_en,
	output     [31:0] mem_mc_addr, 
	inout      [31:0] mem_mc_data,
	output            mem_mc_en1h,
	output            mem_mc_en1l,
	output            mem_mc_en2h,
	output            mem_mc_en2l

	);

	//Fetch <-> Execute
	wire ex_if_stall;
	
	//Fetch <-> Forwarding <-> Decode
	wire fw_if_id_stall;

	//Fetch <-> Decode
	wire [31:0] if_id_proximopc;
	wire [31:0] if_id_instrucao;
	wire id_if_selfontepc;
	wire [31:0] id_if_rega;
	wire [31:0] id_if_pcimd2ext;
	wire [31:0] id_if_pcindx;
	wire [1:0] id_if_seltipopc;
	
	//Decode <-> Execute
	wire id_ex_selalushift;
	wire id_ex_selimregb;
	wire id_ex_selsarega;
	wire [2:0] id_ex_aluop;
	wire id_ex_unsig;
	wire [1:0] id_ex_shiftop;
	wire [4:0] id_ex_shiftamt;
	wire [31:0] id_ex_rega;
	wire [2:0] id_ex_msm;
	wire [2:0] id_ex_msl;
	wire id_ex_readmem;
	wire id_ex_writemem;
	wire id_ex_mshw;
	wire id_ex_lshw;
	wire [31:0] id_ex_regb;
	wire [31:0] id_ex_imedext;
	wire [31:0] id_ex_proximopc;
	wire [2:0] id_ex_selwsource;
	wire [4:0] id_ex_regdest;
	wire id_ex_writereg;
	wire id_ex_writeov;

	//Decode <-> Forwarding
	wire [4:0] id_fw_regdest;
	wire id_fw_load;
	wire [4:0] id_fw_addra;
	wire [4:0] id_fw_addrb;
	wire [31:0] id_fw_rega;
	wire [31:0] id_fw_regb;
	wire [31:0] fw_id_rega;
	wire [31:0] fw_id_regb;
	
	//Decode <-> Registradores
	wire [4:0] id_reg_addra;
	wire [4:0] id_reg_addrb;
	wire [31:0] reg_id_dataa;
	wire [31:0] reg_id_datab;
	wire id_reg_ena;
	wire id_reg_enb;

	//Execute <-> Forwarding
	wire [31:0] ex_fw_wbvalue;
	wire ex_fw_writereg;

	//Execute <-> Memory
	wire [2:0] ex_mem_msm;
	wire [2:0] ex_mem_msl;
	wire ex_mem_readmem;
	wire ex_mem_writemem;
	wire ex_mem_mshw;
	wire ex_mem_lshw;
	wire [31:0] ex_mem_regb;
	wire [2:0] ex_mem_selwsource;
	wire [4:0] ex_mem_regdest;
	wire ex_mem_writereg;
	wire [31:0] ex_mem_aluout;
	wire [31:0] ex_mem_wbvalue;
	
	//Memory <-> Forwarding
	wire [31:0] mem_fw_wb_value;
	wire mem_fw_writereg;
	
	//Memory <-> Writeback
	wire [4:0] mem_wb_regdest;
	wire mem_wb_writereg;
	wire [31:0] mem_wb_wbvalue;
	
	//Writeback <-> Registers
	wire wb_reg_en;
	wire [4:0] wb_reg_addr;
	wire [31:0] wb_regdata;
	
	//Writeback <-> Forwarding
	wire [31:0] wb_fw_wbvalue;
	wire wb_fw_writereg;


	Fetch FETCH(
		clock,
		reset,
		//Execute
		ex_if_stall,
		//Forwarding, Decode
		fw_if_id_stall,
		//Decode
		if_id_proximopc,
		if_id_instrucao,
		id_if_selfontepc,
		id_if_rega,
		id_if_pcimd2ext,
		id_if_pcindex,
		id_if_seltipopc,
		//mc
		if_mc_en,
		if_mc_addr,
		mc_if_data

	);

	Decode DECODE(
		clock,
		reset,
		//Fetch, Forwarding
		fw_if_id_stall,
		//Fetch
		if_id_instrucao,
		if_id_proximopc,
		id_if_selfontepc,
        	id_if_rega,
		id_if_pcimd2ext,
		id_if_pcindex,
		id_if_seltipopc,
		//Execute
		id_ex_selalushift,
		id_ex_selimregb,
		id_ex_selsarega,
		id_ex_aluop,
		id_ex_unsig,
		id_ex_shiftop,
		id_ex_shiftamt,
		id_ex_rega,
		id_ex_msm,
		id_ex_msl,
		id_ex_readmem,
		id_ex_writemem,
		id_ex_mshw,
		id_ex_lshw,
		id_ex_regb,
		id_ex_imedext,
		id_ex_proximopc,
		id_ex_selwsource,
		id_ex_regdest,
		id_ex_writereg,
		id_ex_writeov,
		//Forwarding
		id_fw_regdest,
		id_fw_load,
		id_fw_addra,
		id_fw_addrb,
		id_fw_rega,
		id_fw_regb,
		fw_id_rega,
		fw_id_regb,
		// Registradores
		id_reg_addra,
		id_reg_addrb,
		reg_id_dataa,
		reg_id_datab,  	
		id_reg_ena,
		id_reg_enb  
	);

	Execute EXECUTE(
		clock,
		reset,
		//Decode
		id_ex_selalushift,
		id_ex_selimregb,
		id_ex_selsarega,
		id_ex_aluop,
		id_ex_unsig,
		id_ex_shiftop,
		id_ex_shiftamt,
		id_ex_rega,
		id_ex_msm,
		id_ex_msl,
		id_ex_readmem,
		id_ex_writemem,
		id_ex_mshw,
		id_ex_lshw,
		id_ex_regb,
		id_ex_imedext,
		id_ex_proximopc,
		id_ex_selwsource,
		id_ex_regdest,
		id_ex_writereg,
		id_ex_writeov,
		//Forwarding
		ex_fw_wbvalue,
		ex_fw_writereg,
		//Fetch
		ex_if_stall,
		//Memory
		ex_mem_msm ,
		ex_mem_msl ,
		ex_mem_readmem ,
		ex_mem_writemem ,
		ex_mem_mshw ,
		ex_mem_lshw ,
		ex_mem_regb ,
		ex_mem_selwsource ,
		ex_mem_regdest ,
		ex_mem_writereg ,
		ex_mem_aluout ,
		ex_mem_wbvalue
	);

	Memory MEMORY(
		clock,
		reset,
		//Execute
		ex_mem_msm ,
		ex_mem_msl ,
		ex_mem_readmem ,
		ex_mem_writemem ,
		ex_mem_mshw ,
		ex_mem_lshw ,
		ex_mem_regb ,
		ex_mem_selwsource ,
		ex_mem_regdest ,
		ex_mem_writereg ,
		ex_mem_aluout ,
		ex_mem_wbvalue,
		//mc
		mem_mc_rw,
		mem_mc_en,
		mem_mc_addr,
		mem_mc_data,
		mem_mc_en1h,
		mem_mc_en1l,
		mem_mc_en2h,
		mem_mc_en2l,
		//Forwarding
		mem_fw_wbvalue,
		mem_fw_writereg,
		//Writeback
		mem_wb_regdest,
		mem_wb_writereg,
		mem_wb_wbvalue
	);
   
   	Writeback WRITEBACK (
		clock,
		//Memory
		mem_wb_regdest,
		mem_wb_writereg,
		mem_wb_wbvalue,
		//Registers
		wb_reg_en,
		wb_reg_addr,
		wb_reg_data,
		//Fowarding
		wb_fw_wbvalue,
		wb_fw_writereg
	);
	
	Registers REGS(
		reset,
		//Decode
		id_reg_ena,
		id_reg_addra,
		reg_id_dataa,
		id_reg_enb,
		id_reg_addrb,
		reg_id_datab,  	
		//Writeback
		wb_reg_en,
		wb_reg_addr,
		wb_reg_data
	);
	
	Forwarding FW(
		clock,
		reset,
		//Fetch, Decode
		fw_if_id_stall,
		//Decode
		id_fw_regdest,
		id_fw_load,
		id_fw_addra,
		id_fw_addrb,
		id_fw_rega,
		id_fw_regb,
		fw_id_rega,
		fw_id_regb,
		//Execute
		ex_fw_wbvalue,
		ex_fw_writereg,
		//Memory
		mem_fw_wbvalue,
		mem_fw_writereg,
		//Writeback
		wb_fw_wbvalue,
		wb_fw_writereg
	);
	
endmodule
