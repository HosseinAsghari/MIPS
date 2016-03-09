module MEM(
		input [15:0] inst, ex_res,
		output [15:0] inst_out, mem_res);

		assign mem_res = ex_res;
		
		assign inst_out = inst;
		
endmodule 