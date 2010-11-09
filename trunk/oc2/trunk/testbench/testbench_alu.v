`include "../rtl/Alu.v"

module testbench_alu;

	reg[31:0] tst_a;
	reg[31:0] tst_b;
	reg[2:0] tst_op;
	reg tst_unsig;
	wire[31:0] tst_aluout;
	wire tst_compout;
	wire tst_overflow;

	Alu alu(.a(tst_a), .b(tst_b), .op(tst_op), .unsig(tst_unsig),
		.aluout(tst_aluout), .compout(tst_compout), .overflow(tst_overflow));

	initial begin
	
		/* TESTA AND */

		#1
		// teste 1: 0 & 0 = 0
		tst_a = 0;
		tst_b = 0;
		tst_op = 3'b000;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 1");
		end

		#1
		// teste 2: 0 & 1 = 0
		tst_a = 0;
		tst_b = 1;
		tst_op = 3'b000;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 2");
		end

		#1
		// teste 3: 1 & 0 = 0
		tst_a = 1;
		tst_b = 0;
		tst_op = 3'b000;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 3");
		end

		#1
		// teste 4: 1 & 1 = 1
		tst_a = 1;
		tst_b = 1;
		tst_op = 3'b000;
		
		#1
		if (tst_aluout != 1) begin
			$display("ERRO teste 4");
		end

		#1
		// teste 5: 4294901760 & 65535 = 0
		tst_a = 4294901760;
		tst_b = 65535;
		tst_op = 3'b000;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 5");
		end

		#1
		// teste 6: 65535 & 4294901760 = 0
		tst_a = 65535;
		tst_b = 4294901760;
		tst_op = 3'b000;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 6");
		end

		#1
		// teste 7: 2147483648 & 2147483648 = 2147483648
		tst_a = 2147483648;
		tst_b = 2147483648;
		tst_op = 3'b000;
		
		#1
		if (tst_aluout != 2147483648) begin
			$display("ERRO teste 7");
		end

		/* TESTE OR */

		#1
		// teste 8: 0 | 0 = 0
		tst_a = 0;
		tst_b = 0;
		tst_op = 3'b001;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 8");
		end

		#1
		// teste 9: 0 | 1 = 1
		tst_a = 0;
		tst_b = 1;
		tst_op = 3'b001;
		
		#1
		if (tst_aluout != 1) begin
			$display("ERRO teste 9");
		end

		#1
		// teste 10: 1 | 0 = 1
		tst_a = 1;
		tst_b = 0;
		tst_op = 3'b001;
		
		#1
		if (tst_aluout != 1) begin
			$display("ERRO teste 10");
		end

		#1
		// teste 11: 1 | 1 = 1
		tst_a = 1;
		tst_b = 1;
		tst_op = 3'b001;
		
		#1
		if (tst_aluout != 1) begin
			$display("ERRO teste 11");
		end

		#1
		// teste 12: 4294901760 | 65535 = 4294967295
		tst_a = 4294901760;
		tst_b = 65535;
		tst_op = 3'b001;
		
		#1
		if (tst_aluout != 4294967295) begin
			$display("ERRO teste 12");
		end

		#1
		// teste 13: 4294901760 | 65535 = 4294967295
		tst_a = 65535;
		tst_b = 4294901760;
		tst_op = 3'b001;
		
		#1
		if (tst_aluout != 4294967295) begin
			$display("ERRO teste 13");
		end

		#1
		// teste 14: 2147483648 | 2147483648 = 2147483648
		tst_a = 2147483648;
		tst_b = 2147483648;
		tst_op = 3'b001;
		
		#1
		if (tst_aluout != 2147483648) begin
			$display("ERRO teste 14");
		end

		/* TESTE NOR */

		#1
		// teste 15: ~(0 | 0) = 1
		tst_a = 0;
		tst_b = 0;
		tst_op = 3'b100;
		
		#1
		if (tst_aluout != 32'hffffffff) begin
			$display("ERRO teste 15 %b %b", 32'hffff, tst_aluout);
		end

		#1
		// teste 16: ~(0 | 1) = 0
		tst_a = 0;
		tst_b = 1;
		tst_op = 3'b100;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 16");
		end

		#1
		// teste 17: ~(1 | 0) = 0
		tst_a = 1;
		tst_b = 0;
		tst_op = 3'b100;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 17");
		end

		#1
		// teste 18: ~(1 | 1) = 0
		tst_a = 1;
		tst_b = 1;
		tst_op = 3'b100;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 18");
		end

		#1
		// teste 19: ~(4294901760 | 65535) = 0
		tst_a = 4294901760;
		tst_b = 65535;
		tst_op = 3'b100;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 19");
		end

		#1
		// teste 20: ~(4294901760 | 65535) = 0
		tst_a = 65535;
		tst_b = 4294901760;
		tst_op = 3'b100;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 20");
		end

		#1
		// teste 21: ~(2147483648 | 2147483648) = 2147483647
		tst_a = 2147483648;
		tst_b = 2147483648;
		tst_op = 3'b100;
		
		#1
		if (tst_aluout != 2147483647) begin
			$display("ERRO teste 21");
		end

		/* TESTE XOR */

		#1
		// teste 22: 0 ^ 0 = 0
		tst_a = 0;
		tst_b = 0;
		tst_op = 3'b101;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 22");
		end

		#1
		// teste 23: 0 ^ 1 = 1
		tst_a = 0;
		tst_b = 1;
		tst_op = 3'b101;
		
		#1
		if (tst_aluout != 1) begin
			$display("ERRO teste 23");
		end

		#1
		// teste 24: 1 ^ 0 = 1
		tst_a = 1;
		tst_b = 0;
		tst_op = 3'b101;
		
		#1
		if (tst_aluout != 1) begin
			$display("ERRO teste 24");
		end

		#1
		// teste 25: 1 ^ 1 = 0
		tst_a = 1;
		tst_b = 1;
		tst_op = 3'b101;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 25");
		end

		#1
		// teste 26: 4294901760 ^ 65535 = 4294967295
		tst_a = 4294901760;
		tst_b = 65535;
		tst_op = 3'b101;
		
		#1
		if (tst_aluout != 4294967295) begin
			$display("ERRO teste 26");
		end

		#1
		// teste 27: 4294901760 ^ 65535 = 4294967295
		tst_a = 65535;
		tst_b = 4294901760;
		tst_op = 3'b101;
		
		#1
		if (tst_aluout != 4294967295) begin
			$display("ERRO teste 27");
		end

		#1
		// teste 28: 2147483648 ^ 2147483648 = 0
		tst_a = 2147483648;
		tst_b = 2147483648;
		tst_op = 3'b101;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 28");
		end

		/* TESTA SOMA */

		#1
		// teste 29: 0 + 0 = 0
		tst_a = 0;
		tst_b = 0;
		tst_unsig = 1;
		tst_op = 3'b010;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 29 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 29 sig");
		end

		#1
		if (tst_overflow != 0) begin
			$display("ERRO teste 29 over");
		end

		#1
		// teste 30: 0 + 1 = 1
		tst_a = 0;
		tst_b = 1;
		tst_unsig = 1;
		tst_op = 3'b010;
		
		#1
		if (tst_aluout != 1) begin
			$display("ERRO teste 30 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_aluout != 1) begin
			$display("ERRO teste 30 sig");
		end

		#1
		if (tst_overflow != 0) begin
			$display("ERRO teste 30 over");
		end

		#1
		// teste 31: 1 + 0 = 1
		tst_a = 1;
		tst_b = 0;
		tst_unsig = 1;
		tst_op = 3'b010;
		
		#1
		if (tst_aluout != 1) begin
			$display("ERRO teste 31 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_aluout != 1) begin
			$display("ERRO teste 31 sig");
		end

		#1
		if (tst_overflow != 0) begin
			$display("ERRO teste 31 over");
		end

		#1
		// teste 32: 1 + 1 = 2
		tst_a = 1;
		tst_b = 1;
		tst_unsig = 1;
		tst_op = 3'b010;
		
		#1
		if (tst_aluout != 2) begin
			$display("ERRO teste 32 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_aluout != 2) begin
			$display("ERRO teste 32 sig");
		end

		#1
		if (tst_overflow != 0) begin
			$display("ERRO teste 32 over");
		end

		#1
		// teste 33: 2147483647 + 2147483648 = 4294967295
		tst_a = 2147483647;
		tst_b = 2147483648;
		tst_unsig = 1;
		tst_op = 3'b010;
		
		#1
		if (tst_aluout != 4294967295) begin
			$display("ERRO teste 33 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_aluout != 4294967295) begin
			$display("ERRO teste 33 sig");
		end

		#1
		if (tst_overflow != 0) begin
			$display("ERRO teste 33 over");
		end

		#1
		// teste 34: 2147483648 + 2147483648 = 0 (overflow!)
		tst_a = 2147483648;
		tst_b = 2147483648;
		tst_unsig = 1;
		tst_op = 3'b010;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 34 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 34 sig");
		end

		#1
		if (tst_overflow != 1) begin
			$display("ERRO teste 34 over");
		end

		#1
		// teste 35: 4294901760 + 65535 = 4294967295
		tst_a = 4294901760;
		tst_b = 65535;
		tst_unsig = 1;
		tst_op = 3'b010;
		
		#1
		if (tst_aluout != 4294967295) begin
			$display("ERRO teste 35 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_aluout != 4294967295) begin
			$display("ERRO teste 35 sig");
		end

		#1
		if (tst_overflow != 0) begin
			$display("ERRO teste 35 over");
		end

		#1
		// teste 36: 2147483648 + 2147483650 = 2 (overflow!)
		tst_a = 2147483648;
		tst_b = 2147483650;
		tst_unsig = 1;
		tst_op = 3'b010;
		
		#1
		if (tst_aluout != 2) begin
			$display("ERRO teste 36 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_aluout != 2) begin
			$display("ERRO teste 36 sig");
		end

		#1
		if (tst_overflow != 1) begin
			$display("ERRO teste 36 over");
		end

		/* TESTE SUBTRACAO */

		#1
		// teste 37: 0 - 0 = 0
		tst_a = 0;
		tst_b = 0;
		tst_unsig = 1;
		tst_op = 3'b110;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 37 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 37 sig");
		end

		#1
		if (tst_overflow != 0) begin
			$display("ERRO teste 37 over");
		end

		#1
		// teste 38: 0 - 1 = -1
		tst_a = 0;
		tst_b = 1;
		tst_unsig = 1;
		tst_op = 3'b110;
		
		#1
		if (tst_aluout != 4294967295) begin
			$display("ERRO teste 38 unsig");
		end

		tst_unsig = 0;

		#1;
		if (tst_aluout != 4294967295) begin
			$display("ERRO teste 38 sig");
		end

		#1
		if (tst_overflow != 0) begin
			$display("ERRO teste 38 over");
		end

		#1
		// teste 39: 1 - 0 = 1
		tst_a = 1;
		tst_b = 0;
		tst_unsig = 1;
		tst_op = 3'b110;
		
		#1
		if (tst_aluout != 1) begin
			$display("ERRO teste 39 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_aluout != 1) begin
			$display("ERRO teste 39 sig");
		end

		#1
		if (tst_overflow != 0) begin
			$display("ERRO teste 39 over");
		end

		#1
		// teste 40: 1 - 1 = 0
		tst_a = 1;
		tst_b = 1;
		tst_unsig = 1;
		tst_op = 3'b110;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 40 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 40 sig");
		end

		#1
		if (tst_overflow != 0) begin
			$display("ERRO teste 40 over");
		end

		#1
		// teste 41: 4294967295 - 1 = 0 (overflow!)
		tst_a = 4294967295;
		tst_b = 1;
		tst_unsig = 1;
		tst_op = 3'b010;
		
		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 41 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_aluout != 0) begin
			$display("ERRO teste 41 sig");
		end

		#1
		if (tst_overflow == 1) begin
			$display("ERRO teste 41 over");
		end

		/* TESTE COMPOUT */

		#1
		// teste 42: 0 < 0 = 0
		tst_a = 0;
		tst_b = 0;
		tst_unsig = 1;

		#1
		if (tst_compout != 0) begin
			$display("ERRO teste 42 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_compout != 0) begin
			$display("ERRO teste 42 sig");
		end

		#1
		// teste 43: 0 < 1 = 1
		tst_a = 0;
		tst_b = 1;
		tst_unsig = 1;

		#1
		if (tst_compout != 1) begin
			$display("ERRO teste 43 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_compout != 1) begin
			$display("ERRO teste 43 sig");
		end

		#1
		// teste 44: 1 < 0 = 0
		tst_a = 1;
		tst_b = 0;
		tst_unsig = 1;

		#1
		if (tst_compout != 0) begin
			$display("ERRO teste 44 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_compout != 0) begin
			$display("ERRO teste 44 sig");
		end

		#1
		// teste 45: 1 < 1 = 0
		tst_a = 1;
		tst_b = 1;
		tst_unsig = 1;

		#1
		if (tst_compout != 0) begin
			$display("ERRO teste 45 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_compout != 0) begin
			$display("ERRO teste 45 sig");
		end

		#1
		// teste 46: 4294967295 (-1) < 0 = 
		tst_a = 4294967295;
		tst_b = 1;
		tst_unsig = 1;

		#1
		if (tst_compout != 0) begin // 0 unsig
			$display("ERRO teste 46 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_compout != 1) begin // 1 sig
			$display("ERRO teste 46 sig");
		end

		#1
		// teste 47: 2147483646 < 4294967295 (-1) = 
		tst_a = 2147483646;
		tst_b = 4294967295;
		tst_unsig = 1;

		#1
		if (tst_compout != 1) begin // 1 unsig
			$display("ERRO teste 47 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_compout != 0) begin // 0 sig
			$display("ERRO teste 47 sig");
		end

		#1
		// teste 48: 2147483648 < 2147483646 = 
		tst_a = 2147483649;
		tst_b = 2147483650;
		tst_unsig = 1;

		#1
		if (tst_compout != 0) begin // 0 unsig
			$display("ERRO teste 48 unsig");
		end

		tst_unsig = 0;

		#1
		if (tst_compout != 1) begin // 1 sig
			$display("ERRO teste 48 sig");
		end

	end

endmodule
