`include "../rtl/Execute.v"

module tb_execute();

	Execute execute(

		.clock(clock),
		.reset(reset),

		// Decode
		.id_ex_selalushift(id_ex_selalushift), // Seleciona ALU ou COMP
		.id_ex_selimregb(id_ex_selimregb),   // Seleciona Imediato Extendido ou Reg B
		.id_ex_selsarega(id_ex_selsarega),   // Seleciona Shift Amount ou Reg A
		.id_ex_aluop(id_ex_aluop),       // Operacao da ALU
		.id_ex_unsig(id_ex_unsig),       // Informa se a instruço éem sinal
		.id_ex_shiftop(id_ex_shiftop),     // Direcao do shift e Tipo do shif
		.id_ex_shiftamt(id_ex_shiftamt),    // Shift Amount
		.id_ex_rega(id_ex_rega),
		.id_ex_msm(id_ex_msm),
		.id_ex_msl(id_ex_msl),
		.id_ex_readmem(id_ex_readmem),     // Le memoria
		.id_ex_writemem(id_ex_writemem),	 // Escreve memoria
		.id_ex_mshw(id_ex_mshw),
		.id_ex_lshw(id_ex_lshw),
		.id_ex_regb(id_ex_regb),
		.id_ex_imedext(id_ex_imedext),
		.id_ex_proximopc(id_ex_proximopc),
		.id_ex_selwsource(id_ex_selwsource),	 // Seleciona fonte de dados para WB realizar escrita
		.id_ex_regdest(id_ex_regdest),     // Endereço do registrador de destino ( RD || RT || 31 )
		.id_ex_writereg(id_ex_writereg),    // Escreve em registrador
		.id_ex_writeov(id_ex_writeov),     // Escreve c/ overflow 

		// Forwarding
		.ex_fw_wbvalue(ex_fw_wbvalue),     // Valor que será gravado em WB
		.ex_fw_writereg(ex_fw_writereg),    // Flag para FW saber se este valor será usado (gravado = usado)

		// Fetch
		.ex_if_stall(ex_if_stall),

		// Memory
		.ex_mem_msm(ex_mem_msm),
		.ex_mem_msl(ex_mem_msl),
		.ex_mem_readmem(ex_mem_readmem),    // Le memoria
		.ex_mem_writemem(ex_mem_writemem),	 // Escreve memoria
		.ex_mem_mshw(ex_mem_mshw),
		.ex_mem_lshw(ex_mem_lshw),
		.ex_mem_regb(ex_mem_regb),
		.ex_mem_selwsource(ex_mem_selwsource), // Seleciona fonte de dados para WB realizar escrita
		.ex_mem_regdest(ex_mem_regdest),    // Endereço do registrador de destino ( RD || RT || 31 )
		.ex_mem_writereg(ex_mem_writereg),   // Escreve em registrador
		.ex_mem_aluout(ex_mem_aluout),     // Resultado de ( SHIFT || ALU )
		.ex_mem_wbvalue(ex_mem_wbvalue)

	);

	reg            clock;
	reg            reset;

	// Decode
	reg            id_ex_selalushift; // Seleciona ALU ou COMP
	reg            id_ex_selimregb;   // Seleciona Imediato Extendido ou Reg B
 	reg            id_ex_selsarega;   // Seleciona Shift Amount ou Reg A
 	reg      [2:0] id_ex_aluop;       // Operacao da ALU
 	reg            id_ex_unsig;       // Informa se a instruço éem sinal
 	reg      [1:0] id_ex_shiftop;     // Direcao do shift e Tipo do shif
 	reg      [4:0] id_ex_shiftamt;    // Shift Amount
 	reg     [31:0] id_ex_rega;
 	reg      [2:0] id_ex_msm;
 	reg      [2:0] id_ex_msl;
 	reg            id_ex_readmem;     // Le memoria
 	reg            id_ex_writemem;	 // Escreve memoria
 	reg            id_ex_mshw;
 	reg            id_ex_lshw;
 	reg     [31:0] id_ex_regb;
 	reg     [31:0] id_ex_imedext;
 	reg     [31:0] id_ex_proximopc;
	reg      [2:0] id_ex_selwsource;	 // Seleciona fonte de dados para WB realizar escrita
 	reg      [4:0] id_ex_regdest;     // Endereço do registrador de destino ( RD || RT || 31 )
 	reg            id_ex_writereg;    // Escreve em registrador
 	reg            id_ex_writeov;     // Escreve c/ overflow 

	// Forwarding
	wire       [31:0] ex_fw_wbvalue;     // Valor que será gravado em WB
	wire              ex_fw_writereg;    // Flag para FW saber se este valor será usado (gravado = usado)

	// Fetch
	wire              ex_if_stall;

	// Memory
 	wire        [2:0] ex_mem_msm;
 	wire        [2:0] ex_mem_msl;
 	wire              ex_mem_readmem;    // Le memoria
 	wire              ex_mem_writemem;	 // Escreve memoria
 	wire              ex_mem_mshw;
 	wire              ex_mem_lshw;
 	wire       [31:0] ex_mem_regb;
 	wire        [2:0] ex_mem_selwsource; // Seleciona fonte de dados para WB realizar escrita
 	wire        [4:0] ex_mem_regdest;    // Endereço do registrador de destino ( RD || RT || 31 )
 	wire              ex_mem_writereg;   // Escreve em registrador
 	wire       [31:0] ex_mem_aluout;     // Resultado de ( SHIFT || ALU )
	wire       [31:0] ex_mem_wbvalue;

	reg [3:0] contador_tst;
	
	always #10 clock = ~clock;

	always@(negedge clock or posedge reset)
	begin
	  if(reset)
	  	begin
	  		contador_tst = 4'b0;	      
	  	end
	 	else
	 	  begin
	 	  	if(contador_tst <= 4'd4)
	 	  		begin
	 	  			contador_tst = contador_tst + 4'b1;
	 	  		end
	 	  	else
				begin
					contador_tst = 4'bx;
					$finish;
				end
/*
					id_ex_selalushift = 1'bx;
 					id_ex_selimregb   = 1'bx;
 					id_ex_selsarega   = 1'bx;
 					id_ex_aluop       = 3'dx;
 					id_ex_unsig       = 1'bx;
 					id_ex_shiftop     = 2'dx;
 					id_ex_shiftamt    = 5'dx;
 					id_ex_rega        = 32'dx;
 					id_ex_msm         = 3'dx;
 					id_ex_msl         = 3'dx;
 					id_ex_readmem     = 1'bx;
 					id_ex_writemem	  = 1'bx;
 					id_ex_mshw        = 1'bx;
 					id_ex_lshw        = 1'bx;
 					id_ex_regb        = 32'dx;
 					id_ex_imedext     = 32'dx;
 					id_ex_proximopc   = 32'dx;
 					id_ex_selwsource  = 3'dx;
 					id_ex_regdest     = 5'dx;
 					id_ex_writereg    = 1'bx;
 					id_ex_writeov     = 1'bx;
*/

			case(contador_tst)

				1:
				begin
					// Testa operação shift e stall = 0
					// Entradas ID -> EX 1o. ciclo
					id_ex_selalushift = 1'b1; // shift
 					id_ex_selimregb   = 1'bx;
 					id_ex_selsarega   = 1'b1; // shiftamt
 					id_ex_aluop       = 3'dx;
 					id_ex_unsig       = 1'b1; // Para aluov nao ficar igual a x
 					id_ex_shiftop     = 2'd2; // SLL
 					id_ex_shiftamt    = 5'd2; // x
 					id_ex_rega        = 32'dx;
 					id_ex_msm         = 3'dx;
 					id_ex_msl         = 3'dx;
 					id_ex_readmem     = 1'b0; // x
 					id_ex_writemem    = 1'b1; // x
 					id_ex_mshw        = 1'bx;
 					id_ex_lshw        = 1'bx;
 					id_ex_regb        = 32'd23; // x
 					id_ex_imedext     = 32'dx;
 					id_ex_proximopc   = 32'dx;
 					id_ex_selwsource  = 3'd0; // mux_alushift
 					id_ex_regdest     = 5'd5;
 					id_ex_writereg    = 1'b1;
 					id_ex_writeov     = 1'b0;

					$display;
					$display("teste 1) Testa operação shift e stall = 0");
					$display("(negedge)");
					$display("ciclo : %d (ID -> EX)", contador_tst);
					$display("id_ex_selalushift : %b", id_ex_selalushift);
				 	$display("id_ex_selimregb   : %b", id_ex_selimregb);
					$display("id_ex_selsarega   : %b", id_ex_selsarega);  
				 	$display("id_ex_aluop       : %d", id_ex_aluop);      
					$display("id_ex_unsig       : %b", id_ex_unsig);       
				 	$display("id_ex_shiftop     : %d", id_ex_shiftop);    
					$display("id_ex_shiftamt    : %d", id_ex_shiftamt);    
				 	$display("id_ex_rega        : %d", id_ex_rega);        
				 	$display("id_ex_msm         : %d", id_ex_msm);         
				 	$display("id_ex_msl         : %d", id_ex_msl);         
				 	$display("id_ex_readmem     : %b", id_ex_readmem);     
					$display("id_ex_writemem    : %b", id_ex_writemem);	  
					$display("id_ex_mshw        : %b", id_ex_mshw);        
				 	$display("id_ex_lshw        : %b", id_ex_lshw);        
				 	$display("id_ex_regb        : %d", id_ex_regb);        
				 	$display("id_ex_imedext     : %d", id_ex_imedext);     
				 	$display("id_ex_proximopc   : %d", id_ex_proximopc);   
				 	$display("id_ex_selwsource  : %d", id_ex_selwsource);  
				 	$display("id_ex_regdest     : %d", id_ex_regdest);     
				 	$display("id_ex_writereg    : %b", id_ex_writereg);    
				 	$display("id_ex_writeov     : %b", id_ex_writeov); 
				end

				2:
				begin
				#1
				$display("#1");
				$display("ciclo : %d (EX -> MEM)", (contador_tst));
				$display("Resultado do 1o. ciclo");
				$display("ex_mem_msm       : %d", ex_mem_msm);
				$display("ex_mem_msl       : %d", ex_mem_msl);
				$display("ex_mem_readmem   : %b", ex_mem_readmem);
				$display("ex_mem_writemem  : %b", ex_mem_writemem);
				$display("ex_mem_mshw      : %b", ex_mem_mshw);
				$display("ex_mem_lshw      : %b", ex_mem_lshw);
				$display("ex_mem_regb      : %d", ex_mem_regb);
				$display("ex_mem_selwsource: %d", ex_mem_selwsource);
				$display("ex_mem_regdest   : %d", ex_mem_regdest);
				$display("ex_mem_writereg  : %b", ex_mem_writereg); 
				$display("ex_mem_aluout    : %d", ex_mem_aluout);
				$display("ex_mem_wbvalue   : %d", ex_mem_wbvalue);
				$display("ex_if_stall      : %b", ex_if_stall);
				$display;

					// Testa sinais Alu
					// Entradas ID -> EX 2o. ciclo
					id_ex_selalushift = 1'b0; // alu
 					id_ex_selimregb   = 1'b1; // imedext
 					id_ex_selsarega   = 1'b0; // rega
 					id_ex_aluop       = 3'd2; // ADDI
 					id_ex_unsig       = 1'b0;
 					id_ex_shiftop     = 2'dx;
 					id_ex_shiftamt    = 5'dx;
 					id_ex_rega        = -32'd2147483640; // x
 					id_ex_msm         = 3'dx;
 					id_ex_msl         = 3'dx;
 					id_ex_readmem     = 1'bx;
 					id_ex_writemem    = 1'bx;
 					id_ex_mshw        = 1'bx;
 					id_ex_lshw        = 1'bx;
 					id_ex_regb        = 32'dx;
 					id_ex_imedext     = -32'd128; // x
 					id_ex_proximopc   = 32'dx;
 					id_ex_selwsource  = 3'd0; // mux_alushift
 					id_ex_regdest     = 5'dx;
 					id_ex_writereg    = 1'b1; // x
 					id_ex_writeov     = 1'b0; // x

					$display;
					$display("teste 2) Testa sinais Alu");
					$display("(negedge)");
					$display("ciclo : %d (ID -> EX)", contador_tst);
					$display("id_ex_selalushift : %b", id_ex_selalushift);
				 	$display("id_ex_selimregb   : %b", id_ex_selimregb);
					$display("id_ex_selsarega   : %b", id_ex_selsarega);  
				 	$display("id_ex_aluop       : %d", id_ex_aluop);      
					$display("id_ex_unsig       : %b", id_ex_unsig);       
				 	$display("id_ex_shiftop     : %d", id_ex_shiftop);    
					$display("id_ex_shiftamt    : %d", id_ex_shiftamt);    
				 	$display("id_ex_rega        : %d", id_ex_rega);        
				 	$display("id_ex_msm         : %d", id_ex_msm);         
				 	$display("id_ex_msl         : %d", id_ex_msl);         
				 	$display("id_ex_readmem     : %b", id_ex_readmem);     
					$display("id_ex_writemem    : %b", id_ex_writemem);	  
					$display("id_ex_mshw        : %b", id_ex_mshw);        
				 	$display("id_ex_lshw        : %b", id_ex_lshw);        
				 	$display("id_ex_regb        : %d", id_ex_regb);        
				 	$display("id_ex_imedext     : %d", id_ex_imedext);     
				 	$display("id_ex_proximopc   : %d", id_ex_proximopc);   
				 	$display("id_ex_selwsource  : %d", id_ex_selwsource);  
				 	$display("id_ex_regdest     : %d", id_ex_regdest);     
				 	$display("id_ex_writereg    : %b", id_ex_writereg);    
				 	$display("id_ex_writeov     : %b", id_ex_writeov);    
				end

				3:
				begin
				#1
				$display("#1");
				$display("ciclo : %d (EX -> MEM)", (contador_tst));
				$display("Resultado do 2o. ciclo");
				$display("ex_mem_msm       : %d", ex_mem_msm);
				$display("ex_mem_msl       : %d", ex_mem_msl);
				$display("ex_mem_readmem   : %b", ex_mem_readmem);
				$display("ex_mem_writemem  : %b", ex_mem_writemem);
				$display("ex_mem_mshw      : %b", ex_mem_mshw);
				$display("ex_mem_lshw      : %b", ex_mem_lshw);
				$display("ex_mem_regb      : %d", ex_mem_regb);
				$display("ex_mem_selwsource: %d", ex_mem_selwsource);
				$display("ex_mem_regdest   : %d", ex_mem_regdest);
				$display("ex_mem_writereg  : %b", ex_mem_writereg); 
				$display("ex_mem_aluout    : %d", ex_mem_aluout);
				$display("ex_mem_wbvalue   : %d", ex_mem_wbvalue);
				$display("ex_if_stall      : %b", ex_if_stall);
				$display;
	
					// Testa repasse de sinais e stall = 1
					// Entradas ID -> EX 3o. ciclo
					id_ex_selalushift = 1'bx;
					id_ex_selimregb   = 1'bx;
 					id_ex_selsarega   = 1'bx;
 					id_ex_aluop       = 3'dx;
 					id_ex_unsig       = 1'bx;
 					id_ex_shiftop     = 2'dx;
 					id_ex_shiftamt    = 5'dx;
 					id_ex_rega        = 32'dx; 
					id_ex_msm         = 3'd5; // x
 					id_ex_msl         = 3'd4; // x
 					id_ex_readmem     = 1'b1; // x
 					id_ex_writemem    = 1'b0; // x
 					id_ex_mshw        = 1'b1; // x
 					id_ex_lshw        = 1'b1; // x
 					id_ex_regb        = 32'd790923; //x
 					id_ex_imedext     = 32'dx;
 					id_ex_proximopc   = 32'dx;
 					id_ex_selwsource  = 3'd7; // x
 					id_ex_regdest     = 5'd26; // x
 					id_ex_writereg    = 1'b1; // x
 					id_ex_writeov     = 1'b1; // x

					$display;
					$display("teste 3) Testa repasse de sinais e stall = 1");
					$display("(negedge)");
					$display("ciclo : %d (ID -> EX)", contador_tst);
					$display("id_ex_selalushift : %b", id_ex_selalushift);
				 	$display("id_ex_selimregb   : %b", id_ex_selimregb);
					$display("id_ex_selsarega   : %b", id_ex_selsarega);  
				 	$display("id_ex_aluop       : %d", id_ex_aluop);      
					$display("id_ex_unsig       : %b", id_ex_unsig);       
				 	$display("id_ex_shiftop     : %d", id_ex_shiftop);    
					$display("id_ex_shiftamt    : %d", id_ex_shiftamt);    
				 	$display("id_ex_rega        : %d", id_ex_rega);        
				 	$display("id_ex_msm         : %d", id_ex_msm);         
				 	$display("id_ex_msl         : %d", id_ex_msl);         
				 	$display("id_ex_readmem     : %b", id_ex_readmem);     
					$display("id_ex_writemem    : %b", id_ex_writemem);	  
					$display("id_ex_mshw        : %b", id_ex_mshw);        
				 	$display("id_ex_lshw        : %b", id_ex_lshw);        
				 	$display("id_ex_regb        : %d", id_ex_regb);        
				 	$display("id_ex_imedext     : %d", id_ex_imedext);     
				 	$display("id_ex_proximopc   : %d", id_ex_proximopc);   
				 	$display("id_ex_selwsource  : %d", id_ex_selwsource);  
				 	$display("id_ex_regdest     : %d", id_ex_regdest);     
				 	$display("id_ex_writereg    : %b", id_ex_writereg);    
				 	$display("id_ex_writeov     : %b", id_ex_writeov);    
				end

				4:
				begin
				#1
				$display("#1");
				$display("ciclo : %d (EX -> MEM)", (contador_tst));
				$display("Resultado do 3o. ciclo");
				$display("ex_mem_msm       : %d", ex_mem_msm);
				$display("ex_mem_msl       : %d", ex_mem_msl);
				$display("ex_mem_readmem   : %b", ex_mem_readmem);
				$display("ex_mem_writemem  : %b", ex_mem_writemem);
				$display("ex_mem_mshw      : %b", ex_mem_mshw);
				$display("ex_mem_lshw      : %b", ex_mem_lshw);
				$display("ex_mem_regb      : %d", ex_mem_regb);
				$display("ex_mem_selwsource: %d", ex_mem_selwsource);
				$display("ex_mem_regdest   : %d", ex_mem_regdest);
				$display("ex_mem_writereg  : %b", ex_mem_writereg); 
				$display("ex_mem_aluout    : %d", ex_mem_aluout);
				$display("ex_mem_wbvalue   : %d", ex_mem_wbvalue);
				$display("ex_if_stall      : %b", ex_if_stall);
				$display;
				end


			endcase

	 	  end
	end

	always@(posedge clock)
	begin
		case(contador_tst)
			1:
			begin
				$display("(posedge)");
				// Resultados do 1o. ciclo
				$display("ciclo : %d (EX -> MEM)", (contador_tst));
				// Forwarding
				$display("ex_fw_wbvalue    : %d", ex_fw_wbvalue);
				$display("ex_fw_writereg   : %b", ex_fw_writereg);
				// Fetch
				$display("ex_if_stall      : %b", ex_if_stall);
			end
		
			2:
			begin
				$display("(posedge)");
				// Resultados do 2o. ciclo
				$display("ciclo : %d (EX -> MEM)", (contador_tst));
				// Forwarding
				$display("ex_fw_wbvalue    : %d", ex_fw_wbvalue);
				$display("ex_fw_writereg   : %b", ex_fw_writereg);
				// Fetch
				$display("ex_if_stall      : %b", ex_if_stall);
			end

			3:
			begin
				$display("(posedge)");
				// Resultados do 3o. ciclo
				$display("ciclo : %d (EX -> MEM)", (contador_tst));
				// Forwarding
				$display("ex_fw_wbvalue    : %d", ex_fw_wbvalue);
				$display("ex_fw_writereg   : %b", ex_fw_writereg);
				// Fetch
				$display("ex_if_stall      : %b", ex_if_stall);
			end

		endcase
	end

	initial
	begin
		#1 reset = 0;
		#1 reset = 1;
		#1 reset = 0;
		
		#1 clock = 0;
	end

endmodule
