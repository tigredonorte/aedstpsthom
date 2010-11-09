`include "../rtl/Shifter.v"

module tb_shifter (); 
/*
	parameter TESTE_SLL = 3'd1;
	parameter TESTE_SRL = 3'd2;
	parameter TESTE_SLLV;
	parameter TESTE_SRLV;
	parameter TESTE_SRAV;	
*/
	reg               clock;
	reg               teste_clock;

	reg        [31:0] value_in;
	reg         [1:0] shiftop;
	reg         [4:0] shiftamt;
	wire       [31:0] result;

	Shifter shifter1(
		.value_in(value_in),
		.shiftop(shiftop),
		.shiftamt(shiftamt),
		.result(result)
	);
	
	always #1 clock = ~clock;
	
	always@(posedge clock)
	begin
		if(teste_clock == 1)
		begin
			value_in = 32'hFFFFFFFF;
    		shiftop  = 2'b10;
    		shiftamt = 5'd6;
		end
	end

	always@(negedge clock)
	begin
		if(teste_clock == 1)
		begin
			$display("// Simulando com o evento de clock (Teste SLL)");
    		$display("value_in : %b", value_in);
    		$display("shiftop  : %b", shiftop);
    		$display("shiftamt : %d", shiftamt);
		    $display("result(d): %d", result);
		    $display("result(b): %b", result);
    		$display;
		    $finish;
		end
	end

	// Seqüência de testes ALU	
	initial
	begin

		clock = 0;
		teste_clock = 0;

		$display("++ Shift Logico");

			$display("// SLL - Shift Logico Esquerda");
    		value_in = 32'hFFFFFFFF;
    		shiftop  = 2'b10;
    		shiftamt = 5'd6;
    		#1
    		$display("value_in : %b", value_in);
    		$display("shiftop  : %b", shiftop);
    		$display("shiftamt : %d", shiftamt);
		    $display("result(d): %d", result);
		    $display("result(b): %b", result);
    		$display;
 
			$display("// SRL - Shift Logico Direita");
    		value_in = 32'hFFFFFFFF;
    		shiftop  = 2'b00;
    		shiftamt = 5'd24;
    		#1
    		$display("value_in : %b", value_in);
    		$display("shiftop  : %b", shiftop);
    		$display("shiftamt : %d", shiftamt);
		    $display("result(d): %d", result);
		    $display("result(b): %b", result);
    		$display;
   			
			$display("// SRA - Shift Aritmetico a Direita - Teste 1");
    		value_in = 32'hAAAAAAAA;
    		shiftop  = 2'b01;
    		shiftamt = 5'd6;
    		#1
    		$display("value_in : %b", value_in);
    		$display("shiftop  : %b", shiftop);
    		$display("shiftamt : %d", shiftamt);
		    $display("result(d): %d", result);
		    $display("result(b): %b", result);
    		$display;

			$display("// SRA - Shift Aritmetico a Direita - Teste 2");
    		value_in = 32'h55555555;
    		shiftop  = 2'b01;
    		shiftamt = 5'd6;
    		#1
    		$display("value_in : %b", value_in);
    		$display("shiftop  : %b", shiftop);
    		$display("shiftamt : %d", shiftamt);
		    $display("result(d): %d", result);
		    $display("result(b): %b", result);
    		$display;

		teste_clock = 1;

		#1000 $finish;

	end

endmodule
