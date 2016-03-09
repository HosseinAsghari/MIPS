module InstMem(Addr, Inst, clk, set);
  input[15:0] Addr;
  input clk, set;
  output [15:0] Inst;
  
  reg [15:0] InstMem [0:1024*64-1];
  
  assign Inst = (Addr == 'd0) ? 'h1E50 : //add 2, 3 -> 5 // r1 + r2 -> r7
					 (Addr == 'd1) ? 'h1098 : //add 3, 4 -> 7
					 (Addr == 'd2) ? 'h20E0 : //sub 3, 4 -> F
					 (Addr == 'd3) ? 'h3098 : //and 3, 4 -> 0
					 (Addr == 'd4) ? 'h41D0 : //or  15, 3 -> F
					 (Addr == 'd5) ? 'h81B8 : //SRU 0x8000, 15 -> F
					 (Addr == 'd6) ? 'h71B8 : //SR 0x8000, 15 -> 1
					 (Addr == 'd7) ? 'h7000 : 'h8000;
  
  /*
  always @(*) begin
    if (set)
      //$readmemb("inst_mem.txt", InstMem);
    else
      Inst <= InstMem[Addr];
  end
  */
endmodule