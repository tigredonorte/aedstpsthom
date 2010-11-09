/*
	Módulo Forwarding.
	(usando espaçamento de tabulação igual a quatro espaços; tab space = 4)
	
	Desenvolvido por Cássio Elias e Thompson
*/

module Forwarding(

	input             clock,
	input             reset,

	// Fetch
	output reg        fw_if_id_stall,   // Stall em PC, Fetch e Decode para FW de instruções seguinte a loads com dep. de dados

	// Decode
	input       [4:0] id_fw_regdest,	// Registrador de destino
	input             id_fw_load,		// Instrução de Load ? (equivale a sinal readmem)
	input       [4:0] id_fw_addra,		// Address A
	input       [4:0] id_fw_addrb,		// Address B
	input      [31:0] id_fw_rega,		// Registrador A lido
	input      [31:0] id_fw_regb,		// Registrador B lido
	output reg [31:0] fw_id_rega,		// Valores enviados ao Execute com tratamento de conflito de dados
	output reg [31:0] fw_id_regb,
	
	// Execute
	input      [31:0] ex_fw_wbvalue,	// Valor a ser gravado no Writeback vindo do Pré-Execute (posedge)
	input             ex_fw_writereg,	// Gravar registro do Pré-Execute
	
	// Memory
	input      [31:0] mem_fw_wbvalue,	// Valor a ser gravado no Writeback vindo do Final do Execute (negedge)
	input             mem_fw_writereg,	// Gravar registro do Final do Execute

	// Writeback
	input      [31:0] wb_fw_wbvalue,    // Valor a ser gravado no Writeback vindo do Final do Memory
	input             wb_fw_writereg	// Gravar registro do Final do Memory
	
	);

	reg [4:0] TableFW [3:0];			// Tabela de registro de endereço 	
	reg       load_next;				// Armazena se a próxima instrução é tipo Load
	

	// se a instrução no decode é de load e 
	// tem conflito entre a instrução load no decode e a instrução no execute e
	// se a instrução no execute escreve, nada podemos fazer
	
	always @(posedge clock) begin
		load_next = id_fw_load;
		
		//remove o primeiro da fila e adiciona mais um ao final
		TableFW[3] = TableFW[2]; 	//writeback
		TableFW[2] = TableFW[1]; 	//memory
		TableFW[1] = TableFW[0]; 	//execute
		TableFW[0] = id_fw_regdest; //decode
		
		fw_id_rega = (id_fw_rega);
		fw_id_regb = (id_fw_regb);

		// (WriteBack) conflito entre destino do wb e fonte do decode
		if( (id_fw_addra == TableFW[3]) || (id_fw_addrb == TableFW[3]) ) begin

			// tem conflito e escreve? então, valor = valor do ciclo : não tem, valor = valor do barramento
			fw_id_rega = ((id_fw_addra == TableFW[3]) && (wb_fw_writereg == 1'b1)) ? (wb_fw_wbvalue) : (id_fw_rega);
			fw_id_regb = ((id_fw_addrb == TableFW[3]) && (wb_fw_writereg == 1'b1)) ? (wb_fw_wbvalue) : (id_fw_regb);
		end
		// (Memory) conflito entre destino do memory e fonte do decode
		if( (id_fw_addra == TableFW[2]) || (id_fw_addrb == TableFW[2]) ) begin

			// tem conflito e escreve? então, valor = valor do ciclo : não tem, valor = valor do barramento
			fw_id_rega = ((id_fw_addra == TableFW[2]) && (mem_fw_writereg == 1'b1)) ? (mem_fw_wbvalue) : (id_fw_rega);
			fw_id_regb = ((id_fw_addrb == TableFW[2]) && (mem_fw_writereg == 1'b1)) ? (mem_fw_wbvalue) : (id_fw_regb);
		end
		// (Execute) conflito entre destino do execute e fonte do decode
		if( (id_fw_addra == TableFW[1]) || (id_fw_addrb == TableFW[1]) ) begin
		
			// tem conflito e escreve? então, valor = valor do ciclo : não tem, valor = valor do barramento
			fw_id_rega = ((id_fw_addra == TableFW[1]) && (ex_fw_writereg == 1'b1)) ? (ex_fw_wbvalue) : (id_fw_rega);
			fw_id_regb = ((id_fw_addrb == TableFW[1]) && (ex_fw_writereg == 1'b1)) ? (ex_fw_wbvalue) : (id_fw_regb);
		end

		if( load_next == 1 && ((id_fw_addra == TableFW[1]) || (id_fw_addrb == TableFW[1]) ) )
			fw_if_id_stall = 1;
		else
			fw_if_id_stall = 0;
		
	end
	
	//reseta os registradores de forwarding
	always @(posedge reset) begin
		load_next  = 1'b0;
		
		fw_id_rega = 32'b00000;	
		fw_id_regb = 32'b00000;
		
		TableFW[0] = 5'bx;
		TableFW[1] = 5'bx;
		TableFW[2] = 5'bx;
		TableFW[3] = 5'bx;

		fw_if_id_stall =  1'b0;
	end

endmodule
