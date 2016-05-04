
module SRAM_Controller(
		input clk, rst, 
		input [15:0] inst,
		input [15:0] mem_addr,
		input [15:0] data_in,
		input mem_cmd, wb_mem_select, store_en,
		output [15:0] mem_res,
		output mem_is_busy,
		output [15:0] inst_out,
		
		output [1:0] ready_count_test,
		
		inout reg [15:0] SRAM_DATA,
		output reg [17:0] SRAM_ADDRESS,
		output SRAM_UB, SRAM_LB,
		output reg SRAM_WE,
		output SRAM_CE, SRAM_OE);

		//reg [2:0] ready_counter;
	
		reg temp1, temp2;
	
		assign inst_out = inst;
	
		assign SRAM_UB = 0;
		assign SRAM_LB = 0;
		assign SRAM_CE = ~mem_cmd;
		assign SRAM_OE = 0;
		
		assign mem_res = (wb_mem_select) ? SRAM_DATA : mem_addr;
			
		assign mem_is_busy = mem_cmd;
		
		always @(posedge clk) 
		begin
			if (rst)
			begin
				//ready_counter = 0;
				SRAM_WE = 1;
				SRAM_ADDRESS = 0;
				SRAM_DATA = 16'bzzzzzzzzzzzzzzzz;
			end
			else 
			begin
				if (mem_cmd)
				begin
					SRAM_ADDRESS = {2'b00, mem_addr};
					if (store_en)
					begin
						SRAM_DATA = data_in;
						SRAM_WE = 0;
					end
					else
					begin
						SRAM_DATA = 16'bzzzzzzzzzzzzzzzz;
						SRAM_WE = 1;
					end		
				end
				else
				begin
					temp1 = 1;
				end
			end
		end
		
endmodule 

/*

module SRAM_Controller(
		input clk, rst, 
		input [15:0] inst,
		input [15:0] mem_addr,
		input [15:0] data_in,
		input mem_cmd, wb_mem_select, store_en,
		output [15:0] mem_res,
		output reg mem_is_busy,
		output [15:0] inst_out,
		
		output [1:0] ready_count_test,
		
		inout reg [15:0] SRAM_DATA,
		output reg [17:0] SRAM_ADDRESS,
		output SRAM_UB, SRAM_LB,
		output reg SRAM_WE,
		output SRAM_CE, SRAM_OE);

		reg [2:0] ready_counter;
	
		reg temp1, temp2;
	
		assign inst_out = inst;
	
		assign SRAM_UB = 0;
		assign SRAM_LB = 0;
		assign SRAM_CE = ~(mem_cmd | (ready_counter != 0));
		assign SRAM_OE = 0;
		
		assign mem_res = wb_mem_select ? SRAM_DATA : mem_addr;
			
		//assign mem_is_busy = mem_cmd | (ready_counter != 0);
		
		always @(posedge clk) 
		begin
			if (rst)
			begin
				ready_counter = 0;
				SRAM_WE = 1;
				SRAM_ADDRESS = 0;
				SRAM_DATA = 16'bzzzzzzzzzzzzzzzz;
			end
			else 
			begin
				if (mem_cmd)
				begin
					mem_is_busy = 1;
					SRAM_ADDRESS = {2'b00, mem_addr};
					if (store_en)
					begin
						SRAM_DATA = data_in;
						SRAM_WE = 0;
					end
					else
					begin
						SRAM_DATA = 16'bzzzzzzzzzzzzzzzz;
						SRAM_WE = 1;
					end		
				end
				else
					temp1 = 1;
				if (ready_counter == 3)
					begin
						ready_counter = 0;
						mem_is_busy = 0;
					end
				else if(mem_cmd == 1'b1 || ready_counter > 0)
					ready_counter = ready_counter + 1;
				else
					temp2 = 1;
			end
		end
		
endmodule 
 */