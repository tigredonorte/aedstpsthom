module Controle(
  input [5:0] op,
  input [5:0] fn,
  input [4:0] rt,

  output reg [2:0] selwsource,
  output reg [1:0] selregdest,
  output reg writereg,
  output reg writeov,
  output reg selimregb,
  output reg selsarega,
  output reg selalushift,
  output reg [2:0] aluop,
  output reg unsig,
  output reg [1:0] shiftop,
  output reg mshw,
  output reg lshw,
  output reg [2:0] msm,
  output reg [2:0] msl,
  output reg readmem,
  output reg writemem,
  output reg [1:0] selbrjumpz,
  output reg [1:0] seltipopc,
  output reg [2:0] compop

  );

  initial begin
    selimregb = 1'bx;
    selsarega = 1'bx;
    selbrjumpz = 2'bxx;
    selregdest = 2'bxx;
    selwsource = 3'bxxx;
    writereg = 1'b0;
    writeov = 1'bx;
    unsig = 1'bx;
    shiftop = 2'bxx;
    aluop = 3'bxxx;
    selalushift = 1'bx;
    compop = 3'bxxx;
    seltipopc = 2'bxx;
    readmem = 1'b0;
    writemem = 1'b0;
    mshw = 1'bx;
    lshw = 1'bx;
    msm = 3'bxxx;
    msl = 3'bxxx;
  end

  always @(op or fn or rt) begin

    case(op)
    6'b000000: begin
    case(fn)
      // SSL
      6'b000000: begin
$display("SSL");
      selimregb = 1'b0;
      selsarega = 1'b1;
      selbrjumpz = 2'b00;
      selregdest = 2'b01;
      selwsource = 3'b000;
      writereg = 1'b1;
      writeov = 1'b1;
      unsig = 1'bx;
      shiftop = 2'b10;
      aluop = 3'bxxx;
      selalushift = 1'b1;
      compop = 3'bxxx;
      seltipopc = 2'bxx;
      readmem = 1'b0;
      writemem = 1'b0;
      mshw = 1'bx;
      lshw = 1'bx;
      msm = 3'bxxx;
      msl = 3'bxxx; 
      end
      // SRL
      6'b000010: begin
$display("SRL");
      selimregb = 1'b0; 
      selsarega = 1'b1; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b000; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'bx; 
      shiftop = 2'b00; 
      aluop = 3'bxxx; 
      selalushift = 1'b1; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // SRA
      6'b000011: begin
$display("SRA");
      selimregb = 1'b0; 
      selsarega = 1'b1; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b000; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'bx; 
      shiftop = 2'b01; 
      aluop = 3'bxxx; 
      selalushift = 1'b1; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // SLLV
      6'b000100: begin
$display("SLLV");
      selimregb = 1'b0; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b000; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'bx; 
      shiftop = 2'b10; 
      aluop = 3'bxxx; 
      selalushift = 1'b1; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // SRLV
      6'b000110: begin
$display("SRLV");
      selimregb = 1'b0; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b000; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'bx; 
      shiftop = 2'b00; 
      aluop = 3'bxxx; 
      selalushift = 1'b1; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // SRAV
      6'b000111: begin
$display("SRAV");
      selimregb = 1'b0; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b000; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'bx; 
      shiftop = 2'b01; 
      aluop = 3'bxxx; 
      selalushift = 1'b1; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // JR
      6'b001000: begin
$display("JR");
      selimregb = 1'bx; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b01; 
      selregdest = 2'b11; 
      selwsource = 3'bxxx; 
      writereg = 1'b0; 
      writeov = 1'bx; 
      unsig = 1'bx; 
      shiftop = 2'bxx; 
      aluop = 3'bxxx; 
      selalushift = 1'bx; 
      compop = 3'bxxx; 
      seltipopc = 2'b01; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // JALR
      6'b001001: begin
$display("JALR");
      selimregb = 1'bx; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b01; 
      selregdest = 2'b01; 
      selwsource = 3'b011; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'bx; 
      shiftop = 2'bxx; 
      aluop = 3'bxxx; 
      selalushift = 1'bx; 
      compop = 3'bxxx; 
      seltipopc = 2'b01; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // ADD
      6'b100000: begin
$display("ADD");
      selimregb = 1'b0; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b000; 
      writereg = 1'b1; 
      writeov = 1'b0; 
      unsig = 1'b0; 
      shiftop = 2'bxx; 
      aluop = 3'b010; 
      selalushift = 1'b0; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // ADDU
      6'b100001: begin
$display("ADDU");
      selimregb = 1'b0; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b000; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'b1; 
      shiftop = 2'bxx; 
      aluop = 3'b010; 
      selalushift = 1'b0; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // SUB
      6'b100010: begin
