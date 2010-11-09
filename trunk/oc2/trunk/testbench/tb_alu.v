`include "../rtl/Alu.v"

module tb_alu (); 

  parameter AND = 3'b000;
  parameter OR  = 3'b001;
  parameter ADD = 3'b010;
  parameter NOR = 3'b100;
  parameter XOR = 3'b101;
  parameter SUB = 3'b110;

	reg               clock;
	reg               teste_clock;

	reg        [31:0] a;
	reg        [31:0] b;
	reg        [2:0]  op;
	reg               unsig;
	wire       [31:0] aluout;
	wire              compout;
	wire              overflow;
	
	Alu alu1(
		.a(a),
		.b(b),
		.op(op),
		.unsig(unsig),
		.aluout(aluout),
		.compout(compout),
		.overflow(overflow)
	);
	
	always #1 clock = ~clock;
	
	always@(posedge clock)
	begin
		if(teste_clock == 1)
		  begin
	      a = 50;
	      b = 200;
	      op = ADD;
	      unsig = 0;
		  end
	end

	always@(negedge clock)
	begin
		if(teste_clock == 1)
			begin
		    $display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("aluout:   %d", aluout);
		    $display("compout:  %b", compout);
		    $display("overflow: %b", overflow);
		    $finish;
			end
	end

	// Seqüência de testes ALU	
	initial
	begin

		clock = 0;
		teste_clock = 0;

		$display("++ Operacoes aritmeticas com sinal");
		unsig = 0;
		
    		$display("// Teste quando ocorre overflow");
    		
    		a = 2147483647;
    		b = 128;
    		op = ADD;
    		#1
    		$display("a >= 0, b >= 0 -> r < 0");
    		$display("ADD e ADDI");
    		$display("unsig: %b ", unsig);
			$display("a: %d  (2147483647)", a);
    		$display("b: %d  (128)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		a = -2147483640;
    		b = -128;
    		op = ADD;
    		#1
    		$display("a < 0, b < 0 -> r >= 0");
			$display("ADD e ADDI");
    		$display("unsig: %b ", unsig);
			$display("a: %d  (-2147483640)", a);
    		$display("b: %d  (-128)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		a = 2147483647;
    		b = -128;
    		op = SUB;
    		#1
    		$display("a >= 0, b < 0 -> r < 0");
    		$display("SUB");
    		$display("unsig: %b ", unsig);
			$display("a: %d  (2147483647)", a);
    		$display("b: %d  (-128)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		a = -128;
    		b = 2147483647;
    		op = SUB;
    		#1
    		$display("a < 0, b >= 0 -> r >= 0");
    		$display("SUB");
    		$display("unsig: %b ", unsig);
			$display("a: %d  (-128)", a);
    		$display("b: %d  (2147483647)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		$display("// Teste quando nao ocorre overflow");
    		
    		a = 256;
    		b = 128;
    		op = ADD;
    		#1
    		$display("a >= 0, b >= 0 -> r < 0");
    		$display("ADD e ADDI");
    		$display("unsig: %b ", unsig);
			$display("a: %d  (256)", a);
    		$display("b: %d  (128)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		a = -256;
    		b = -128;
    		op = ADD;
    		#1
    		$display("a < 0, b < 0 -> r >= 0");
    		$display("ADD e ADDI");
    		$display("unsig: %b ", unsig);
			$display("a: %d  (-256)", a);
    		$display("b: %d  (-128)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    		
    		a = 256;
    		b = -128;
    		op = SUB;
    		#1
    		$display("a >= 0, b < 0 -> r < 0");
    		$display("SUB");
    		$display("unsig: %b ", unsig);
			$display("a: %d  (256)", a);
    		$display("b: %d  (-128)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		a = -128;
    		b = 256;
    		op = SUB;
    		#1
    		$display("a < 0, b >= 0 -> r >= 0");
    		$display("SUB");
    		$display("unsig: %b ", unsig);
			$display("a: %d  (-128)", a);
    		$display("b: %d  (256)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;

		$display("++ Operacoes aritmeticas sem sinal");
		unsig = 1;
    		
    		$display("// Condicoes de overflow para signed, que nao ocorrem para unsigned.");
    		
    		a = 2147483647;
    		b = 128;
    		op = ADD;
    		#1
    		$display("a >= 0, b >= 0 -> r < 0");
			$display("ADDU e ADDIU");
    		$display("unsig: %b ", unsig);
			$display("a: %d  (2147483647)", a);
    		$display("b: %d  (128)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		a = -2147483640;
    		b = -128;
    		op = ADD;
    		#1
    		$display("a < 0, b < 0 -> r >= 0");
			$display("ADDU e ADDIU");
    		$display("unsig: %b ", unsig);
			$display("a: %d  (-2147483640)", a);
    		$display("b: %d  (-128)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		a = 2147483647;
    		b = -128;
    		op = SUB;
    		#1
    		$display("a >= 0, b < 0 -> r < 0");
			$display("SUBU");
    		$display("unsig: %b ", unsig);
			$display("a: %d  (2147483647)", a);
    		$display("b: %d  (-128)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		a = -128;
    		b = 2147483647;
    		op = SUB;
    		#1
    		$display("SUBU");
			$display("a < 0, b >= 0 -> r >= 0");
   			$display("unsig: %b ", unsig);
			$display("a: %d  (-128)", a);
    		$display("b: %d  (2147483647)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		$display("// Condicoes de nao overflow para signed, e que tambem nao ocorrem para unsigned.");
    		
    		a = 256;
    		b = 128;
    		op = ADD;
    		#1
    		$display("a >= 0, b >= 0 -> r < 0");
    		$display("ADDU e ADDIU");
   			$display("unsig: %b ", unsig);
    		$display("a: %d  (256)", a);
    		$display("b: %d  (128)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		a = -256;
    		b = -128;
    		op = ADD;
    		#1
    		$display("a < 0, b < 0 -> r >= 0");
   			$display("ADDU e ADDIU");
  			$display("unsig: %b ", unsig);
  			$display("a: %d  (-256)", a);
    		$display("b: %d  (-128)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    		
    		a = 256;
    		b = -128;
    		op = SUB;
    		#1
    		$display("a >= 0, b < 0 -> r < 0");
    		$display("SUBU");
   			$display("unsig: %b ", unsig);
 	  		$display("a: %d  (256)", a);
    		$display("b: %d  (-128)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		a = -128;
    		b = 256;
    		op = SUB;
    		#1
    		$display("a < 0, b >= 0 -> r >= 0");
    		$display("SUBU");
    		$display("unsig: %b ", unsig);
			$display("a: %d  (-128)", a);
    		$display("b: %d  (256)", b);
    		$display("r: %d  (%b)", aluout, aluout);
    		$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;

		$display("++ Operacoes logicas");

    		a = 32'b111111111111110010100000000000;
    		b = 32'b111100000000110001101111100000;
    
    		op = OR;
    		#1
    		$display("OR");
    		$display("a: %b", a);
    		$display("b: %b", b);
    		$display("r: %b", aluout);
			$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		op = NOR;
    		#1
    		$display("NOR");
    		$display("a: %b", a);
    		$display("b: %b", b);
    		$display("r: %b", aluout);
			$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    		
    		op = XOR;
    		#1
    		$display("XOR");
    		$display("a: %b", a);
    		$display("b: %b", b);
    		$display("r: %b", aluout);
			$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;
    
    		op = AND;
    		#1
    		$display("AND");
    		$display("a: %b", a);
    		$display("b: %b", b);
    		$display("r: %b", aluout);
			$display("overflow: %b", overflow);
    		$display("compout:  %b", compout);
    		$display;

		$display("++ Operacoes SLT com sinal (SLT e SLTI)");

    		op = SUB;
    		unsig = 0;
    		
    		a = -128;
    		b = 256;
    		#1
    		$display("SLT e SLTI");
    		$display("unsig: %b ", unsig);
			$display("a: %b  (-128)", a);
    		$display("b: %b  (256)", b);
			$display("compout: %b", compout);
    		$display("r: %b", aluout);
    		$display("overflow: %b", overflow);
    		$display;

    		a = 128;
    		b = -256;
    		#1
    		$display("SLT e SLTI");
    		$display("unsig: %b ", unsig);
			$display("a: %b  (128)", a);
    		$display("b: %b  (-256)", b);
			$display("compout: %b", compout);
    		$display("r: %b", aluout);
    		$display("overflow: %b", overflow);
    		$display;

    		a = 128;
    		b = 256;
    		#1
    		$display("SLT e SLTI");
    		$display("unsig: %b ", unsig);
			$display("a: %b  (128)", a);
    		$display("b: %b  (256)", b);
			$display("compout: %b", compout);
    		$display("r: %b", aluout);
    		$display("overflow: %b", overflow);
    		$display;

    		a = -128;
    		b = -256;
    		#1
    		$display("SLT e SLTI");
    		$display("unsig: %b ", unsig);
			$display("a: %b  (-128)", a);
    		$display("b: %b  (-256)", b);
			$display("compout: %b", compout);
    		$display("r: %b", aluout);
    		$display("overflow: %b", overflow);
    		$display;

		$display("++ Operacoes SLT sem sinal (SLTU e SLTIU)");

    		op = SUB;
    		unsig = 1;
    		
    		a = -128;
    		b = 256;
    		#1
    		$display("SLTU e SLTIU");
    		$display("unsig: %b ", unsig);
			$display("a: %b  (-128)", a);
    		$display("b: %b  (256)", b);
			$display("compout: %b", compout);
    		$display("r: %b", aluout);
    		$display("overflow: %b", overflow);
    		$display;

    		a = 128;
    		b = -256;
    		#1
    		$display("SLTU e SLTIU");
    		$display("unsig: %b ", unsig);
			$display("a: %b  (128)", a);
    		$display("b: %b  (-256)", b);
			$display("compout: %b", compout);
    		$display("r: %b", aluout);
    		$display("overflow: %b", overflow);
    		$display;

    		a = 128;
    		b = 256;
    		#1
    		$display("SLTU e SLTIU");
 			$display("unsig: %b ", unsig);
	   		$display("a: %b  (128)", a);
    		$display("b: %b  (256)", b);
			$display("compout: %b", compout);
    		$display("r: %b", aluout);
    		$display("overflow: %b", overflow);
    		$display;

    		a = -128;
    		b = -256;
    		#1
    		$display("SLTU e SLTIU");
    		$display("unsig: %b ", unsig);
			$display("a: %b  (-128)", a);
    		$display("b: %b  (-256)", b);
			$display("compout: %b", compout);
    		$display("r: %b", aluout);
    		$display("overflow: %b", overflow);
    		$display;

		teste_clock = 1;

		#1000 $finish;

	end

endmodule
