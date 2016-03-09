module seg7_disp(output [6:0]not_segs, input [3:0]n);
	assign not_segs=~segs;

	wire [6:0]segs, segs_0_9, segs_A_F;
        wire [3:0] a0, a1, a2, a3, a4, a5, a6, a7, a8, a9,aa ,ab,ac,ad,ae,af;
        assign a0=4'b0000;
        assign a1=4'b0001;
        assign a2=4'b0010;
        assign a3=4'b0011;
        assign a4=4'b0100;
        assign a5=4'b0101;
        assign a6=4'b0110;
        assign a7=4'b0111;
        assign a8=4'b1000;
        assign a9=4'b1001;
	assign aa=4'b1010;
	assign ab=4'b1011;
	assign ac=4'b1100;
	assign ad=4'b1101;
	assign ae=4'b1110;
	assign af=4'b1111;
	
	
        // assign A = (n==a0) || (n==a1) || (n==a2) || (n==a3) || (n==a4) || (n==a5) || (n==a6) || (n==a7) || (n==a8) || (n==a9);
	assign segs=(n>'d9)?segs_A_F:segs_0_9;
	//assign segs = segs_A_F;

        assign segs_0_9[0] = (n==a0) || (n==a2) || (n==a3) || (n==a5) || (n==a6) || (n==a7) || (n==a8) || (n==a9);
        assign segs_0_9[1] = (n==a0) || (n==a1) || (n==a2) || (n==a3) || (n==a4) || (n==a7) || (n==a8) || (n==a9);
        assign segs_0_9[2] = (n==a0) || (n==a1) || (n==a3) || (n==a4) || (n==a5) || (n==a6) || (n==a7) || (n==a8) || (n==a9);
        assign segs_0_9[3] = (n==a0) || (n==a2) || (n==a3) || (n==a5) || (n==a6) || (n==a8) || (n==a9);
        assign segs_0_9[4] = (n==a0) || (n==a2) || (n==a6) || (n==a8);
        assign segs_0_9[5] = (n==a0) || (n==a4) || (n==a5) || (n==a6) || (n==a8) || (n==a9);
        assign segs_0_9[6] = (n==a2) || (n==a3) || (n==a4) || (n==a5) || (n==a6) || (n==a8) || (n==a9);

        assign segs_A_F[0] = (n==aa) || (n==ac) || (n==ae) || (n==af);
        assign segs_A_F[1] = (n==aa) || (n==ad);
        assign segs_A_F[2] =(n==aa) || (n==ab) || (n==ad);
        assign segs_A_F[3] =(n==ab) || (n==ac) || (n==ad) || (n==ae);
        assign segs_A_F[4] =(n==aa) || (n==ab) || (n==ac) || (n==ad) || (n==ae) || (n==af);
        assign segs_A_F[5] =(n==aa) || (n==ab) || (n==ac) || (n==ae) || (n==af);
        assign segs_A_F[6] =(n==aa) || (n==ab) || (n==ad) || (n==ae) || (n==af);
endmodule
