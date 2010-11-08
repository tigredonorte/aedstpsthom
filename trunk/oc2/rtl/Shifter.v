
module Shifter(

	input	[31:0] value_in,
	input	 [1:0] shiftop,
	input	 [4:0] shiftamt,

	output	reg [31:0] result

	);

	reg [31:0] value;
	reg msb;
	integer i;

	always @ (value_in or shiftop or shiftamt)
	begin
		case (shiftop)
		2'b00: value = value_in >> shiftamt;
		2'b01: 
			begin
				msb = value_in[31];
				value = value_in >> shiftamt;
				for (i=(31-shiftamt);i<=31;i=i+1)
				begin
					value[i] = msb;
				end
			end
		2'b10: value = value_in << shiftamt;
		default: value = value_in;
		endcase
		result <= value;
	end

	//assign result = value;

endmodule

