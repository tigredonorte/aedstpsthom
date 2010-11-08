`include "../rtl/Ram.v"

module tb_ram ();

	reg clock;
	reg reset;
	
	reg [31:0] addr;
	reg [7:0] data1h, data1l, data2h, data2l;
	reg rw, en1h, en1l, en2h, en2l;
	
	wire [7:0] wdata1h, wdata1l, wdata2h, wdata2l;

	assign wdata1h = (en1h & rw) ? data1h : 8'bz;
	assign wdata1l = (en1l & rw) ? data1l : 8'bz;
	assign wdata2h = (en2h & rw) ? data2h : 8'bz;
	assign wdata2l = (en2l & rw) ? data2l : 8'bz;

	Ram ram1(
		.clock(clock),
		.reset(reset),
	
		.addr(addr),
		.rw(rw),
		.en1h(en1h),
		.data1h(wdata1h),
		.en1l(en1l),
		.data1l(wdata1l),
		.en2h(en2h),
		.data2h(wdata2h),
		.en2l(en2l),
		.data2l(wdata2l)
	);
	
	reg [4:0] contador_tst;
	
	always #1 clock = ~clock;
	
	always@(negedge clock or posedge reset)
	begin
	  if(reset)
	  	begin
	  		contador_tst = 5'b0;	      
	  	end
	 	else
	 	  begin
	 	  	if(contador_tst <= 5'd20)
	 	  		begin
	 	  			$display("wdata: %h", {wdata1h,wdata1l,wdata2h,wdata2l});
					$display;
	 	  			contador_tst = contador_tst + 5'b1;
	 	  		end
	 	  	else
	 	  	  contador_tst = 5'bx;
	 	  end
	end
		
	always@(posedge clock)
	begin
		case(contador_tst)

			1:
			begin
				$display("// Escreve 1a. halfword;");
			    addr   = 32'd16;
			    rw     = 1;
				data1h = 8'hAA;
				data1l = 8'hAA;
				data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 1;
				en1l   = 1;
				en2h   = 0;
				en2l   = 0;
			end

			2:
    		begin
    			$display("// Escreve 2a. halfword;");
			    addr   = 32'd20;
				rw     = 1;
			    data1h = 8'hx;
				data1l = 8'hx;
			    data2h = 8'hA0;
				data2l = 8'hA0;
				en1h   = 0;
				en1l   = 0;
				en2h   = 1;
				en2l   = 1;
    		end

			3:
    		begin
    			$display("// Le 1a. halfword;");
			    addr   = 32'd16;
				rw     = 0;
				data1h = 8'hx;
				data1l = 8'hx;
			    data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 1;
				en1l   = 1;
				en2h   = 0;
				en2l   = 0;
    		end    		

			4:
    		begin
    			$display("// Le 2a. halfword;");
			    addr   = 32'd20;
				rw     = 0;
				data1h = 8'hx;
				data1l = 8'hx;
			    data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 0;
				en1l   = 0;
				en2h   = 1;
				en2l   = 1;
    		end   		
    
			5:
    		begin
    			$display("// Escreve 1a. halfword, en = 0;");
			    addr  = 32'd24;
				rw     = 1;
				data1h = 8'hAA;
				data1l = 8'hAA;
			    data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 0;
				en1l   = 0;
				en2h   = 0;
				en2l   = 0;
    		end
			
			6:
    		begin
    			$display("// Escreve 2a. halfword, en = 0;");
			    addr  = 32'd28;
				rw     = 1;
				data1h = 8'hx;
				data1l = 8'hx;
			    data2h = 8'hA0;
				data2l = 8'hA0;
				en1h   = 0;
				en1l   = 0;
				en2h   = 0;
				en2l   = 0;
    		end

			7:
    		begin
    			$display("// Le 1a. halfword, en = 0;");
			    addr  = 32'd24;
				rw     = 0;
				data1h = 8'hx;
				data1l = 8'hx;
			    data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 0;
				en1l   = 0;
				en2h   = 0;
				en2l   = 0;
    		end
	
			8:
    		begin
    			$display("// Le 2a. halfword, en = 0;");
			   	addr   = 32'd28;
				rw     = 0;
				data1h = 8'hx;
				data1l = 8'hx;
			    	data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 0;
				en1l   = 0;
				en2h   = 0;
				en2l   = 0;
    		end
 
			9:
    		begin
    			$display("// Escreve word completa, en = 1;");
			    	addr   = 32'd32;
				rw     = 1;
				data1h = 8'hAA;
				data1l = 8'hAA;
			    	data2h = 8'h44;
				data2l = 8'h55;
				en1h   = 1;
				en1l   = 1;
				en2h   = 1;
				en2l   = 1;
    		end

			10:
    		begin
    			$display("// Le word completa, en = 1;");
				addr  = 32'd32;
				rw     = 0;
				data1h = 8'hx;
				data1l = 8'hx;
			    	data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 1;
				en1l   = 1;
				en2h   = 1;
				en2l   = 1;
    		end
    
			11:
    		begin
    			$display("// Escreve word completa, en = 0;");
			    	addr  = 32'd36;
				rw     = 1;
				data1h = 8'hAA;
				data1l = 8'hAA;
			    	data2h = 8'h44;
				data2l = 8'h55;
				en1h   = 0;
				en1l   = 0;
				en2h   = 0;
				en2l   = 0;
    		end
    	
			12:
    		begin
    			$display("// Le word completa, en = 0;");
			    	addr  = 32'd36;
				rw     = 0;
				data1h = 8'hx;
				data1l = 8'hx;
			   	 data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 0;
				en1l   = 0;
				en2h   = 0;
				en2l   = 0;
    		end

			13:
			begin
	   			$display("// Escreve byte 1l, en = 1;");
			    	addr  = 32'd24;
				rw     = 1;
				data1h = 8'hx;
				data1l = 8'hFF;
			    	data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 0;
				en1l   = 1;
				en2h   = 0;
				en2l   = 0;
			end

			14:
			begin
	   			$display("// Escreve byte 2h, en = 1;");
			    	addr  = 32'd28;
				rw     = 1;
				data1h = 8'hx;
				data1l = 8'hx;
			    	data2h = 8'h11;
				data2l = 8'hx;
				en1h   = 0;
				en1l   = 0;
				en2h   = 1;
				en2l   = 0;
			end

			15:
			begin
	   			$display("// Escreve byte 1h, en = 1;");
			    	addr  = 32'd8;
				rw     = 1;
				data1h = 8'h22;
				data1l = 8'hx;
			    data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 1;
				en1l   = 0;
				en2h   = 0;
				en2l   = 0;
			end

			16:
			begin
	   			$display("// Escreve byte 2l, en = 1;");
			    addr  = 32'd12;
				rw     = 1;
				data1h = 8'hx;
				data1l = 8'hx;
			    data2h = 8'hx;
				data2l = 8'h33;
				en1h   = 0;
				en1l   = 0;
				en2h   = 0;
				en2l   = 1;
			end

			17:
			begin
	   			$display("// Le byte 1l, en = 1;");
			    addr  = 32'd24;
				rw     = 0;
				data1h = 8'hx;
				data1l = 8'hx;
			    data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 0;
				en1l   = 1;
				en2h   = 0;
				en2l   = 0;
			end

			18:
			begin
	   			$display("// Le byte 2h, en = 1;");
			    	addr  = 32'd28;
				rw     = 0;
				data1h = 8'hx;
				data1l = 8'hx;
			    	data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 0;
				en1l   = 0;
				en2h   = 1;
				en2l   = 0;
			end

			19:
			begin
	   			$display("// Le byte 1h, en = 1;");
			    addr  = 32'd8;
				rw     = 0;
				data1h = 8'hx;
				data1l = 8'hx;
			    data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 1;
				en1l   = 0;
				en2h   = 0;
				en2l   = 0;
			end

			20:
			begin
	   			$display("// Le byte 2l, en = 1;");
			    addr  = 32'd12;
				rw     = 0;
				data1h = 8'hx;
				data1l = 8'hx;
			    data2h = 8'hx;
				data2l = 8'hx;
				en1h   = 0;
				en1l   = 0;
				en2h   = 0;
				en2l   = 1;
			end


	    endcase
		
	end

	initial	$monitor("addr  : %d\nrw  : %b\ndata1h: %h\ndata1l: %h\ndata2h: %h\ndata2l: %h\nen1h : %b\nen1l : %b\nen2h : %b\nen2l : %b\n", addr, rw, data1h, data1l, data2h, data2l, en1h, en1l, en2h, en2l);


	initial
	begin

		#1 reset = 0;

		$display("Memoria[ 0] : %h%h %h%h", ram1.Memory[ 0], ram1.Memory[ 1], ram1.Memory[ 2], ram1.Memory[ 3]);
		$display("Memoria[ 4] : %h%h %h%h", ram1.Memory[ 4], ram1.Memory[ 5], ram1.Memory[ 6], ram1.Memory[ 7]);
		$display("Memoria[ 8] : %h%h %h%h", ram1.Memory[ 8], ram1.Memory[ 9], ram1.Memory[10], ram1.Memory[11]);
		$display("Memoria[12] : %h%h %h%h", ram1.Memory[12], ram1.Memory[13], ram1.Memory[14], ram1.Memory[15]);
		$display("Memoria[16] : %h%h %h%h", ram1.Memory[16], ram1.Memory[17], ram1.Memory[18], ram1.Memory[19]);
		$display("Memoria[20] : %h%h %h%h", ram1.Memory[20], ram1.Memory[21], ram1.Memory[22], ram1.Memory[23]);
		$display("Memoria[24] : %h%h %h%h", ram1.Memory[24], ram1.Memory[25], ram1.Memory[26], ram1.Memory[27]);
		$display("Memoria[28] : %h%h %h%h", ram1.Memory[28], ram1.Memory[29], ram1.Memory[30], ram1.Memory[31]);
		$display("Memoria[32] : %h%h %h%h", ram1.Memory[32], ram1.Memory[33], ram1.Memory[34], ram1.Memory[35]);
		$display("Memoria[36] : %h%h %h%h", ram1.Memory[36], ram1.Memory[37], ram1.Memory[38], ram1.Memory[39]);

		#1 reset = 1;
		#1 reset = 0;
		
		#1 clock = 0;

		#50
		$display("Memoria[ 0] : %h%h %h%h", ram1.Memory[ 0], ram1.Memory[ 1], ram1.Memory[ 2], ram1.Memory[ 3]);
		$display("Memoria[ 4] : %h%h %h%h", ram1.Memory[ 4], ram1.Memory[ 5], ram1.Memory[ 6], ram1.Memory[ 7]);
		$display("Memoria[ 8] : %h%h %h%h", ram1.Memory[ 8], ram1.Memory[ 9], ram1.Memory[10], ram1.Memory[11]);
		$display("Memoria[12] : %h%h %h%h", ram1.Memory[12], ram1.Memory[13], ram1.Memory[14], ram1.Memory[15]);
		$display("Memoria[16] : %h%h %h%h", ram1.Memory[16], ram1.Memory[17], ram1.Memory[18], ram1.Memory[19]);
		$display("Memoria[20] : %h%h %h%h", ram1.Memory[20], ram1.Memory[21], ram1.Memory[22], ram1.Memory[23]);
		$display("Memoria[24] : %h%h %h%h", ram1.Memory[24], ram1.Memory[25], ram1.Memory[26], ram1.Memory[27]);
		$display("Memoria[28] : %h%h %h%h", ram1.Memory[28], ram1.Memory[29], ram1.Memory[30], ram1.Memory[31]);
		$display("Memoria[32] : %h%h %h%h", ram1.Memory[32], ram1.Memory[33], ram1.Memory[34], ram1.Memory[35]);
		$display("Memoria[36] : %h%h %h%h", ram1.Memory[36], ram1.Memory[37], ram1.Memory[38], ram1.Memory[39]);

		#1 $finish;
		    
	end
	
endmodule
