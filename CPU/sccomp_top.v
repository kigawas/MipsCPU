`timescale 1ns / 1ps

module sccomp_top(clock, resetn, inst, pc, aluout, memout,  a_to_g,  an, dp, reg_addr, ispc, hl );
  input clock, resetn;
  output [31:0] inst, pc, aluout, memout; 
  output  [6:0] a_to_g;
  output  [3:0] an;
  output  dp;
  input [4:0] reg_addr;
  input ispc;
  input hl;

  wire outclock;
  re_hz re_hz(clock, resetn, outclock);
  wire [31:0] reg_out;
  wire [31:0] data_show;
  wire [15:0] data_out;

  
  sccomp_dataflow sccomp( outclock, resetn, pc, inst, aluout, memout, reg_addr, reg_out );
  //assign reg_22 = sccomp_top.sccomp.cpu.rf.reg22.q;
  
  //led led( inst[15:0], clock, resetn,  a_to_g, an, dp );
  mux2x32 mux1(reg_out,pc,ispc,data_show);
  mux2x16 mux2(data_show[15:0],data_show[31:16],hl, data_out);
  
  led led( data_out[15:0], clock, resetn,  a_to_g, an, dp );


endmodule

module re_hz( 
input clock,
input resetn,
output outclock
);

reg [31:0] cnt;
always @( posedge clock or posedge resetn)  begin
  if( resetn == 1 )
    cnt = 0;
  else 
    cnt = cnt + 1;
end
  assign outclock = cnt[21];
endmodule