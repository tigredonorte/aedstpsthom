`include "fetch.v"

module TestBenchFetch;
    //inputs
    reg clock, reset, ex_if_stall, fw_if_id_stall, id_if_selfontepc;
	reg [31:0] id_if_rega;
	reg [31:0] id_if_pcimd2ext;
	reg [31:0] id_if_pcindx;
	reg [1:0] id_if_seltipopc;
    //GDM
    reg [31:0] gdm_if_data;
    //outputs
    wire [31:0] if_id_proximopc;
	wire [31:0] if_id_instrucao;
	// GDM
	wire if_gdm_en;
	wire [31:0] if_gdm_addr;

    //aux
    reg [8:0] result;
    reg [8:0] testes;
    reg [31:0] auxA;
    reg [31:0] auxB;
    Fetch fecth1 (
        clock ,
        reset ,
        // Execute
        ex_if_stall ,
        // Forwarding
        fw_if_id_stall ,
        // Decode
        if_id_proximopc ,
        if_id_instrucao ,
    	id_if_selfontepc ,
        id_if_rega ,
        id_if_pcimd2ext ,
        id_if_pcindx ,
        id_if_seltipopc ,
        // GDM
        if_gdm_en ,
        if_gdm_addr,
	    gdm_if_data
    );



	initial begin
        clock   <= 0;
        testes <= 8'b0;
        result <= 8'b0;
	//inicializa
      #2
        reset <= 0;
        ex_if_stall <= 0;
        fw_if_id_stall <= 0;
        id_if_selfontepc <= 0;
	    id_if_rega <= 32'b0;
	    id_if_pcimd2ext <= 32'b0;
	    id_if_pcindx <= 32'b0;
	    id_if_seltipopc <= 2'b0;
    
        gdm_if_data <= 32'b00001011;
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
    //teste1: reset
        reset <= 1;
      #2
        if( if_id_proximopc == 32'b0 &&
            if_id_instrucao == 32'b0 &&
            if_gdm_en == 1'b0 &&
            if_gdm_addr == 32'b0)
        begin
//            $display( "Teste 1: passou");
            result = result +1;
        end
        testes = testes +1;
        reset <= 0;
    //teste2: ex_if_stall
      #2
        ex_if_stall <= 1;
      #2
        if( if_id_proximopc == if_gdm_addr &&
            if_id_instrucao == 32'b0 )
        begin
//            $display( "Teste 2: passou");
            result = result +1;
        end
        testes = testes +1;
      #2
        ex_if_stall <= 0;
    //teste3: id_if_selfontepc = 0;
      #2
        auxA <= if_gdm_addr;      
        id_if_selfontepc <= 0;
      #2
        if( (auxA + 4) == if_gdm_addr )
        begin
//            $display( "Teste 3: passou");
            result = result +1;
        end
        testes = testes +1;
    //teste4: id_if_selfontepc = 1, id_if_seltipopc = 00
            //id_if_pcimd2ext 
      #2
        id_if_selfontepc <= 1;
        id_if_seltipopc <= 2'b00;
        id_if_pcimd2ext <= if_gdm_addr + 32;
      #2
        if(if_gdm_addr == id_if_pcimd2ext)
        begin
//            $display( "Teste 4: passou");
            result = result +1;
        end
        testes = testes +1;
        id_if_selfontepc <= 0;
    //teste5: id_if_selfontepc = 1, id_if_seltipopc = 01
            //id_if_rega
      #2
        id_if_selfontepc <= 1;
        id_if_seltipopc <= 2'b01;
        id_if_rega <= 23;
      #2
        if(if_gdm_addr == id_if_rega)
        begin
//            $display( "Teste 5: passou");
            result = result + 1;
        end
        testes = testes +1;
        id_if_selfontepc <= 0;
    //teste6: id_if_selfontepc = 1, id_if_seltipopc = 10
            //id_if_pcindx
      #2
        id_if_selfontepc <= 1;
        id_if_seltipopc <= 2'b10;
        id_if_pcindx <= if_gdm_addr << 1;
      #2
        if(if_gdm_addr == id_if_pcindx)
        begin
//            $display( "Teste 6: passou");
            result = result + 1;
        end
        testes = testes +1;
        id_if_selfontepc <= 0;
    //teste7: id_if_selfontepc = 1, id_if_seltipopc = 11
            //32'd64
      #2
        id_if_selfontepc <= 1;
        id_if_seltipopc <= 2'b11;
      #2
        if(if_gdm_addr == 32'd64)
        begin
//            $display( "Teste 7: passou");
            result = result + 1;
        end
        testes = testes +1;
    //teste8: id_if_selfontepc = 0;
      #2
        auxA <= if_gdm_addr;      
        id_if_selfontepc <= 0;
      #2
        if( (auxA + 4) == if_gdm_addr )
        begin
//            $display( "Teste 8: passou");
            result = result +1;
        end
        testes = testes +1;
    //teste9: fw_if_id_stall
      #2
        auxA = if_id_proximopc;
        auxB = if_id_instrucao;
        fw_if_id_stall <= 1;
      #2
        if( if_id_proximopc == auxA &&
            if_id_instrucao == auxB )
        begin
//            $display( "Teste 9: passou");
            result = result +1;
        end
        testes = testes +1;
      #2
        fw_if_id_stall <= 0;
    //teste10: reset
      #2
        reset <= 1;
      #1
        if( if_id_proximopc == 32'b0 &&
            if_id_instrucao == 32'b0 &&
            if_gdm_en == 1'b0 &&
            if_gdm_addr == 32'b0)
        begin
//            $display( "Teste 10: passou");
            result = result +1;
        end
        testes = testes +1;
      #2
        reset <= 0;

    //teste11: ex_if_stall
      #2
        ex_if_stall <= 1;
      #2
        if( if_id_proximopc == if_gdm_addr &&
            if_id_instrucao == 32'b0 )
        begin
//            $display( "Teste 11: passou");
            result = result +1;
        end
        testes = testes +1;

  //testes com o flag stall ativo - execucao
        //$display("testes com o flag stall ativo\n")
    //teste3: id_if_selfontepc = 0;
      #2
        auxA <= if_gdm_addr;      
        id_if_selfontepc <= 0;
      #2
         if( if_id_proximopc == if_gdm_addr &&
            if_id_instrucao == 32'b0 )
        begin
//            $display( "Teste 12: passou");
            result = result +1;
        end
        testes = testes +1;
    //teste4: id_if_selfontepc = 1, id_if_seltipopc = 00
            //id_if_pcimd2ext 
      #2
        id_if_selfontepc <= 1;
        id_if_seltipopc <= 2'b00;
        id_if_pcimd2ext <= if_gdm_addr + 32;
      #2
        if( if_id_proximopc == if_gdm_addr &&
            if_id_instrucao == 32'b0 )
        begin
//            $display( "Teste 13: passou");
            result = result +1;
        end
        testes = testes +1;
        id_if_selfontepc <= 0;
    //teste5: id_if_selfontepc = 1, id_if_seltipopc = 01
            //id_if_rega
      #2
        id_if_selfontepc <= 1;
        id_if_seltipopc <= 2'b01;
        id_if_rega <= 23;
      #2
        if( if_id_proximopc == if_gdm_addr &&
            if_id_instrucao == 32'b0 )
        begin
//            $display( "Teste 14: passou");
            result = result +1;
        end
        testes = testes +1;
        id_if_selfontepc <= 0;
    //teste6: id_if_selfontepc = 1, id_if_seltipopc = 10
            //id_if_pcindx
      #2
        id_if_selfontepc <= 1;
        id_if_seltipopc <= 2'b10;
        id_if_pcindx <= if_gdm_addr << 1;
      #2
        if( if_id_proximopc == if_gdm_addr &&
            if_id_instrucao == 32'b0 )
        begin
//            $display( "Teste 15: passou");
            result = result +1;
        end
        testes = testes +1;
        id_if_selfontepc <= 0;
    //teste7: id_if_selfontepc = 1, id_if_seltipopc = 11
            //32'd64
      #2
        id_if_selfontepc <= 1;
        id_if_seltipopc <= 2'b11;
      #2
        if( if_id_proximopc == if_gdm_addr &&
            if_id_instrucao == 32'b0 )
        begin
//            $display( "Teste 16: passou");
            result = result +1;
        end
        testes = testes +1;
    //teste8: id_if_selfontepc = 0;
      #2
        auxA <= if_gdm_addr;      
        id_if_selfontepc <= 0;
      #2
        if( if_id_proximopc == if_gdm_addr &&
            if_id_instrucao == 32'b0 )
        begin
//            $display( "Teste 17: passou");
            result = result +1;
        end
        testes = testes +1;
      #2
        ex_if_stall <= 0;
  //testes com o flag stall ativo - fowarding    
      #2
        auxA = if_id_proximopc;
        auxB = if_id_instrucao;
        fw_if_id_stall <= 1;
    //teste3: id_if_selfontepc = 0;
      #2
        //auxA <= if_gdm_addr;      
        id_if_selfontepc <= 0;
      #2
        if( if_id_proximopc == auxA &&
            if_id_instrucao == auxB )
        begin
//            $display( "Teste 18: passou");
            result = result +1;
        end
        testes = testes +1;
      #2
        auxA = if_id_proximopc;
        auxB = if_id_instrucao;
    //teste4: id_if_selfontepc = 1, id_if_seltipopc = 00
            //id_if_pcimd2ext 
      #2
        id_if_selfontepc <= 1;
        id_if_seltipopc <= 2'b00;
        id_if_pcimd2ext <= if_gdm_addr + 32;
      #2
        if( if_id_proximopc == auxA &&
            if_id_instrucao == auxB )
        begin
//            $display( "Teste 19: passou");
            result = result +1;
        end
        testes = testes +1;
        id_if_selfontepc <= 0;
      #2
        auxA = if_id_proximopc;
        auxB = if_id_instrucao;
    //teste5: id_if_selfontepc = 1, id_if_seltipopc = 01
            //id_if_rega
      #2
        id_if_selfontepc <= 1;
        id_if_seltipopc <= 2'b01;
        id_if_rega <= 23;
      #2
        if( if_id_proximopc == auxA &&
            if_id_instrucao == auxB )
        begin
//            $display( "Teste 20: passou");
            result = result +1;
        end
        testes = testes +1;
        id_if_selfontepc <= 0;
      #2
        auxA = if_id_proximopc;
        auxB = if_id_instrucao;
    //teste6: id_if_selfontepc = 1, id_if_seltipopc = 10
            //id_if_pcindx
      #2
        id_if_selfontepc <= 1;
        id_if_seltipopc <= 2'b10;
        id_if_pcindx <= if_gdm_addr << 1;
      #2
        if( if_id_proximopc == auxA &&
            if_id_instrucao == auxB )
        begin
//            $display( "Teste 21: passou");
            result = result +1;
        end
        testes = testes +1;
        id_if_selfontepc <= 0;
      #2
        auxA = if_id_proximopc;
        auxB = if_id_instrucao;
    //teste7: id_if_selfontepc = 1, id_if_seltipopc = 11
            //32'd64
      #2
        if( if_id_proximopc == auxA &&
            if_id_instrucao == auxB )
        begin
//            $display( "Teste 22: passou");
            result = result +1;
        end
        testes = testes +1;
        id_if_selfontepc <= 0;
    end

endmodule