$display("SUB");
      selimregb = 1'b0; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b000; 
      writereg = 1'b1; 
      writeov = 1'b0; 
      unsig = 1'b0; 
      shiftop = 2'bxx; 
      aluop = 3'b110; 
      selalushift = 1'b0; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // SUBU
      6'b100011: begin
$display("SUBU");
      selimregb = 1'b0; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b000; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'b1; 
      shiftop = 2'bxx; 
      aluop = 3'b110; 
      selalushift = 1'b0; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // AND
      6'b100100: begin
$display("AND");
      selimregb = 1'b0; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b000; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'bx; 
      shiftop = 2'bxx; 
      aluop = 3'b000; 
      selalushift = 1'b0; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // OR
      6'b100101: begin
$display("OR");
      selimregb = 1'b0; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b000; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'bx; 
      shiftop = 2'bxx; 
      aluop = 3'b001; 
      selalushift = 1'b0; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // xOR
      6'b100110: begin
$display("xOR");
      selimregb = 1'b0; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b000; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'bx; 
      shiftop = 2'bxx; 
      aluop = 3'b101; 
      selalushift = 1'b0; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // NOR
      6'b100111: begin
$display("NOR");
      selimregb = 1'b0; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b000; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'bx; 
      shiftop = 2'bxx; 
      aluop = 3'b100; 
      selalushift = 1'b0; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // SLT
      6'b101010: begin
$display("SLT");
      selimregb = 1'b0; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b100; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'b0; 
      shiftop = 2'bxx; 
      aluop = 3'b110; 
      selalushift = 1'b0; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      // SLTU
      6'b101011: begin
$display("SLTU");
      selimregb = 1'b0; 
      selsarega = 1'b0; 
      selbrjumpz = 2'b00; 
      selregdest = 2'b01; 
      selwsource = 3'b100; 
      writereg = 1'b1; 
      writeov = 1'b1; 
      unsig = 1'b1; 
      shiftop = 2'bxx; 
      aluop = 3'b110; 
      selalushift = 1'b0; 
      compop = 3'bxxx; 
      seltipopc = 2'bxx; 
      readmem = 1'b0; 
      writemem = 1'b0; 
      mshw = 1'bx; 
      lshw = 1'bx; 
      msm = 3'bxxx; 
      msl = 3'bxxx;
      end
      default: begin
$display("DEFAULT 1");
      selimregb = 1'bx;
      selsarega = 1'bx;
      selbrjumpz = 2'bxx;
      selregdest = 2'bxx;
      selwsource = 3'bxxx;
      writereg = 1'b0;
      writeov = 1'bx;
      unsig = 1'bx;
      shiftop = 2'bxx;
      aluop = 3'bxxx;
      selalushift = 1'bx;
      compop = 3'bxxx;
      seltipopc = 2'bxx;
      readmem = 1'b0;
      writemem = 1'b0;
      mshw = 1'bx;
      lshw = 1'bx;
      msm = 3'bxxx;
      msl = 3'bxxx;
      end
    endcase
    end
    6'b000001: begin

    case(rt)
    // BLTZ
    5'b00000: begin
$display("BLTZ");
    selimregb = 1'bx; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b10; 
    selregdest = 2'bxx; 
    selwsource = 3'bxxx; 
    writereg = 1'b0; 
    writeov = 1'bx; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'bxxx; 
    selalushift = 1'bx; 
    compop = 3'b100; 
    seltipopc = 2'b00; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // BGEZ
    5'b00001: begin
$display("BGEZ");
    selimregb = 1'bx; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b10; 
    selregdest = 2'bxx; 
    selwsource = 3'bxxx; 
    writereg = 1'b0; 
    writeov = 1'bx; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'bxxx; 
    selalushift = 1'bx; 
    compop = 3'b001; 
    seltipopc = 2'b00; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // BLTZAL
    5'b10000: begin
$display("BLTZAL");
    selimregb = 1'bx; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b10; 
    selregdest = 2'b10; 
    selwsource = 3'b011; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'bxxx; 
    selalushift = 1'bx; 
    compop = 3'b100; 
    seltipopc = 2'b00; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // BGEZAL
    5'b10001: begin
$display("BGEZAL");
    selimregb = 1'bx; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b10; 
    selregdest = 2'b10; 
    selwsource = 3'b011; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'bxxx; 
    selalushift = 1'bx; 
    compop = 3'b001; 
    seltipopc = 2'b00; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    default: begin
