module ALU(input [15:0] A, B,
				input [2:0] cmd,
				output reg [15:0] res);
				
				wire [31:0]AA;
				assign AA={{16{A[15]}}, A};
				always @(A, B, cmd) 
				begin 
					if (cmd == 3'b000)
						res <= A + B;
					else if (cmd == 3'b001)
						res <= A - B;
					else if (cmd == 3'b010)
						res <= A & B;
					else if (cmd == 3'b011)
						res <= A | B;
					else if (cmd == 3'b100)
						res <= A ^ B;
					else if (cmd == 3'b101)
						res <= (A << B);
					else if (cmd == 3'b110)
						res <= (A >> B);
					else if (cmd == 3'b111)
						res <= AA >> B;
					else
						res <= 0;
				end

endmodule 