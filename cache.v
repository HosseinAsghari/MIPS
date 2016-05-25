module cache(
	input clk, rst,
	input	[15:0] address,
	input	[15:0] wdata,
	input 	w_command,
	output	[15:0] rdata,
	output	read_hit
);
	reg recently_used_col [255:0];
	reg [7:0] tag_bank_1	[255:0];
	reg [7:0] tag_bank_2	[255:0];
	reg [15:0] data_bank_1	[255:0];
	reg [15:0] data_bank_2	[255:0];
	reg valid_bank_1	[255:0];
	reg valid_bank_2	[255:0];
	reg [15:0] selected_data;
	reg set_1_hit, set_2_hit;

	wire [7:0] tag;
	wire [7:0] index;
	assign tag=address[15:8];
	assign index=address[7:0];

	assign read_hit=(set_1_hit || set_2_hit);
	assign rdata=selected_data;

	always@(posedge clk)
	begin
		if(rst)
		begin
			selected_data<=0;
			set_1_hit<=0;
			set_2_hit<=0;
		end
		else
			if(w_command==1'b1)
			begin
				set_1_hit<=1'b0;
				set_2_hit<=1'b0;

				if(tag==tag_bank_1[index])
				begin
					valid_bank_1[index]<=1'b1;
					data_bank_1[index]<=wdata;
					recently_used_col[index]<=1'b0;
				end
				else
				begin
					if(tag==tag_bank_2[index])
					begin
						valid_bank_2[index]<=1'b1;
						data_bank_2[index]<=wdata;
						recently_used_col[index]<=1'b1;
					end
					else
					begin
						if(recently_used_col[index]==1'b1)
						begin
							valid_bank_1[index]<=1'b1;
							data_bank_1[index]<=wdata;
							tag_bank_1[index]<=tag;
							recently_used_col[index]<=1'b0;
						end
						else
						begin
							valid_bank_2[index]<=1'b1;
							data_bank_2[index]<=wdata;
							tag_bank_2[index]<=tag;
							recently_used_col[index]<=1'b1;
						end
					end
				end
			end
			else
			begin
				if(tag==tag_bank_1[index] && valid_bank_1[index]==1'b1)
				begin
					set_1_hit<=1'b1;
					set_2_hit<=1'b0;
					recently_used_col[index]<=1'b0;
					selected_data<=data_bank_1[index];
				end
				else
				begin
					if(tag==tag_bank_2[index] && valid_bank_2[index]==1'b1)
					begin
						set_1_hit<=1'b0;
						set_2_hit<=1'b1;
						recently_used_col[index]<=1'b1;
						selected_data<=data_bank_2[index];
					end
					else
					begin
						set_1_hit<=1'b0;
						set_2_hit<=1'b0;
					end
				end
			end
	end
	
endmodule
