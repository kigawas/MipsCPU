module scdatamem #(parameter DEPTH = 2000)(
input clk, 
output [31:0] dataout,
input [31:0] datain,
input [31:0] addr,
input we
);

reg [31:0] ram[0:DEPTH-1];
//assign dataout = ram[addr[15:0]];
assign dataout = ram[addr];

always@(posedge clk) begin
	if(we) ram[addr] = datain;
end
endmodule
