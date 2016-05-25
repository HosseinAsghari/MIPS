module EX(
		input [15:0] inst, id_inst, src1, src2, imm_data, 
		input [2:0] alu_cmd,
		input [1:0] alu_src2_sel_rf_imm,
		output [15:0] inst_out, res_out);
	
		
		ALU alu_instance(src1,
								(alu_src2_sel_rf_imm==2'b01) ? imm_data :
								(alu_src2_sel_rf_imm==2'b10) ? id_inst : src2,
								alu_cmd, res_out);
		
		assign inst_out = inst;
				
endmodule 
