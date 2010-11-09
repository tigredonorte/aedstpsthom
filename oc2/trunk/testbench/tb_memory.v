`include "../rtl/Memory.v"

module tb_memory();

	Memory memory(
                                    
		.clock(            clock),
		.reset(            reset),
		
		.ex_mem_msm(       ex_mem_msm),
		.ex_mem_msl(       ex_mem_msl),
		.ex_mem_readmem(   ex_mem_readmem), 
		.ex_mem_writemem(  ex_mem_writemem),
		.ex_mem_mshw(      ex_mem_mshw),
		.ex_mem_lshw(      ex_mem_lshw),
		.ex_mem_regb(      ex_mem_regb),   
		.ex_mem_selwsource(ex_mem_selwsource),
		.ex_mem_regdest(   ex_mem_regdest),  
		.ex_mem_writereg(  ex_mem_writereg),
		.ex_mem_aluout(    ex_mem_aluout),
		.ex_mem_wbvalue(	ex_mem_wbvalue),	
		
		.mem_mc_rw(       mem_mc_rw),        
		.mem_mc_en(       mem_mc_en),        
		.mem_mc_addr(     mem_mc_addr),      
		.mem_mc_data(    w_mem_mc_data),      
		.mem_mc_en1h(     mem_mc_en1h),
		.mem_mc_en1l(     mem_mc_en1l),
		.mem_mc_en2h(     mem_mc_en2h),
		.mem_mc_en2l(     mem_mc_en2l),
		
		.mem_fw_wbvalue(   mem_fw_wbvalue),
		.mem_fw_writereg(  mem_fw_writereg),
		
		.mem_wb_regdest(   mem_wb_regdest),
		.mem_wb_writereg(  mem_wb_writereg),
		.mem_wb_wbvalue(   mem_wb_wbvalue)
	);

	reg               clock;
	reg               reset;

	// Execute	
	reg         [2:0] ex_mem_msm;
	reg         [2:0] ex_mem_msl;
	reg               ex_mem_readmem;    // Le memoria
	reg               ex_mem_writemem;	 // Escreve memoria
	reg               ex_mem_mshw;
	reg               ex_mem_lshw;
	reg        [31:0] ex_mem_regb;       // registrador destino
	reg         [2:0] ex_mem_selwsource; // Seleciona fonte de dados para WB realizar escrita
	reg         [4:0] ex_mem_regdest;    // Endereço do registrador de destino ( RD || RT || 31 )
	reg               ex_mem_writereg;   // informa quando um valor deve ser escrito em um registrador
	reg        [31:0] ex_mem_aluout;
	reg        [31:0] ex_mem_wbvalue;	

	// MC
	wire              mem_mc_rw;        
	wire              mem_mc_en;        
	wire       [31:0] mem_mc_addr;      
	reg        [31:0] r_mem_mc_data;      
	wire       [31:0] w_mem_mc_data;
	wire              mem_mc_en1h;
	wire              mem_mc_en1l;
	wire              mem_mc_en2h;
	wire              mem_mc_en2l;

	// Forwarding
	wire       [31:0] mem_fw_wbvalue;    // Valor que será gravado em WB
	wire              mem_fw_writereg;   // Flag para FW saber se este valor será usado (gravado = usado)

	// Writeback
	wire        [4:0] mem_wb_regdest;
	wire              mem_wb_writereg;
	wire       [31:0] mem_wb_wbvalue;

	assign w_mem_mc_data = (ex_mem_readmem) ? r_mem_mc_data : 32'bz;

	reg [4:0] contador_tst;
	
	always #1 clock = ~clock;

	always@(negedge clock or posedge reset)
	begin
	  if(reset)
	  	begin
	  		contador_tst = 5'b0; 
	  	end
	 	else
	 	  begin
	 	  	if(contador_tst <= 5'd27)
	 	  		begin
	 	  			contador_tst = contador_tst + 5'b1;
	 	  		end
	 	  	else
				begin
					contador_tst = 5'bx;
					$finish;
				end
/*
					// ordem de digitação
					ex_mem_mshw       = 1'bx;
					ex_mem_lshw       = 1'bx;
					ex_mem_readmem    = 1'bx;
					ex_mem_writemem   = 1'bx;
					ex_mem_msm        = 3'dx;
					ex_mem_msl        = 3'dx;
					ex_mem_regb       = 32'hx;
					ex_mem_selwsource = 3'dx;
					ex_mem_regdest    = 5'dx;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'dx;
					ex_mem_wbvalue    = 32'dx;
*/

			case(contador_tst)

				1:
				begin
					// LB
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd3;
					ex_mem_msl        = 3'd3;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;

					r_mem_mc_data    = 32'hdda0ffe1;
				
					$display("LB");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				2:
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// LH
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd3;
					ex_mem_msl        = 3'd1;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("LH");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				3:
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// LWL 0
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b0;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd2;
					ex_mem_msl        = 3'd0;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("LWL 0");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				
				end

				4: // LWL + 1
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// LWL +1
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b0;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd2;
					ex_mem_msl        = 3'd0;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd129; // 128 + 1;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("LWL +1");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				
				end

				5: // LWL + 2
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// LWL +2
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b0;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd2;
					ex_mem_msl        = 3'd0;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd130; // 128 + 2;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("LWL +2");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				6: // LWL + 3
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// LWL +3
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b0;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd2;
					ex_mem_msl        = 3'd0;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd131; // 128 + 3;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("LWL +3");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				7:
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// LW
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd1;
					ex_mem_msl        = 3'd2;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("LW");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				8:
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// LBU
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd0;
					ex_mem_msl        = 3'd4;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("LBU");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				9:
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// LHU
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd0;
					ex_mem_msl        = 3'd1;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("LHU");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				10: // LWR 0
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// LWR 0
					ex_mem_mshw       = 1'b0;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd0;
					ex_mem_msl        = 3'd1;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("LWR 0");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				11: // LWR +1
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// LWR +1
					ex_mem_mshw       = 1'b0;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd0;
					ex_mem_msl        = 3'd1;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd129;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("LWR +1");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				12: // LWR +2
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// LWR +2
					ex_mem_mshw       = 1'b0;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd0;
					ex_mem_msl        = 3'd1;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd130;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("LWR +2");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				13: // LWR +3
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// LWR +3
					ex_mem_mshw       = 1'b0;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd0;
					ex_mem_msl        = 3'd1;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd131;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("LWR +3");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				14:
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// SB
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b0;
					ex_mem_writemem   = 1'b1;
					ex_mem_msm        = 3'd4;
					ex_mem_msl        = 3'd3;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					//r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("SB");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				15:
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// SH
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b0;
					ex_mem_writemem   = 1'b1;
					ex_mem_msm        = 3'd2;
					ex_mem_msl        = 3'd0;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					//r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("SH");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				16: // SWL 0
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// SWL 0
					ex_mem_mshw       = 1'b0;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b0;
					ex_mem_writemem   = 1'b1;
					ex_mem_msm        = 3'd0;
					ex_mem_msl        = 3'd1;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					//r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("SWL 0");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				17: // SWL +1
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// SWL +1
					ex_mem_mshw       = 1'b0;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b0;
					ex_mem_writemem   = 1'b1;
					ex_mem_msm        = 3'd0;
					ex_mem_msl        = 3'd1;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd129; // 128 + 1;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					//r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("SWL +1");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				18: // SWL +2
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// SWL +2
					ex_mem_mshw       = 1'b0;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b0;
					ex_mem_writemem   = 1'b1;
					ex_mem_msm        = 3'd0;
					ex_mem_msl        = 3'd1;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd130; // 128 + 2;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					//r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("SWL +2");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				19: // SWL +3
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// SWL +3
					ex_mem_mshw       = 1'b0;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b0;
					ex_mem_writemem   = 1'b1;
					ex_mem_msm        = 3'd0;
					ex_mem_msl        = 3'd1;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd131; // 128 + 3;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					//r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("SWL +3");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				20:
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// SW
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b0;
					ex_mem_writemem   = 1'b1;
					ex_mem_msm        = 3'd1;
					ex_mem_msl        = 3'd2;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					//r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("SW");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				21: // SWR 0
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// SWR 0
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b0;
					ex_mem_readmem    = 1'b0;
					ex_mem_writemem   = 1'b1;
					ex_mem_msm        = 3'd2;
					ex_mem_msl        = 3'd0;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					//r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("SWR 0");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				22: // SWR +1
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// SWR +1
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b0;
					ex_mem_readmem    = 1'b0;
					ex_mem_writemem   = 1'b1;
					ex_mem_msm        = 3'd2;
					ex_mem_msl        = 3'd0;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd129; // 128 + 1
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					//r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("SWR +1");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				23: // SWR +2
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// SWR +2
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b0;
					ex_mem_readmem    = 1'b0;
					ex_mem_writemem   = 1'b1;
					ex_mem_msm        = 3'd2;
					ex_mem_msl        = 3'd0;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd130; // 128 + 2
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					//r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("SWR +2");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				24: // SWR +3
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// SWR +3
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b0;
					ex_mem_readmem    = 1'b0;
					ex_mem_writemem   = 1'b1;
					ex_mem_msm        = 3'd2;
					ex_mem_msl        = 3'd0;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd131; // 128 + 3
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					//r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("SWR +3");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				25:
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// LL
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b1;
					ex_mem_writemem   = 1'b0;
					ex_mem_msm        = 3'd1;
					ex_mem_msl        = 3'd2;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("LL");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				26:
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
					
					// SC
					ex_mem_mshw       = 1'b1;
					ex_mem_lshw       = 1'b1;
					ex_mem_readmem    = 1'b0;
					ex_mem_writemem   = 1'b1;
					ex_mem_msm        = 3'd1;
					ex_mem_msl        = 3'd2;
					ex_mem_regb       = 32'hA0B1C2D3;
					ex_mem_selwsource = 3'b001;
					ex_mem_regdest    = 5'd22;
					ex_mem_writereg   = 1'bx;
					ex_mem_aluout     = 32'd128;
					ex_mem_wbvalue    = 32'h7777FFFF;
	
					r_mem_mc_data    = 32'hdda0ffe1;
			
					$display("SC");	
					$display("ciclo : %d", contador_tst);
					$display("ex_mem_msm        : %d",  ex_mem_msm); 
					$display("ex_mem_msl        : %d",  ex_mem_msl);
					$display("ex_mem_readmem    : %b",  ex_mem_readmem);
					$display("ex_mem_writemem   : %b",  ex_mem_writemem);
					$display("ex_mem_mshw       : %b",  ex_mem_mshw);
					$display("ex_mem_lshw       : %b",  ex_mem_lshw);
					$display("ex_mem_regb       : %h",  ex_mem_regb);
					$display("ex_mem_selwsource : %d",  ex_mem_selwsource);
					$display("ex_mem_regdest    : %d",  ex_mem_regdest);
					$display("ex_mem_writereg   : %b",  ex_mem_writereg);
					$display("ex_mem_aluout     : %d",  ex_mem_aluout);
					$display("ex_mem_wbvalue    : %h",  ex_mem_wbvalue);
				end

				27:
				begin
					$display("(negedge)");
					$display("Resultado do 1o. ciclo");
					$display("mem_mc_rw     : %b",  mem_mc_rw); 
					$display("mem_mc_en     : %b",  mem_mc_en); 
					$display("mem_mc_addr   : %d",  mem_mc_addr); 
					$display("w_mem_mc_data : %h",  w_mem_mc_data);
					$display("mem_mc_en1h   : %b",  mem_mc_en1h);
					$display("mem_mc_en1l   : %b",  mem_mc_en1l);
					$display("mem_mc_en2h   : %b",  mem_mc_en2h);
					$display("mem_mc_en2l   : %b",  mem_mc_en2l);
					$display("mem_fw_wbvalue : %h",  mem_fw_wbvalue);
					$display("mem_fw_writereg: %b",  mem_fw_writereg);
					$display("mem_wb_regdest : %d",  mem_wb_regdest);
					$display("mem_wb_writereg: %b",  mem_wb_writereg);
					$display("mem_wb_wbvalue : %h",  mem_wb_wbvalue);
					$display;
					$display;
				end
			endcase

	 	  end
	end

	initial
	begin
		#1 reset = 0;
		#1 reset = 1;
		#1 reset = 0;
		
		#1 clock = 0;
	end

endmodule
