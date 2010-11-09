//include Ram.v
`include "Ram.v" 

module testBench();
	//inputs Ram
	reg clock, reset, rw;
	reg [31:0] addr;
	reg en1h, en1l, en2h, en2l;
	//inout Ram
	wire [7:0] wdata1h, wdata1l, wdata2h, wdata2l;
	//outputs TestBench
	reg [7:0] indata1h, indata1l, indata2h, indata2l;
	reg [7:0] outdata1h, outdata1l, outdata2h, outdata2l;
	

	//to r/w enXX=1, to w rw = 1, to r rw = 0
	assign wdata1h = (rw && en1h) ? (indata1h) : (8'bz);
	assign wdata1l = (rw && en1l) ? (indata1l) : (8'bz);
	assign wdata2h = (rw && en2h) ? (indata2h) : (8'bz);
	assign wdata2l = (rw && en2l) ? (indata2l) : (8'bz);
	
	//"create" Ram
	Ram m(clock, reset, addr, rw, en1h, wdata1h, en1l, wdata1l, en2h, wdata2h, en2l, wdata2l);
	
	initial begin

		clock   <= 0;
		reset   <= 0;
		addr    <= 0;
		rw      <= 0;
		en1h    <= 0;
		en2h    <= 0;
		en1l    <= 0;
		en2l    <= 0;
		indata1h <= 0;
		indata2h <= 0;
		indata1l <= 0;
		indata2l <= 0;
	
		$display("clock reset \t   addr(dec) rw enab wdata(bin) \t\t\trdata(bin)");
		$monitor("%b \t %b %d \t     %b  %b %b %b", clock, reset, addr, rw, {en1h, en2h, en1l, en2l}, {indata1h, indata2h, indata1l, indata2l}, {wdata1h, wdata2h, wdata1l, wdata2l});
	end
		
	initial begin
		#0 outdata1h = 0;
		#0 outdata1l = 0;
		#0 outdata2h = 0;
		#0 outdata2l = 0;
		// test enable and write
		$display("\t \t \t test enable and write");
		#2 addr    <= 0;
		#0 en1h    <= 1;
		#0 en2h    <= 1;
		#0 en1l    <= 1;
		#0 en2l    <= 1;
		#0 rw      <= 1;
		#0 indata1h <= 240;
		#0 indata1l <= 153;
		#0 indata2h <= 129;
		#0 indata2l <= 15;
		#1 rw      <= 0;

		// view address
		#1 addr   <= 0;
	    $display("\t \t \t view address");
		#1 addr   <= 10;
		#1 addr   <= 255;

		// test reset
		#1 reset  <= 1;
		$display("\t \t \t test reset");
		#1 reset  <= 0;

		// view address
		#1 addr   <= 0;
	    $display("\t \t \t view address");
		#1 addr   <= 10;
		#1 addr   <= 255;

		// test address 10
		#1 addr    <= 10;
		if (clock == 0) #1 $display("\t \t \t test address 10");
		else $display("\t \t \t test address 10");
		#0 rw   	 <= 1;
		#0 indata1h <= 8'b1;
		#0 indata2h <= 8'b1;
		#0 indata1l <= 8'b1;
		#0 indata2l <= 8'b1;
		#1 rw      <= 0;
		

		// test address 255
		#1 addr    <= 255;
		if (clock == 0) #1 $display("\t \t \t test address 255");
		else $display("\t \t \t test address 255");
		#0 rw   	 <= 1;
		#0 indata1h <= 8'b0;
		#0 indata2h <= 8'b0;
		#0 indata1l <= 8'b00000010;
		#0 indata2l <= 8'b10011010;
		#1 rw      <= 0;
		
		// view address
		#1 addr   <= 0;
	    $display("\t \t \t view address");
		#1 addr   <= 10;
		#1 addr   <= 255;
	end

	always begin
			repeat(30) begin
			#1 clock <= clock + 1;
		end
		$finish;
	end
endmodule

