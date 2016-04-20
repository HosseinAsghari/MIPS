module HDU( input [15:0] inst,
				input [2:0] ex_rd, mem_rd, wb_rd,
				input ex_wb_en, mem_wb_en, wb_wb_en,
				output pc_en, if_id_en, id_ex_regs_sel);

		wire need_stall;
		
		wire [3:0] opcode;
		wire [2:0] rs1, rs2;
		
		assign opcode = inst[15:12];
		
		assign rs1 = (opcode <= 'b1001) ? (inst[8:6]) : 
							(opcode == 'b1011) ? (inst[11:9]) : 
							(opcode == 'b1100) ? (inst[8:6]) : 0;
							
		assign rs2 = (opcode <= 'b1000) ? (inst[5:3]) :
							(opcode == 'b1001) ? (0) :
							(opcode == 'b1011 || opcode == 'b1010) ? (inst[8:6]) : 0;
				
		assign need_stall = ((rs1 != 0) && (((rs1 == ex_rd) && ex_wb_en) || ((rs1 == mem_rd) && mem_wb_en) || ((rs1 == wb_rd) && wb_wb_en)))
								|| ((rs2 != 0) && (((rs2 == ex_rd) && ex_wb_en) || ((rs2 == mem_rd) && mem_wb_en) || ((rs2 == wb_rd) && wb_wb_en)));
		
		assign pc_en = ~ need_stall;
		assign if_id_en = ~ need_stall;
		assign id_ex_regs_sel = need_stall;
				
endmodule 