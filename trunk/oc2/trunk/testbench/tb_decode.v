`include "../rtl/Decode.v"

module tb_decode();

	Decode decode(
                                                           
		.clock            (clock),
		.reset            (reset),
		.fw_if_id_stall   (fw_if_id_stall),
						
		.if_id_instrucao  (if_id_instrucao),
		.if_id_proximopc  (if_id_proximopc),
		.id_if_selfontepc (id_if_selfontepc),
                   
		.id_if_rega       (id_if_rega),
		.id_if_pcimd2ext  (id_if_pcimd2ext),
		.id_if_pcindex    (id_if_pcindex),
		.id_if_seltipopc  (id_if_seltipopc),
                   
		.id_ex_selalushift(id_ex_selalushift),
		.id_ex_selimregb  (id_ex_selimregb),
		.id_ex_selsarega  (id_ex_selsarega),
		.id_ex_aluop      (id_ex_aluop),
		.id_ex_unsig      (id_ex_unsig),
		.id_ex_shiftop    (id_ex_shiftop),
		.id_ex_shiftamt   (id_ex_shiftamt),
		.id_ex_rega       (id_ex_rega),
		.id_ex_msm        (id_ex_msm),
		.id_ex_msl        (id_ex_msl),
		.id_ex_readmem    (id_ex_readmem),
		.id_ex_writemem   (id_ex_writemem),
		.id_ex_mshw       (id_ex_mshw),
		.id_ex_lshw       (id_ex_lshw),
		.id_ex_regb       (id_ex_regb),
		.id_ex_imedext    (id_ex_imedext),
		.id_ex_proximopc  (id_ex_proximopc),
		.id_ex_selwsource (id_ex_selwsource),
		.id_ex_regdest    (id_ex_regdest),
		.id_ex_writereg   (id_ex_writereg),
		.id_ex_writeov    (id_ex_writeov),
                   
		.id_fw_regdest    (id_fw_regdest),
		.id_fw_load	      (id_fw_load),
		.id_fw_addra      (id_fw_addra),
		.id_fw_addrb      (id_fw_addrb),
		.id_fw_rega       (id_fw_rega),
		.id_fw_regb       (id_fw_regb),
		.fw_id_rega       (fw_id_rega),
		.fw_id_regb       (fw_id_regb),
                   
		.id_reg_addra     (id_reg_addra),
		.id_reg_addrb	  (id_reg_addrb),
		.reg_id_dataa     (reg_id_dataa),
		.reg_id_datab     (reg_id_datab),
		.id_reg_ena       (id_reg_ena),
		.id_reg_enb       (id_reg_enb)
	
	);

	reg               clock;
	reg               reset;
	reg               fw_if_id_stall;       // Sinal de stall vindo de FW para instrução seguinte a load com dependencia de dados
	
	// Fetch
	reg        [31:0] if_id_instrucao;   //ir,
	reg        [31:0] if_id_proximopc;   //pc,  // valor do PC da proxima instrução
 	wire              id_if_selfontepc;
 	 
	wire       [31:0] id_if_rega; 
	wire       [31:0] id_if_pcimd2ext;   // PC + Imediato << 2 c/ sinal extendido (Usado em Branches) 
	wire       [31:0] id_if_pcindex;     // PC[31:28], 26 bits (index) << 2 (Usado em J e JAL)
	wire        [1:0] id_if_seltipopc;   // Seletor de fonte do PC
	
	// Excecute
	wire              id_ex_selalushift; // Seleciona ALU ou COMP
	wire              id_ex_selimregb;   // Seleciona Imediato Extendido ou Reg B
	wire              id_ex_selsarega;   // Seleciona Shift Amount ou Reg A
	wire        [2:0] id_ex_aluop;       // opAlu,    // Operacao da ALU
	wire              id_ex_unsig;       // Informa se a instruço éem sinal
	wire        [1:0] id_ex_shiftop;     // Direcao do shift e Tipo do shif
	wire        [4:0] id_ex_shiftamt;    // Shift Amount
	wire       [31:0] id_ex_rega;		 // Registrador lido A
	wire        [2:0] id_ex_msm;
	wire        [2:0] id_ex_msl;
	wire              id_ex_readmem;     // Le memoria
	wire              id_ex_writemem;	 // Escreve memoria
	wire              id_ex_mshw;
	wire              id_ex_lshw;
	wire       [31:0] id_ex_regb;		 // Registrador lido B
	wire       [31:0] id_ex_imedext;	 // Imediato com extensão de sinal
	wire       [31:0] id_ex_proximopc;
	wire        [2:0] id_ex_selwsource;	 // Seleciona fonte de dados para WB realizar escrita
	wire        [4:0] id_ex_regdest;     // Endereço do registrador de destino ( RD || RT || 31 )
	wire              id_ex_writereg;    // Escreve em registrador
	wire              id_ex_writeov;     // Escreve c/ overflow
	
	// Forwarding
	wire        [4:0] id_fw_regdest;	// Registrador de destino
	wire              id_fw_load;		// Instrução de Load ? (equivale a sinal readmem)
	wire        [4:0] id_fw_addra;		// Address A
	wire        [4:0] id_fw_addrb;		// Address B
	wire       [31:0] id_fw_rega;		// Registrador A lido
	wire       [31:0] id_fw_regb;		// Registrador B lido

	reg        [31:0] fw_id_rega;		// Valores enviados ao Execute com tratamento de conflito de dados
	reg        [31:0] fw_id_regb;
		
	// Registradores
	wire        [4:0] id_reg_addra; 	 // Endereço A do registrador (campo RS)
	wire        [4:0] id_reg_addrb; 	 // Endereço B do registrador (campo RT)

	reg        [31:0] reg_id_dataa;  	 // Barramento de dados dos registradores
	reg        [31:0] reg_id_datab;  	

	wire              id_reg_ena;  		 // Enable dos registradores
	wire              id_reg_enb; 
	
	reg [3:0] contador_tst;
	
	always #10 clock = ~clock;

	always@(negedge (clock) or posedge reset)
	begin
	  if(reset)
	  	begin
	  		contador_tst = 4'b0;
	  	end
	 	else
	 	  begin
	 	  	if(contador_tst <= 4'd14)
	 	  		begin
	 	  			contador_tst = contador_tst + 4'b1;
	 	  		end
	 	  	else
				begin
					contador_tst = 4'bx;
					$finish;
				end

			case(contador_tst)

				1:
				begin
					fw_if_id_stall  = 1'b0;                                       
					if_id_instrucao = 32'h20047fff; // addi $a0, $zero, 15000
					if_id_proximopc = 32'd4;

					$display;
					$display("addi $a0, $zero, 15000");
					$display;
					$display("(negedge)");

					$display("teste 1) Entrada: IF -> ID");
					$display("fw_if_id_stall  : %b", fw_if_id_stall); 
					$display("if_id_instrucao : %h", if_id_instrucao);
					$display("if_id_proximopc : %d", if_id_proximopc);

					#1 $display("#1");
					$display("teste 1) Saida: ID -> Registers");
					$display("id_reg_addra    : %d", id_reg_addra);
					$display("id_reg_addrb    : %d", id_reg_addrb);
					$display("id_reg_ena      : %b", id_reg_ena);
					$display("id_reg_enb      : %b", id_reg_enb);


				end

				2:
				begin
					$display;
					$display("(negedge)");

					$display("teste 1) Saida: ID -> IF");
					$display("id_if_selfontepc: %b", id_if_selfontepc);
					$display("id_if_rega      : %h", id_if_rega);
					$display("id_if_pcimd2ext : %h", id_if_pcimd2ext);
					$display("id_if_pcindex   : %h", id_if_pcindex);
					$display("id_if_seltipopc : %d", id_if_seltipopc);

					fw_id_rega      = 32'hff1e00a5; // Sinal gerado em Forwarding, somente repassado por ID a EX.
					fw_id_regb      = 32'h11111111; //  "
					$display("teste 1) Entrada: Forwarding -> ID");
					$display("fw_id_rega      : %h", fw_id_rega);
					$display("fw_id_regb      : %h", fw_id_regb);   

					#1
					$display("#1");
					$display("teste 1) Saida: ID -> EX");
					$display("id_ex_selalushift : %b", id_ex_selalushift);
					$display("id_ex_selimregb   : %b", id_ex_selimregb);
					$display("id_ex_selsarega   : %b", id_ex_selsarega);
					$display("id_ex_aluop       : %d", id_ex_aluop);
					$display("id_ex_unsig       : %b", id_ex_unsig);
					$display("id_ex_shiftop     : %d", id_ex_shiftop);
					$display("id_ex_shiftamt    : %d", id_ex_shiftamt);
					$display("id_ex_rega        : %h", id_ex_rega);
					$display("id_ex_msm         : %d", id_ex_msm);
					$display("id_ex_msl         : %d", id_ex_msl);
					$display("id_ex_readmem     : %b", id_ex_readmem);
					$display("id_ex_writemem    : %b", id_ex_writemem);
					$display("id_ex_mshw        : %b", id_ex_mshw);
					$display("id_ex_lshw        : %b", id_ex_lshw);
					$display("id_ex_regb        : %h", id_ex_regb);
					$display("id_ex_imedext     : %h", id_ex_imedext);
					$display("id_ex_proximopc   : %h", id_ex_proximopc);
					$display("id_ex_selwsource  : %d", id_ex_selwsource);
					$display("id_ex_regdest     : %d", id_ex_regdest);
					$display("id_ex_writereg    : %b", id_ex_writereg);
					$display("id_ex_writeov     : %b", id_ex_writeov);
				end

				5:
				begin
					fw_if_id_stall  = 1'b1;                                       
					if_id_instrucao = 32'hbba40015; // swr $a0, 21($sp)
					if_id_proximopc = 32'd200;

					$display;
					$display("swr $a0, 21($sp)");
					$display;
					$display("(negedge)");

					$display("teste 2) Entrada: IF -> ID");
					$display("fw_if_id_stall  : %b", fw_if_id_stall); 
					$display("if_id_instrucao : %h", if_id_instrucao);
					$display("if_id_proximopc : %d", if_id_proximopc);

					#1 $display("#1");
					$display("teste 2) Saida: ID -> Registers");
					$display("id_reg_addra    : %d", id_reg_addra);
					$display("id_reg_addrb    : %d", id_reg_addrb);
					$display("id_reg_ena      : %b", id_reg_ena);
					$display("id_reg_enb      : %b", id_reg_enb);


				end

				6:
				begin
					$display;
					$display("(negedge)");

					$display("teste 2) Saida: ID -> IF");
					$display("id_if_selfontepc: %b", id_if_selfontepc);
					$display("id_if_rega      : %h", id_if_rega);
					$display("id_if_pcimd2ext : %h", id_if_pcimd2ext);
					$display("id_if_pcindex   : %h", id_if_pcindex);
					$display("id_if_seltipopc : %d", id_if_seltipopc);

					fw_id_rega      = 32'haaaaaa01; // Sinal gerado em Forwarding, somente repassado por ID a EX.
					fw_id_regb      = 32'h98989898; //  "
					$display("teste 2) Entrada: Forwarding -> ID");
					$display("fw_id_rega      : %h", fw_id_rega);
					$display("fw_id_regb      : %h", fw_id_regb);   

					#1
					$display("#1");
					$display("teste 2) Saida: ID -> EX");
					$display("id_ex_selalushift : %b", id_ex_selalushift);
					$display("id_ex_selimregb   : %b", id_ex_selimregb);
					$display("id_ex_selsarega   : %b", id_ex_selsarega);
					$display("id_ex_aluop       : %d", id_ex_aluop);
					$display("id_ex_unsig       : %b", id_ex_unsig);
					$display("id_ex_shiftop     : %d", id_ex_shiftop);
					$display("id_ex_shiftamt    : %d", id_ex_shiftamt);
					$display("id_ex_rega        : %h", id_ex_rega);
					$display("id_ex_msm         : %d", id_ex_msm);
					$display("id_ex_msl         : %d", id_ex_msl);
					$display("id_ex_readmem     : %b", id_ex_readmem);
					$display("id_ex_writemem    : %b", id_ex_writemem);
					$display("id_ex_mshw        : %b", id_ex_mshw);
					$display("id_ex_lshw        : %b", id_ex_lshw);
					$display("id_ex_regb        : %h", id_ex_regb);
					$display("id_ex_imedext     : %h", id_ex_imedext);
					$display("id_ex_proximopc   : %h", id_ex_proximopc);
					$display("id_ex_selwsource  : %d", id_ex_selwsource);
					$display("id_ex_regdest     : %d", id_ex_regdest);
					$display("id_ex_writereg    : %b", id_ex_writereg);
					$display("id_ex_writeov     : %b", id_ex_writeov);
				end

				9:
				begin
					fw_if_id_stall  = 1'b0;                                       
					if_id_instrucao = 32'h03e00008; // jr $ra
					if_id_proximopc = 32'd300;

					$display;
					$display("jr $ra");
					$display;
					$display("(negedge)");

					$display("teste 3) Entrada: IF -> ID");
					$display("fw_if_id_stall  : %b", fw_if_id_stall); 
					$display("if_id_instrucao : %h", if_id_instrucao);
					$display("if_id_proximopc : %d", if_id_proximopc);

					#1 $display("#1");
					$display("teste 3) Saida: ID -> Registers");
					$display("id_reg_addra    : %d", id_reg_addra);
					$display("id_reg_addrb    : %d", id_reg_addrb);
					$display("id_reg_ena      : %b", id_reg_ena);
					$display("id_reg_enb      : %b", id_reg_enb);


				end

				10:
				begin
					$display;
					$display("(negedge)");

					$display("teste 3) Saida: ID -> IF");
					$display("id_if_selfontepc: %b", id_if_selfontepc);
					$display("id_if_rega      : %h", id_if_rega);
					$display("id_if_pcimd2ext : %h", id_if_pcimd2ext);
					$display("id_if_pcindex   : %h", id_if_pcindex);
					$display("id_if_seltipopc : %d", id_if_seltipopc);

					fw_id_rega      = 32'haaaaffff; // Sinal gerado em Forwarding, somente repassado por ID a EX.
					fw_id_regb      = 32'hbbbb0000; //  "
					$display("teste 3) Entrada: Forwarding -> ID");
					$display("fw_id_rega      : %h", fw_id_rega);
					$display("fw_id_regb      : %h", fw_id_regb);   

					#1
					$display("#1");
					$display("teste 3) Saida: ID -> EX");
					$display("id_ex_selalushift : %b", id_ex_selalushift);
					$display("id_ex_selimregb   : %b", id_ex_selimregb);
					$display("id_ex_selsarega   : %b", id_ex_selsarega);
					$display("id_ex_aluop       : %d", id_ex_aluop);
					$display("id_ex_unsig       : %b", id_ex_unsig);
					$display("id_ex_shiftop     : %d", id_ex_shiftop);
					$display("id_ex_shiftamt    : %d", id_ex_shiftamt);
					$display("id_ex_rega        : %h", id_ex_rega);
					$display("id_ex_msm         : %d", id_ex_msm);
					$display("id_ex_msl         : %d", id_ex_msl);
					$display("id_ex_readmem     : %b", id_ex_readmem);
					$display("id_ex_writemem    : %b", id_ex_writemem);
					$display("id_ex_mshw        : %b", id_ex_mshw);
					$display("id_ex_lshw        : %b", id_ex_lshw);
					$display("id_ex_regb        : %h", id_ex_regb);
					$display("id_ex_imedext     : %h", id_ex_imedext);
					$display("id_ex_proximopc   : %h", id_ex_proximopc);
					$display("id_ex_selwsource  : %d", id_ex_selwsource);
					$display("id_ex_regdest     : %d", id_ex_regdest);
					$display("id_ex_writereg    : %b", id_ex_writereg);
					$display("id_ex_writeov     : %b", id_ex_writeov);
				end

				13:
				begin
					fw_if_id_stall  = 1'b0;                                       
					if_id_instrucao = 32'h87a6000c; // lh $a2, 12($sp)
					if_id_proximopc = 32'd500;

					$display;
					$display("lh $a2, 12($sp)");
					$display;
					$display("(negedge)");

					$display("teste 4) Entrada: IF -> ID");
					$display("fw_if_id_stall  : %b", fw_if_id_stall); 
					$display("if_id_instrucao : %h", if_id_instrucao);
					$display("if_id_proximopc : %d", if_id_proximopc);

					#1 $display("#1");
					$display("teste 4) Saida: ID -> Registers");
					$display("id_reg_addra    : %d", id_reg_addra);
					$display("id_reg_addrb    : %d", id_reg_addrb);
					$display("id_reg_ena      : %b", id_reg_ena);
					$display("id_reg_enb      : %b", id_reg_enb);


				end

				14:
				begin
					$display;
					$display("(negedge)");

					$display("teste 4) Saida: ID -> IF");
					$display("id_if_selfontepc: %b", id_if_selfontepc);
					$display("id_if_rega      : %h", id_if_rega);
					$display("id_if_pcimd2ext : %h", id_if_pcimd2ext);
					$display("id_if_pcindex   : %h", id_if_pcindex);
					$display("id_if_seltipopc : %d", id_if_seltipopc);

					fw_id_rega      = 32'hdddddddd; // Sinal gerado em Forwarding, somente repassado por ID a EX.
					fw_id_regb      = 32'heeeeeeee; //  "
					$display("teste 4) Entrada: Forwarding -> ID");
					$display("fw_id_rega      : %h", fw_id_rega);
					$display("fw_id_regb      : %h", fw_id_regb);   

					#1
					$display("#1");
					$display("teste 4) Saida: ID -> EX");
					$display("id_ex_selalushift : %b", id_ex_selalushift);
					$display("id_ex_selimregb   : %b", id_ex_selimregb);
					$display("id_ex_selsarega   : %b", id_ex_selsarega);
					$display("id_ex_aluop       : %d", id_ex_aluop);
					$display("id_ex_unsig       : %b", id_ex_unsig);
					$display("id_ex_shiftop     : %d", id_ex_shiftop);
					$display("id_ex_shiftamt    : %d", id_ex_shiftamt);
					$display("id_ex_rega        : %h", id_ex_rega);
					$display("id_ex_msm         : %d", id_ex_msm);
					$display("id_ex_msl         : %d", id_ex_msl);
					$display("id_ex_readmem     : %b", id_ex_readmem);
					$display("id_ex_writemem    : %b", id_ex_writemem);
					$display("id_ex_mshw        : %b", id_ex_mshw);
					$display("id_ex_lshw        : %b", id_ex_lshw);
					$display("id_ex_regb        : %h", id_ex_regb);
					$display("id_ex_imedext     : %h", id_ex_imedext);
					$display("id_ex_proximopc   : %h", id_ex_proximopc);
					$display("id_ex_selwsource  : %d", id_ex_selwsource);
					$display("id_ex_regdest     : %d", id_ex_regdest);
					$display("id_ex_writereg    : %b", id_ex_writereg);
					$display("id_ex_writeov     : %b", id_ex_writeov);
				end



			endcase

	 	  end
	end

	always@(posedge clock)
	begin
		case(contador_tst)
			1:
			begin
				$display;
				$display("(posedge)");

				reg_id_dataa    = 32'hff1e00a5;  // Simula valor lido no Registrador A
				reg_id_datab    = 32'h7ffec02b;  //                "                 B
				$display("teste 1) Entrada: Registers -> ID");
				$display("reg_id_dataa    : %h", reg_id_dataa);
				$display("reg_id_datab    : %h", reg_id_datab); 

				#1
				$display("#1");
				$display("teste 1) Saida: ID -> Forwarding");
				$display("id_fw_regdest   : %d", id_fw_regdest);
				$display("id_fw_load      : %b", id_fw_load);
				$display("id_fw_addra     : %d", id_fw_addra);
				$display("id_fw_addrb     : %d", id_fw_addrb);
				$display("id_fw_rega      : %h", id_fw_rega);
				$display("id_fw_regb      : %h", id_fw_regb);
			end
		
			5:
			begin
				$display;
				$display("(posedge)");

				reg_id_dataa    = 32'h00001111;  // Simula valor lido no Registrador A
				reg_id_datab    = 32'h22220000;  //                "                 B
				$display("teste 2) Entrada: Registers -> ID");
				$display("reg_id_dataa    : %h", reg_id_dataa);
				$display("reg_id_datab    : %h", reg_id_datab); 

				#1
				$display("#1");
				$display("teste 2) Saida: ID -> Forwarding");
				$display("id_fw_regdest   : %d", id_fw_regdest);
				$display("id_fw_load      : %b", id_fw_load);
				$display("id_fw_addra     : %d", id_fw_addra);
				$display("id_fw_addrb     : %d", id_fw_addrb);
				$display("id_fw_rega      : %h", id_fw_rega);
				$display("id_fw_regb      : %h", id_fw_regb);
			end

			9:
			begin
				$display;
				$display("(posedge)");

				reg_id_dataa    = 32'haaaaffff;  // Simula valor lido no Registrador A
				reg_id_datab    = 32'hbbbb0000;  //                "                 B
				$display("teste 3) Entrada: Registers -> ID");
				$display("reg_id_dataa    : %h", reg_id_dataa);
				$display("reg_id_datab    : %h", reg_id_datab); 

				#1
				$display("#1");
				$display("teste 3) Saida: ID -> Forwarding");
				$display("id_fw_regdest   : %d", id_fw_regdest);
				$display("id_fw_load      : %b", id_fw_load);
				$display("id_fw_addra     : %d", id_fw_addra);
				$display("id_fw_addrb     : %d", id_fw_addrb);
				$display("id_fw_rega      : %h", id_fw_rega);
				$display("id_fw_regb      : %h", id_fw_regb);
			end

			13:
			begin
				$display;
				$display("(posedge)");

				reg_id_dataa    = 32'hdddddddd;  // Simula valor lido no Registrador A
				reg_id_datab    = 32'heeeeeeee;  //                "                 B
				$display("teste 3) Entrada: Registers -> ID");
				$display("reg_id_dataa    : %h", reg_id_dataa);
				$display("reg_id_datab    : %h", reg_id_datab); 

				#1
				$display("#1");
				$display("teste 3) Saida: ID -> Forwarding");
				$display("id_fw_regdest   : %d", id_fw_regdest);
				$display("id_fw_load      : %b", id_fw_load);
				$display("id_fw_addra     : %d", id_fw_addra);
				$display("id_fw_addrb     : %d", id_fw_addrb);
				$display("id_fw_rega      : %h", id_fw_rega);
				$display("id_fw_regb      : %h", id_fw_regb);
			end


		endcase
	end

	initial
	begin
		$display("clock = #10");
		#1 reset = 0;
		#1 reset = 1;
		#1 reset = 0;
		
		#1 clock = 0;
	end

endmodule
