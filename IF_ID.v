module IF_ID(
		input clk, input rst,
		input [15:0] inst, pc,
		input [2:0] alu_cmd,
		input [2:0] read1_addr, read2_addr, write_addr,
		input wr_en,
		output reg[15:0] inst_out, pc_out, 
		output reg[2:0] alu_cmd_out,
		output reg [2:0] read1_addr_out, read2_addr_out, write_addr_out,
		output reg wr_en_out);
		
	always @(posedge clk)
	begin
		if (rst)
		begin
			inst_out <= 0;
			pc_out <= 0;
			alu_cmd_out <= 0;
			wr_en_out <= 0;
			read1_addr_out <= 0;
			read2_addr_out <= 0;
			write_addr_out <= 0;
		end
		else
		begin
			inst_out <= inst;
			pc_out <= pc;
			alu_cmd_out <= alu_cmd;
			wr_en_out <= wr_en;
			read1_addr_out <= read1_addr;
			read2_addr_out <= read2_addr;
			write_addr_out <= write_addr;
		end
	end
endmodule 