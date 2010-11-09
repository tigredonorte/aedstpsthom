`include "Shifter.v"
module TestBench;
	reg [1:0] shiftop;
	reg [4:0] shiftamt;
	wire [31:0] value_in;
	wire [31:0] result;

	reg [31:0] value;
	reg clk;

	Shifter shift1 (value_in, shiftop, shiftamt, result);

	assign value_in = value;


	initial begin
		clk <= 0;
		shiftop <= 2'b0;
		shiftamt <= 5'b0;
		value <= 32'b0;

		$display("clk value_in\t\t\t   op amt result");
		$monitor("%b %b %b %b %b", clk, value_in, shiftop, shiftamt, result);
	
	end

	initial begin
		// Shift Logico à direita
		#1 $display("Shift logico direita");
		#0 shiftop <= 2'b00;
		#0 shiftamt <= 5'b00001;
		#0 value <= 32'b11111111000000000000000000000000;
		
		#1 shiftamt <= 5'b00010;
		#1 shiftamt <= 5'b00011;
		#1 shiftamt <= 5'b00100;
		#1 shiftamt <= 5'b00101;

		#1 value <= 32'b11111111;
		#0 shiftamt <= 5'b00001;
		#1 shiftamt <= 5'b00010;
		#1 shiftamt <= 5'b00011;
		#1 shiftamt <= 5'b00100;
		#1 shiftamt <= 5'b00101;

		//Shift Logico à esquerda
		#1 $display("Shift logico esquerda");
		#0 shiftop <= 2'b10;
		#0 shiftamt <= 5'b00001;
		#0 value <= 32'b11111111000000000000000000000000;
		
		#1 shiftamt <= 5'b00010;
		#1 shiftamt <= 5'b00011;
		#1 shiftamt <= 5'b00100;
		#1 shiftamt <= 5'b00101;

		#1 value <= 32'b11111111;
		#0 shiftamt <= 5'b00001;
		#1 shiftamt <= 5'b00010;
		#1 shiftamt <= 5'b00011;
		#1 shiftamt <= 5'b00100;
		#1 shiftamt <= 5'b00101;

		//Shift Aritimético à direita
		#1 $display("Shift aritmetico direita");
		#0 shiftop <= 2'b01;
		#0 shiftamt <= 5'b00001;
		#0 value <= 32'b11111111000000000000000000000000;
		
		#1 shiftamt <= 5'b00010;
		#1 shiftamt <= 5'b00011;
		#1 shiftamt <= 5'b00100;
		#1 shiftamt <= 5'b00101;

		#1 value <= 32'b11111111;
		#0 shiftamt <= 5'b00001;
		#1 shiftamt <= 5'b00010;
		#1 shiftamt <= 5'b00011;
		#1 shiftamt <= 5'b00100;
		#1 shiftamt <= 5'b00101;


	end	
	
	always begin
			repeat(31) begin
			#1 clk = !clk;
		end
		$finish;
	end

endmodule
