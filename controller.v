module controller(input [15:0] instruction,
					output [2:0] alu_cmd,
					output wr_en, br_comm, alu_src2_sel_rf_imm, mem_store, wb_mem_select);

	wire [3:0] opcode;
	
	assign opcode = instruction[15:12];
	assign alu_cmd = (opcode == 'b0001 || opcode == 'b1001 || opcode == 'b1010 || opcode == 'b1011) ? 'b000 : 
							(opcode == 'b0010) ? 'b001 :
							(opcode == 'b0011) ? 'b010 :
							(opcode == 'b0100) ? 'b011 :
							(opcode == 'b0101) ? 'b100 :
							(opcode == 'b0110) ? 'b101 :
							(opcode == 'b0111) ? 'b110 : 'b111;

	assign wr_en = ~(opcode == 'b0000 || opcode == 'b1011 || opcode == 'b1100 ||
							opcode == 'b1101 || opcode == 'b1110 || opcode == 'b1111);	
	assign br_comm = opcode == 'b1100;	

	assign alu_src2_sel_rf_imm = (opcode == 'b1001 || opcode == 'b1010 || opcode == 'b1011);
							
	assign mem_store = (opcode == 'b1011);
	
	assign wb_mem_select = (opcode == 'b1010);
endmodule 