`include "../rtl/Comp.v"

module tb_comp (); 

	parameter IGUAL       = 3'b000;
	parameter MAIOR_IGUAL = 3'b001;
	parameter MENOR_IGUAL = 3'b010;
	parameter MAIOR       = 3'b011;
	parameter MENOR       = 3'b100;
	parameter DIFERENTE   = 3'b101;

	reg               clock;
	reg               teste_clock;

	reg        [31:0] a;
	reg        [31:0] b;
	reg        [2:0]  op;
	wire              compout;
	
	Comp comp1(
		.a(a),
		.b(b),
		.op(op),
		.compout(compout)
	);
	
	always #1 clock = ~clock;
	
	always@(posedge clock)
	begin
		if(teste_clock == 1)
		begin
			a = 128;
			b = 128;
			op = IGUAL;
		end
	end

	always@(negedge clock)
	begin
		if(teste_clock == 1)
		begin
	 		$display("// Teste com clock");
			$display("a == b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		//$display();
		    $finish;
		end
	end

	// Seqüência de testes da unidade de comparação
	initial
	begin

		clock = 0;
		teste_clock = 0;

		$display("// Teste (==) Verdadeiro");
    		
		    a = 128;
		    b = 128;
		    op = IGUAL;
	 		#1
	 		$display("a == b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;
    
		$display("// Teste Falso");
    		
		    a = 128;
		    b = 0;
		    op = IGUAL;
	 		#1
	 		$display("a == b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;

		$display("// Teste Verdadeiro 1");
    		
		    a = 128;
		    b = 16;
		    op = MAIOR_IGUAL;
	 		#1
	 		$display("a >= b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;
  
		$display("// Teste Verdadeiro 2");
    		
		    a = 128;
		    b = 128;
		    op = MAIOR_IGUAL;
	 		#1
	 		$display("a >= b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;
  
		$display("// Teste Falso");
    		
		    a = 1;
		    b = 128;
		    op = MAIOR_IGUAL;
	 		#1
	 		$display("a >= b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;

		$display("// Teste Verdadeiro 1");
    		
		    a = 1;
		    b = 16;
		    op = MENOR_IGUAL;
	 		#1
	 		$display("a <= b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;

		$display("// Teste Verdadeiro 2");
    		
		    a = 16;
		    b = 16;
		    op = MENOR_IGUAL;
	 		#1
	 		$display("a <= b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;
   
		$display("// Teste Falso");
    		
		    a = 256;
		    b = 128;
		    op = MENOR_IGUAL;
	 		#1
	 		$display("a <= b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;

		$display("// Teste Verdadeiro");
    		
		    a = 128;
		    b = 16;
		    op = MAIOR;
	 		#1
	 		$display("a > b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;
    
		$display("// Teste Falso");
    		
		    a = 128;
		    b = 128;
		    op = MAIOR;
	 		#1
	 		$display("a > b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;
		
		$display("// Teste Verdadeiro");
    		
		    a = 8;
		    b = 16;
		    op = MENOR;
	 		#1
	 		$display("a < b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;
    
		$display("// Teste Falso");
    		
		    a = 256;
		    b = 256;
		    op = MENOR;
	 		#1
	 		$display("a < b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;

		$display("// Teste Verdadeiro");
    		
		    a = 1;
		    b = 0;
		    op = DIFERENTE;
	 		#1
	 		$display("a != b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;
    
		$display("// Teste Falso");
    		
		    a = 128;
		    b = 128;
		    op = DIFERENTE;
	 		#1
	 		$display("a != b");
    		$display("a: %d ", a);
    		$display("b: %d ", b);
    		$display("compout: %b ", compout);
    		$display;

		teste_clock = 1;

		#1000 $finish;

	end

endmodule
