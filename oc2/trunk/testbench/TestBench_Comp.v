`include "Comp.v"

module tb_comp (); 

	

	parameter BEQ = 3'b000;
	parameter BGE  = 3'b001;
	parameter BLE = 3'b010;
	parameter BGT = 3'b011;
	parameter BLT = 3'b100;
	parameter BNE = 3'b101;

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
	


	
	initial
	begin

		clock = 0;
		teste_clock = 0; // Desabilita teste do clock.

		$display("++ Operacoes de comparacao");
		
    		$display("// Teste de comparacao A==B");
    		a = 128;
    		b = 128;
    		op = BEQ;
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A==B");
    		a = 129;
    		b = 128;
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A>=B");
    		a = 128;
    		b = 128;
    		op = BGE;
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A>=B");
    		a = 12;
    		b = 128;
    		op = BGE;
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A>=B");
    		a = 128;
    		b = 12;
    		op = BGE;
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A<=B");
    		a = 128;
    		b = 128;
    		op = BLE;
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A<=B");
    		a = 1;
    		b = 128;
    		op = BLE;
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A<=B");
    		a = 128;
    		b = 12;
    		op = BLE;
    		
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A>B");
    		a = 128;
    		b = 128;
    		op = BGT;
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A>B");
    		a = 1;
    		b = 128;
    		op = BGT;
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A>B");
    		a = 128;
    		b = 1;
    		op = BGT;
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A<B");
    		a = 128;
    		b = 128;
    		op = BLT;
			
			#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A<B");
    		a = 12;
    		b = 128;
    		op = BLT;
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A<B");
    		a = 128;
    		b = 12;
    		op = BLT;
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A!=B");
    		a = 128;
    		b = 128;
    		op = BNE;    
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A!=B");
    		a = 12;
    		b = 128;
    		op = BNE;    
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    		
    		$display("// Teste de comparacao A!=B");
    		a = 128;
    		b = 12;
    		op = BNE; 
    		
    		#1
    		$display("a:        %d", a);
		    $display("b:        %d", b);
		    $display("op:       %d", op);
		    $display("compout:   %d", compout);
    		$display;
    	   
		// ...

		teste_clock = 1; // Habilita teste do clock.

		#1 $finish;

	end

endmodule
