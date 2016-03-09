module ID( input clk, rst, wb_wr_en,
		input [15:0] inst, wb_data_input,
		input [2:0] test_reg_selector, wb_address_input,
		input [2:0] read1_addr, read2_addr,
		output [15:0] inst_out, read1, read2, test_selected_reg);
		
		RF reg_file (clk, rst, read1_addr, read2_addr, wb_address_input, test_reg_selector, wb_wr_en, 
		wb_data_input, read1, read2, test_selected_reg);
		
		assign inst_out = inst;
				
endmodule 