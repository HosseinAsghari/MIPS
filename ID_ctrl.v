module ID_ctrl(input [15:0] instruction,
					output [2:0] alu_cmd);

	wire [3:0] opcode;
	
	assign opcode = instruction[15:12];
	assign alu_cmd = (opcode == 'b0001 || opcode == 'b1001 || opcode == 'b1010 || opcode == 'b1011) ? 'b000 : 
							(opcode == 'b0010) ? 'b001 :
							(opcode == 'b0011) ? 'b010 :
							(opcode == 'b0100) ? 'b011 :
							(opcode == 'b0101) ? 'b100 :
							(opcode == 'b0110) ? 'b101 :
							(opcode == 'b0111) ? 'b110 : 'b111;

endmodule 