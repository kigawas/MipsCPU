`include "sccu_dataflow.v"
`include "cla32.v"
`include "alu.v"
`include "regfile.v"

module sccpu_dataflow(clock, resetn, inst, memout, pc, wmem, aluout, data2mem, reg_addr, reg_out );
  input [31:0] inst, memout;  
  input clock, resetn;
  output [31:0] pc, aluout, data2mem;  
  output wmem;
  input [4:0]reg_addr;
  output [31:0] reg_out;

  wire [1:0] pcsource;  //下一条指令的地址选择信号  00为pc+4, 01选转移地址，10选寄存器内的地址，11选跳转地址
  wire [3:0] aluc;  //ALU控制操作  
  wire zero;  //零标志位 beq,bnq
  wire wmem;  //写入内存dmem，为1时写入，否则不写，在lw，sw指令中
  wire wreg;  //写寄存器堆
  wire regrt; //目的寄存器选择，为1时选rt，为0时选rd
  wire m2reg; //存储数据写入寄存器：为1时选择存储器数据，为0时选择ALU结果
  wire shift; //ALU a使用移位位数：为1时使用sa，否则使用寄存器数据
  wire aluimm;  //ALU b用立即数：为1时用立即数，否则使用寄存器数据
  wire jal;   //子程序调用：为1时表示指令是jal,否则不是
  wire sext;   //立即数符号位扩展：为1时符号扩展，否则零扩展
  wire enable = 1;  //ip写使能
  wire co, overflow, negative, carry;
  wire [31:0] pcplus4out;
  wire [31:0] pcplus8out;
  wire [31:0] wpcout;
  wire [31:0] alu1, alu2;
  wire [31:0] rfouta;
  wire [31:0] sa = {27'b0, inst[10:6]};    //移位指令中的移位位数   将rt指定寄存器中的内容移动sa位，注意：inst中sa只有5位，此处将它扩展为32位
  wire e = sext & inst[15];  //立即数符号位，若sext为0则0扩展
  wire [15:0] imm = {16{e} };
  wire [31:0] immediate = {imm, inst[15:0]}; //符号位扩展后的立即数
  wire [4:0] reg_dest;
  wire [4:0] wn;
  wire [31:0] offset = {imm[13:0], inst[15:0], 2'b00};  //beq.bnq中相对转移地址
  wire [31:0] bpc;  //beq, bne中的转移地址
  wire [31:0] jpc = {pcplus4out[31:28], inst[25:0], 2'b00};  //j中的转移地址
  wire [31:0] data;  //寄存器堆中要写入的数据
  wire [31:0] nextpcout;
  wire [31:0] resultout;

  sccu_dataflow cpu_cu (inst[31:26], inst[5:0], zero, wmem, rmem, wreg, regrt, m2reg, aluc, shift, aluimm, pcsource, jal, sext, wpc);
  
  //ip，存放下一条指令地址
  dffe32 ip(nextpcout, clock, resetn, enable, pc);
  cla32 pcplus4(pc, 32'h4, 1'b0, pcplus4out, co); 
  cla32 pcplus8(pc, 32'h8, 1'b0, pcplus8out, co);
  mux2x5 reg_wn (inst[15:11], inst[20:16], regrt, reg_dest);
  assign wn = reg_dest | {5{jal}};  //jal: r31 <-- pc+8, if jal == 1, wn = 31 else wn = reg_dest
  mux2x32 pcorpc8(pc, pcplus8out, wpc, wpcout);  
  mux2x32 result(aluout, memout, m2reg, resultout);
  mux2x32 rf_add(resultout, pcplus8out, jal, data); 
  regfile rf(inst[25:21], inst[20:16], data, wn, wreg, clock, resetn, rfouta, data2mem, reg_addr, reg_out );
  mux2x32 alu_a(rfouta, sa, shift, alu1); 
  mux2x32 alu_b(data2mem, immediate, aluimm, alu2);
  alu aluunit(alu1, alu2, aluc, aluout, zero, negative, overflow, carry);
  cla32 beqbnepc(pc, offset, 1'b0, bpc, co);
  mux4x32 nextpc(pcplus4out, bpc, rfouta , jpc, pcsource, nextpcout);
endmodule