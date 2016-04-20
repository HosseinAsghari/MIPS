module dataMem(
	input clk, rst, wr_en,
	input[15:0] addr, data_in,
	output[15:0] data_out, test_data_out
);
	// WARNING: DUE TO LOW SIZE, MEMORY ADDRESSES HAVE BEEN ALIASED.
	// ONLY 6 RIGHT BITS ARE VALID. TOTAL IS 64 WORDS.
	
	reg [15:0] data [0:63];
	
	assign data_out = data[addr[5:0]];
	assign test_data_out = data[0];
	
	always @(posedge clk)
	begin
		/*if(rst)
		begin
			integer i;
			for(i = 0; i < (2**16); i = i+1)
			begin
				data[i] = 0;
			end	
		end
		
		else */
		if(wr_en)
		begin
			data[addr[5:0]] = data_in;
		end
	end
	
endmodule