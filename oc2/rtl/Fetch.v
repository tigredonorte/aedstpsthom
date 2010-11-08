module Fetch (

	input             clock ,
	input             reset ,

	// Execute
	input             ex_if_stall ,

	// Forwarding
	input             fw_if_id_stall ,

	// Decode
	output reg [31:0] if_id_proximopc ,
	output reg [31:0] if_id_instrucao ,
	input             id_if_selfontepc ,
	input      [31:0] id_if_rega ,
	input      [31:0] id_if_pcimd2ext ,
	input      [31:0] id_if_pcindex ,
	input       [1:0] id_if_seltipopc ,

	// GDM
	output            if_gdm_en ,
	output     [31:0] if_gdm_addr ,
	input      [31:0] gdm_if_data
	);

	reg        [31:0] pc ;
	reg				  if_gdm_en_reg;
   
	assign if_gdm_en = if_gdm_en_reg;
	assign if_gdm_addr = pc;	 

	//gravar resultados             $display("%b", pc);dos estagios do pipeline na borda de decida do clock
	always@(negedge clock or posedge reset)
	begin
		
      	//reseta os registradores do módulo na borda de subida do reset - nao pode esquecer de dealigar o reset, noentanto
        if (reset)
        begin
            if_gdm_en_reg = 1'b0;
       		pc[31:0] =  32'b0;
    		if_id_proximopc[31:0]  = 32'b0;
    		if_id_instrucao[31:0]  = 32'b0;
    	end
        else
        begin
			//estagio de execussao - resolucao de Hazards
			if_gdm_en_reg=1'b1;
			if( ex_if_stall == 1'b1)
			begin
				if_id_proximopc = pc;
				if_id_instrucao = 32'b0;

			end	
			else if(fw_if_id_stall == 1'b0)
			begin
				if_id_instrucao = gdm_if_data; // passa a instrucao para o id da instrucao
				
			
				//se o pc será incrementado ou se virá de outro estagio
				if( id_if_selfontepc == 1'b0 )
					pc = pc + 4;
				else
				begin
					 case(id_if_seltipopc)
							2'b00: pc = id_if_pcimd2ext;
							2'b01: pc = id_if_rega;
							2'b10: pc = id_if_pcindex;
							2'b11: pc = 32'd64;
					 endcase
				end
				if_id_proximopc = pc;
			end	
		end	
		//estagio de execussao - resolucao de Hazards
		//parte dogdm
	end//end always



endmodule

