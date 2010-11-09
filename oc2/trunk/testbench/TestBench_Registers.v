`include "Registers.v"

module testbanch_registradores();

   reg   clock;
   //reg   [0:5] i; // contador para exibir o conteúdo dos registradores
   integer i;

   wire  [31:0] dataa;
   reg   [4:0] addra;
   reg   ena;

   wire  [31:0] datab;
   reg   [4:0] addrb;
   reg   enb;

   reg   [31:0] datac;
   reg   [4:0] addrc;
   reg   enc;

   reg  reset;


   Registers bancoreg(
      reset,
      ena,
      addra,
      dataa,
      enb,
      addrb,
      datab,
      enc,
      addrc,
      datac
   );


   // Sessão de Testes
   initial begin

      clock = 0;

// -------------------------------------------------------------

      // Teste de Escrita no barramento C com enc desabilitado
      #1
      $display("");
      $display("Teste Escrita Barramento C, desabilitado");
      enc = 0;
      addrc = 5'd11;
      datac = 32'd45;
      $display("enc: %b - addrc: %b - datac: %b", enc, addrc, datac);

      #1
      enb = 1;
      addrb = 5'd11;
      $display("Dado no endereço %b: %b", addrb, datab);
      #1
      enb = 0;
      
      // Teste de Escrita no barramento C com enc habilitado
      #1
      $display("");
      $display("Teste Escrita Barramento C, habilitado");
      enc = 1;
      addrc = 5'd11;
      datac = 32'd45;
      $display("enc: %b - addrc: %b - datac: %b", enc, addrc, datac);
      #1
      enc = 0;

      // Teste de Escrita no barramento C com enc habilitado
      #1
      $display("");
      $display("Teste Escrita Barramento C, habilitado");
      enc = 1;
      addrc = 5'd12;
      datac = 32'd75;
      $display("enc: %b - addrc: %b - datac: %b", enc, addrc, datac);
      #1
      enc = 0;

// -------------------------------------------------------------
      // Teste de Leitura no barramento A com ena desabilitado
      #1
      $display("");
      $display("Teste Leitura Barramento A, desabilitado");
      ena = 0;
      addra = 5'd11;
      $display("ena:  %b - addra: %b - dataa: %b", ena, addra, dataa);

      // Teste de Leitura no barramento A com ena habilitado
      #1
      $display("");
      $display("Teste Leitura Barramento A, habilitado");
      ena = 1;
      addra = 5'd11;
      $display("ena:  %b - addra: %b - dataa: %b", ena, addra, dataa);
      #1
      ena = 0;

// -------------------------------------------------------------

      // Teste de Leitura no barramento B com enb desabilitado
      #1
      $display("");
      $display("Teste Leitura Barramento B, desabilitado");
      enb = 0;
      addrb = 5'd12;
      #1
      $display("enb:  %b - addrb: %b - datab: %b", enb, addrb, datab);

      // Teste de Leitura no barramento B com enb habilitado
      #1
      $display("");
      $display("Teste Leitura Barramento B, habilitado");
      enb = 1;
      addrb = 5'd12;
      #1
      $display("enb:  %b - addrb: %b - datab: %b", enb, addrb, datab);
      
      enb = 0;

// -------------------------------------------------------------

      // Teste do Reset
      #1
      $display("");
      reset = 1;
      $display("Teste Reset");

      #5
      $display("Reset dos Registradores: ");
      for(i=0; i<32; i=i+1)begin
         #1
         ena = 1;
         addra = i;
         #1
         $display("reg[%d]: %b", i, dataa);
         ena = 0;
      end
      reset=0;

// -------------------------------------------------------------


      #60 $finish;

   end


endmodule
