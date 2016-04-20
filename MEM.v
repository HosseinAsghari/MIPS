module MEM(
		input clk, rst, store_en, wb_mem_select,
		input [15:0] inst, ex_res, data_in,
		output [15:0] inst_out, mem_res, test_data_out);

		wire[15:0] loaded_data;
		
		assign inst_out = inst;
		
		assign mem_res = (wb_mem_select) ? loaded_data : ex_res;
	
		dataMem dataMem_inst(clk, rst, store_en, ex_res, data_in, loaded_data, test_data_out);
endmodule 