$display("DEFAULT 2");
     selimregb = 1'bx;
     selsarega = 1'bx;
     selbrjumpz = 2'bxx;
     selregdest = 2'bxx;
     selwsource = 3'bxxx;
     writereg = 1'b0;
     writeov = 1'bx;
     unsig = 1'bx;
     shiftop = 2'bxx;
     aluop = 3'bxxx;
     selalushift = 1'bx;
     compop = 3'bxxx;
     seltipopc = 2'bxx;
     readmem = 1'b0;
     writemem = 1'b0;
     mshw = 1'bx;
     lshw = 1'bx;
     msm = 3'bxxx;
     msl = 3'bxxx; 
    end
    endcase
    end
    6'b000010: begin     
    // J
$display("J");
    selimregb = 1'bx; 
    selsarega = 1'bx; 
    selbrjumpz = 2'b01; 
    selregdest = 2'bxx; 
    selwsource = 3'bxxx; 
    writereg = 1'b0; 
    writeov = 1'bx; 
    unsig = 1'bx; 
    shiftop = 2'bxx; 
    aluop = 3'bxxx; 
    selalushift = 1'bx; 
    compop = 3'bxxx; 
    seltipopc = 2'b10; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // JAL
    6'b000011: begin
$display("JAL");
    selimregb = 1'bx; 
    selsarega = 1'bx; 
    selbrjumpz = 2'b01; 
    selregdest = 2'b10; 
    selwsource = 3'b011; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'bx; 
    shiftop = 2'bxx; 
    aluop = 3'bxxx; 
    selalushift = 1'bx; 
    compop = 3'bxxx; 
    seltipopc = 2'b10; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // BEQ
    6'b000100: begin
$display("BEQ");
    selimregb = 1'bx; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b10; 
    selregdest = 2'bxx; 
    selwsource = 3'bxxx; 
    writereg = 1'b0; 
    writeov = 1'bx; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'bxxx; 
    selalushift = 1'bx; 
    compop = 3'b000; 
    seltipopc = 2'b00; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // BNE
    6'b000101: begin
$display("BNE");
    selimregb = 1'bx; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b10; 
    selregdest = 2'bxx; 
    selwsource = 3'bxxx; 
    writereg = 1'b0; 
    writeov = 1'bx; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'bxxx; 
    selalushift = 1'bx; 
    compop = 3'b101; 
    seltipopc = 2'b00; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // BLEZ
    6'b000110: begin
$display("BLEZ");
    selimregb = 1'bx; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b10; 
    selregdest = 2'bxx; 
    selwsource = 3'bxxx; 
    writereg = 1'b0; 
    writeov = 1'bx; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'bxxx; 
    selalushift = 1'bx; 
    compop = 3'b010; 
    seltipopc = 2'b00; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // BGTZ
    6'b000111: begin
$display("BGTZ");
    selimregb = 1'bx; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b10; 
    selregdest = 2'bxx; 
    selwsource = 3'bxxx; 
    writereg = 1'b0; 
    writeov = 1'bx; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'bxxx; 
    selalushift = 1'bx; 
    compop = 3'b011; 
    seltipopc = 2'b00; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // ADDI
    6'b001000: begin
$display("ADDI");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b000; 
    writereg = 1'b1; 
    writeov = 1'b0; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // ADDIU
    6'b001001: begin
$display("ADDIU");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b000; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'b1; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // SLTI
    6'b001010: begin
$display("SLTI");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b100; 
    writereg = 1'b1; 
    writeov = 1'b0; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b110; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // SLTIU
    6'b001011: begin
$display("SLTIU");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b100; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'b1; 
    shiftop = 2'bxx; 
    aluop = 3'b110; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // ANDI
    6'b001100: begin
$display("ANDI");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b000; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'bx; 
    shiftop = 2'bxx; 
    aluop = 3'b000; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // ORI
    6'b001101: begin
$display("ORI");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b000; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'bx; 
    shiftop = 2'bxx; 
    aluop = 3'b001; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // XORI
    6'b001110: begin
$display("XORI");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b000; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'bx; 
    shiftop = 2'bxx; 
    aluop = 3'b101; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // LUI
    6'b001111: begin
$display("LUI");
    selimregb = 1'bx; 
    selsarega = 1'bx; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b010; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'bx; 
    shiftop = 2'bxx; 
    aluop = 3'bxxx; 
    selalushift = 1'bx; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b0; 
    writemem = 1'b0; 
    mshw = 1'bx; 
    lshw = 1'bx; 
    msm = 3'bxxx; 
    msl = 3'bxxx;
    end
    // LB
    6'b100000: begin
$display("LB");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b001; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b1; 
    writemem = 1'b0; 
    mshw = 1'b1; 
    lshw = 1'b1; 
    msm = 3'b011; 
    msl = 3'b011;
    end
    // LH
    6'b100001: begin
$display("LH");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b001; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b1; 
    writemem = 1'b0; 
    mshw = 1'b1; 
    lshw = 1'b1; 
    msm = 3'b011; 
    msl = 3'b001;
    end
    // LWL
    6'b100010: begin
