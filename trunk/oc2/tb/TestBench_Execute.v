`include "../rtl/Execute.v"

module tb_comp (); 

	reg clock, reset;
	
	// Decode
	reg id_ex_selalushift, id_ex_selimregb , id_ex_selsarega;
	reg [2:0] id_ex_aluop;
	reg id_ex_unsig; //sinais para ALU
	reg [1:0] id_ex_shiftop;
	reg [4:0] id_ex_shiftamt; //sinais da unidade de deslocamento
	reg [31:0] id_ex_rega;
	reg [31:0] id_ex_regb; //registrador de entrada A e B
	
	//registradores q devem ser repassados a unidade de memoria
	reg [2:0] id_ex_msm;
	reg [2:0] id_ex_msl;
	reg id_ex_readmem, id_ex_writemem, id_ex_mshw , id_ex_lshw;
	reg [4:0] id_ex_regdest;
	
	reg [31:0] id_ex_imedext; //valor imediato
	reg [31:0] id_ex_proximopc; //proximo pc
	reg [2:0] id_ex_selwsource; //controle do resultado de saida
	
	reg id_ex_writereg, id_ex_writeov; //indica se a instrucao escreve em registrador

	// Forwarding
	wire [31:0] ex_fw_wbvalue;
	wire ex_fw_writereg;

	// Fetch
	wire ex_if_stall; //quando ocorre um acesso a memoria

	// Memory
	wire [2:0] ex_mem_msm;
	wire [2:0] ex_mem_msl;
	wire ex_mem_readmem, ex_mem_writemem, ex_mem_mshw, ex_mem_lshw;
	wire [31:0] ex_mem_regb; //valor do registrador B
	wire [2:0] ex_mem_selwsource;
	wire [4:0] ex_mem_regdest;
	wire ex_mem_writereg;
	wire [31:0] ex_mem_aluout; //resultado ALU
	wire [31:0] ex_mem_wbvalue; //valor que sera gravado

	//aux
	reg [8:0] result;
    reg [8:0] testes;

	//declaracao da unidade de execucao	
	Execute execute(clock, reset, id_ex_selalushift, id_ex_selimregb, id_ex_selsarega,
		id_ex_aluop, id_ex_unsig, id_ex_shiftop, id_ex_shiftamt, id_ex_rega, id_ex_msm,
		id_ex_msl, id_ex_readmem, id_ex_writemem, id_ex_mshw, id_ex_lshw, id_ex_regb,
		id_ex_imedext, id_ex_proximopc, id_ex_selwsource, id_ex_regdest, id_ex_writereg,
		id_ex_writeov, ex_fw_wbvalue, ex_fw_writereg, ex_if_stall, ex_mem_msm,
		ex_mem_msl, ex_mem_readmem, ex_mem_writemem, ex_mem_mshw, ex_mem_lshw, ex_mem_regb,
		ex_mem_selwsource, ex_mem_regdest, ex_mem_writereg, ex_mem_aluout, ex_mem_wbvalue);


	initial begin
		result = 0;
		testes = 0;
		
		//inicializa os registradores de entrada
		clock   <= 0;
		reset   <= 0;
		
		// Decode
		id_ex_selalushift <= 0; 
		id_ex_selimregb <= 0;
		id_ex_selsarega <= 0;
		id_ex_aluop <= 3'b0;
		id_ex_unsig <= 0;
		id_ex_shiftop <= 2'b0;
		id_ex_shiftamt <= 5'b0;
		id_ex_rega <= 32'b0;
		id_ex_msm <= 3'b0;
		id_ex_msl <= 3'b0;
		id_ex_readmem <= 0;
		id_ex_writemem <= 0;
		id_ex_mshw <= 0;
		id_ex_lshw <= 0;
		id_ex_regb <= 32'b0;
		id_ex_imedext <= 32'b0;
		id_ex_proximopc <= 32'b0;
		id_ex_selwsource <= 3'b0;
		id_ex_regdest <= 5'b0;
		id_ex_writereg <= 0;
		id_ex_writeov <= 0;
	end	
	
	always begin
		repeat(110) begin
		#1 clock <= ~clock;	
		end
		$display("%d / %d", result, testes);
		$finish;
	end
	
	initial begin

        $dumpfile("dump.txt");
        $dumpvars;
        
		#3 //3
		//teste1: reset
        reset <= 1;
		#2 //5
		//valores de saida para memoria devem ser todos zeros
		if(ex_mem_msm == 3'b0 &&
		   ex_mem_msl == 3'b0 &&
		   ex_mem_readmem == 0 &&
		   ex_mem_writemem == 0 &&
		   ex_mem_mshw == 0 &&
		   ex_mem_lshw == 0 &&
		   ex_mem_regb == 32'b0 &&
		   ex_mem_selwsource == 3'b0 &&
		   ex_mem_regdest == 5'b0 &&
		   ex_mem_writereg == 0 &&
		   ex_mem_aluout == 32'b0 &&
		   ex_mem_wbvalue == 32'b0)
		   
        begin
            result = result +1;
        end
        testes = testes +1;
		reset <= 0;
		
		 //teste2: teste de variaveis de repasse para a memoria
        #2 //7
       id_ex_msm = 3'b001;
	   id_ex_msl = 3'b001;
	   id_ex_readmem = 1;
	   id_ex_writemem = 1;
	   id_ex_mshw = 1;
	   id_ex_lshw = 1;
	   id_ex_regdest = 1;
	   #2 //9
	   //valores de saida esperado
	   if(ex_mem_msm == 3'b001 &&
		   ex_mem_msl == 3'b001 &&
		   ex_mem_readmem == 1 &&
		   ex_mem_writemem == 1 &&
		   ex_mem_mshw == 1 &&
		   ex_mem_lshw == 1 &&
		   ex_mem_regdest == 1)
		begin
            result = result +1;
        end
        testes = testes +1;		  
        
        #2 //11
        //teste3: teste novamente de reset
        reset = 1;
        #1 //12
        
        //valores de saida para memoria devem ser todos zeros
		if(ex_mem_msm == 3'b0 &&
		   ex_mem_msl == 3'b0 &&
		   ex_mem_readmem == 0 &&
		   ex_mem_writemem == 0 &&
		   ex_mem_mshw == 0 &&
		   ex_mem_lshw == 0 &&
		   ex_mem_regb == 32'b0 &&
		   ex_mem_selwsource == 3'b0 &&
		   ex_mem_regdest == 5'b0 &&
		   ex_mem_writereg == 0 &&
		   ex_mem_aluout == 32'b0 &&
		   ex_mem_wbvalue == 32'b0)
		   
        begin
            result = result +1;
        end
        testes = testes +1;
		
		//teste4: teste da ALU1 com soma dos registradores
		#1 //13
		id_ex_aluop <= 3'b010;
        id_ex_rega <= 1;
		id_ex_regb <= 5;
		id_ex_writereg <= 1;
		id_ex_readmem <= 0;
		id_ex_writemem <= 0;
		#2 //15
		//$display("%d / %d", ex_mem_msm, ex_mem_msl);
		//valores de saida para memoria
		if(ex_fw_wbvalue == 6 &&
		   ex_fw_writereg == 1 &&
		   ex_if_stall == 0 &&
		   ex_mem_regb == 5 &&
		   ex_mem_selwsource == 3'b0 &&
		   ex_mem_writereg == 1 &&
		   ex_mem_aluout == 6 &&
		   ex_mem_wbvalue == 6
		   )   
        begin
            result = result +1;
        end
        testes = testes +1;	
        
        //teste5: teste da ALU2 com soma de imediato
        #2 //17
		id_ex_selimregb <= 1;
		id_ex_imedext <= 2;
		#2 //19
		//valores de saida para memoria
		if(ex_fw_wbvalue == 3 &&
		   ex_fw_writereg == 1 &&
		   ex_if_stall == 0 &&
		   ex_mem_selwsource == 3'b0 &&
		   ex_mem_writereg == 1 &&
		   ex_mem_aluout == 3 &&
		   ex_mem_wbvalue == 3)
		begin
            result = result +1;
        end
        testes = testes +1;	
        
        //teste6: teste da unidade de deslocamento
        #2
        id_ex_selalushift <= 1;
        id_ex_selimregb <= 0;
		id_ex_shiftop <= 2'b10;
		id_ex_shiftamt <= 1;
		id_ex_writeov <= 1;
		#2
		//valores de saida para a memoria
		if(ex_fw_wbvalue == 10 &&
		   ex_fw_writereg == 1 &&
		   ex_if_stall == 0 &&
		   ex_mem_selwsource == 3'b0 &&
		   ex_mem_writereg == 1 &&
		   ex_mem_aluout == 10 &&
		   ex_mem_wbvalue == 10)
		begin
            result = result +1;
        end
        testes = testes +1;	
        
        
	end   
		

endmodule
