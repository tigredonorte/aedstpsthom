module Writeback (

	input clock ,

	// Memory
	input [4:0] mem_wb_regdest ,
	input mem_wb_writereg ,
	input [31:0] mem_wb_wbvalue ,
	
	// Registers
	output reg wb_reg_en ,
	output reg [4:0] wb_reg_addr ,
	output reg [31:0] wb_reg_data ,

	// Forwarding
	output [31:0] wb_fw_wbvalue ,
	output wb_fw_writereg
);

//fowarding
assign wb_fw_writereg = mem_wb_writereg;
assign wb_fw_wbvalue = mem_wb_wbvalue;


always@(negedge clock)
begin
	//registers
	wb_reg_en = mem_wb_writereg;
	wb_reg_addr = mem_wb_regdest;
	wb_reg_data = mem_wb_wbvalue;
end

endmodule

