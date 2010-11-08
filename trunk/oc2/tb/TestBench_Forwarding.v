/*
	TestBench do módulo Forwarding.
	(usando espaçamento de tabulação igual a quatro espaços; tab space = 4)
	
	Desenvolvido por Cássio Elias e Gerley e Thompson
	
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
	
		Testes de dependencia de dados:
		- testamos os sinais setando reset para 1 e voltando para 0;
		- Testamos os casos de forwarding havia dependência:
			1) somente do execute
			2) somente do memory
			3) somente do write back
			4) execute e memory
			5) write back e memory
			6) write back e execute
			7) stall
		
	Resultados Esperados:
		O módulo passou nos testes descritos acima.
*/


`include "../rtl/Forwarding.v"

module testBench();

	integer total;
	integer result;

	reg clock;
	reg reset;
	
	reg [4:0] id_fw_regdest;
	reg id_fw_load;
	reg [4:0] id_fw_addra;
	reg [4:0] id_fw_addrb;
	reg [31:0] id_fw_rega;
	reg [31:0] id_fw_regb;
	
	reg [31:0] ex_fw_wbvalue;
	reg ex_fw_writereg;
	
	reg [31:0] mem_fw_wbvalue;
	reg mem_fw_writereg;

	reg [31:0] wb_fw_wbvalue;
	reg wb_fw_writereg;

	Forwarding FORWARDING(
		clock,
		reset,

		fw_if_id_stall, // Stall em PC, Fetch e Decode para FW de instruções seguinte a loads com dep. de dados

		id_fw_regdest,	// Registrador de destino
		id_fw_load,		// Instrução de Load ? (equivale a sinal readmem)
		id_fw_addra,	// Address A
		id_fw_addrb,	// Address B
		id_fw_rega,		// Registrador A lido
		id_fw_regb,		// Registrador B lido
		fw_id_rega,		// Valores enviados ao Execute com tratamento de conflito de dados
		fw_id_regb,
	
		// Execute
		ex_fw_wbvalue,	// Valor a ser gravado no Writeback vindo do Pré-Execute (posedge)
		ex_fw_writereg,	// Gravar registro do Pré-Execute
	
		// Memory
		mem_fw_wbvalue,	// Valor a ser gravado no Writeback vindo do Final do Execute (negedge)
		mem_fw_writereg,// Gravar registro do Final do Execute
	
		// Writeback
		wb_fw_wbvalue,  // Valor a ser gravado no Writeback vindo do Final do Memory
		wb_fw_writereg	// Gravar registro do Final do Memory	
	);

	initial begin
	// inicialização
	total			<= 0;
	result			<= 0;

	clock			<= 0;
	reset			<= 0;

    $dumpfile("dump.txt");
    $dumpvars;


	// Testa Reset
	#2 reset <= 1;
	#2 reset <= 0;
	total <= total + 1;
	if(
		(fw_id_rega 	== 0) &&
		(fw_id_regb 	== 0) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1; 

	// Constantes	
	id_fw_rega	 	<= 32'd10;
	id_fw_regb	 	<= 32'd10;
	
	ex_fw_wbvalue 	<= 32'd20;
	ex_fw_writereg 	<= 1'b1;
	
	mem_fw_wbvalue 	<= 32'd30;
	mem_fw_writereg	<= 1'b1;
	
	wb_fw_wbvalue	<= 32'd40;
	wb_fw_writereg 	<= 1'b1;

	// TESTA DUAS FUNÇÕES SEGUIDAS
	// 2,1 = 3
	id_fw_addra	 	<= 5'd2;
	id_fw_addrb	 	<= 5'd1;
	id_fw_regdest	<= 5'd3;
	id_fw_load	 	<= 1'b0;
	#2;
	// 3,1 = 2
	id_fw_addra	 	<= 5'd3;
	id_fw_addrb	 	<= 5'd1;
	id_fw_regdest	<= 5'd2;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd20) &&
		(fw_id_regb 	== 32'd10) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1; 

	// TESTA PULANDO 1 FUNÇÃO
	// 4,5 = 6
	id_fw_addra	 	<= 5'd4;
	id_fw_addrb	 	<= 5'd5;
	id_fw_regdest	<= 5'd6;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd10) &&
		(fw_id_regb 	== 32'd10) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1; 
	// 3,2 = 2
	id_fw_addra	 	<= 5'd3;
	id_fw_addrb	 	<= 5'd2;
	id_fw_regdest	<= 5'd2;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd40) &&
		(fw_id_regb 	== 32'd30) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1; 

	// TESTA PULANDO 2 FUNÇÃO
	// 4,5 = 6
	id_fw_addra	 	<= 5'd4;
	id_fw_addrb	 	<= 5'd5;
	id_fw_regdest	<= 5'd6;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd10) &&
		(fw_id_regb 	== 32'd10) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1; 
	// 4,5 = 6
	id_fw_addra	 	<= 5'd4;
	id_fw_addrb	 	<= 5'd5;
	id_fw_regdest	<= 5'd6;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd10) &&
		(fw_id_regb 	== 32'd10) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1; 
	// 3,2 = 2
	id_fw_addra	 	<= 5'd3;
	id_fw_addrb	 	<= 5'd2;
	id_fw_regdest	<= 5'd2;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd10) &&
		(fw_id_regb 	== 32'd40) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1; 

	// TESTA 2 INDEPENDENTES SEGUIDAS DE 1 DEPENDENTE
	// 4,5 = 6
	id_fw_addra	 	<= 5'd4;
	id_fw_addrb	 	<= 5'd5;
	id_fw_regdest	<= 5'd6;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd10) &&
		(fw_id_regb 	== 32'd10) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1; 
	// 4,5 = 7
	id_fw_addra	 	<= 5'd4;
	id_fw_addrb	 	<= 5'd5;
	id_fw_regdest	<= 5'd7;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd10) &&
		(fw_id_regb 	== 32'd10) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1;
	// 6,7 = 2
	id_fw_addra	 	<= 5'd6;
	id_fw_addrb	 	<= 5'd7;
	id_fw_regdest	<= 5'd2;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd30) &&
		(fw_id_regb 	== 32'd20) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1;

	// TESTA DEP. WB e MEM
	// 1,3 = 4
	id_fw_addra	 	<= 5'd1;
	id_fw_addrb	 	<= 5'd3;
	id_fw_regdest	<= 5'd4;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd10) &&
		(fw_id_regb 	== 32'd10) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1;
	// 1,5 = 6
	id_fw_addra	 	<= 5'd1;
	id_fw_addrb	 	<= 5'd5;
	id_fw_regdest	<= 5'd6;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd10) &&
		(fw_id_regb 	== 32'd10) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1;
	// 4,2 = 3
	id_fw_addra	 	<= 5'd4;
	id_fw_addrb	 	<= 5'd2;
	id_fw_regdest	<= 5'd3;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd30) &&
		(fw_id_regb 	== 32'd40) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1;

	// TESTA DEP. WB e EXE
	// 4,3 = 1
	id_fw_addra	 	<= 5'd4;
	id_fw_addrb	 	<= 5'd3;
	id_fw_regdest	<= 5'd1;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd40) &&
		(fw_id_regb 	== 32'd20) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1;
		
	// TESTA BOLHA
	// 1,2 = 3
	id_fw_addra	 	<= 5'd1;
	id_fw_addrb	 	<= 5'd2;
	id_fw_regdest	<= 5'd3;
	id_fw_load	 	<= 1'b1;
	#2;
	total <= total + 1;
	if(
		(fw_id_rega 	== 32'd20) &&
		(fw_id_regb 	== 32'd10) &&
		(fw_if_id_stall	== 0)
	)
		result <= result + 1;
	// 3,4 = 5
	id_fw_addra	 	<= 5'd3;
	id_fw_addrb	 	<= 5'd4;
	id_fw_regdest	<= 5'd5;
	id_fw_load	 	<= 1'b0;
	#2;
	total <= total + 1;
	if(
		(fw_if_id_stall	== 1)
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

