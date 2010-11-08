module Alu(

	input      [31:0] a,
	input      [31:0] b,
	input      [2:0]  op,
	input             unsig,
	output     [31:0] aluout,
	output            compout,
	output            overflow
	
	);

reg[31:0] out_aluout;
reg out_compout;
reg out_overflow;

always @(a or b or op or unsig) begin

	/* CALCULA SAIDA COMPOUT */	
	if (unsig == 1) // unsigned
	    begin	
		if (a < b)
		    begin
			assign out_compout = 1;
		    end
		else
		    begin
			assign out_compout = 0;
		    end
	    end
	else if (a[31] != b[31]) // signed: um e negativo e outro e positivo
	    begin
		if (a[31] == 1)
		    begin
			assign out_compout = 1;
		    end
		else
		    begin
			assign out_compout = 0;
		    end
	    end 	
	else if (a[31] == 0) // signed: ambos positivos
	    begin
		if (a[30:0] < b[30:0])
		    begin
			assign out_compout = 1;
		    end
		else
		    begin
			assign out_compout = 0;
		    end
	    end 
	else	// signed: ambos negativos
	    begin
		if (a[30:0] > b[30:0])
		    begin
			assign out_compout = 1;
		    end
		else
		    begin
			assign out_compout = 0;
		    end
	    end 

        if(op == 3'b000) //AND
            begin
		assign out_aluout = a & b;
	    end

	else if(op == 3'b001) //OR
	    begin
		assign out_aluout = a | b;
	    end

	else if(op == 3'b010) //soma
	    begin
		assign out_aluout = a + b;

		//overflow
		if (unsig == 0) // trata overflow apenas para o caso de numeros com sinal
		begin
			// overflow (caso 1): dois numeros positivos somados resultando
			// em um numero negativo
			if((a[31] == 0) && (b[31] == 0) && (out_aluout[31] == 1))
			    begin
				assign out_overflow = 1;
			    end
			else
			    begin
				assign out_overflow = 0;
			    end

			// overflow (caso 2): dois numeros negativos somados resultando
			// em um numero positivo ou zero
			if((a[31] == 1) && (b[31] == 1) && (out_aluout[31] == 0))
			    begin
				assign out_overflow = 1;
			    end
			else
			    begin
				assign out_overflow = 0;
			    end
		end
	    end

	else if(op == 3'b100) //NOR
	    begin
		assign out_aluout = ~(a | b);
	    end

	else if(op == 3'b101) //XOR
	    begin
		assign out_aluout = a ^ b;
	    end

	else if(op == 3'b110) //subtracao
	    begin
		assign out_aluout = a - b;

		//overflow
		if (unsig == 0) // trata overflow apenas para o caso de numeros com sinal
		begin
			// overflow (caso 1): um numero positivo subtraido de um
			// um numero negativo resultando em um numero negativo
			if((a[31] == 0) && (b[31] == 1) && (out_aluout[31] == 1))
			    begin
				assign out_overflow = 1;
			    end
			else
			    begin
				assign out_overflow = 0;
			    end

			// overflow (caso 2): um numero negativo subtraido de um
			// um numero positivo resultando em um numero positivo
			if((a[31] == 1) && (b[31] == 0) && (out_aluout[31] == 0))
			    begin
				assign out_overflow = 1;
			    end
			else
			    begin
				assign out_overflow = 0;
			    end
		end
	    end
end

assign aluout = out_aluout;
assign compout = out_compout;
assign overflow = out_overflow;

endmodule
