module InstMem(Addr, Inst, clk, set);
  input[15:0] Addr;
  input clk, set;
  output [15:0] Inst;
  
  reg [15:0] InstMem [0:1024*64-1];
  
  assign Inst = 
			(Addr == 'd0 ) ? 'b1001_001_000_000_001: // addi r1 = 1 = r0+1	
			(Addr == 'd1 ) ? 'b1001_010_000_000_010: // addi r2 = 2 = r0+2	
			(Addr == 'd2 ) ? 'b0000_000_000_000_000: //nop
			(Addr == 'd3 ) ? 'b0000_000_000_000_000: //nop
			(Addr == 'd4 ) ? 'b0000_000_000_000_000: //nop
			(Addr == 'd5 ) ? 'b0000_000_000_000_000: //nop
			(Addr == 'd6 ) ? 'b1111_011_001_000_000: //dat r3=r1+next
			(Addr == 'd7 ) ? 'b0001_100_001_010_111: //must not be executed: add r4=r1+r2=1+2=3
			(Addr == 'd8 ) ? 'b0001_101_001_011_000: //add r5=r1+r3=0001 100 001 011 001
							 'b0000_000_000_000000;
					 
					 
					 /*
					 (Addr == 'd1) ? 'h1098 : //add 3, 4 -> 7
					 (Addr == 'd2) ? 'h20E0 : //sub 3, 4 -> F
					 (Addr == 'd3) ? 'h3098 : //and 3, 4 -> 0
					 (Addr == 'd4) ? 'h41D0 : //or  15, 3 -> F
					 (Addr == 'd5) ? 'h81B8 : //SRU 0x8000, 15 -> F
					 (Addr == 'd6) ? 'h71B8 : //SR 0x8000, 15 -> 1
					 */
  
  /*
  always @(*) begin
    if (set)
      //$readmemb("inst_mem.txt", InstMem);
    else
      Inst <= InstMem[Addr];
  end
  */
endmodule
