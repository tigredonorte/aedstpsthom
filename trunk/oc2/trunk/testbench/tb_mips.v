`include "../rtl/Mips.v"
`include "../rtl/MemController.v"
`include "../rtl/Ram.v"

/**
 * Pacote MIPS32 Pipeline sem Cache
 * José Augusto Nacif - jnacif@dcc.ufmg.br
 * Thiago Sousa F. Silva - thiagosf@dcc.ufmg.br
 * 28/10/2009
 */

module tb_mips();

	// Fetch <-> MemController
	wire              if_mc_en;	
	wire       [31:0] if_mc_addr;	
	wire       [31:0] mc_if_data;

	// Memory <-> MemController
	wire              mem_mc_rw;
	wire              mem_mc_en;
	wire       [31:0] mem_mc_addr; 
	wire       [31:0] mem_mc_data;
	wire              mem_mc_en1h;
	wire              mem_mc_en1l;
	wire              mem_mc_en2h;
	wire              mem_mc_en2l;

	wire       [31:0] mc_ram_addr;
	wire              mc_ram_rw;
	wire              mc_ram_en1h;
	wire        [7:0] mc_ram_data1h;
	wire              mc_ram_en1l;
	wire        [7:0] mc_ram_data1l;
	wire              mc_ram_en2h;
	wire        [7:0] mc_ram_data2h;
	wire              mc_ram_en2l;
	wire        [7:0] mc_ram_data2l;

	Mips MIPS(

		.clock         (clock),
		.reset         (reset),
		                   
		// Fetch <-> MemController   
		.if_mc_en 	   (if_mc_en),	
		.if_mc_addr   (if_mc_addr), 
		.mc_if_data   (mc_if_data),
                                        
		// Memory <-> MemController  
		.mem_mc_rw    (mem_mc_rw),
		.mem_mc_en    (mem_mc_en),
		.mem_mc_addr  (mem_mc_addr),
		.mem_mc_data  (mem_mc_data),
		.mem_mc_en1h  (mem_mc_en1h),
		.mem_mc_en1l  (mem_mc_en1l),
		.mem_mc_en2h  (mem_mc_en2h),
		.mem_mc_en2l  (mem_mc_en2l)

	);

	MemController MC(

		// MemController <-> Fetch   
		.if_mc_en      (if_mc_en),
		.if_mc_addr    (if_mc_addr),
		.mc_if_data    (mc_if_data),
	                                         
		// MemController <-> Memory  
		.mem_mc_rw     (mem_mc_rw),
		.mem_mc_en     (mem_mc_en),
		.mem_mc_addr   (mem_mc_addr),
		.mem_mc_data   (mem_mc_data),
		.mem_mc_en1h   (mem_mc_en1h),
		.mem_mc_en1l   (mem_mc_en1l),
		.mem_mc_en2h   (mem_mc_en2h),
		.mem_mc_en2l   (mem_mc_en2l),
	                                         
		// Ram             
		.mc_ram_addr   (mc_ram_addr),
		.mc_ram_rw     (mc_ram_rw),
		.mc_ram_en1h   (mc_ram_en1h),
		.mc_ram_data1h (mc_ram_data1h),
		.mc_ram_en1l   (mc_ram_en1l),
		.mc_ram_data1l (mc_ram_data1l),
		.mc_ram_en2h   (mc_ram_en2h),
		.mc_ram_data2h (mc_ram_data2h),
		.mc_ram_en2l   (mc_ram_en2l),
		.mc_ram_data2l (mc_ram_data2l)

	);

	Ram RAM(

		.clock   (clock),
		.reset   (reset),
	
		// Gerenciadores de memória
		.addr    (mc_ram_addr),
		.rw      (mc_ram_rw),
		.en1h    (mc_ram_en1h),
		.data1h  (mc_ram_data1h),
		.en1l    (mc_ram_en1l),
		.data1l  (mc_ram_data1l),
		.en2h    (mc_ram_en2h),
		.data2h  (mc_ram_data2h),
		.en2l    (mc_ram_en2l),
		.data2l  (mc_ram_data2l)
	
	);

	reg clock;
	reg reset;

	reg [31:0] contador_tst;
	
	always #10 clock = ~clock;

	always@(negedge clock or posedge reset)
	begin
	  if(reset)
	  	begin
	  		contador_tst = 32'b0;
	  	end
	 	else
	 	  begin
	 	  	if(contador_tst <= 32'd30)
	 	  		begin
	 	  			contador_tst = contador_tst + 32'b1;
	 	  		end
	 	  	else
				begin
					contador_tst = 32'bx;

					$display("Reg[ 0] : %h\tReg[16] : %h", MIPS.REGS.Registers[ 0], MIPS.REGS.Registers[16]);
					$display("Reg[ 1] : %h\tReg[17] : %h", MIPS.REGS.Registers[ 1], MIPS.REGS.Registers[17]);
					$display("Reg[ 2] : %h\tReg[18] : %h", MIPS.REGS.Registers[ 2], MIPS.REGS.Registers[18]);
					$display("Reg[ 3] : %h\tReg[19] : %h", MIPS.REGS.Registers[ 3], MIPS.REGS.Registers[19]);
					$display("Reg[ 4] : %h\tReg[20] : %h", MIPS.REGS.Registers[ 4], MIPS.REGS.Registers[20]);
					$display("Reg[ 5] : %h\tReg[21] : %h", MIPS.REGS.Registers[ 5], MIPS.REGS.Registers[21]);
					$display("Reg[ 6] : %h\tReg[22] : %h", MIPS.REGS.Registers[ 6], MIPS.REGS.Registers[22]);
					$display("Reg[ 7] : %h\tReg[23] : %h", MIPS.REGS.Registers[ 7], MIPS.REGS.Registers[23]);
					$display("Reg[ 8] : %h\tReg[24] : %h", MIPS.REGS.Registers[ 8], MIPS.REGS.Registers[24]);
					$display("Reg[ 9] : %h\tReg[25] : %h", MIPS.REGS.Registers[ 9], MIPS.REGS.Registers[25]);
					$display("Reg[10] : %h\tReg[26] : %h", MIPS.REGS.Registers[10], MIPS.REGS.Registers[26]);
					$display("Reg[11] : %h\tReg[27] : %h", MIPS.REGS.Registers[11], MIPS.REGS.Registers[27]);
					$display("Reg[12] : %h\tReg[28] : %h", MIPS.REGS.Registers[12], MIPS.REGS.Registers[28]);
					$display("Reg[13] : %h\tReg[29] : %h", MIPS.REGS.Registers[13], MIPS.REGS.Registers[29]);
					$display("Reg[14] : %h\tReg[30] : %h", MIPS.REGS.Registers[14], MIPS.REGS.Registers[30]);
					$display("Reg[15] : %h\tReg[31] : %h", MIPS.REGS.Registers[15], MIPS.REGS.Registers[31]);
					$display;
					$display;

					$display("Memoria[ 0] : %h%h %h%h", RAM.Memory[ 0], RAM.Memory[ 1], RAM.Memory[ 2], RAM.Memory[ 3]);
					$display("Memoria[ 4] : %h%h %h%h", RAM.Memory[ 4], RAM.Memory[ 5], RAM.Memory[ 6], RAM.Memory[ 7]);
					$display("Memoria[ 8] : %h%h %h%h", RAM.Memory[ 8], RAM.Memory[ 9], RAM.Memory[10], RAM.Memory[11]);
					$display("Memoria[12] : %h%h %h%h", RAM.Memory[12], RAM.Memory[13], RAM.Memory[14], RAM.Memory[15]);
					$display("Memoria[16] : %h%h %h%h", RAM.Memory[16], RAM.Memory[17], RAM.Memory[18], RAM.Memory[19]);
					$display("Memoria[20] : %h%h %h%h", RAM.Memory[20], RAM.Memory[21], RAM.Memory[22], RAM.Memory[23]);
					$display("Memoria[24] : %h%h %h%h", RAM.Memory[24], RAM.Memory[25], RAM.Memory[26], RAM.Memory[27]);
					$display("Memoria[28] : %h%h %h%h", RAM.Memory[28], RAM.Memory[29], RAM.Memory[30], RAM.Memory[31]);
					$display("Memoria[32] : %h%h %h%h", RAM.Memory[32], RAM.Memory[33], RAM.Memory[34], RAM.Memory[35]);
					$display("Memoria[36] : %h%h %h%h", RAM.Memory[36], RAM.Memory[37], RAM.Memory[38], RAM.Memory[39]);

					$finish;
				end
		  end
	end
/*
	always@(posedge clock)
	begin
		$display("(posedge)");
		$display("PC: %d", MIPS.FETCH.pc);
	end
*/
	always@(negedge clock)
	begin
		$display;
		$display("ciclo: %d", contador_tst);
		$display("(negedge)");
		$display("PC: %d", MIPS.FETCH.pc);

		#1
//		$display("CASS %h %h %h", mc_ram_addr, MIPS.MEMORY.ex_mem_readmem, MIPS.MEMORY.ex_mem_writemem);
		$display(" ID | EX | MEM | WB ");
		$display(" %d | %d | %d  | %d", MIPS.FW.TableFW[0], MIPS.FW.TableFW[1], MIPS.FW.TableFW[2], MIPS.FW.TableFW[3]);

		$display("FETCH:  (if_id_)        | DECODE:  (id_ex_)      | EX: (ex_mem_)           | MEM:  (mem_wb_)       | WRITEBACK:");
		$display("                        |                        |                         |                       |           ");
		$display("proximopc  : %d | selalushift : %b        | msm        : %d          | regdest    : %d       |           ", MIPS.FETCH.if_id_proximopc, MIPS.DECODE.id_ex_selalushift, MIPS.EXECUTE.ex_mem_msm, MIPS.MEMORY.mem_wb_regdest);
		$display("instrucao  : %h   | selimregb   : %b        | msl        : %d          | writereg   : %b        |           ", MIPS.FETCH.if_id_instrucao, MIPS.DECODE.id_ex_selimregb, MIPS.EXECUTE.ex_mem_msl, MIPS.MEMORY.mem_wb_writereg);
		$display("                        | selsarega   : %b        | readmem    : %b          | wbvalue    : %h |           ", MIPS.DECODE.id_ex_selsarega, MIPS.EXECUTE.ex_mem_readmem, MIPS.MEMORY.mem_wb_wbvalue);
		$display("                        | aluop       : %d        | writemem   : %b          |                       |           ", MIPS.DECODE.id_ex_aluop, MIPS.EXECUTE.ex_mem_writemem);
		$display("                        | unsig       : %b        | mshw       : %b          |                       |           ", MIPS.DECODE.id_ex_unsig, MIPS.EXECUTE.ex_mem_mshw);
		$display("                        | shiftop     : %d        | lshw       : %b          |                       |           ", MIPS.DECODE.id_ex_shiftop, MIPS.EXECUTE.ex_mem_lshw);
		$display("                        | shiftamt    : %d       | regb       : %d          |                       |           ", MIPS.DECODE.id_ex_shiftamt, MIPS.EXECUTE.ex_mem_selwsource);
		$display("                        | rega        : %h | selwsource : %d         |                       |           ", MIPS.DECODE.id_ex_rega, MIPS.EXECUTE.ex_mem_regdest);
		$display("                        | msm         : %d        | regdest    : %d         |                       |           ", MIPS.DECODE.id_ex_msm, MIPS.EXECUTE.ex_mem_regdest);
		$display("                        | msl         : %d        | writereg   : %b          |                       |           ", MIPS.DECODE.id_ex_msl, MIPS.EXECUTE.ex_mem_writereg);
		$display("                        | readmem     : %b        | aluout     : %d |                       |           ", MIPS.DECODE.id_ex_readmem, MIPS.EXECUTE.ex_mem_aluout);
		$display("                        | writemem    : %b        | wbvalue    : %d |                       |           ", MIPS.DECODE.id_ex_writemem, MIPS.EXECUTE.ex_mem_wbvalue);
		$display("                        | mshw        : %b        | tall       : %b          |                       |           ", MIPS.DECODE.id_ex_mshw, MIPS.EXECUTE.ex_if_stall);
		$display("                        | lshw        : %b        |                         |                       |           ", MIPS.DECODE.id_ex_lshw);
		$display("                        | regb        : %h |                         |                       |           ", MIPS.DECODE.id_ex_regb);
		$display("                        | imedext     : %h |                         |                       |           ", MIPS.DECODE.id_ex_imedext);
		$display("                        | proximopc   : %h |                         |                       |           ", MIPS.DECODE.id_ex_proximopc);
		$display("                        | selwsource  : %d        |                         |                       |           ", MIPS.DECODE.id_ex_selwsource);
		$display("                        | regdest     : %d       |                         |                       |           ", MIPS.DECODE.id_ex_regdest);
		$display("                        | writereg    : %b        |                         |                       |           ", MIPS.DECODE.id_ex_writereg);
		$display("                        | writeov     : %b        |                         |                       |           ", MIPS.DECODE.id_ex_writeov);
		$display("                        |                        |                         |                       |           ");
		$display("                        | fw_id_rega  : %h |                         |                       |           ", MIPS.FW.fw_id_rega);
		$display("                        | fw_id_regb  : %h |                         |                       |           ", MIPS.FW.fw_id_regb);


/*		
		#1
		$display("FETCH:");
		$display("if_id_proximopc   : %d", MIPS.FETCH.if_id_proximopc);
		$display("if_id_instrucao   : %h", MIPS.FETCH.if_id_instrucao);
		$display;
		$display("DECODE:");
		$display("id_ex_selalushift : %b", MIPS.DECODE.id_ex_selalushift);
		$display("id_ex_selimregb   : %b", MIPS.DECODE.id_ex_selimregb);
		$display("id_ex_selsarega   : %b", MIPS.DECODE.id_ex_selsarega);
		$display("id_ex_aluop       : %d", MIPS.DECODE.id_ex_aluop);
		$display("id_ex_unsig       : %b", MIPS.DECODE.id_ex_unsig);
		$display("id_ex_shiftop     : %d", MIPS.DECODE.id_ex_shiftop);
		$display("id_ex_shiftamt    : %d", MIPS.DECODE.id_ex_shiftamt);
		$display("id_ex_rega        : %h", MIPS.DECODE.id_ex_rega);
		$display("id_ex_msm         : %d", MIPS.DECODE.id_ex_msm);
		$display("id_ex_msl         : %d", MIPS.DECODE.id_ex_msl);
		$display("id_ex_readmem     : %b", MIPS.DECODE.id_ex_readmem);
		$display("id_ex_writemem    : %b", MIPS.DECODE.id_ex_writemem);
		$display("id_ex_mshw        : %b", MIPS.DECODE.id_ex_mshw);
		$display("id_ex_lshw        : %b", MIPS.DECODE.id_ex_lshw);
		$display("id_ex_regb        : %h", MIPS.DECODE.id_ex_regb);
		$display("id_ex_imedext     : %h", MIPS.DECODE.id_ex_imedext);
		$display("id_ex_proximopc   : %h", MIPS.DECODE.id_ex_proximopc);
		$display("id_ex_selwsource  : %d", MIPS.DECODE.id_ex_selwsource);
		$display("id_ex_regdest     : %d", MIPS.DECODE.id_ex_regdest);
		$display("id_ex_writereg    : %b", MIPS.DECODE.id_ex_writereg);
		$display("id_ex_writeov     : %b", MIPS.DECODE.id_ex_writeov);
		$display;
		$display("EXECUTE:");
		$display("ex_mem_msm        : %d", MIPS.EXECUTE.ex_mem_msm);
		$display("ex_mem_msl        : %d", MIPS.EXECUTE.ex_mem_msl);
		$display("ex_mem_readmem    : %b", MIPS.EXECUTE.ex_mem_readmem);
		$display("ex_mem_writemem   : %b", MIPS.EXECUTE.ex_mem_writemem);
		$display("ex_mem_mshw       : %b", MIPS.EXECUTE.ex_mem_mshw);
		$display("ex_mem_lshw       : %b", MIPS.EXECUTE.ex_mem_lshw);
		$display("ex_mem_regb       : %d", MIPS.EXECUTE.ex_mem_regb);
		$display("ex_mem_selwsource : %d", MIPS.EXECUTE.ex_mem_selwsource);
		$display("ex_mem_regdest    : %d", MIPS.EXECUTE.ex_mem_regdest);
		$display("ex_mem_writereg   : %b", MIPS.EXECUTE.ex_mem_writereg); 
		$display("ex_mem_aluout     : %d", MIPS.EXECUTE.ex_mem_aluout);
		$display("ex_mem_wbvalue    : %d", MIPS.EXECUTE.ex_mem_wbvalue);
		$display("ex_if_stall       : %b", MIPS.EXECUTE.ex_if_stall);
		$display;
		$display("MEMORY:");
		$display("mem_wb_regdest    : %d", MIPS.MEMORY.mem_wb_regdest);
		$display("mem_wb_writereg   : %b", MIPS.MEMORY.mem_wb_writereg);
		$display("mem_wb_wbvalue    : %h", MIPS.MEMORY.mem_wb_wbvalue);
		$display;*/
	end

	initial
	begin
		$dumpfile("dump.txt");
        $dumpvars;
		#1 reset = 0;
		#1 reset = 1;
		#1 reset = 0;
		
		#1 clock = 0;
	end


endmodule
