
module Ram(

	input             clock,
	input             reset,
	input      [31:0] addr,
	input             rw,
	input             en1h,
	inout       [7:0] data1h,
	input             en1l,
	inout       [7:0] data1l,
	input             en2h,
	inout       [7:0] data2h,
	input             en2l,
	inout       [7:0] data2l

	);

	reg[7:0] Memory[1023:0];
	reg[31:0] out;
	integer i;

	assign data1h = (~rw && en1h) ? (out[31:24]) : (8'bz);
	assign data1l = (~rw && en1l) ? (out[23:16]) : (8'bz);
	assign data2h = (~rw && en2h) ? (out[15:08]) : (8'bz);
	assign data2l = (~rw && en2l) ? (out[07:00]) : (8'bz);
	
	always @(posedge reset) 
	begin
		for(i = 0; i <= 1023; i = i+1)
		begin
			Memory[i] = 8'b0;
		end
	end

	// read cicle
	always @(posedge clock)
	begin
		out[7:0]   <= Memory[addr+3];
		out[15:8]  <= Memory[addr+2];
		out[23:16] <= Memory[addr+1];
		out[31:24] <= Memory[addr+0];
	end

	// write cicle
	always @(negedge clock)
	begin
		if( en1h == 1'b1 )
			if( rw == 1'b1 )
				Memory[addr+0] = data1h;

		if( en1l == 1'b1 )
			if( rw == 1'b1 )
				Memory[addr+1] = data1l;

		if( en2h == 1'b1 )
			if( rw == 1'b1 )
				Memory[addr+2] = data2h;

		if( en2l == 1'b1 )
			if( rw == 1'b1 )
				Memory[addr+3] = data2l;
	end

	// Descomente para simular a memória com valores iniciais.
	initial #5
		begin 
		$readmemh("memoria.txt", Memory); 
		end
endmodule
