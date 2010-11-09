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
   
	assign if_gdm_en = ~reset;
	assign if_gdm_addr = pc;
	
	always @(reset or fw_if_id_stall) begin
		if(reset || fw_if_id_stall) begin
       		pc[31:0] =  32'b0;
    		if_id_proximopc[31:0]  = 32'b0;
    		if_id_instrucao[31:0]  = 32'bx;
		end	
	end

	always@(negedge clock)
	begin
        if(~(reset || fw_if_id_stall))
        begin
			if_id_instrucao = gdm_if_data; // passa a instrucao para o id da instrucao
		
			//se o pc será incrementado ou se virá de outro estagio
			if( id_if_selfontepc == 1'b0 )
			begin
				pc = pc + 4;
			end
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
	end//end always
endmodule

