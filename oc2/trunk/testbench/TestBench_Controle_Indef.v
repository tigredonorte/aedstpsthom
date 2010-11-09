`include "../rtl/Controle.v"

module testBench();
  reg [5:0] op;
  reg [5:0] fn;
  reg [4:0] rt;

  wire [2:0] selwsource;
  wire [1:0] selregdest;
  wire writereg;
  wire writeov;
  wire selimregb;
  wire selsarega;
  wire selalushift;
  wire [2:0] aluop;
  wire unsig;
  wire [1:0] shiftop;
  wire mshw;
  wire lshw;
  wire [2:0] msm;
  wire [2:0] msl;
  wire readmem;
  wire writemem;
  wire [1:0] selbrjumpz;
  wire [1:0] seltipopc;
  wire [2:0] compop;
  
  Controle c(
    op,
    fn,
    rt,
    selwsource,
    selregdest,
    writereg,
    writeov,
    selimregb,
    selsarega,
    selalushift,
    aluop,
    unsig,
    shiftop,
    mshw,
    lshw,
    msm,
    msl,
    readmem,
    writemem,
    selbrjumpz,
    seltipopc,
    compop  
  );
  
  initial begin
    $dumpfile("dump.txt");
    $dumpvars;

    // Indef.
    op = 6'b010000;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b010001;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b010010;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b010011;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b010100;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b010101;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b010110;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b010111;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b011000;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b011001;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b011010;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b011011;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b011100;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b011101;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b011110;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b011111;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
      
#1
    // Indef.
    op = 6'b100111;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b101100;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b101101;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b101111;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b110001;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b110010;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b110100;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b110101;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b110110;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b110111;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b111001;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b111010;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b111011;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b111100;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b111101;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b111110;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1
    // Indef.
    op = 6'b111111;
    fn = 6'bxxxxxx;
    rt = 5'bxxxxx;
#1

    $finish;
  end

endmodule

