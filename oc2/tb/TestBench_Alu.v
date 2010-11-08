`include "Alu.v"

module testBench;
  reg uns;
  reg [2:0]  op;
	reg [31:0] a, b;
	wire cmp, ov;
  wire [2:0] wop;
  wire [31:0] wa, wb, wout;
  wire wuns;

  assign wop = op;
  assign wa = a;
  assign wb = b;
  assign wuns = uns;

	Alu alu( wa, wb, wop, wuns, wout, cmp, ov );

	initial begin
	  op  = 3'b000;
	  a   = 0;
	  b   = 0;
	  uns = 1;

		$display("op \t\t a \t\t b \t\t out \t over \t cmp");
		$monitor("%b \t %d \t %d \t %d \t %b \t %b", wop, $unsigned(wa), $unsigned(wb), $unsigned(wout), ov, cmp);
	end

	always begin
          $display("AND");
	  op = 3'b000;
	  a  = 1;
	  b  = 1;
	  #1;

	  op = 3'b001;
	  op = 3'b000;
	  a  = 0;
	  b  = 0;
	  #1;

	  a  = 1;
	  b  = 0;	
	  #1;

	  a  = 4294967295;
	  b  = 4294967295;	  
	  #1;

	  $display("OR");
	  #1 op <= 3'b001;
	  a  <= 1;
	  b  <= 1;
	  #1;

	  a  <= 0;
	  b  <= 0;
	  #1;

	  a  <= 1;
	  b  <= 0;	
	  #1;

	  a  <= 4294967295;
	  b  <= 4294967295;	  
	  #1;


	  $display("SOMA");
	  #1 op <= 3'b010;
	  a  <= 1;
	  b  <= 1;
	  #1;

	  a  <= 0;
	  b  <= 0;
	  #1;

	  a  <= 1;
	  b  <= 0;	
	  #1;

	  a  <= 4294967295;
	  b  <= 4294967295;	  
	  #1;

	  uns <= 0;
	  a  <= -2147483647;
	  b  <= 2147483647;	  
	  #1;

	  a  <= -2147483647;
	  b  <= -2147483647;	  
	  #1;
	  uns <= 1;
	  #1; 


	  $display("NOR");
	  #1 op <= 3'b100;
	  a  <= 1;
	  b  <= 1;
	  #1;

	  a  <= 0;
	  b  <= 0;
	  #1;

	  a  <= 1;
	  b  <= 0;	
	  #1;

	  a  <= 4294967295;
	  b  <= 4294967295;	  
	  #1;


	  $display("XOR");
	  #1 op <= 3'b101;
 	  a  <= 1;
	  b  <= 1;
	  #1;

	  a  <= 0;
	  b  <= 0;
	  #1;

	  a  <= 1;
	  b  <= 0;	
	  #1;

	  a  <= 4294967295;
	  b  <= 4294967295;	  
	  #1; 
	

	  $display("SUB");
	  #1 op <= 3'b110;
	  a  <= 1;
	  b  <= 1;
	  #1;

	  a  <= 0;
	  b  <= 0;
	  #1;

	  a  <= 1;
	  b  <= 0;	
	  #1;

	  a  <= 4294967295;
	  b  <= 4294967295;	  
	  #1;

	  uns <= 0;
	  a  <= -2147483647;
	  b  <= 2147483647;	  
	  #1;

	  a  <= -2147483647;
	  b  <= -2147483647;	  
	  #1;
	  uns <= 1;

	  #1 $display("finished");

	  $finish;
	end
endmodule
