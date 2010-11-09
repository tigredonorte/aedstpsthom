module MemController(
   
       // Fetch
       input   if_mc_en ,
       input    [31:0]  if_mc_addr ,
       output    [31:0]  mc_if_data ,
 
       // Memory
       input            mem_mc_rw ,
       input            mem_mc_en ,
       input     [31:0] mem_mc_addr ,
       inout     [31:0] mem_mc_data ,
       input            mem_mc_en1h ,
       input            mem_mc_en1l ,
       input            mem_mc_en2h ,
       input            mem_mc_en2l ,
       
       // Ram
       output     [31:0] mc_ram_addr ,
       output           mc_ram_rw ,
       output           mc_ram_en1h ,
       inout      [7:0] mc_ram_data1h ,
       output           mc_ram_en1l ,
       inout      [7:0] mc_ram_data1l ,
       output           mc_ram_en2h ,
       inout   [7:0] mc_ram_data2h ,
       output           mc_ram_en2l ,
       inout      [7:0] mc_ram_data2l
       );
       
  reg [7:0] data1h;
  reg [7:0] data1l;
  reg [7:0] data2h;
  reg [7:0] data2l;

	assign mc_ram_rw = (mem_mc_en) ? (mem_mc_rw) : (1'b0);
	assign mc_ram_addr = (if_mc_en && ~mem_mc_en) ? (if_mc_addr) : (mem_mc_addr);

	assign mc_ram_en1h = (mem_mc_en) ? (mem_mc_en1h) : (if_mc_en);
	assign mc_ram_en1l = (mem_mc_en) ? (mem_mc_en1l) : (if_mc_en);
	assign mc_ram_en2h = (mem_mc_en) ? (mem_mc_en2h) : (if_mc_en);
	assign mc_ram_en2l = (mem_mc_en) ? (mem_mc_en2l) : (if_mc_en);

	assign mc_if_data[31:24] = mc_ram_data1h;
	assign mc_if_data[23:16] = mc_ram_data1l;
	assign mc_if_data[15:08] = mc_ram_data2h;
	assign mc_if_data[07:00] = mc_ram_data2l;

	assign mem_mc_data[31:24] = (mc_ram_rw || ~mem_mc_en) ? (8'bz) : (mc_ram_data1h);
	assign mem_mc_data[23:16] = (mc_ram_rw || ~mem_mc_en) ? (8'bz) : (mc_ram_data1l);
	assign mem_mc_data[15:08] = (mc_ram_rw || ~mem_mc_en) ? (8'bz) : (mc_ram_data2h);
	assign mem_mc_data[07:00] = (mc_ram_rw || ~mem_mc_en) ? (8'bz) : (mc_ram_data2l);
	
	assign mc_ram_data1h = (mc_ram_rw && mem_mc_en) ? (mem_mc_data[31:24]) : (8'bz);
	assign mc_ram_data1l = (mc_ram_rw && mem_mc_en) ? (mem_mc_data[23:16]) : (8'bz);
	assign mc_ram_data2h = (mc_ram_rw && mem_mc_en) ? (mem_mc_data[15:08]) : (8'bz);
	assign mc_ram_data2l = (mc_ram_rw && mem_mc_en) ? (mem_mc_data[07:00]) : (8'bz);
endmodule

