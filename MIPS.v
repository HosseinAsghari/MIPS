module MIPS(
		input CLOCK_50, input [3:0] KEY, 
		input [17:0] SW,
		output [6:0] HEX0,
		output [6:0] HEX1,
		output [6:0] HEX2,
		output [6:0] HEX3,
		output [6:0] HEX4,
		output [6:0] HEX5,
		output [6:0] HEX6,
		output [6:0] HEX7);
	
	wire clk, rst;
	
	clk_selector selector_instance (~KEY[3], CLOCK_50, SW[17], clk);	
	assign rst = ~KEY[1];
		  
	wire [15:0] if_inst, pc, id_inst, id_pc;
	wire [2:0] id_alu_cmd, if_alu_cmd, if_read1_addr, if_read2_addr, id_read1_addr, id_read2_addr;
	wire [2:0] if_write_addr, id_write_addr;
	wire id_wr_en, if_wr_en;
	
	IF if_instance (clk, rst, 'b1, 0, 0, if_read1_addr, if_read2_addr, if_write_addr, pc, if_inst);
	
	
	controller ex_ctrl(if_inst, if_alu_cmd, if_wr_en);
	
	IF_ID if_id_instance (clk, rst, if_inst, pc, if_alu_cmd, if_read1_addr, if_read2_addr, if_write_addr ,if_wr_en, 
								id_inst, id_pc, id_alu_cmd, id_read1_addr, id_read2_addr, id_write_addr, id_wr_en);
	
	seg7_disp seg7_if (HEX0, id_inst[15:12]);
	
	wire [15:0] id_ex_inst, ex_inst, id_read1, id_read2, id_ex_read1, id_ex_read2, test_selected_reg;
	wire [2:0] reg_selector, wb_id_write_addr, ex_write_addr, ex_alu_cmd;
	wire wb_id_wr_en, ex_wr_en;
	wire [15:0] wb_id_data;
	
	assign reg_selector = SW[2:0];
	
	ID id_instance (clk, rst, wb_id_wr_en, id_inst, wb_id_data, reg_selector, wb_id_write_addr, 
					id_read1_addr, id_read2_addr, id_ex_inst, id_read1, id_read2, test_selected_reg);
	
	seg7_disp seg7_debug_ctrl (HEX6, {id_read1[3:0]});
	
	ID_EX id_ex_instance (clk, rst, id_ex_inst, id_read1, id_read2, id_wr_en, id_alu_cmd, id_write_addr, 
							ex_inst, id_ex_read1, id_ex_read2, ex_wr_en, ex_alu_cmd, ex_write_addr);
	
	seg7_disp seg7_rf (HEX4, test_selected_reg[3:0]);
	seg7_disp seg7_id (HEX1, ex_inst[15:12]);
	
	wire [15:0] ex_mem_inst, mem_inst, ex_res, ex_mem_res;
	wire mem_wr_en;
	wire [2:0] mem_write_addr;
		
	EX ex_instance (ex_inst, id_ex_read1, id_ex_read2, ex_alu_cmd, ex_mem_inst, ex_res);
	
	
	seg7_disp seg7_debug_ctrl2 (HEX7, {1'b0, ex_alu_cmd});
	
	EX_MEM ex_mem_instance (clk, rst, ex_mem_inst, ex_res, ex_wr_en, ex_write_addr,
									mem_inst, ex_mem_res, mem_wr_en, mem_write_addr);
	
	seg7_disp seg7_ex_res (HEX5, ex_res[3:0]);
	seg7_disp seg7_ex (HEX2, mem_inst[15:12]);
	
	wire [15:0] mem_wb_inst, wb_inst, mem_res, mem_wb_res;
	wire wb_wr_en;
	wire [2:0] wb_write_addr;
	
	MEM mem_instance (mem_inst, ex_mem_res, mem_wb_inst, mem_res);
	
	MEM_WB mem_wb_instance (clk, rst, mem_wb_inst, mem_res, mem_wr_en, mem_write_addr,
									wb_inst, mem_wb_res, wb_wr_en, wb_write_addr);
	
	seg7_disp seg7_mem (HEX3, wb_inst[15:12]);
	
	wire [15:0] wb_out_inst;
	
	WB wb_instance (wb_wr_en, wb_write_addr, wb_inst, mem_wb_res, 
	wb_id_wr_en, wb_id_write_addr, wb_out_inst, wb_id_data);
	
endmodule 