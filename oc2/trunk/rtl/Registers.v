module Registers(
         input                    reset ,
         input                    ena ,
         input             [4:0] addra ,
         output reg [31:0] dataa ,
         input                    enb ,
         input             [4:0] addrb ,
         output reg [31:0] datab ,
         input                    enc ,
         input             [4:0] addrc ,
         input            [31:0] datac
         );
         
         //Registradores
         reg [31:0] Registers[31:0];
		
	 	 integer i;


         //zera os registradores
         always @ (posedge reset)
         begin
         	dataa = 0;
         	datab = 0;
         	for (i = 0; i < 32; i = i + 1)
         	begin
         		Registers[i] = 0;
         	end
         end
         
         //leitura do registrador a
         always @ (ena or addra)
         begin
         	if(ena)
	         	dataa = Registers[addra];
         end
         
         //leitura do registrador b
         always @ (enb or addrb)
         begin
         	if(enb)
	         	datab = Registers[addrb];
         end
         
         //escrita do registrador c
         always @ (enc or addrc or datac)
         begin
         	if(enc)
         		Registers[addrc] = datac;
         end         	
endmodule

