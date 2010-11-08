`include "../rtl/Alu.v"
`include "../rtl/Shifter.v"

module Execute(

	input clock ,
	input reset ,

	// Decode
	input id_ex_selalushift ,
	input id_ex_selimregb, 
	input id_ex_selsarega , 
	input [2:0] id_ex_aluop ,
	input id_ex_unsig ,
	input [1:0] id_ex_shiftop ,
	input [4:0] id_ex_shiftamt ,
	input [31:0] id_ex_rega ,
	input [2:0] id_ex_msm ,
	input [2:0] id_ex_msl ,
	input id_ex_readmem ,
	input id_ex_writemem ,
	input id_ex_mshw ,
	input id_ex_lshw ,
	input [31:0] id_ex_regb ,
	input [31:0] id_ex_imedext ,
	input [31:0] id_ex_proximopc ,
	input [2:0] id_ex_selwsource ,
	input [4:0] id_ex_regdest ,
	input id_ex_writereg ,
	input id_ex_writeov ,

	// Forwarding
	output [31:0] ex_fw_wbvalue ,
	output ex_fw_writereg ,

	// Fetch
	output reg ex_if_stall ,

	// Memory
	output reg [2:0] ex_mem_msm ,
	output reg [2:0] ex_mem_msl ,
	output reg ex_mem_readmem ,
	output reg ex_mem_writemem ,
	output reg ex_mem_mshw ,
	output reg ex_mem_lshw ,
	output reg [31:0] ex_mem_regb ,
	output reg [2:0] ex_mem_selwsource ,
	output reg [4:0] ex_mem_regdest ,
	output reg ex_mem_writereg ,
	output reg [31:0] ex_mem_aluout ,
	output reg [31:0] ex_mem_wbvalue
	);

	//variaveis internas
	//ALU
	wire [31:0] mux_imregb;  //transmite o valor do registrador b
	wire [31:0] aluout;      //resultado da ALU
	wire compout;
	wire aluov;
	assign mux_imregb = (id_ex_selimregb) ? id_ex_imedext : id_ex_regb;

	//Shifter
	wire [4:0] mux_sarega;  //transmite o sinal de shiftamt
	wire [31:0] result; //resultado de Shifter

	assign mux_sarega = (id_ex_selsarega) ? id_ex_shiftamt : id_ex_rega[4:0] ;
	
	//saida
	wire [31:0] mux_alusft; 
	wire [31:0] mux_wbvalue;
	
	assign mux_alusft = (id_ex_selalushift==1)?result : 
						(id_ex_selalushift==0)?aluout : 32'bx;
	
	
	assign mux_wbvalue = (id_ex_selwsource == 0)? mux_alusft : 
						 (id_ex_selwsource == 2)? id_ex_imedext:
						 (id_ex_selwsource == 3)? id_ex_proximopc: 
						 (id_ex_selwsource == 4)? {31'b0,compout}: 32'bz; 
	
	
	Alu ALU(
		id_ex_rega, 
		mux_imregb,
		id_ex_aluop,
		id_ex_unsig,
		aluout,
		compout,
		aluov
		);
		
	Shifter SHIFTER(
		id_ex_regb,
		id_ex_shiftop,
		mux_sarega,
		result
		 );

	// Forwarding	 
	assign ex_fw_wbvalue = mux_wbvalue;
	assign ex_fw_writereg = (~aluov | id_ex_writeov) & id_ex_writereg;
	
	always@(negedge clock)
    begin
		//Fetch
		ex_if_stall = (id_ex_readmem | id_ex_writemem);

		//Men
		ex_mem_msm = id_ex_msm;
		ex_mem_msl = id_ex_msl;
		ex_mem_readmem = id_ex_readmem;
		ex_mem_writemem = id_ex_writemem;
		ex_mem_mshw = id_ex_mshw;
		ex_mem_lshw = id_ex_lshw;
		ex_mem_regb = id_ex_regb;
		ex_mem_selwsource = id_ex_selwsource;
		ex_mem_regdest = id_ex_regdest;
		ex_mem_writereg = (~aluov | id_ex_writeov) & id_ex_writereg;
		ex_mem_aluout = mux_alusft;
		ex_mem_wbvalue = mux_wbvalue;
		
	end
	
	always@(posedge reset)
	begin
		//Men
		ex_mem_msm = 3'b0;
		ex_mem_msl = 3'b0;
		ex_mem_readmem = 0;
		ex_mem_writemem = 0;
		ex_mem_mshw = 0;
		ex_mem_lshw = 0;
		ex_mem_regb = 32'b0;
		ex_mem_selwsource = 3'b0;
		ex_mem_regdest = 5'b0;
		ex_mem_writereg = 0;
		ex_mem_aluout = 32'b0;
		ex_mem_wbvalue = 32'b0;
	end
	 
endmodule
