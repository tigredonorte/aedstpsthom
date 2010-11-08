`include "../rtl/Writeback.v"

module tb_writeback();

	Writeback writeback(

		.clock(clock),
	
		// Memory
		.mem_wb_regdest(mem_wb_regdest),
		.mem_wb_writereg(mem_wb_writereg),
		.mem_wb_wbvalue(mem_wb_wbvalue),

		// Registers
		.wb_reg_en(w_wb_reg_en),			// Enable do banco de registradores
		.wb_reg_addr(w_wb_reg_addr),      // Endereco do registrador a ser escrito
		.wb_reg_data(w_wb_reg_data),      // dado a ser gravado no registrador
	
		// Forwarding
		.wb_fw_wbvalue(w_wb_fw_wbvalue),    // Valor vindo de Memory para ser enviado ao módulo de FW
		.wb_fw_writereg(w_wb_fw_writereg)
	
	);

	// inserir aqui os regs
	reg clock, reset;
	reg [4:0] mem_wb_regdest;
	reg mem_wb_writereg;
	reg [31:0] mem_wb_wbvalue;

	// Registers
	wire w_wb_reg_en;				// Enable do banco de registradores
	wire [4:0] w_wb_reg_addr;      // Endereco do registrador a ser escrito
	wire [31:0] w_wb_reg_data;      // dado a ser gravado no registrador
	
	// Forwarding
	wire [31:0] w_wb_fw_wbvalue;    // Valor vindo de Memory para ser enviado ao módulo de FW
	wire w_wb_fw_writereg;

	reg [3:0] contador_tst;
	
	always #1 clock = ~clock;
	
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

			case(contador_tst)
				1: // Entradas para gravar no registrador 2.
				begin
					mem_wb_regdest  = 5'd2;
					mem_wb_writereg = 1;
					mem_wb_wbvalue  = 32'hFFFFA0EE;
				end

				2:
				begin
					// Resultado do 1o. ciclo
					$display("Registradores (negedge):");
					$display("en   : %b", w_wb_reg_en);
					$display("addr : %d", w_wb_reg_addr);
					$display("data : %h", w_wb_reg_data);
					$display;

					// Entrada do 2o. ciclo
					mem_wb_regdest  = 5'd30;
					mem_wb_writereg = 0;
					mem_wb_wbvalue  = 32'h5538A0AB;
				end

				3:
				begin
					// Resultado do 2o. ciclo
					$display("Registradores (negedge):");
					$display("en   : %b", w_wb_reg_en);
					$display("addr : %d", w_wb_reg_addr);
					$display("data : %h", w_wb_reg_data);
					$display;
						
					mem_wb_regdest  = 5'd8;
					mem_wb_writereg = 1;
					mem_wb_wbvalue  = 32'h07E8A0EE;
				end

				4:
				begin
					// Resultado do 3o. ciclo
					$display("Registradores (negedge):");
					$display("en   : %b", w_wb_reg_en);
					$display("addr : %d", w_wb_reg_addr);
					$display("data : %h", w_wb_reg_data);
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
				$display("Resultado do 1o. ciclo:");
				$display("Forwarding (wire):");
				$display("wbvalue  : %h", w_wb_fw_wbvalue);
				$display("writereg : %b", w_wb_fw_writereg);
				$display;
			end

			2:
			begin
				$display("Resultado do 2o. ciclo:");
				$display("Forwarding (wire):");
				$display("wbvalue  : %h", w_wb_fw_wbvalue);
				$display("writereg : %b", w_wb_fw_writereg);
				$display;
			end

			3:
			begin
				$display("Resultado do 3o. ciclo:");
				$display("Forwarding (wire):");
				$display("wbvalue  : %h", w_wb_fw_wbvalue);
				$display("writereg : %b", w_wb_fw_writereg);
				$display;
			end

			4:
			begin
				$display;
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
