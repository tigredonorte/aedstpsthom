/*
	TestBench do módulo Decode.
	(usando espaçamento de tabulação igual a quatro espaços; tab space = 4)
	
	Desenvolvido por Cássio Elias e Fernanda Takahashi
	cass@dcc.ufmg.br; fetaka@dcc.ufmg.br;
	
	Como Funciona:
		Uma variável result é inicialmente setada para zero
		junto com outra variável total.
		A cada teste, a variável total é incrementada em 1
		e os sinais do módulo são comparados, se os sinais
		estão corretos, a variável result também é incrementada.
		
		No final as duas variáveis são impressas e se a variável
		result for igual a variável total então o módulo passou
		nos testes.
	
	Cenários:
		- testamos os sinais setando reset para 1 e voltando para 0;
		- testamos os sinais setando stall para 1 e voltando para 0;
		- testamos o sinal de selregdest usando a função ADDI, SLL e BLTZAL
		- testamos o sinal de pcimd2ext usando a função ADDI
		- testamos o sinal de shiftamt usando a função SLL
		- testamos o sinal de proximopc e imedext usando a função ADDI
		- testamos o sinal reg_addrb em todas as situações onde
		  o registrador usado é o registrador 0, ou seja, com as funções:
		  BLTZ, BGEZ, BGEZAL, BLTZAL, BLEZ, BLTZ e ainda com mais duas
		  funções onde o registrador é o campo rt (SLL e ADDI).

	Resultados Esperados:
		O módulo passou nos testes descritos acima.
*/


