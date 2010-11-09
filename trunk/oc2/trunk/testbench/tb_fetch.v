`include "../rtl/Fetch.v"

module tb_fetch (); 

	reg               clock;
	reg               reset;
	reg               reset_fetch;
	reg               teste_clock;

	// Execute -> Fetch
	reg               ex_if_stall;

	// Forwarding -> Fetch
	reg               fw_if_id_stall;

	// Fetch -> Decode
	wire       [31:0] if_id_proximopc;
	wire       [31:0] if_id_instrucao;

	// Decode -> Fetch
	reg               id_if_selfontepc;
	reg        [31:0] id_if_rega; 
	reg        [31:0] id_if_pcimd2ext;
	reg        [31:0] id_if_pcindex;
	reg         [1:0] id_if_seltipopc;

	// Fetch <-> MemController
	wire              if_gdm_en;
	wire       [31:0] if_gdm_addr;
	wire       [31:0] mc_if_data;

	// Memory
/*	reg               mem_gdm_rw;
	reg               mem_gdm_en;
	reg        [31:0] mem_gdm_addr;
	wire       [31:0] mem_gdm_data;
	reg               mem_gdm_mshw;
	reg               mem_gdm_lshw;
	
	// Ram
	wire       [31:0] mc_ram_addr;
	wire              mc_ram_rw1;
	wire              mc_ram_en1;
	wire       [15:0] mc_ram_data1;
	wire              mc_ram_rw2;
	wire              mc_ram_en2;
	wire       [15:0] mc_ram_data2;*/

	Fetch fetch(
		.clock(clock),
		.reset(reset_fetch),

   	// Execute
		.ex_if_stall(ex_if_stall),

		// Forwarding
		.fw_if_id_stall(fw_if_id_stall),

		// Decode
		.if_id_proximopc(if_id_proximopc),
		.if_id_instrucao(if_id_instrucao),
		.id_if_selfontepc(id_if_selfontepc),
		.id_if_rega(id_if_rega),
		.id_if_pcimd2ext(id_if_pcimd2ext),
		.id_if_pcindex(id_if_pcindex),
		.id_if_seltipopc(id_if_seltipopc),

		// MC
		.if_gdm_en(if_gdm_en),
		.if_gdm_addr(if_gdm_addr),
		.gdm_if_data(gdm_if_data)
	);


	reg [4:0] contador_tst;

	always #1
	begin
		if(teste_clock == 1)
		begin
			clock = ~clock;
		end
	end

	always@(negedge clock or posedge reset)
	begin
	  if(reset)
	  	begin
	  		contador_tst = 5'b0;	      
	  	end
	 	else
			if(teste_clock == 1)
		  	begin
	 			begin
			  		if(contador_tst <= 13)
					begin
						if(contador_tst >= 3)
						begin
							$display("-- Valores apos nedge anterior:");
							$display(" if_id_proximopc : %d", if_id_proximopc);
							$display(" if_id_instrucao : %h", if_id_instrucao);
							//$display(" fetch.pc        : %d", fetch.pc);
						end
		 	  			contador_tst = contador_tst + 5'b1;
	 		  		end
		 	  		else
	 	  		  		contador_tst = 5'bx;
				end
			end
	end
		
	always@(posedge clock)
	begin
		if(teste_clock == 1)
		begin
			if(contador_tst >= 1 && contador_tst <= 13)	
				$display("Ciclo de clock: %d", contador_tst);

			case(contador_tst)

			1:
			begin
				reset_fetch = 1;
				$display("reset = 1");
			end

			2:
			begin
				reset_fetch = 0;
				$display("reset = 0");
			end

			3:
			begin
				$display("// PC = 0, serah incrementado em 4.");
				ex_if_stall      = 0;
				fw_if_id_stall   = 0;
				id_if_selfontepc = 0;
				id_if_rega       = 32'hAAAAAAAA;
				id_if_pcimd2ext  = 32'hEEEEEEEE;
				id_if_pcindex    = 32'hBBBBBBBB;
				id_if_seltipopc  = 0;

				$display("if_gdm_en    : %b", if_gdm_en);
				$display("if_gdm_addr  : %d", if_gdm_addr);
			end
    
			4:
			begin
				$display("// PC = 4, apos incremento serah 8.");
				ex_if_stall      = 0;
				fw_if_id_stall   = 0;
				id_if_selfontepc = 0;
				id_if_rega       = 32'hAAAAAAAA;
				id_if_pcimd2ext  = 32'hEEEEEEEE;
				id_if_pcindex    = 32'hBBBBBBBB;
				id_if_seltipopc  = 0;

				$display("if_gdm_en    : %b", if_gdm_en);
				$display("if_gdm_addr  : %d", if_gdm_addr);
			end
			
			5:
			begin
				$display("// PC = 8, assumirá valor de id_if_rega (100).");
				ex_if_stall      = 0;
				fw_if_id_stall   = 0;
				id_if_selfontepc = 1; // branch ou jump
				id_if_rega       = 32'd100;
				id_if_pcimd2ext  = 32'hEEEEEEEE;
				id_if_pcindex    = 32'hBBBBBBBB;
				id_if_seltipopc  = 1; // reg A

				$display("if_gdm_en    : %b", if_gdm_en);
				$display("if_gdm_addr  : %d", if_gdm_addr);
			end

			6:
			begin
				$display("// PC = 100, serah incrementado em 4 (104).");
				ex_if_stall      = 0;
				fw_if_id_stall   = 0;
				id_if_selfontepc = 0; // Fluxo normal
				id_if_rega       = 32'hAAAAAAAA;
				id_if_pcimd2ext  = 32'hEEEEEEEE;
				id_if_pcindex    = 32'hBBBBBBBB;
				id_if_seltipopc  = 0; // don't care

				$display("if_gdm_en    : %b", if_gdm_en);
				$display("if_gdm_addr  : %d", if_gdm_addr);
			end

			7:
			begin
				$display("// PC = 104, assumirá valor de id_if_pcimd2ext (200).");
				ex_if_stall      = 0;
				fw_if_id_stall   = 0;
				id_if_selfontepc = 1; // branch ou jump
				id_if_rega       = 32'hAAAAAAAA;
				id_if_pcimd2ext  = 32'd200;     
				id_if_pcindex    = 32'hBBBBBBBB;
				id_if_seltipopc  = 0; // pcimd2ext

				$display("if_gdm_en    : %b", if_gdm_en);
				$display("if_gdm_addr  : %d", if_gdm_addr);
			end

			8:
			begin
				$display("// PC = 200, serah incrementado em 4 (204).");
				ex_if_stall      = 0;
				fw_if_id_stall   = 0;
				id_if_selfontepc = 0; // Fluxo normal
				id_if_rega       = 32'hAAAAAAAA;
				id_if_pcimd2ext  = 32'hEEEEEEEE;     
				id_if_pcindex    = 32'hBBBBBBBB;
				id_if_seltipopc  = 0; // don't care

				$display("if_gdm_en    : %b", if_gdm_en);
				$display("if_gdm_addr  : %d", if_gdm_addr);
			end

			9:
			begin
				$display("// PC = 204, assumirá o valor de id_if_pcindex (300).");
				ex_if_stall      = 0;
				fw_if_id_stall   = 0;
				id_if_selfontepc = 1; // branch ou jump
				id_if_rega       = 32'hAAAAAAAA;
				id_if_pcimd2ext  = 32'hEEEEEEEE;
				id_if_pcindex    = 32'd300;
				id_if_seltipopc  = 2; // pcindex

				$display("if_gdm_en    : %b", if_gdm_en);
				$display("if_gdm_addr  : %d", if_gdm_addr);
			end

			10:
			begin
				$display("// PC = 300, serah incrementado em 4 (304).");
				ex_if_stall      = 0;
				fw_if_id_stall   = 0;
				id_if_selfontepc = 0; // Fluxo normal  
				id_if_rega       = 32'hAAAAAAAA;
				id_if_pcimd2ext  = 32'hEEEEEEEE;
				id_if_pcindex    = 32'hBBBBBBBB;
				id_if_seltipopc  = 0; // don't care

				$display("if_gdm_en    : %b", if_gdm_en);
				$display("if_gdm_addr  : %d", if_gdm_addr);
			end

			11:
			begin
				$display("// PC = 304, assumirá valor 64.");
				ex_if_stall      = 0;
				fw_if_id_stall   = 0;
				id_if_selfontepc = 1; // branch ou jump
				id_if_rega       = 32'hAAAAAAAA;
				id_if_pcimd2ext  = 32'hEEEEEEEE;
				id_if_pcindex    = 32'hBBBBBBBB; 
				id_if_seltipopc  = 3; // 32'd64;

				$display("if_gdm_en    : %b", if_gdm_en);
				$display("if_gdm_addr  : %d", if_gdm_addr);
			end

			12:
			begin
				$display("// PC = 64, serah incrementado em 4 (68).");
				ex_if_stall      = 0;
				fw_if_id_stall   = 0;
				id_if_selfontepc = 0; // Fluxo normal
				id_if_rega       = 32'hAAAAAAAA;
				id_if_pcimd2ext  = 32'hEEEEEEEE;
				id_if_pcindex    = 32'hBBBBBBBB; 
				id_if_seltipopc  = 0; // don't care

				$display("if_gdm_en    : %b", if_gdm_en);
				$display("if_gdm_addr  : %d", if_gdm_addr);
			end

			13:
			begin
				$display("// PC = 68, serah incrementado em 4 (72).");
				ex_if_stall      = 0;
				fw_if_id_stall   = 0;
				id_if_selfontepc = 0; // Fluxo normal
				id_if_rega       = 32'hAAAAAAAA;
				id_if_pcimd2ext  = 32'hEEEEEEEE;
				id_if_pcindex    = 32'hBBBBBBBB; 
				id_if_seltipopc  = 0; // don't care

				$display("if_gdm_en    : %b", if_gdm_en);
				$display("if_gdm_addr  : %d", if_gdm_addr);
			end

	    endcase
		end
		
	end

	initial
	begin

		teste_clock = 1;

		$display("xxxxxxxxxxxxxxxxxxxx TESTE COM O CLOCK xxxxxxxxxxxxxxxxxxxxxx");
		#1 reset = 0;
		   reset_fetch = 0;

		#1 reset = 1;
		#1 reset = 0;
		
		#1 clock = 0;

		#60

		#1 $finish;

	end

endmodule
