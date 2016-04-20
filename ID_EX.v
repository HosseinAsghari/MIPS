module ID_EX(
		input clk, input rst, ctrl_regs_sel,
		input [15:0] inst, read1, read2, imm_data,
		input wr_en, alu_src2_sel_rf_imm, mem_store_in, wb_mem_select_in,
		input [2:0] alu_cmd,
		input [2:0] write_addr,
		output reg[15:0] inst_out, read1_out, read2_out, imm_data_out,
		output reg wr_en_out, alu_src2_sel_rf_imm_out, mem_store_out, wb_mem_select_out,
		output reg [2:0] alu_cmd_out,
		output reg [2:0] write_addr_out);
		
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
			wb_mem_select_out <= 0;
			write_addr_out <= 0;
			alu_cmd_out <= 0;
		end
		else
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
				wb_mem_select_out <= 0;
			end
			else
			begin
				wr_en_out <= wr_en;
				alu_src2_sel_rf_imm_out <= alu_src2_sel_rf_imm;
				mem_store_out <= mem_store_in;
				wb_mem_select_out <= wb_mem_select_in;
			end
		end
	end
endmodule 