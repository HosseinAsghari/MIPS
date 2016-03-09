module IF(
        input clk, rst, if_enable,
        input [5:0] imm_pc_offset,
        input branch_enable,
		  output [2:0] read1_addr, read2_addr, write_addr,
        output reg [15:0] pc,
        output [15:0] instruction
);
		 
		  wire [15:0] wire_inst;
		 
		  InstMem instance_mem (pc, wire_inst, clk, rst);
		  
		  assign instruction = wire_inst;
		  assign read1_addr = wire_inst[8:6];
		  assign read2_addr = wire_inst[5:3];
		  assign write_addr = wire_inst[11:9];
		  
        always@(posedge clk)
        begin
                if(rst)
                        pc<='h0000;
                else
                        if(if_enable)
                        begin
                                pc<=(branch_enable=='b1)?
                                        (pc+{10'b0000000000, imm_pc_offset}):pc+1;
                        end
        end
endmodule 