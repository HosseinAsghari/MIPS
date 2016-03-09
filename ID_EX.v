module ID_EX(
		input clk, input rst,
		input [15:0] inst, read1, read2,
		input wr_en,
		input [2:0] alu_cmd,
		input [2:0] write_addr,
		output reg[15:0] inst_out, read1_out, read2_out,
		output reg wr_en_out,
		output reg [2:0] alu_cmd_out,
		output reg [2:0] write_addr_out);
		
	always @(posedge clk)
	begin
		if (rst)
		begin
			inst_out <= 0;
			read1_out <= 0;
			read2_out <= 0;
			wr_en_out <= 0;
			write_addr_out <= 0;
			alu_cmd_out <= 0;
		end
		else
		begin
			inst_out <= inst;
			read1_out <= read1;
			read2_out <= read2;
			wr_en_out <= wr_en;
			write_addr_out <= write_addr;
			alu_cmd_out <= alu_cmd;
		end
	end
endmodule 