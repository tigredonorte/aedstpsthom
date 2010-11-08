module Comp (

   input  [31:0] a,
   input  [31:0] b,
   input  [2:0]  op,
   output reg    compout

   );
   
   always @(op or a or b) begin
      case(op)

         3'b000:
            // a == b
            compout = (a == b) ? 1'b1 : 1'b0 ;
   
         3'b001:
            // a >= b
            compout = (a >= b) ? 1'b1 : 1'b0 ;

         3'b010:
            // a <= b
            compout = (a <= b) ? 1'b1 : 1'b0 ;
   
         3'b011:
            // a > b
            compout = (a > b) ? 1'b1 : 1'b0 ;
   
         3'b100:
            // a < b
            compout = (a < b) ? 1'b1 : 1'b0 ;
      
         3'b101:
            // a != b
            compout = (a != b) ? 1'b1 : 1'b0 ;
      endcase
   end

endmodule
