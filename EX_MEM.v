module EX_MEM(
		input clk, input rst,
		input [15:0] inst, res, store_data_in,
		input wr_en, mem_stroe_in, wb_mem_select_in,
		input [2:0] write_addr,
		output reg[15:0] inst_out, res_out, store_data_out,
		output reg wr_en_out, mem_stroe_out, wb_mem_select_out,
		output reg [2:0] write_addr_out);
		
	always @(posedge clk)
	begin
		if (rst)
		begin
			inst_out <= 0;
			res_out <= 0;
			store_data_out <= 0;
			wr_en_out <= 0;
			mem_stroe_out <= 0;
			wb_mem_select_out <= 0;
			write_addr_out <= 0;
		end
		else
		begin
			inst_out <= inst;
			res_out <= res;
			store_data_out <= store_data_in;
			wr_en_out <= wr_en;
			mem_stroe_out <= mem_stroe_in;
			wb_mem_select_out <= wb_mem_select_in;
			write_addr_out <= write_addr;
		end
	end
endmodule 