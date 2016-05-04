module HDU( input [15:0] inst,
				input reg_mem_select,
				input [2:0] ex_rd, mem_rd, wb_rd,
				input ex_wb_en, mem_wb_en, wb_wb_en,
				input forward_stall_sel,
				output pc_en, if_id_en, id_ex_regs_sel,
				output [1:0] alu_src_sel1, alu_src_sel2, store_data_sel);

		wire need_stall;
		
		wire [3:0] opcode;
		wire [2:0] rs1, rs2, alu_arg1_addr, alu_arg2_addr;
		
		assign opcode = inst[15:12];
		
		assign rs1 = (opcode <= 'b1001) ? (inst[8:6]) : 
							(opcode == 'b1011) ? (inst[11:9]) : 
							(opcode == 'b1100) ? (inst[8:6]) : 3'b000;
							
		assign rs2 = (opcode <= 'b1000) ? (inst[5:3]) :
							(opcode == 'b1001) ? (3'b000) :
							(opcode == 'b1011 || opcode == 'b1010) ? (inst[8:6]) : 3'b000;
		assign alu_arg1_addr=inst[8:6];
		assign alu_arg2_addr=(opcode<='b1000)?inst[5:3]:3'b000;
				
		assign need_stall = ((rs1 != 0) && (((rs1 == ex_rd) && ex_wb_en) || ((rs1 == mem_rd) && mem_wb_en) || ((rs1 == wb_rd) && wb_wb_en)))
								|| ((rs2 != 0) && (((rs2 == ex_rd) && ex_wb_en) || ((rs2 == mem_rd) && mem_wb_en) || ((rs2 == wb_rd) && wb_wb_en)));
		
		assign need_bubble = ((reg_mem_select && ex_wb_en) || (opcode == 'b1100)) && (((rs1 != 0) && (rs1 == ex_rd)) || ((rs2 != 0) && (rs2 == ex_rd)));
		
		assign pc_en = (forward_stall_sel == 0) ? (~ need_stall) : (need_bubble) ? 'b0 : 'b1;
		assign if_id_en = (forward_stall_sel == 0) ? (~ need_stall) : (need_bubble) ? 'b0 : 'b1;
		assign id_ex_regs_sel = (forward_stall_sel == 0) ? (need_stall) : (need_bubble) ? 'b1 : 'b0;
		
		assign alu_src_sel1 = ((alu_arg1_addr != 0) && (alu_arg1_addr == ex_rd) && ex_wb_en) ? 2'b01 : 
										((alu_arg1_addr != 0) && (alu_arg1_addr == mem_rd) && mem_wb_en) ? 2'b10 :
										((alu_arg1_addr != 0) && (alu_arg1_addr == wb_rd) && wb_wb_en) ? 2'b11 : 2'b00;
		assign alu_src_sel2 = ((alu_arg2_addr != 0) && (alu_arg2_addr == ex_rd) && ex_wb_en) ? 2'b01 : 
										((alu_arg2_addr != 0) && (alu_arg2_addr == mem_rd) && mem_wb_en) ? 2'b10 :
										((alu_arg2_addr != 0) && (alu_arg2_addr == wb_rd) && wb_wb_en) ? 2'b11 : 2'b00;
		assign store_data_sel =	(opcode==4'b1011 && rs1!=0 && rs1==ex_rd && ex_wb_en) ? 2'b01:
										(opcode==4'b1011 && rs1!=0 && rs1==mem_rd && mem_wb_en)? 2'b10:
										(opcode==4'b1011 && rs1!=0 && rs1==wb_rd && wb_wb_en)? 2'b11: 2'b00;
				
endmodule 