`include "Ram.v"
`include "MemController.v"

module testBench();

  reg clock;
  reg reset;

  reg  if_mc_en;
  reg  [31:0] if_mc_addr;
  wire [31:0] if_mc_wdata;
  
  reg  mem_mc_rw;
  reg  mem_mc_en;
  reg  mem_mc_en1h;
  reg  mem_mc_en1l;
  reg  mem_mc_en2h;
  reg  mem_mc_en2l;
  reg  [31:0] mem_mc_addr;
  reg  [31:0] mem_mc_data;
  wire [31:0] mem_mc_wdata;
	assign mem_mc_wdata = (mem_mc_rw && mem_mc_en) ? (mem_mc_data) : (32'bz);
  
  wire [31:0] mc_ram_addr;
  wire mc_ram_rw;
  wire mc_ram_en1h;
  wire mc_ram_en1l;
  wire mc_ram_en2h;
  wire mc_ram_en2l;
  wire [7:0] mc_ram_data1h;
  wire [7:0] mc_ram_data1l;
  wire [7:0] mc_ram_data2h;
  wire [7:0] mc_ram_data2l;
  
  MemController mc(
                   // fetch
                   if_mc_en,
                   if_mc_addr,
                   if_mc_wdata,
                   // mem
                   mem_mc_rw,
                   mem_mc_en,
                   mem_mc_addr,
                   mem_mc_wdata,
                   mem_mc_en1h,
                   mem_mc_en1l,
                   mem_mc_en2h,
                   mem_mc_en2l,
                   // ram
                   mc_ram_addr,
                   mc_ram_rw,
                   mc_ram_en1h,
                   mc_ram_data1h,
                   mc_ram_en1l,
                   mc_ram_data1l,
                   mc_ram_en2h,
                   mc_ram_data2h,
                   mc_ram_en2l,
                   mc_ram_data2l
                   );	

	Ram ram(
	        clock,
	        reset,
	        mc_ram_addr,
	        mc_ram_rw,
	        mc_ram_en1h,
	        mc_ram_data1h,
	        mc_ram_en1l,
	        mc_ram_data1l,
	        mc_ram_en2h,
	        mc_ram_data2h,
	        mc_ram_en2l,
	        mc_ram_data2l
	        );

	initial begin
		clock       <= 0;
		reset       <= 0;

    if_mc_en    <= 0;
    if_mc_addr  <= 0;

    mem_mc_rw   <= 0;
    mem_mc_en   <= 0;
    mem_mc_addr <= 0;
    mem_mc_en1h <= 0;
    mem_mc_en1l <= 0;
    mem_mc_en2h <= 0;
    mem_mc_en2l <= 0;

    $dumpfile("dump.txt");
    $dumpvars;
/*
		$monitor("%b %b %b %d %b %b %d %d %d %d %d",
		         clock,
		         reset,
		         if_mc_en,
		         if_mc_addr,
		         mem_mc_rw,
		         mem_mc_en,
		         mem_mc_addr,
		         mem_mc_en1h,
		         mem_mc_en1l,
		         mem_mc_en2h,
		         mem_mc_en2l
		         );
*/
    #2 reset = 1;
    #2 reset = 0;
    
    // 24 to adress 0
    #2 mem_mc_addr = 0;
    #2 mem_mc_data = 32'hFFFFFF01;
    #2 mem_mc_en1h = 0;
    #2 mem_mc_en1l = 0;
    #2 mem_mc_en2h = 0;
    #2 mem_mc_en2l = 1;
    #2 mem_mc_rw   = 1;
    #2 mem_mc_en   = 1;
    #2 mem_mc_en   = 0;

    // view adress
    #2 mem_mc_addr = 0;
    #2 mem_mc_rw   = 0;
    #2 mem_mc_en1h = 1;
    #2 mem_mc_en1l = 1;
    #2 mem_mc_en2h = 1;
    #2 mem_mc_en2l = 1;
    #2 mem_mc_en   = 1;
    #2 mem_mc_en   = 0;

    // 24 (2º byte) to adress 1
    #2 mem_mc_addr = 1;
    #2 mem_mc_data = 32'hFFFF02FF;
    #2 mem_mc_en1h = 0;
    #2 mem_mc_en1l = 0;
    #2 mem_mc_en2h = 1;
    #2 mem_mc_en2l = 0;
    #2 mem_mc_rw   = 1;
    #2 mem_mc_en   = 1;
    #2 mem_mc_en   = 0;

    // view adress
    #2 mem_mc_addr = 1;
    #2 mem_mc_rw   = 0;
    #2 mem_mc_en1h = 1;
    #2 mem_mc_en1l = 1;
    #2 mem_mc_en2h = 1;
    #2 mem_mc_en2l = 1;
    #2 mem_mc_en   = 1;
    #2 mem_mc_en   = 0;

    // 24 (3º byte) to adress 2
    #2 mem_mc_addr = 2;
    #2 mem_mc_data = 32'hFF03FFFF;
    #2 mem_mc_en1h = 0;
    #2 mem_mc_en1l = 1;
    #2 mem_mc_en2h = 0;
    #2 mem_mc_en2l = 0;
    #2 mem_mc_rw   = 1;
    #2 mem_mc_en   = 1;
    #2 mem_mc_en   = 0;

    // view adress
    #2 mem_mc_addr = 2;
    #2 mem_mc_rw   = 0;
    #2 mem_mc_en1h = 1;
    #2 mem_mc_en1l = 1;
    #2 mem_mc_en2h = 1;
    #2 mem_mc_en2l = 1;
    #2 mem_mc_en   = 1;
    #2 mem_mc_en   = 0;
    
    // 16 (4º byte) to adress 3
    #2 mem_mc_addr = 3;
    #2 mem_mc_data = 32'h04FFFFFF;
    #2 mem_mc_en1h = 1;
    #2 mem_mc_en1l = 0;
    #2 mem_mc_en2h = 0;
    #2 mem_mc_en2l = 0;    
    #2 mem_mc_rw   = 1;
    #2 mem_mc_en   = 1;
    #2 mem_mc_en   = 0;    
    
 		// view adress
    #2 mem_mc_addr = 3;
    #2 mem_mc_rw   = 0;
    #2 mem_mc_en1h = 1;
    #2 mem_mc_en1l = 1;
    #2 mem_mc_en2h = 1;
    #2 mem_mc_en2l = 1;
    #2 mem_mc_en   = 1;
    #2 mem_mc_en   = 0;

    #2 mem_mc_addr = 1;
    #2 mem_mc_rw   = 0;
    #2 mem_mc_en1h = 1;
    #2 mem_mc_en1l = 1;
    #2 mem_mc_en2h = 1;
    #2 mem_mc_en2l = 1;
    #2 mem_mc_en   = 1;
    #2 mem_mc_en   = 0;

    // Teste IF habilitado
    #2 if_mc_addr = 0;
    #2 if_mc_en 	= 1;
    #2 if_mc_en 	= 0;
    
    // Teste IF habilitado
    #2 if_mc_addr = 3;
    #2 if_mc_en 	= 1;
	  #2 if_mc_en 	= 0;
    
    // Teste IF desabilitado
 		#2 if_mc_addr = 1;
    #2 if_mc_en 	= 0;
    
 		#2 $finish;
	end
	
	initial begin
		while( 1 )
		  #1 clock <= ~clock;
	end

endmodule

