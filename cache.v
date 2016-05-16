module cache_column(
	input	clk, rst,
	input	[7:0]	index,
	input	[7:0]	tag,
	input	[15:0]	writing_data,
	input	write_command,
	output	[15:0]	data,
	output	hit_o
);
	reg [24:0] cell_bank[255:0];
	reg is_fresh[255:0];
	reg [24:0] selected_cell;
	reg hit;

	wire [24:0] writing_value;
	integer i;

	assign writing_value={tag, writing_data, 1'b1};
	assign data=selected_cell[16:1];
	assign hit_o=hit;

	always @(posedge clk)
	begin
		if(rst)
		begin
			selected_cell<=0;
			for(i=0; i<256; i=i+1)
			begin
				hit<=0;
				is_fresh[i]<=0;
				cell_bank[i]<=0;
			end
		end
		else
		begin
			if(write_command)
			begin
				if(is_fresh[index]==0)
				begin
					cell_bank[index]<=writing_value;
					is_fresh[index]<=1;
				end
				else
				begin
					is_fresh[index]<=0;
				end
			end
			else
			begin
				if(tag==cell_bank[index][24:17] && cell_bank[index][0]==1'b1)
				begin
					hit<=1;
					is_fresh[index]<=1'b1;
					selected_cell<=cell_bank[index];
				end
				else
				begin
					hit<=0;
					is_fresh[index]<=1'b0;
				end
			end
		end
	end
endmodule

module cache(
	input clk, rst,
	input	[15:0] address,
	input	[15:0] wdata,
	input 	w_command,
	output	[15:0] rdata,
	output	read_hit
);
	wire [7:0] input_tag;
	wire [7:0] input_index;

	assign input_tag=address[15:8];
	assign input_index=address[7:0];

	wire [15:0]	set_1_data, set_2_data;
	wire set_1_hit, set_2_hit;

	assign read_hit=(set_1_hit || set_2_hit);
	assign rdata=( set_1_hit?set_1_data:set_2_data );

	cache_column set_1_column(clk, rst, input_index,
					input_tag, wdata, w_command,
					set_1_data, set_1_hit);

	cache_column set_2_column(clk, rst, input_index,
					input_tag, wdata, w_command,
					set_2_data, set_2_hit);
	
endmodule
