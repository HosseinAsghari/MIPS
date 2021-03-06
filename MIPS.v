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
		output [6:0] HEX7,
		output [17:0] LEDR,
		output [8:0] LEDG,
		output [17:0] SRAM_ADDR,
		inout [15:0] SRAM_DQ,
		output SRAM_WE_N, SRAM_OE_N, SRAM_UB_N, SRAM_LB_N, SRAM_CE_N);
	
	wire clk, rst, mem_is_busy;
	
	clk_selector selector_instance (~KEY[3], CLOCK_50, SW[17], clk);	
	assign rst = ~KEY[1];
		  
	wire [15:0] if_inst, pc, id_inst, id_pc;
	wire [2:0] id_alu_cmd, if_alu_cmd, if_read1_addr, if_read2_addr, id_read1_addr, id_read2_addr;
	wire [2:0] if_write_addr, id_write_addr;
	wire id_wr_en, br_comm, br_perform, id_alu_src2_sel_rf_imm, id_mem_store, id_is_mem_cmd, id_wb_mem_select;
	wire [15:0] pc_branched;
	
	wire pc_en, if_id_en, id_ex_regs_sel, forward_stall_sel; // HDU wires
	wire [1:0]id_read2_data_sel;
	
	assign forward_stall_sel = SW[16];
	
	assign LEDR = {2'b00, pc};
	
	IF if_instance (clk, rst, pc_en & ~mem_is_busy, 0, br_perform, pc_branched, if_read1_addr, if_read2_addr, 
						if_write_addr, pc, if_inst);
	
	IF_ID if_id_instance (clk, rst | br_perform, if_id_en & ~mem_is_busy,
								if_inst, pc, 
								if_read1_addr, if_read2_addr, if_write_addr , 
								id_inst, id_pc, 
								id_read1_addr, id_read2_addr, id_write_addr);
	
	
	
	controller ex_ctrl (id_inst, id_alu_cmd, id_wr_en, br_comm, id_alu_src2_sel_rf_imm, 
								id_mem_store, id_is_mem_cmd, id_wb_mem_select);
								
	seg7_disp seg7_if (HEX0, id_inst[15:12]);
	
	wire [15:0] id_ex_inst, ex_inst, id_read1, id_read2, id_ex_read1, id_ex_read2, test_selected_reg;
	wire [2:0] reg_selector, wb_id_write_addr, ex_write_addr, ex_alu_cmd;
	wire wb_id_wr_en, ex_wr_en, ex_alu_src2_sel_rf_imm, ex_mem_store, ex_is_mem_cmd, ex_wb_mem_select;
	wire [15:0] wb_id_data, ex_imm_data, id_imm_data;
	
	assign reg_selector = SW[2:0];
	
	ID id_instance (clk, rst, wb_id_wr_en,
						id_inst, wb_id_data, id_pc,
						reg_selector, wb_id_write_addr, 
						id_read1_addr, id_read2_addr,
						br_comm, id_mem_store, 
						id_ex_inst, id_read1, id_read2, id_imm_data, test_selected_reg,
						br_perform, 
						pc_branched);
	wire [15:0] ex_res, mem_res, forward_ex_data, forward_mem_data, forward_wb_data;
	wire [1:0] id_alu_src_sel1, id_alu_src_sel2, ex_alu_src_sel1, ex_alu_src_sel2;
	
	ID_EX id_ex_instance (clk, rst, ~mem_is_busy, id_ex_regs_sel,
								id_ex_inst, id_read1,
								
								(id_read2_data_sel==2'b01) ? ex_res:
								(id_read2_data_sel==2'b10) ? mem_res:
								(id_read2_data_sel==2'b11) ? wb_id_data : id_read2,
								
								id_imm_data, 
								ex_res, mem_res, wb_id_data,
								id_wr_en, id_alu_src2_sel_rf_imm, id_mem_store, id_is_mem_cmd, id_wb_mem_select,
								id_alu_cmd, id_write_addr, 
								id_alu_src_sel1, id_alu_src_sel2,
								ex_inst, id_ex_read1, id_ex_read2, ex_imm_data,
								forward_ex_data, forward_mem_data, forward_wb_data,
								ex_wr_en, ex_alu_src2_sel_rf_imm, ex_mem_store, ex_is_mem_cmd, ex_wb_mem_select,
								ex_alu_cmd, 
								ex_write_addr, 
								ex_alu_src_sel1, ex_alu_src_sel2); 
	
	seg7_disp seg7_rf (HEX4, test_selected_reg[3:0]);
	seg7_disp seg7_id (HEX1, ex_inst[15:12]);
	
	wire [15:0] ex_mem_inst, mem_inst, ex_mem_res, mem_store_data;
	wire mem_wr_en, mem_store_command, mem_is_mem_cmd, mem_wb_mem_select;
	wire [2:0] mem_write_addr;	
	
	EX ex_instance (ex_inst, 
						(ex_alu_src_sel1 == 2'b00) ? id_ex_read1 : (ex_alu_src_sel1 == 2'b01) ? forward_ex_data :
						(ex_alu_src_sel1 == 2'b10) ? forward_mem_data : forward_wb_data,
						(ex_alu_src_sel2 == 2'b00) ? id_ex_read2 : (ex_alu_src_sel2 == 2'b01) ? forward_ex_data :
						(ex_alu_src_sel2 == 2'b10) ? forward_mem_data : forward_wb_data,
						ex_imm_data, ex_alu_cmd, ex_alu_src2_sel_rf_imm, ex_mem_inst, ex_res);
	
	seg7_disp seg6_mem_forward (HEX6, {2'b00, id_read2_data_sel});
	seg7_disp seg7_wb_forward (HEX7, mem_test_data[3:0]);
	
	EX_MEM ex_mem_instance (clk, rst, mem_is_busy,
									ex_mem_inst, ex_res, id_ex_read2, 
									ex_wr_en, ex_mem_store, ex_is_mem_cmd, ex_wb_mem_select,
									ex_write_addr,
									mem_inst, ex_mem_res, mem_store_data,   
									mem_wr_en, mem_store_command, mem_is_mem_cmd, mem_wb_mem_select,
									mem_write_addr);
	
	seg7_disp seg7_ex (HEX2, mem_inst[15:12]);
	
	wire [15:0] mem_wb_inst, wb_inst, mem_wb_res, mem_test_data;
	wire wb_wr_en;
	wire [2:0] wb_write_addr;
	
	//MEM mem_instance (clk, rst, mem_store_command, mem_wb_mem_select,
	//						mem_inst, ex_mem_res, mem_store_data, 
	//						mem_wb_inst, mem_res, mem_test_data);
	
	wire [2:0] ready_count_test;
	
	assign mem_test_data = 0;
	
	SRAM_Controller sram_instance(clk, rst, mem_inst, ex_mem_res, mem_store_data, mem_is_mem_cmd, 
								mem_wb_mem_select, mem_store_command, mem_res, mem_is_busy, mem_wb_inst, ready_count_test,
								SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);
	
	seg7_disp seg7_ex_res (HEX5, {1'b0, ready_count_test});
	
	assign LEDG[0] = mem_is_busy;
	assign LEDG[1] = mem_is_mem_cmd;
	
	MEM_WB mem_wb_instance (clk, rst, ~mem_is_busy, mem_wb_inst, mem_res, mem_wr_en, mem_write_addr,
									wb_inst, mem_wb_res, wb_wr_en, wb_write_addr);
	
	seg7_disp seg7_mem (HEX3, wb_inst[15:12]);
	
	wire [15:0] wb_out_inst;
	
	WB wb_instance (wb_wr_en, wb_write_addr, wb_inst, mem_wb_res, 
	wb_id_wr_en, wb_id_write_addr, wb_out_inst, wb_id_data);
	
	HDU hdu_instance (id_inst,
							ex_wb_mem_select,
							ex_write_addr, mem_write_addr, wb_write_addr,
							ex_wr_en, mem_wr_en, wb_wr_en,
							forward_stall_sel,
							pc_en, if_id_en, id_ex_regs_sel,
							id_alu_src_sel1, id_alu_src_sel2, id_read2_data_sel);
	
endmodule 