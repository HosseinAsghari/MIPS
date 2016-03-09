module RF(input clk, rst,
			input [2:0] rd_addr1, rd_addr2,
			input [2:0] dest_addr,
			input [2:0] reg_selector,
			input wr_en,
			input [15:0] wr_data,
			output [15:0] rd1, rd2,
			output [15:0] test_selected_reg);
			
			reg [15:0] reg_bank [0:7];
			
			assign rd1 = reg_bank[rd_addr1];
			assign rd2 = reg_bank[rd_addr2];
			
			assign test_selected_reg = reg_bank[reg_selector];
						
			always @(posedge clk) 
			begin
				if (rst) begin
					reg_bank[0] <= 'd0;
					reg_bank[1] <= 'd2;
					reg_bank[2] <= 'd3;
					reg_bank[3] <= 'd4;
					reg_bank[4] <= 'd5;
					reg_bank[5] <= 'd6;
					reg_bank[6] <= 'h8000;
					reg_bank[7] <= 'd15;
				end
				else if (wr_en && dest_addr != 0)
					reg_bank[dest_addr] <= wr_data;
			end			

endmodule 