`include "../rtl/Forwarding.v"

module tb_forwarding();

	Forwarding forwarding(

		clock,
		reset,

		// Fetch
		fw_if_id_stall,   // Stall em PC, Fetch e Decode para FW de instruções seguinte a loads com dep. de dados

		// Decode
		id_fw_regdest,	// Registrador de destino
		id_fw_load,		// Instrução de Load ? (equivale a sinal readmem)
		id_fw_addra,		// Address A
		id_fw_addrb,		// Address B
		id_fw_rega,		// Registrador A lido
		id_fw_regb,		// Registrador B lido
		fw_id_rega,		// Valores enviados ao Execute com tratamento de conflito de dados
		fw_id_regb,
	
		// Execute
		ex_fw_wbvalue,	// Valor a ser gravado no Writeback vindo do Pré-Execute (posedge)
		ex_fw_writereg,	// Gravar registro do Pré-Execute
	
		// Memory
		mem_fw_wbvalue,	// Valor a ser gravado no Writeback vindo do Final do Execute (negedge)
		mem_fw_writereg,	// Gravar registro do Final do Execute

		// Writeback
		wb_fw_wbvalue,    // Valor a ser gravado no Writeback vindo do Final do Memory
		wb_fw_writereg	// Gravar registro do Final do Memory
	
	);

	// inserir aqui os regs
	reg clock, reset;

	// FW <-> Fetch
	wire              fw_if_id_stall;   // Stall em PC, Fetch e Decode para FW de instruções seguinte a loads com dep. de dados

	// FW <-> Decode
	reg         [4:0] id_fw_regdest;	// Registrador de destino
	reg               id_fw_load;		// Instrução de Load ? (equivale a sinal readmem)
	reg         [4:0] id_fw_addra;		// Address A
	reg         [4:0] id_fw_addrb;		// Address B
	reg        [31:0] id_fw_rega;		// Registrador A lido
	reg        [31:0] id_fw_regb;		// Registrador B lido
	wire       [31:0] fw_id_rega;		// Valores enviados ao Execute com tratamento de conflito de dados
	wire       [31:0] fw_id_regb;
	
	// FW <-> Execute
	reg        [31:0] ex_fw_wbvalue;	// Valor a ser gravado no Writeback vindo do Pré-Execute (posedge)
	reg               ex_fw_writereg;	// Gravar registro do Pré-Execute
	
	// FW <-> Memory
	reg        [31:0] mem_fw_wbvalue;	// Valor a ser gravado no Writeback vindo do Final do Execute (negedge)
	reg               mem_fw_writereg;	// Gravar registro do Final do Execute

	// FW <-> Writeback
	reg        [31:0] wb_fw_wbvalue;    // Valor a ser gravado no Writeback vindo do Final do Memory
	reg               wb_fw_writereg;	// Gravar registro do Final do Memory

	reg [3:0] contador_tst;
	
	always #10 clock = ~clock;
	
/*
	 ID  | EX  | MEM | WB  ADRRs:  A  |  B    HZ
1    5   |     |     |   	       3  |  4    -
2    6   | 5   |     |             5  |  2    EX
3    30  | 6   | 5   |   	       6  |  5    EX, MEM
4    6   | 30  | 6   | 5 	       8  |  9    -
5    7   | 6   | 30  | 6 	       6  |  1    EX
6    16  | 7   | 6   | 30	       30 |  6    MEM, WB
7        |     |     |   	          |       
*/	
	
	always@(negedge clock or posedge reset)
	begin
	  if(reset)
	  	begin
	  		contador_tst = 4'b0;	      
	  	end
	 	else
	 	  begin
	 	  	if(contador_tst <= 4'd7)
	 	  		begin
	 	  			contador_tst = contador_tst + 4'b1;
	 	  		end
	 	  	else
				begin
					contador_tst = 4'bx;
					$finish;
				end

			case(contador_tst)
				1: // ID -> FW
				begin
					id_fw_regdest   = 5'd5;
					id_fw_load      = 0;
					id_fw_addra     = 5'd3;
					id_fw_addrb     = 5'd4;
					id_fw_rega      = 32'h1111111a;
					id_fw_regb      = 32'h1111111b;

					ex_fw_wbvalue   = 32'hEEEEEEEE;
					ex_fw_writereg  = 1;
					mem_fw_wbvalue  = 32'hCCCCCCCC;
					mem_fw_writereg = 1;
					wb_fw_wbvalue   = 32'hFFFFFFFF;
					wb_fw_writereg  = 1;

					$display("ciclo: %d", contador_tst);

					$display(" ID | EX | MEM | WB ");
					$display(" %d | %d | %d  | %d", forwarding.TableFW[0], forwarding.TableFW[1], forwarding.TableFW[2], forwarding.TableFW[3]);
					$display("(negedge)");
					$display("ID -> FW (negedge)");
					$display("id_fw_regdest : %d", id_fw_regdest);
					$display("id_fw_load    : %b", id_fw_load);
					$display("id_fw_addra   : %d", id_fw_addra);
					$display("id_fw_addrb   : %d", id_fw_addrb);
					$display("id_fw_rega    : %h", id_fw_rega);
					$display("id_fw_regb    : %h", id_fw_regb);

					$display("ex_fw_wbvalue   : %h", ex_fw_wbvalue);
					$display("ex_fw_writereg  : %b", ex_fw_writereg);
					$display("mem_fw_wbvalue  : %h", mem_fw_wbvalue);
					$display("mem_fw_writereg : %b", mem_fw_writereg);
					$display("wb_fw_wbvalue   : %h", wb_fw_wbvalue);
					$display("wb_fw_writereg  : %b", wb_fw_writereg);
				end

				2: // ID -> FW
				begin
				#1
				$display;
				//$display("(posedge)");
				$display("fw(rega)       : %h", fw_id_rega);
				$display("fw(regb)       : %h", fw_id_regb);
				$display("fw_if_id_stall : %b", fw_if_id_stall);
				$display;

					// Teste 2
					id_fw_regdest   = 5'd6;
					id_fw_load      = 0;
					id_fw_addra     = 5'd5;
					id_fw_addrb     = 5'd2;
					id_fw_rega      = 32'h2222222a;
					id_fw_regb      = 32'h2222222b;

					ex_fw_wbvalue   = 32'hEEEEEEEE;
					ex_fw_writereg  = 1;
					mem_fw_wbvalue  = 32'hCCCCCCCC;
					mem_fw_writereg = 1;
					wb_fw_wbvalue   = 32'hFFFFFFFF;
					wb_fw_writereg  = 1;
	
					$display("ciclo: %d", contador_tst);

					$display(" ID | EX | MEM | WB ");
					$display(" %d | %d | %d  | %d", forwarding.TableFW[0], forwarding.TableFW[1], forwarding.TableFW[2], forwarding.TableFW[3]);
					$display("(negedge)");
					$display("ID -> FW (negedge)");
					$display("id_fw_regdest : %d", id_fw_regdest);
					$display("id_fw_load    : %b", id_fw_load);
					$display("id_fw_addra   : %d", id_fw_addra);
					$display("id_fw_addrb   : %d", id_fw_addrb);
					$display("id_fw_rega    : %h", id_fw_rega);
					$display("id_fw_regb    : %h", id_fw_regb);

					$display("ex_fw_wbvalue   : %h", ex_fw_wbvalue);
					$display("ex_fw_writereg  : %b", ex_fw_writereg);
					$display("mem_fw_wbvalue  : %h", mem_fw_wbvalue);
					$display("mem_fw_writereg : %b", mem_fw_writereg);
					$display("wb_fw_wbvalue   : %h", wb_fw_wbvalue);
					$display("wb_fw_writereg  : %b", wb_fw_writereg);
				end

				3: // ID -> FW
				begin
				#1
				$display;
				//$display("(posedge)");
				$display("fw(rega)       : %h", fw_id_rega);
				$display("fw(regb)       : %h", fw_id_regb);
				$display("fw_if_id_stall : %b", fw_if_id_stall);
				$display;

					// Teste 3
					id_fw_regdest   = 5'd30;
					id_fw_load      = 0;
					id_fw_addra     = 5'd6;
					id_fw_addrb     = 5'd5;
					id_fw_rega      = 32'h3333333a;
					id_fw_regb      = 32'h3333333b;

					ex_fw_wbvalue   = 32'hEEEEEEEE;
					ex_fw_writereg  = 1;
					mem_fw_wbvalue  = 32'hCCCCCCCC;
					mem_fw_writereg = 1;
					wb_fw_wbvalue   = 32'hFFFFFFFF;
					wb_fw_writereg  = 1;
	
					$display("ciclo: %d", contador_tst);
	
					$display(" ID | EX | MEM | WB ");
					$display(" %d | %d | %d  | %d", forwarding.TableFW[0], forwarding.TableFW[1], forwarding.TableFW[2], forwarding.TableFW[3]);
					$display("(negedge)");
					$display("ID -> FW (negedge)");
					$display("id_fw_regdest : %d", id_fw_regdest);
					$display("id_fw_load    : %b", id_fw_load);
					$display("id_fw_addra   : %d", id_fw_addra);
					$display("id_fw_addrb   : %d", id_fw_addrb);
					$display("id_fw_rega    : %h", id_fw_rega);
					$display("id_fw_regb    : %h", id_fw_regb);

					$display("ex_fw_wbvalue   : %h", ex_fw_wbvalue);
					$display("ex_fw_writereg  : %b", ex_fw_writereg);
					$display("mem_fw_wbvalue  : %h", mem_fw_wbvalue);
					$display("mem_fw_writereg : %b", mem_fw_writereg);
					$display("wb_fw_wbvalue   : %h", wb_fw_wbvalue);
					$display("wb_fw_writereg  : %b", wb_fw_writereg);
				end

				4: // ID -> FW
				begin
				#1
				$display;
				//$display("(posedge)");
				$display("fw(rega)       : %h", fw_id_rega);
				$display("fw(regb)       : %h", fw_id_regb);
				$display("fw_if_id_stall : %b", fw_if_id_stall);
				$display;

					id_fw_regdest   = 5'd6;
					id_fw_load      = 0;
					id_fw_addra     = 5'd8;
					id_fw_addrb     = 5'd9;
					id_fw_rega      = 32'h4444444a;
					id_fw_regb      = 32'h4444444b;

					ex_fw_wbvalue   = 32'hEEEEEEEE;
					ex_fw_writereg  = 1;
					mem_fw_wbvalue  = 32'hCCCCCCCC;
					mem_fw_writereg = 1;
					wb_fw_wbvalue   = 32'hFFFFFFFF;
					wb_fw_writereg  = 1;

					$display("ciclo: %d", contador_tst);
	
					$display(" ID | EX | MEM | WB ");
					$display(" %d | %d | %d  | %d", forwarding.TableFW[0], forwarding.TableFW[1], forwarding.TableFW[2], forwarding.TableFW[3]);
					$display("(negedge)");
					$display("ID -> FW (negedge)");
					$display("id_fw_regdest : %d", id_fw_regdest);
					$display("id_fw_load    : %b", id_fw_load);
					$display("id_fw_addra   : %d", id_fw_addra);
					$display("id_fw_addrb   : %d", id_fw_addrb);
					$display("id_fw_rega    : %h", id_fw_rega);
					$display("id_fw_regb    : %h", id_fw_regb);

					$display("ex_fw_wbvalue   : %h", ex_fw_wbvalue);
					$display("ex_fw_writereg  : %b", ex_fw_writereg);
					$display("mem_fw_wbvalue  : %h", mem_fw_wbvalue);
					$display("mem_fw_writereg : %b", mem_fw_writereg);
					$display("wb_fw_wbvalue   : %h", wb_fw_wbvalue);
					$display("wb_fw_writereg  : %b", wb_fw_writereg);
				end

				5: // ID -> FW
				begin
				#1
				$display;
				//$display("(posedge)");
				$display("fw(rega)       : %h", fw_id_rega);
				$display("fw(regb)       : %h", fw_id_regb);
				$display("fw_if_id_stall : %b", fw_if_id_stall);
				$display;

					id_fw_regdest   = 5'd7;
					id_fw_load      = 0;
					id_fw_addra     = 5'd6;
					id_fw_addrb     = 5'd1;
					id_fw_rega      = 32'h5555555a;
					id_fw_regb      = 32'h5555555b;
					
					ex_fw_wbvalue   = 32'hEEEEEEEE;
					ex_fw_writereg  = 1;
					mem_fw_wbvalue  = 32'hCCCCCCCC;
					mem_fw_writereg = 1;
					wb_fw_wbvalue   = 32'hFFFFFFFF;
					wb_fw_writereg  = 1;
					
					$display("ciclo: %d", contador_tst);

					$display(" ID | EX | MEM | WB ");
					$display(" %d | %d | %d  | %d", forwarding.TableFW[0], forwarding.TableFW[1], forwarding.TableFW[2], forwarding.TableFW[3]);
					$display("(negedge)");
					$display("ID -> FW (negedge)");
					$display("id_fw_regdest : %d", id_fw_regdest);
					$display("id_fw_load    : %b", id_fw_load);
					$display("id_fw_addra   : %d", id_fw_addra);
					$display("id_fw_addrb   : %d", id_fw_addrb);
					$display("id_fw_rega    : %h", id_fw_rega);
					$display("id_fw_regb    : %h", id_fw_regb);

					$display("ex_fw_wbvalue   : %h", ex_fw_wbvalue);
					$display("ex_fw_writereg  : %b", ex_fw_writereg);
					$display("mem_fw_wbvalue  : %h", mem_fw_wbvalue);
					$display("mem_fw_writereg : %b", mem_fw_writereg);
					$display("wb_fw_wbvalue   : %h", wb_fw_wbvalue);
					$display("wb_fw_writereg  : %b", wb_fw_writereg);
				end

				6: // ID -> FW
				begin
				#1
				$display;
				//$display("(posedge)");
				$display("fw(rega)       : %h", fw_id_rega);
				$display("fw(regb)       : %h", fw_id_regb);
				$display("fw_if_id_stall : %b", fw_if_id_stall);
				$display;

					id_fw_regdest   = 5'd16;
					id_fw_load      = 0;
					id_fw_addra     = 5'd30;
					id_fw_addrb     = 5'd6;
					id_fw_rega      = 32'h6666666a;
					id_fw_regb      = 32'h6666666b;

					ex_fw_wbvalue   = 32'hEEEEEEEE;
					ex_fw_writereg  = 1;
					mem_fw_wbvalue  = 32'hCCCCCCCC;
					mem_fw_writereg = 1;
					wb_fw_wbvalue   = 32'hFFFFFFFF;
					wb_fw_writereg  = 1;

					$display("ciclo: %d", contador_tst);

					$display(" ID | EX | MEM | WB ");
					$display(" %d | %d | %d  | %d", forwarding.TableFW[0], forwarding.TableFW[1], forwarding.TableFW[2], forwarding.TableFW[3]);
					$display("(negedge)");
					$display("ID -> FW (negedge)");
					$display("id_fw_regdest : %d", id_fw_regdest);
					$display("id_fw_load    : %b", id_fw_load);
					$display("id_fw_addra   : %d", id_fw_addra);
					$display("id_fw_addrb   : %d", id_fw_addrb);
					$display("id_fw_rega    : %h", id_fw_rega);
					$display("id_fw_regb    : %h", id_fw_regb);

					$display("ex_fw_wbvalue   : %h", ex_fw_wbvalue);
					$display("ex_fw_writereg  : %b", ex_fw_writereg);
					$display("mem_fw_wbvalue  : %h", mem_fw_wbvalue);
					$display("mem_fw_writereg : %b", mem_fw_writereg);
					$display("wb_fw_wbvalue   : %h", wb_fw_wbvalue);
					$display("wb_fw_writereg  : %b", wb_fw_writereg);
				end

				7: // ID -> FW
				begin
				#1
				$display;
				//$display("(posedge)");
				$display("fw(rega)       : %h", fw_id_rega);
				$display("fw(regb)       : %h", fw_id_regb);
				$display("fw_if_id_stall : %b", fw_if_id_stall);
				$display;
				end

			endcase

	 	  end
	end

/*
	always@(posedge clock)
	begin
		case(contador_tst)
			1:
			begin

			end

			2:
			begin
				$display;
				$display("(posedge)");
				$display("fw(rega)       : %h", fw_id_rega);
				$display("fw(regb)       : %h", fw_id_regb);
				$display("fw_if_id_stall : %b", fw_if_id_stall);
				$display;
			end

			3:
			begin
				$display;
				$display("(posedge)");
				$display("fw(rega)       : %h", fw_id_rega);
				$display("fw(regb)       : %h", fw_id_regb);
				$display("fw_if_id_stall : %b", fw_if_id_stall);
				$display;`			
			end

			4:
			begin
				$display;
				$display("(posedge)");
				$display("fw(rega)       : %h", fw_id_rega);
				$display("fw(regb)       : %h", fw_id_regb);
				$display("fw_if_id_stall : %b", fw_if_id_stall);
				$display;`			
			end

			5:
			begin
				$display;
				$display("(posedge)");
				$display("fw(rega)       : %h", fw_id_rega);
				$display("fw(regb)       : %h", fw_id_regb);
				$display("fw_if_id_stall : %b", fw_if_id_stall);
				$display;`			
			end

			6:
			begin
				$display;
				$display("(posedge)");
				$display("fw(rega)       : %h", fw_id_rega);
				$display("fw(regb)       : %h", fw_id_regb);
				$display("fw_if_id_stall : %b", fw_if_id_stall);
				$display;`			
			end
		endcase
	end
*/
	initial
	begin
		$display("Valores de pipeline utilizados no teste:");
		$display;
		$display("     ID  | EX  | MEM | WB   ADRRs :  A  |  B    HZ      ");
		$display("1    5   |     |     |               3  |  4    -       ");
		$display("2    6   | 5   |     |               5  |  2    EX      ");
 		$display("3    30  | 6   | 5   |               6  |  5    EX, MEM ");
 		$display("4    6   | 30  | 6   | 5             8  |  9    -       ");
 		$display("5    7   | 6   | 30  | 6             6  |  1    EX      ");
 		$display("6    16  | 7   | 6   | 30            30 |  6    MEM, WB ");
 		$display("7        |     |     |                  |               "); 
		$display;

		#1 reset = 0;
		#1 reset = 1;
		#1 reset = 0;
		
		#1 clock = 0;
	end

endmodule
