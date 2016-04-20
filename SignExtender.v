module SignExtender(input[11:0] extend, output reg [15:0]  extended );

always @(*) begin
    extended[11:0] = extend[11:0];
    extended[15:12] = {4{extend[11]}};
end

endmodule 