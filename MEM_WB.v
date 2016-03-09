module MEM_WB(
		input clk, input rst,
		input [15:0] inst, res,
		input wr_en,
		input [2:0] write_addr,
		output reg[15:0] inst_out, res_out,
		output reg wr_en_out,
		output reg [2:0] write_addr_out);
		
		
	always @(posedge clk)
	begin
		if (rst)
		begin
			inst_out <= 0;
			res_out <= 0;
			wr_en_out <= 0;
			write_addr_out <= 0;
			
		end
		else
		begin
			inst_out <= inst;
			res_out <= res;
			wr_en_out <= wr_en;
			write_addr_out <= write_addr;
		end
	end
endmodule 