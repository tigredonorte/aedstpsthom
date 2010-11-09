module Alu(

	input      [31:0] a,
	input      [31:0] b,
	input      [2:0]  op,
	input             unsig,
	output reg [31:0] aluout,
	output reg        compout,
	output reg        overflow
	
	);
	
  always @( a || b || op || unsig ) begin
    compout = (unsig) ? ($unsigned(a) < $unsigned(b)) : ($signed(a) < $signed(b));
	overflow = 1'b0;
    case(op)
      //and
      3'b000:
        	aluout = (a & b);
        	
      //or
      3'b001:
        	aluout = (a | b);
        	
      //nor
      3'b100:
        	aluout = ~(a | b);
        	
      //xor
      3'b101:
        	aluout = (a ^ b);        	

      //soma
      3'b010:
      begin
        aluout   = (unsig) ? ($unsigned(a) + $unsigned(b)) : ($signed(a) + $signed(b));
        overflow = (unsig) ? 1'b0: 
                    ((($signed(a) >= 0) && ($signed(b) >= 0)) ? ($signed(aluout) <  0) : 
                    ((($signed(a) <  0) && ($signed(b) <  0)) ? ($signed(aluout) >= 0) : (1'b0)));
      end
      //sub
      3'b110:
      begin
        aluout   = (unsig) ? ($unsigned(a) - $unsigned(b)) : ($signed(a) - $signed(b));
        overflow = (unsig) ?  1'b0 : 
                    ((($signed(a) >= 0) && ($signed(b) < 0)) ? ($signed(aluout) <  0) : 
                    ((($signed(a) <  0) && ($signed(b) >=  0)) ? ($signed(aluout) >= 0) : (1'b0)));
      end
    endcase
  end

endmodule
