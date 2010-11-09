`include "../rtl/Memory.v"

module TestBench();
    reg             clock;
	reg             reset;
	// Execute	
	reg       [2:0] ex_mem_msm;
	reg       [2:0] ex_mem_msl;
	reg             ex_mem_readmem;
	reg             ex_mem_writemem;
	reg             ex_mem_mshw;
	reg             ex_mem_lshw;
	reg      [31:0] ex_mem_regb;
	reg       [2:0] ex_mem_selwsource;
	reg       [4:0] ex_mem_regdest;
	reg             ex_mem_writereg;
	reg      [31:0] ex_mem_aluout;
	reg      [31:0] ex_mem_wbvalue;	

	// GDM
	wire            mem_mc_rw;        
	wire            mem_mc_en;        
	wire     [31:0] mem_mc_addr;      
	wire     [31:0] mem_mc_data;      
	wire            mem_mc_en1h;
	wire            mem_mc_en1l;
	wire            mem_mc_en2h;
	wire            mem_mc_en2l;

	// Forwarding
	wire     [31:0] mem_fw_wbvalue;
	wire            mem_fw_writereg;

	// Writeback
	wire  [4:0] mem_wb_regdest;
	wire        mem_wb_writereg;
	wire [31:0] mem_wb_wbvalue;


    Memory MEMORY(
        clock,
        reset,
	    // Execute	
	    ex_mem_msm,
	    ex_mem_msl,
	    ex_mem_readmem,    
	    ex_mem_writemem,
	    ex_mem_mshw,
	    ex_mem_lshw,
	    ex_mem_regb,
	    ex_mem_selwsource,
	    ex_mem_regdest,
	    ex_mem_writereg,
	    ex_mem_aluout,
	    ex_mem_wbvalue,	
	    // GDM
	    mem_mc_rw,        
	    mem_mc_en,        
	    mem_mc_addr,      
	    mem_mc_data,      
	    mem_mc_en1h,
	    mem_mc_en1l,
	    mem_mc_en2h,
	    mem_mc_en2l,
    	// Forwarding
	    mem_fw_wbvalue,
	    mem_fw_writereg,
    	// Writeback
	    mem_wb_regdest,
	    mem_wb_writereg,
	    mem_wb_wbvalue
	);
    
    reg [31:0] datain;
    assign mem_mc_data = (ex_mem_readmem & ~ex_mem_writemem) ? (datain) : (32'bz) ;

    integer count;
    integer testes;

    initial begin
        testes = 0;
        count = 0;
        clock = 0;
        reset = 0;
        ex_mem_msm = 0;
	    ex_mem_msl = 0;
	    ex_mem_readmem = 0;    
	    ex_mem_writemem = 0;
	    ex_mem_mshw = 0;
	    ex_mem_lshw = 0;
	    ex_mem_regb = 0;
	    ex_mem_selwsource = 0;
	    ex_mem_regdest = 0;
	    ex_mem_writereg = 0;
	    ex_mem_aluout = 0;
	    ex_mem_wbvalue = 0;

		$dumpfile("dump.txt");
		$dumpvars;

        //reset
        #2 reset = 1;
        #2 testes = testes + 1;
        reset = 0;
        if (mem_wb_regdest == 0 &&
    	    mem_wb_writereg == 0 &&
	        mem_wb_wbvalue == 0) begin
           count = count + 1;
        end

        /*  Leitura ou Escrita
            (mem_mc_rw, mem_mc_en)
        //ex_mem_readmem  -  ex_mem_writemem
        // 1 - 0
        */
        #2 ex_mem_readmem = 1;
        #2 testes = testes + 1;
        if (mem_mc_rw == 0 &&
            mem_mc_en == 1)begin
           count = count + 1;
        end
        // 1 - 1
        #2 ex_mem_writemem = 1;
        #2 testes = testes + 1;
        if (mem_mc_rw == 0 &&
            mem_mc_en == 1)begin
           count = count + 1;
        end
        // 0 - 1
        #2 ex_mem_readmem = 0;
        #2 testes = testes + 1;
        if (mem_mc_rw == 1 &&
            mem_mc_en == 1)begin
           count = count + 1;
        end
        // 0 - 0
        #2 ex_mem_writemem = 0;
        #2 testes = testes + 1;
        if (mem_mc_rw == 0 &&
            mem_mc_en == 0)begin
           count = count + 1;
        end

        //mem_mc_addr
        #2 ex_mem_aluout = 57;
        #2 testes = testes + 1;
        if (mem_mc_addr == 57)begin
           count = count + 1;
        end

/*-----------------------------------------------------------------DATA(OUT) INICIO-----------------------------------------------------------------------*/
        //SB
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 4;
	    ex_mem_msl = 3;
        ex_mem_regb = 32'b11110000111100001111000011110000;
        #2 testes = testes + 1;
        if (mem_mc_data[7:0] == ex_mem_regb[7:0]) count = count +1;
        else begin
            $display("SB data");
            $display("mem_mc_data[7:0] = %b deveria ser %b = ex_mem_regb[7:0]", mem_mc_data[7:0], ex_mem_regb[7:0]);
        end

        //SH
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        ex_mem_regb = 32'b11111111000000001111111100000000;
        #2 testes = testes + 1;
        if (mem_mc_data[15:0] == ex_mem_regb[15:0])count = count +1;
        else begin
            $display("SH data");
            $display("%d mem_mc_data = %b deveria ser %b = ex_mem_regb[15:0]", $time, mem_mc_data[15:0], ex_mem_regb[15:0]);
        end

        //SWL
        #2 ex_mem_aluout = 32'b0;
        #2 ex_mem_mshw = 0;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 0;
	    ex_mem_msl = 1;
        ex_mem_regb = 32'b11111111000000001111111100000000;
        #2 testes = testes + 1;
        if (mem_mc_data == ex_mem_regb)count = count +1;
        else begin
            $display("SWL data - 00");
            $display("mem_mc_data = %b deveria ser %b = ex_mem_regb", mem_mc_data, ex_mem_regb);
        end

        #2 ex_mem_aluout = 32'b1;
        #2 ex_mem_mshw = 0;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 0;
	    ex_mem_msl = 1;
        ex_mem_regb = 32'b00001111111100001111000000001111;
        #2 testes = testes + 1;
        if(mem_mc_data[23:0] == ex_mem_regb[23:0])count = count +1;
        else begin
            $display("SWL data - 01");
            $display("mem_mc_data[23:0] = %b deveria ser %b = ex_mem_regb[23:0]", mem_mc_data[23:0], ex_mem_regb[23:0]);
        end

        #2 ex_mem_aluout = 32'b10;
        #2 ex_mem_mshw = 0;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 0;
	    ex_mem_msl = 1;
        ex_mem_regb = 32'b00001111111100001111000000001111;
        #2 testes = testes + 1;
        if (mem_mc_data[15:0] == ex_mem_regb[15:0])count = count +1;
        else begin
            $display("SWL data - 10");
            $display("mem_mc_data[15:0] = %b deveria ser %b = ex_mem_regb[15:0]", mem_mc_data[15:0], ex_mem_regb[15:0]);
        end

        #2 ex_mem_aluout = 32'b11;
        #2 ex_mem_mshw = 0;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 0;
	    ex_mem_msl = 1;
        ex_mem_regb = 32'b00001111111100001111000000001111;  
        #2 testes = testes + 1;
        if (mem_mc_data[7:0] == ex_mem_regb[7:0])count = count +1;
        else begin
            $display("SWL data - 11");
            $display("mem_mc_data[7:0] = %b deveria ser %b = ex_mem_regb[7:0]", mem_mc_data[7:0], ex_mem_regb[7:0]);
        end

        //SW
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 1;
	    ex_mem_msl = 2;
        ex_mem_regb = 32'b00110011001100110011001100110011;
        #2 testes = testes + 1;
        if (mem_mc_data == ex_mem_regb)count = count +1;
        else begin
            $display("SWL data - 00");
            $display("mem_mc_data = %b deveria ser %b = ex_mem_regb", mem_mc_data, ex_mem_regb);
        end

        //SWR
        #2 ex_mem_aluout = 32'b0;
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 0;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        ex_mem_regb = 32'b00110011001100110011001100110011;
        #2 testes = testes + 1;
        if(mem_mc_data[31:24] == ex_mem_regb[31:24])count = count +1;
        else begin
            $display("SWR data - 00");
            $display("mem_mc_data[31:24] = %b deveria ser %b = ex_mem_regb[31:24]", mem_mc_data[31:24], ex_mem_regb[31:24]);
        end

        #2 ex_mem_aluout = 32'b1;
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 0;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        ex_mem_regb = 32'b11111111000000001111111100000000;
        #2 testes = testes + 1;
        if(mem_mc_data[31:16] == ex_mem_regb[31:16])count = count +1;
        else begin
            $display("SWR data - 01");
            $display("mem_mc_data[31:16] = %b deveria ser %b = ex_mem_regb[31:16]", mem_mc_data[31:16], ex_mem_regb[31:16]);
        end

        #2 ex_mem_aluout = 32'b10;
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 0;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        ex_mem_regb = 32'b00110011001100110011001100110011;
        #2 testes = testes + 1;
        if(mem_mc_data[31:8] == ex_mem_regb[31:8])count = count +1;
        else begin
            $display("SWR data - 10");
            $display("mem_mc_data[31:8] = %b deveria ser %b = ex_mem_regb[31:8]", mem_mc_data[31:8], ex_mem_regb[31:8]);
        end


        #2 ex_mem_aluout = 32'b11;
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 0;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        ex_mem_regb = 32'b11111111000000001111111100000000;
        #2 testes = testes + 1;
        if(mem_mc_data[31:16] == ex_mem_regb[31:16])count = count +1;
        else begin
            $display("SWR data - 11");
            $display("mem_mc_data = %b deveria ser %b = ex_mem_regb", mem_mc_data, ex_mem_regb);
        end

        //SC
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 1;
	    ex_mem_msl = 2;
        ex_mem_regb = 32'b00110011001100110011001100110011;
        #2 testes = testes + 1;
        if (mem_mc_data == ex_mem_regb)count = count +1;
        else begin
            $display("SWL data - 00");
            $display("mem_mc_data = %b deveria ser %b = ex_mem_regb", mem_mc_data, ex_mem_regb);
        end
/*-----------------------------------------------------------------DATA(OUT) FIM--------------------------------------------------------------------------*/
     
	    //mem_fw_writereg
        #2 ex_mem_writereg = 1;
        #2 testes = testes + 1;
        if (mem_fw_writereg == 1)begin
           count = count + 1;
        end
        // qlquer função diferente de SC
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 3;
	    ex_mem_msl = 2;
        ex_mem_writereg = 0;
        #2 testes = testes + 1;
        if (mem_fw_writereg == 0)begin
           count = count + 1;
        end
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 1;
	    ex_mem_msl = 2;
        #2 testes = testes + 1;
        if (mem_fw_writereg == 1)begin
           count = count + 1;
        end
        else begin
            $display("mem_fw_writereg deve ser %b, se instrucao SC", 1'b1);
        end

        //mem_wb_regdest
        #2 ex_mem_regdest = 5'b10101;
        #2 testes = testes + 1;
        if (mem_wb_regdest == 5'b10101)begin
           count = count + 1;
        end

	    //mem_wb_writereg
        #2 ex_mem_writereg = 1;
        #2 testes = testes + 1;
        if (mem_wb_writereg == 1)begin
           count = count + 1;
        end
        #2 ex_mem_writereg = 0;
        #2 testes = testes + 1;
        if (mem_wb_writereg == 0)begin
           count = count + 1;
        end
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 1;
	    ex_mem_msl = 2;
        #2 testes = testes + 1;
        if (mem_fw_writereg == 1)begin
           count = count + 1;
        end
        else begin
            $display("mem_wb_wirtereg deve ser %b, se instrucao SC", 1'b1);
        end

/*-----------------------------------------------------------------ENABLE INICIO--------------------------------------------------------------------------*/
        //LB
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 3;
	    ex_mem_msl = 3;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("LB");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b0, 1'b0, 1'b0, 1'b1);
        end

        //LH
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 3;
	    ex_mem_msl = 1;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("LH");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b0, 1'b0, 1'b1, 1'b1);
        end

        //LWL
        #2 ex_mem_aluout = 32'b0;
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 0;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("LWL - 00");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b1, 1'b1);
        end

        #2 ex_mem_aluout = 32'b1;
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 0;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 0) )count = count +1;
        else begin
            $display("LWL - 01");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b1, 1'b0);
        end

        #2 ex_mem_aluout = 32'b10;
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 0;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 0) &&
         (mem_mc_en2l == 0) )count = count +1;
        else begin
            $display("LWL - 10");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b0, 1'b0);
        end

        #2 ex_mem_aluout = 32'b11;
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 0;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 0) &&
         (mem_mc_en2h == 0) &&
         (mem_mc_en2l == 0) )count = count +1;
        else begin
            $display("LWL - 11");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b0, 1'b0, 1'b0);
        end

        //LW
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 1;
	    ex_mem_msl = 2;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("Lw");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b1, 1'b1);
        end

        //LBU
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 0;
	    ex_mem_msl = 4;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("LBU");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b1, 1'b1);
        end

        //LHU
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 0;
	    ex_mem_msl = 1;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("LHU");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b1, 1'b1);
        end

        //LWR
        #2 ex_mem_aluout = 32'b0;
        #2 ex_mem_mshw = 0;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 0;
	    ex_mem_msl = 1;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 0) &&
         	(mem_mc_en1l == 0) &&
         	(mem_mc_en2h == 0) &&
         	(mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("LWR - 00");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b0, 1'b0, 1'b0, 1'b1);
        end
                
        #2 ex_mem_aluout = 32'b1;
        #2 ex_mem_mshw = 0;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 0;
	    ex_mem_msl = 1;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 0) &&
         (mem_mc_en1l == 0) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("LWR - 01");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b0, 1'b0, 1'b1, 1'b1);
        end

        #2 ex_mem_aluout = 32'b10;
        #2 ex_mem_mshw = 0;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 0;
	    ex_mem_msl = 1;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 0) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("LWR - 10");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b0, 1'b1, 1'b1, 1'b1);
        end

        #2 ex_mem_aluout = 32'b11;
        #2 ex_mem_mshw = 0;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 0;
	    ex_mem_msl = 1;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("LWR - 11");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b1, 1'b1);
        end

        //SB
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 4;
	    ex_mem_msl = 3;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 0) &&
         (mem_mc_en1l == 0) &&
         (mem_mc_en2h == 0) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("SB");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b0, 1'b0, 1'b0, 1'b1);
        end

        //SH
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 0) &&
         (mem_mc_en1l == 0) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("SH");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b0, 1'b0, 1'b1, 1'b1);
        end

        //SWL
        #2 ex_mem_aluout = 32'b0;
        #2 ex_mem_mshw = 0;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 0;
	    ex_mem_msl = 1;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("SWL - 00");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b1, 1'b1);
        end

        #2 ex_mem_aluout = 32'b1;
        #2 ex_mem_mshw = 0;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 0;
	    ex_mem_msl = 1;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 0) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("SWL - 01");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b0, 1'b1, 1'b1, 1'b1);
        end

        #2 ex_mem_aluout = 32'b10;
        #2 ex_mem_mshw = 0;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 0;
	    ex_mem_msl = 1;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 0) &&
         (mem_mc_en1l == 0) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("SWL - 10");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b0, 1'b0, 1'b1, 1'b1);
        end

        #2 ex_mem_aluout = 32'b11;
        #2 ex_mem_mshw = 0;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 0;
	    ex_mem_msl = 1;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 0) &&
         (mem_mc_en1l == 0) &&
         (mem_mc_en2h == 0) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("SWL - 11");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b0, 1'b0, 1'b0, 1'b1);
        end

        //SW
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 1;
	    ex_mem_msl = 2;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("SW");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b1, 1'b1);
        end

        //SWR
        #2 ex_mem_aluout = 32'b0;
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 0;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 0) &&
         (mem_mc_en2h == 0) &&
         (mem_mc_en2l == 0) )count = count +1;
        else begin
            $display("SWR - 00");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b0, 1'b0, 1'b0);
        end

        #2 ex_mem_aluout = 32'b1;
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 0;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 0) &&
         (mem_mc_en2l == 0) )count = count +1;
        else begin
            $display("SWR - 01");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b0, 1'b0);
        end

        #2 ex_mem_aluout = 32'b10;
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 0;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 0) )count = count +1;
        else begin
            $display("SWR - 10");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b1, 1'b0);
        end

        #2 ex_mem_aluout = 32'b11;
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 0;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 2;
	    ex_mem_msl = 0;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("SWR - 11");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b1, 1'b1);
        end

        //LL
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 1;
	    ex_mem_msl = 2;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("LL");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b1, 1'b1);
        end

        //SC
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 1;
	    ex_mem_msl = 2;
        #2 testes = testes + 1;
        if ((mem_mc_en1h == 1) &&
         (mem_mc_en1l == 1) &&
         (mem_mc_en2h == 1) &&
         (mem_mc_en2l == 1) )count = count +1;
        else begin
            $display("SC");
            $display("%b, %b, %b, %b deveria ser %b, %b, %b, %b", mem_mc_en1h, mem_mc_en1l, mem_mc_en2h, mem_mc_en2l, 1'b1, 1'b1, 1'b1, 1'b1);
        end

/*------------------------------------------------------------------ENABLE FIM----------------------------------------------------------------------------*/
/*----------------------------------------------------------------WBVALUE INICIO--------------------------------------------------------------------------*/
        #2 ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 0;    
	    ex_mem_writemem = 1;
        ex_mem_msm = 1;
	    ex_mem_msl = 2;
        #2 testes = testes + 1;
        if (mem_wb_wbvalue == 32'd1)begin
           count = count + 1;
        end
        else begin
            $display("mem_wb_wbvalue deve ser %b, se instrucao SC", 32'd1);
        end

		/*
		
		está faltando setar a função desse teste
		
        #2 ex_mem_selwsource = 3'b000;
        ex_mem_wbvalue = 32'b00000000111111111111111100000000;
        #2 testes = testes + 2;
        if (mem_wb_wbvalue == ex_mem_wbvalue)begin
           count = count + 1;
        end
        else begin
            $display("erro 1: mem_wb_wbvalue = %b deve ser %b = ex_mem_wbvalue",mem_wb_wbvalue, ex_mem_wbvalue);
        end
        if (mem_fw_wbvalue == ex_mem_wbvalue)begin
           count = count + 1;
        end
        else begin
            $display("erro 2: mem_fw_wbvalue = %b deve ser %b = ex_mem_wbvalue",mem_fw_wbvalue, ex_mem_wbvalue);
        end
        */

        #2 ex_mem_selwsource = 3'b001;
        ex_mem_mshw = 0;
        ex_mem_regb = 32'b00000000111111111111111100000000;
        #2 testes = testes + 2;
        if (mem_wb_wbvalue[31:16] == ex_mem_regb[31:16])begin
           count = count + 1;
        end
        else begin
            $display("erro 3: mem_wb_wbvalue[31:16] = %b deve ser %b = ex_mem_regb[31:16]",mem_wb_wbvalue[31:16], ex_mem_regb[31:16]);
        end
        if (mem_fw_wbvalue[31:16] == ex_mem_regb[31:16])begin
           count = count + 1;
        end
        else begin
            $display("erro 4: mem_fw_wbvalue[31:16] = %b deve ser %b = ex_mem_regb[31:16]",mem_fw_wbvalue[31:16], ex_mem_regb[31:16]);
        end
        #2 ex_mem_lshw = 0;
        ex_mem_regb = 32'b00000000111111111111111100000000;
        #2 testes = testes + 2;
        if (mem_wb_wbvalue[15:0] == ex_mem_regb[15:0])begin
           count = count + 1;
        end
        else begin
            $display("erro 5: mem_wb_wbvalue[15:0] = %b deve ser %b = ex_mem_regb[15:0]",mem_wb_wbvalue[15:0], ex_mem_regb[15:0]);
        end
        if (mem_fw_wbvalue[15:0] == ex_mem_regb[15:0])begin
           count = count + 1;
        end
        else begin
            $display("erro 6: mem_fw_wbvalue[15:0] = %b deve ser %b = ex_mem_regb[15:0]",mem_fw_wbvalue[15:0], ex_mem_regb[15:0]);
        end

        #2 ex_mem_mshw = 1;
        datain = 32'b00110011001100110011001100110011;
        ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 3;
	    ex_mem_msl = 3;
        #2 testes = testes + 2;
        if (mem_wb_wbvalue[31:16] == {16{datain[7]}})begin
           count = count + 1;
        end
        else begin
            $display("erro 7: mem_wb_wbvalue[31:16] = %b deve ser %b = {16{datain[7]}}",mem_wb_wbvalue[31:16], {16{datain[7]}});
        end
        if (mem_fw_wbvalue[31:16] == {16{datain[7]}})begin
           count = count + 1;
        end
        else begin
            $display("erro 8: mem_fw_wbvalue[31:16] = %b deve ser %b = {16{datain[7]}}",mem_fw_wbvalue[31:16], {16{datain[7]}});
        end


        #2 ex_mem_lshw = 1;
        datain = 32'b00110011001100110011001100110011;
        ex_mem_mshw = 1;
	    ex_mem_lshw = 1;
        ex_mem_readmem = 1;    
	    ex_mem_writemem = 0;
        ex_mem_msm = 3;
	    ex_mem_msl = 3;
        #2 testes = testes + 2;
        if (mem_wb_wbvalue[15:0] == {8{datain[7]},{datain[7:0]}})begin
           count = count + 1;
        end
        else begin
            $display("erro 9: mem_wb_wbvalue[15:0] = %b deve ser %b = {8{datain[7]},{datain[7:0]}}",mem_wb_wbvalue[15:0], {8{datain[7]},{datain[7:0]}});
        end
        if (mem_fw_wbvalue[15:0] == {8{datain[7]},{datain[7:0]}})begin
           count = count + 1;
        end
        else begin
            $display("erro 10: mem_fw_wbvalue[15:0] = %b deve ser %b = {8{datain[7]},{datain[7:0]}}",mem_fw_wbvalue[15:0], {8{datain[7]},{datain[7:0]}});
        end
        
        
/*-----------------------------------------------------------------WBVALUE FIM----------------------------------------------------------------------------*/
    end

    always begin
        repeat(900) begin
		#1 clock <= ~clock;	
		end
        $display("%d / %d", count, testes);
		$finish;
    end
endmodule
