/*
	Módulo Decode.
	(usando espaçamento de tabulação igual a quatro espaços; tab space = 4)
	
	Desenvolvido por Cássio Elias e Fernanda Takahashi
	cass@dcc.ufmg.br; fetaka@dcc.ufmg.br;
*/

`include "../rtl/Comp.v"
`include "../rtl/Controle.v"

module Decode(

	input             clock,
	input             reset,
	input             fw_if_id_stall,       // Sinal de stall vindo de FW para instrução seguinte a load com dependencia de dados
	
	// Fetch
	input      [31:0] if_id_instrucao,   //ir,
	input      [31:0] if_id_proximopc,   //pc,  // valor do PC da proxima instrução
	output            id_if_selfontepc,
 	
	output     [31:0] id_if_rega, 
	output reg [31:0] id_if_pcimd2ext,   // PC + Imediato << 2 c/ sinal extendido (Usado em Branches)
	output reg [31:0] id_if_pcindex,     // PC[31:28], 26 bits (index) << 2 (Usado em J e JAL)
	output      [1:0] id_if_seltipopc,   // Seletor de fonte do PC
	
	// Excecute
	output reg        id_ex_selalushift, // Seleciona ALU ou COMP
	output reg        id_ex_selimregb,   // Seleciona Imediato Extendido ou Reg B
	output reg        id_ex_selsarega,   // Seleciona Shift Amount ou Reg A
	output reg  [2:0] id_ex_aluop,       // opAlu,    // Operacao da ALU
	output reg        id_ex_unsig,       // Informa se a instruço éem sinal
	output reg  [1:0] id_ex_shiftop,     // Direcao do shift e Tipo do shif
	output reg  [4:0] id_ex_shiftamt,    // Shift Amount
	output     [31:0] id_ex_rega,		 // Registrador lido A
	output reg  [2:0] id_ex_msm,
	output reg  [2:0] id_ex_msl,
	output reg        id_ex_readmem,     // Le memoria
	output reg        id_ex_writemem,	 // Escreve memoria
	output reg        id_ex_mshw,
	output reg        id_ex_lshw,
	output     [31:0] id_ex_regb,		 // Registrador lido B
	output reg [31:0] id_ex_imedext,	 // Imediato com extensão de sinal
	output reg [31:0] id_ex_proximopc,
	output reg  [2:0] id_ex_selwsource,	 // Seleciona fonte de dados para WB realizar escrita
	output reg  [4:0] id_ex_regdest,     // Endereço do registrador de destino ( RD || RT || 31 )
	output reg        id_ex_writereg,    // Escreve em registrador
	output reg        id_ex_writeov,     // Escreve c/ overflow
	
	// Forwarding
	output      [4:0] id_fw_regdest,	// Registrador de destino
	output            id_fw_load,		// Instrução de Load ? (equivale a sinal readmem)
	output      [4:0] id_fw_addra,		// Address A
	output      [4:0] id_fw_addrb,		// Address B
	output     [31:0] id_fw_rega,		// Registrador A lido
	output     [31:0] id_fw_regb,		// Registrador B lido
	input      [31:0] fw_id_rega,		// Valores enviados ao Execute com tratamento de conflito de dados
	input      [31:0] fw_id_regb,
		
	// Registradores
	output      [4:0] id_reg_addra, 	 // Endereço A do registrador (campo RS)
	output      [4:0] id_reg_addrb, 	 // Endereço B do registrador (campo RT)
	input      [31:0] reg_id_dataa,  	 // Barramento de dados dos registradores
	input      [31:0] reg_id_datab,  	
	output            id_reg_ena,  		 // Enable dos registradores
	output            id_reg_enb  
	
	);
	
	Comp COMP(
		fw_id_rega,
		fw_id_regb,
		compop,
		compout
	);
	
	Controle CONTROLE(
		if_id_instrucao[31:26],
		if_id_instrucao[5:0],
		if_id_instrucao[20:16],
		id_ex_w_selwsource,
		selregdest,
		id_ex_w_writereg,
		id_ex_w_writeov,
		id_ex_w_selimregb,
		id_ex_w_selsarega,
		id_ex_w_selalushift,
		id_ex_w_aluop,
		id_ex_w_unsig,
		id_ex_w_shiftop,
		id_ex_w_mshw,
		id_ex_w_lshw,
		id_ex_w_msm,
		id_ex_w_msl,
		id_ex_w_readmem,
		id_ex_w_writemem,
		selbrjumpz,
//		id_if_w_seltipopc,
		id_if_seltipopc,
		compop_w
    );

	assign id_if_selfontepc = (selbrjumpz == 2'b00) ? 1'b0 :
							  (selbrjumpz == 2'b01) ? 1'b1 :
							  (selbrjumpz == 2'b10) ? compout : 1'b0;							  
	
//	assign id_if_rega = if_id_instrucao[25:21];
	assign id_if_rega = id_fw_rega;
	
//	assign id_ex_rega = ((reset) || (fw_if_id_stall)) ? (0) : (fw_id_rega);
//	assign id_ex_regb = ((reset) || (fw_if_id_stall)) ? (0) : (fw_id_regb);
	assign id_ex_rega = (fw_id_rega);
	assign id_ex_regb = (fw_id_regb);

//	assign id_fw_regdest = id_ex_regdest;
	assign id_fw_regdest =	(selregdest == 2'b00) ? (if_id_instrucao[20:16]) :
							(selregdest == 2'b01) ? (if_id_instrucao[15:11]) :
							(selregdest == 2'b10) ? (5'd31) :
							5'dx;

	assign id_fw_load = id_ex_w_readmem;

	assign id_fw_addra = if_id_instrucao[25:21]; // rs
	assign id_fw_addrb = if_id_instrucao[20:16]; // rt

	assign id_reg_ena = 1'b1;
	assign id_reg_enb = 1'b1;

	//assign id_reg_ena = id_ex_selsarega;
	//assign id_reg_enb = id_ex_selimregb;
	
	assign id_fw_rega = reg_id_dataa;
	assign id_fw_regb = reg_id_datab;
		
	assign id_reg_addra = if_id_instrucao[25:21]; // rs
	assign id_reg_addrb = ((if_id_instrucao[31:26] == 6'b000001)
						|| (if_id_instrucao[31:26] == 6'b000110)
						|| (if_id_instrucao[31:26] == 6'b000111)) ?
							(5'd0) : (if_id_instrucao[20:16]);

	always @(negedge clock) begin

		if (~(fw_if_id_stall || reset))
		begin
			id_if_pcimd2ext <= (if_id_proximopc + ($signed(if_id_instrucao[15:0]) <<< 2));

			id_if_pcindex[31:28] <= if_id_proximopc[31:28];
			id_if_pcindex[27:00] <= (if_id_instrucao[25:0] << 2);

			id_ex_shiftamt 	<= if_id_instrucao[10:6];

			id_ex_imedext 	<= {16{if_id_instrucao[15]}, if_id_instrucao[15:0]};

			id_ex_proximopc <= if_id_proximopc;

			case(selregdest)
				2'b00: id_ex_regdest <= if_id_instrucao[20:16];	// rt
				2'b01: id_ex_regdest <= if_id_instrucao[15:11];	// rd
				2'b10: id_ex_regdest <= 5'd31;				  	// registrador de retorno
				2'b11: id_ex_regdest <= 5'dx;					// situação não tratada
			endcase
				
			id_ex_selwsource 	<= id_ex_w_selwsource;
			id_ex_writereg 		<= id_ex_w_writereg;
			id_ex_writeov 		<= id_ex_w_writeov;
			id_ex_selsarega		<= id_ex_w_selsarega;
			id_ex_selimregb		<= id_ex_w_selimregb;
			id_ex_selalushift 	<= id_ex_w_selalushift;
			id_ex_aluop 		<= id_ex_w_aluop;
			id_ex_unsig 		<= id_ex_w_unsig;
			id_ex_shiftop 		<= id_ex_w_shiftop;
			id_ex_mshw 			<= id_ex_w_mshw;
			id_ex_lshw 			<= id_ex_w_lshw;
			id_ex_msm 			<= id_ex_w_msm;
			id_ex_msl 			<= id_ex_w_msl;
			id_ex_readmem 		<= id_ex_w_readmem;
			id_ex_writemem 		<= id_ex_w_writemem;
//			id_if_seltipopc 	<= id_if_w_seltipopc;
		end
	end

	always @(reset or fw_if_id_stall) begin
		if(reset || fw_if_id_stall)
		begin
			id_ex_shiftamt 		<= 0;
			id_ex_imedext 		<= 0;
			id_ex_proximopc 	<= 0;
			id_ex_regdest 		<= 0;
			id_ex_selwsource 	<= 0;
			id_ex_writereg 		<= 0;
			id_ex_writeov 		<= 0;
			id_ex_selsarega		<= 0;
			id_ex_selimregb		<= 0;
			id_ex_selalushift 	<= 0;
			id_ex_aluop 		<= 0;
			id_ex_unsig 		<= 0;
			id_ex_shiftop 		<= 0;
			id_ex_mshw 			<= 0;
			id_ex_lshw 			<= 0;
			id_ex_msm 			<= 0;
			id_ex_msl 			<= 0;
			id_ex_readmem 		<= 0;
			id_ex_writemem 		<= 0;
			id_if_pcimd2ext 	<= 0;
			id_if_pcindex 		<= 0;
		end
	end
endmodule
