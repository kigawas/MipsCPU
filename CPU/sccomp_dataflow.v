`include "sccpu_dataflow.v"
`include "scinstmem.v"
`include "scdatamem.v"
module sccomp_dataflow(clock, resetn, pc, inst, aluout, memout,reg_addr,reg_out  );
   input clock, resetn;
   output [31:0] inst, pc, aluout, memout;   
	input [4:0] reg_addr;
	output [31:0] reg_out;

   
   wire [31:0] datatomem;
   wire wmem;

   sccpu_dataflow cpu( clock, resetn, inst, memout, pc, wmem, aluout, datatomem,reg_addr,reg_out );
   iram_ip iram_ip (
    .a(pc[11:2]), // input [9 : 0] a
    .spo(inst) // output [31 : 0] spo
    );
	 
	 
 
  //scinstmem imem ( pc, inst );  
  scdatamem dmem (clock,memout, datatomem, aluout, wmem );
endmodule

