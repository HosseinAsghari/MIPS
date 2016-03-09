module EX(
		input [15:0] inst, src1, src2,
		input [2:0] alu_cmd,
		output [15:0] inst_out, res_out);
	
		
		ALU alu_instance(src1, src2, alu_cmd, res_out);
		
		assign inst_out = inst;
				
endmodule 