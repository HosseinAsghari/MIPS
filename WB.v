module WB(
		input mem_wr_en,
		input [2:0] mem_address_res,
		input [15:0] inst, mem_data_res,
		output wb_wr_en,
		output [2:0] wb_address_res, 
		output [15:0] inst_out, wb_data_res);

		assign wb_data_res = mem_data_res;
		assign wb_wr_en = mem_wr_en;
		assign wb_address_res = mem_address_res;
		assign inst_out = inst;
		
endmodule 