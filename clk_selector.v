module clk_selector(
		input manual_clk,
		input normal_clk,
		input clk_sel,
		output clk_out);

		assign clk_out = (clk_sel) ? normal_clk : manual_clk;
		
endmodule 