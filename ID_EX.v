module ID_EX(
		input clk, input rst, id_ex_en, ctrl_regs_sel,
		input [15:0] inst, read1, read2, imm_data, forward_ex_data, forward_mem_data, forward_wb_data,
		input wr_en, alu_src2_sel_rf_imm, mem_store_in, is_mem_cmd_in, wb_mem_select_in,
		input [2:0] alu_cmd,
		input [2:0] write_addr,
		input [1:0] alu_src_sel1, alu_src_sel2,
		output reg[15:0] inst_out, read1_out, read2_out, imm_data_out, 
		output reg[15:0] forward_ex_data_out, forward_mem_data_out, forward_wb_data_out,
		output reg wr_en_out, alu_src2_sel_rf_imm_out, mem_store_out, is_mem_cmd_out, wb_mem_select_out,
		output reg [2:0] alu_cmd_out,
		output reg [2:0] write_addr_out,
		output reg [1:0] alu_src_sel1_out, alu_src_sel2_out);
		
	always @(posedge clk)
	begin
		if (rst)
		begin
			inst_out <= 0;
			read1_out <= 0;
			read2_out <= 0;
			imm_data_out <= 0;
			wr_en_out <= 0;
			alu_src2_sel_rf_imm_out <= 0;
			mem_store_out <= 0;
			is_mem_cmd_out <= 0;
			wb_mem_select_out <= 0;
			write_addr_out <= 0;
			alu_cmd_out <= 0;
			forward_ex_data_out <= 0;
			forward_mem_data_out <= 0;
			forward_wb_data_out <= 0;
			alu_src_sel1_out <= 0;
			alu_src_sel2_out <= 0;
		end
		else if (id_ex_en)
		begin
			inst_out <= inst;
			read1_out <= read1;
			read2_out <= read2;
			imm_data_out <= imm_data;
			write_addr_out <= write_addr;
			alu_cmd_out <= alu_cmd;
			if (ctrl_regs_sel)
			begin
				wr_en_out <= 0;
				alu_src2_sel_rf_imm_out <= 0;
				mem_store_out <= 0;
				is_mem_cmd_out <= 0;
				wb_mem_select_out <= 0;
				forward_ex_data_out <= 0;
				forward_mem_data_out <= 0;
				forward_wb_data_out <= 0;
				alu_src_sel1_out <= 0;
				alu_src_sel2_out <= 0;
			end
			else
			begin
				wr_en_out <= wr_en;
				alu_src2_sel_rf_imm_out <= alu_src2_sel_rf_imm;
				mem_store_out <= mem_store_in;
				is_mem_cmd_out <= is_mem_cmd_in;
				wb_mem_select_out <= wb_mem_select_in;
				forward_ex_data_out <= forward_ex_data;
				forward_mem_data_out <= forward_mem_data;
				forward_wb_data_out <= forward_wb_data;
				alu_src_sel1_out <= alu_src_sel1;
				alu_src_sel2_out <= alu_src_sel2;
			end
		end
	end
endmodule 