$display("LWL");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b001; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b1; 
    writemem = 1'b0; 
    mshw = 1'b1; 
    lshw = 1'b0; 
    msm = 3'b010; 
    msl = 3'b000;
    end
    // LW
    6'b100011: begin
$display("LW");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b001; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b1; 
    writemem = 1'b0; 
    mshw = 1'b1; 
    lshw = 1'b1; 
    msm = 3'b001; 
    msl = 3'b010;
    end
    // LBU
    6'b100100: begin
$display("LBU");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b001; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b1; 
    writemem = 1'b0; 
    mshw = 1'b1; 
    lshw = 1'b1; 
    msm = 3'b000; 
    msl = 3'b100;
    end
    // LHU
    6'b100101: begin
$display("LHU");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b001; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b1; 
    writemem = 1'b0; 
    mshw = 1'b1; 
    lshw = 1'b1; 
    msm = 3'b000; 
    msl = 3'b001;
    end
    // LWR
    6'b100110: begin
$display("LWR");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b001; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b1; 
    writemem = 1'b0; 
    mshw = 1'b0; 
    lshw = 1'b1; 
    msm = 3'b000; 
    msl = 3'b001;
    end
    // SB
    6'b101000: begin
$display("SB");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'bxx; 
    selwsource = 3'bxxx; 
    writereg = 1'b0; 
    writeov = 1'bx; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b0; 
    writemem = 1'b1; 
    mshw = 1'b1; 
    lshw = 1'b1; 
    msm = 3'b100; 
    msl = 3'b011;
    end
    // SH
    6'b101001: begin
$display("SH");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'bxx; 
    selwsource = 3'bxxx; 
    writereg = 1'b0; 
    writeov = 1'bx; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b0; 
    writemem = 1'b1; 
    mshw = 1'b1; 
    lshw = 1'b1; 
    msm = 3'b010; 
    msl = 3'b000;
    end
    // SWL
    6'b101010: begin
$display("SWL");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'bxx; 
    selwsource = 3'bxxx; 
    writereg = 1'b0; 
    writeov = 1'bx; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b0; 
    writemem = 1'b1; 
    mshw = 1'b0; 
    lshw = 1'b1; 
    msm = 3'b000; 
    msl = 3'b001;
    end
    // SW
    6'b101011: begin
$display("SW");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'bxx; 
    selwsource = 3'bxxx; 
    writereg = 1'b0; 
    writeov = 1'bx; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b0; 
    writemem = 1'b1; 
    mshw = 1'b1; 
    lshw = 1'b1; 
    msm = 3'b001; 
    msl = 3'b010;
    end
    // SWR
    6'b101110: begin
$display("SWR");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'bxx; 
    selwsource = 3'bxxx; 
    writereg = 1'b0; 
    writeov = 1'bx; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'b00; 
    readmem = 1'b0; 
    writemem = 1'b1; 
    mshw = 1'b1; 
    lshw = 1'b0; 
    msm = 3'b010; 
    msl = 3'b000;
    end
    // LL
    6'b110000: begin
$display("LL");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b001; 
    writereg = 1'b1; 
    writeov = 1'b1; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b1; 
    writemem = 1'b0; 
    mshw = 1'b1; 
    lshw = 1'b1; 
    msm = 3'b001; 
    msl = 3'b010;
    end
    // SC
    6'b111000: begin
$display("SC");
    selimregb = 1'b1; 
    selsarega = 1'b0; 
    selbrjumpz = 2'b00; 
    selregdest = 2'b00; 
    selwsource = 3'b001; 
    writereg = 1'b1; 
    writeov = 1'bx; 
    unsig = 1'b0; 
    shiftop = 2'bxx; 
    aluop = 3'b010; 
    selalushift = 1'b0; 
    compop = 3'bxxx; 
    seltipopc = 2'bxx; 
    readmem = 1'b0; 
    writemem = 1'b1; 
    mshw = 1'b1; 
    lshw = 1'b1; 
    msm = 3'b001; 
    msl = 3'b010;
    end
    default: begin
$display("DEFAULT 3");
    selimregb = 1'bx;
    selsarega = 1'bx;
    selbrjumpz = 2'bxx;
    selregdest = 2'bxx;
    selwsource = 3'bxxx;
    writereg = 1'b0;
    writeov = 1'bx;
    unsig = 1'bx;
    shiftop = 2'bxx;
    aluop = 3'bxxx;
    selalushift = 1'bx;
    compop = 3'bxxx;
    seltipopc = 2'bxx;
    readmem = 1'b0;
    writemem = 1'b0;
    mshw = 1'bx;
    lshw = 1'bx;
    msm = 3'bxxx;
    msl = 3'bxxx;
    end
    endcase
  end
endmodule

