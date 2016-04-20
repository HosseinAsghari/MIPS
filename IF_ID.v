module IF_ID(
		input clk, rst, if_id_en,
		input [15:0] inst, pc,
		input [2:0] read1_addr, read2_addr, write_addr,
		output reg[15:0] inst_out, pc_out, 
		output reg [2:0] read1_addr_out, read2_addr_out, write_addr_out);
		
	always @(posedge clk)
	begin
		if (rst)
		begin
			inst_out <= 0;
			pc_out <= 0;
			read1_addr_out <= 0;
			read2_addr_out <= 0;
			write_addr_out <= 0;
		end
		else if (if_id_en)
		begin
			inst_out <= inst;
			pc_out <= pc;
			read1_addr_out <= read1_addr;
			read2_addr_out <= read2_addr;
			write_addr_out <= write_addr;
		end
	end
endmodule 