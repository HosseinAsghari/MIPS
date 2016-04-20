module ID( input clk, rst, wb_wr_en,
		input [15:0] inst, wb_data_input, pc,
		input [2:0] test_reg_selector, wb_address_input,
		input [2:0] read1_addr, read2_addr,
		input br_comm, mem_store,
		output [15:0] inst_out, read1, read2, imm_data, test_selected_reg,
		output br_perform,
		output[15:0] pc_branched);
		
		wire[15:0] read2_addr_store_handled; 
		
		RF reg_file (clk, rst, read1_addr, read2_addr_store_handled, wb_address_input, test_reg_selector, wb_wr_en, 
		wb_data_input, read1, read2, test_selected_reg);
		
		assign read2_addr_store_handled = (mem_store)?inst[11:9]:read2_addr;
		assign inst_out = inst;
		assign imm_data = {{10{inst[5]}},inst[5:0]};
		assign br_perform = br_comm & (read1 == 0);
		assign pc_branched = {{10{inst[5]}},inst[5:0]} + pc + 'h0001;
				
endmodule 