`include "../rtl/Decode.v"

module testBench();

	integer total;
	integer result;

	reg clock;
	reg reset;
	reg fw_if_id_stall;
	
	reg [31:0] if_id_instrucao;
	reg [31:0] if_id_proximopc;

	reg [31:0] reg_id_dataa;
	reg [31:0] reg_id_datab;
	
	reg [31:0] fw_id_rega;
	reg [31:0] fw_id_regb;

	Decode DECODE(
		clock,
		reset,
		fw_if_id_stall,
			
		if_id_instrucao,
		if_id_proximopc,
		id_if_selfontepc,
		
		id_if_rega,
		id_if_pcimd2ext,   // PC + Imediato << 2 c/ sinal extendido (Usado em Branches)
		id_if_pcindex,     // PC[31:28], 26 bits (index) << 2 (Usado em J e JAL)
		id_if_seltipopc,   // Seletor de fonte do PC
		
		id_ex_selalushift, // Seleciona ALU ou COMP
		id_ex_selimregb,   // Seleciona Imediato Extendido ou Reg B
		id_ex_selsarega,   // Seleciona Shift Amount ou Reg A
		id_ex_aluop,       // opAlu,    // Operacao da ALU
		id_ex_unsig,       // Informa se a instruço éem sinal
		id_ex_shiftop,     // Direcao do shift e Tipo do shif
		id_ex_shiftamt,    // Shift Amount
		id_ex_rega,		 // Registrador lido A
		id_ex_msm,
		id_ex_msl,
		id_ex_readmem,     // Le memoria
		id_ex_writemem,	 // Escreve memoria
		id_ex_mshw,
		id_ex_lshw,
		id_ex_regb,		 // Registrador lido B
		id_ex_imedext,	 // Imediato com extensão de sinal
		id_ex_proximopc,
		id_ex_selwsource,	 // Seleciona fonte de dados para WB realizar escrita
		id_ex_regdest,     // Endereço do registrador de destino ( RD || RT || 31 )
		id_ex_writereg,    // Escreve em registrador
		id_ex_writeov,     // Escreve c/ overflow
	
		// Forwarding
		id_fw_regdest,	// Registrador de destino
		id_fw_load,		// Instrução de Load ? (equivale a sinal readmem)
		id_fw_addra,		// Address A
		id_fw_addrb,		// Address B
		id_fw_rega,		// Registrador A lido
		id_fw_regb,		// Registrador B lido
		fw_id_rega,		// Valores enviados ao Execute com tratamento de conflito de dados
		fw_id_regb,
		
		// Registradores
		id_reg_addra, 	 // Endereço A do registrador (campo RS)
		id_reg_addrb, 	 // Endereço B do registrador (campo RT)
		reg_id_dataa,  	 // Barramento de dados dos registradores
		reg_id_datab,  	
		id_reg_ena,  		 // Enable dos registradores
		id_reg_enb  
	);

	initial begin
	// inicialização
	total			<= 0;
	result			<= 0;

	clock			<= 1;
	reset			<= 0;
	
	fw_if_id_stall	<= 0;
	if_id_instrucao <= 0;
	if_id_proximopc <= 0;
	reg_id_dataa 	<= 0;
	reg_id_datab 	<= 0;
	fw_id_rega 		<= 0;
	fw_id_regb 		<= 0;

    $dumpfile("dump.txt");
    $dumpvars;

	// Testa Reset
	#2 reset <= 1;
	#2 reset <= 0;

	total <= total + 1;
	if(
		(id_ex_selalushift 	== 0) &&
		(id_ex_selimregb 	== 0) &&
		(id_ex_selsarega 	== 0) &&
		(id_ex_aluop		== 0) &&
		(id_ex_unsig		== 0) &&
		(id_ex_shiftop		== 0) &&
		(id_ex_shiftamt		== 0) &&
		(id_ex_rega			== 0) &&
		(id_ex_msm			== 0) &&
		(id_ex_msl			== 0) &&
		(id_ex_readmem		== 0) &&
		(id_ex_writemem		== 0) &&
		(id_ex_mshw			== 0) &&
		(id_ex_lshw			== 0) &&
		(id_ex_regb			== 0) &&
		(id_ex_imedext		== 0) &&
		(id_ex_proximopc	== 0) &&
		(id_ex_selwsource	== 0) &&
		(id_ex_regdest		== 0) &&
		(id_ex_writereg		== 0) &&
		(id_ex_writeov		== 0)
	)
		result <= result + 1; 

	// Testa Stall
	#2 fw_if_id_stall <= 1;
	#2 fw_if_id_stall <= 0;

	total <= total + 1;
	if(
		(id_ex_selalushift 	== 0) &&
		(id_ex_selimregb 	== 0) &&
		(id_ex_selsarega 	== 0) &&
		(id_ex_aluop		== 0) &&
		(id_ex_unsig		== 0) &&
		(id_ex_shiftop		== 0) &&
		(id_ex_shiftamt		== 0) &&
		(id_ex_rega			== 0) &&
		(id_ex_msm			== 0) &&
		(id_ex_msl			== 0) &&
		(id_ex_readmem		== 0) &&
		(id_ex_writemem		== 0) &&
		(id_ex_mshw			== 0) &&
		(id_ex_lshw			== 0) &&
		(id_ex_regb			== 0) &&
		(id_ex_imedext		== 0) &&
		(id_ex_proximopc	== 0) &&
		(id_ex_selwsource	== 0) &&
		(id_ex_regdest		== 0) &&
		(id_ex_writereg		== 0) &&
		(id_ex_writeov		== 0)
	)
		result <= result + 1; 

	// Testa selregdest com ADDI
	#2 if_id_instrucao <= {6'b001000, 5'bx, 5'b10101, 16'bx};
	#2 total <= total + 1;
	if(
		(id_ex_regdest == 5'b10101)
	)
		result <= result + 1; 

	// Testa selregdest com SLL
	#2 if_id_instrucao <= {6'b000000, 5'bx, 5'bx, 5'b10101, 5'bx, 6'b000000};
	#2 total <= total + 1;
	if(
		(id_ex_regdest == 5'b10101)
	)
		result <= result + 1; 

	// Testa selregdest com BLTZAL
	#2 if_id_instrucao <= {6'b000001, 5'bx, 5'b10000, 5'bx, 5'bx, 6'bx};
	#2 total <= total + 1;
	if(
		(id_ex_regdest == 5'd31)
	)
		result <= result + 1; 

	// Testa pcimd2ext (com imediato) com ADDI
	#2 if_id_instrucao <= {6'b001000, 5'bx, 5'b10101, (-16'd19)};
	#2 total <= total + 1;
	if(
		(id_if_pcimd2ext == ((-32'd19) <<< 2))
	)
		result <= result + 1;

	// Testa shiftamt com SLL
	#2 if_id_instrucao <= {6'b000000, 5'bx, 5'bx, 5'b10101, 5'd4, 6'b000000};
	#2 total <= total + 1;
	if(
		(id_ex_shiftamt == 5'd4)
	)
		result <= result + 1; 

	// Testa imedext, proximopc com ADDI
	if_id_proximopc    <= 32'd666;
	#2 if_id_instrucao <= {6'b001000, 5'bx, 5'b10101, (-16'd1)};
	#2 total <= total + 1;
	if(
		((id_ex_imedext)   == (-32'b1)) &&
		((id_ex_proximopc) == (32'd666))
	)
		result <= result + 1;

	// Testa reg_addrb com BLTZAL
	#2 if_id_instrucao <= {6'b000001, 5'bx, 5'b10000, 5'bx, 5'bx, 6'bx};
	#2 total <= total + 1;
	if(
		(id_reg_addrb == 5'd0)
	)
		result <= result + 1; 

	// Testa reg_addrb com BLTZ
	#2 if_id_instrucao <= {6'b000001, 5'bx, 5'b00000, 5'bx, 5'bx, 6'bx};
	#2 total <= total + 1;
	if(
		(id_reg_addrb == 5'd0)
	)
		result <= result + 1; 

	// Testa reg_addrb com BGEZ
	#2 if_id_instrucao <= {6'b000001, 5'bx, 5'b00001, 5'bx, 5'bx, 6'bx};
	#2 total <= total + 1;
	if(
		(id_reg_addrb == 5'd0)
	)
		result <= result + 1; 

	// Testa reg_addrb com BGEZAL
	#2 if_id_instrucao <= {6'b000001, 5'bx, 5'b10001, 5'bx, 5'bx, 6'bx};
	#2 total <= total + 1;
	if(
		(id_reg_addrb == 5'd0)
	)
		result <= result + 1; 

	// Testa reg_addrb com BLEZ
	#2 if_id_instrucao <= {6'b000110, 5'bx, 5'bx, 5'bx, 5'bx, 6'bx};
	#2 total <= total + 1;
	if(
		(id_reg_addrb == 5'd0)
	)
		result <= result + 1; 

	// Testa reg_addrb com BGTZ
	#2 if_id_instrucao <= {6'b000111, 5'bx, 5'bx, 5'bx, 5'bx, 6'bx};
	#2 total <= total + 1;
	if(
		(id_reg_addrb == 5'd0)
	)
		result <= result + 1; 

	// Testa reg_addrb com SLL
	#2 if_id_instrucao <= {6'b000000, 5'bx, 5'b10101, 5'b10101, 5'd4, 6'b000000};
	#2 total <= total + 1;
	if(
		(id_reg_addrb == 5'b10101)
	)
		result <= result + 1; 

	// Testa reg_addrb com ADDI
	#2 if_id_instrucao <= {6'b001000, 5'bx, 5'b01010, (-16'd1)};
	#2 total <= total + 1;
	if(
		(id_reg_addrb == 5'b01010)
	)
		result <= result + 1;

    // FIM
    #2 $display("Testes OK: %0d/%0d", result, total);
	$finish;
	end
	
	initial begin
		while( 1 )
			#1 clock = ~clock;
	end

endmodule

