module EX(
		input [15:0] inst, src1, src2, imm_data, 
		input [2:0] alu_cmd,
		input alu_src2_sel_rf_imm,
		output [15:0] inst_out, res_out);
	
		
		ALU alu_instance(src1,
								(alu_src2_sel_rf_imm) ? imm_data : src2,
								alu_cmd, res_out);
		
		assign inst_out = inst;
				
endmodule 