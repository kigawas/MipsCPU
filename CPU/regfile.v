`include "dffe32.v"
module regfile(rna, rnb, d, wn, we, clk, clrn, qa, qb, reg_addr, reg_out );
  input [4:0] rna, rnb, wn;
  input [31:0] d;
  input clk, clrn, we;
  output [31:0] qa, qb;
  
  input [4:0] reg_addr;
  output [31:0] reg_out;
  
  wire [31:0] e;
  wire [31:0] r00, r01, r02, r03, r04, r05, r06, r07;
  wire [31:0] r08, r09, r10, r11, r12, r13, r14, r15;
  wire [31:0] r16, r17, r18, r19, r20, r21, r22, r23;
  wire [31:0] r24, r25, r26, r27, r28, r29, r30, r31;
  
  
  dec5e decoder(wn, we, e);
  assign r00 = 0;
  dffe32 reg01 (d, clk, clrn, e[01], r01);
  dffe32 reg02 (d, clk, clrn, e[02], r02);
  dffe32 reg03 (d, clk, clrn, e[03], r03);
  dffe32 reg04 (d, clk, clrn, e[04], r04);
  dffe32 reg05 (d, clk, clrn, e[05], r05);
  dffe32 reg06 (d, clk, clrn, e[06], r06);
  dffe32 reg07 (d, clk, clrn, e[07], r07);
  dffe32 reg08 (d, clk, clrn, e[08], r08);
  dffe32 reg09 (d, clk, clrn, e[09], r09);
  dffe32 reg10 (d, clk, clrn, e[10], r10);
  dffe32 reg11 (d, clk, clrn, e[11], r11);
  dffe32 reg12 (d, clk, clrn, e[12], r12);
  dffe32 reg13 (d, clk, clrn, e[13], r13);
  dffe32 reg14 (d, clk, clrn, e[14], r14);
  dffe32 reg15 (d, clk, clrn, e[15], r15);
  dffe32 reg16 (d, clk, clrn, e[16], r16);
  dffe32 reg17 (d, clk, clrn, e[17], r17);
  dffe32 reg18 (d, clk, clrn, e[18], r18);
  dffe32 reg19 (d, clk, clrn, e[19], r19);
  dffe32 reg20 (d, clk, clrn, e[20], r20);
  dffe32 reg21 (d, clk, clrn, e[21], r21);
  dffe32 reg22 (d, clk, clrn, e[22], r22);
  dffe32 reg23 (d, clk, clrn, e[23], r23);
  dffe32 reg24 (d, clk, clrn, e[24], r24);
  dffe32 reg25 (d, clk, clrn, e[25], r25);
  dffe32 reg26 (d, clk, clrn, e[26], r26);
  dffe32 reg27 (d, clk, clrn, e[27], r27);
  dffe32 reg28 (d, clk, clrn, e[28], r28);
  dffe32 reg29 (d, clk, clrn, e[29], r29);
  dffe32 reg30 (d, clk, clrn, e[30], r30);
  dffe32 reg31 (d, clk, clrn, e[31], r31);

  function [31:0] select;
    input [31:0] r00, r01, r02, r03, r04, r05, r06, r07, r08, r09, r10, r11, r12, r13, r14, r15,                       
                r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
   input [4:0] s;
   case(s)
     5'd00: select = r00;
     5'd01: select = r01;
     5'd02: select = r02;
     5'd03: select = r03;
     5'd04: select = r04;
     5'd05: select = r05;
     5'd06: select = r06;
     5'd07: select = r07;
     5'd08: select = r08;
     5'd09: select = r09;
     5'd10: select = r10;
     5'd11: select = r11;
     5'd12: select = r12;
     5'd13: select = r13;
     5'd14: select = r14;
     5'd15: select = r15;
     5'd16: select = r16;
     5'd17: select = r17;
     5'd18: select = r18;
     5'd19: select = r19;
     5'd20: select = r20;
     5'd21: select = r21;
     5'd22: select = r22;
     5'd23: select = r23;
     5'd24: select = r24;
     5'd25: select = r25;
     5'd26: select = r26;
     5'd27: select = r27;
     5'd28: select = r28;
     5'd29: select = r29;
     5'd30: select = r30;
     5'd31: select = r31;
    endcase
  endfunction
   assign qa = select(r00, r01, r02, r03, r04, r05, r06, r07, r08, r09, r10, r11, r12, r13, r14, r15,
                     r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, rna);
   assign qb = select(r00, r01, r02, r03, r04, r05, r06, r07, r08, r09, r10, r11, r12, r13, r14, r15,
                     r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, rnb);
	assign reg_out = select(r00, r01, r02, r03, r04, r05, r06, r07, r08, r09, r10, r11, r12, r13, r14, r15,
                     r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, reg_addr);
endmodule

module dec5e(n, ena, e);
  input [4:0] n;
  input ena;
  output [31:0] e;
  
  function [31:0] decoder;
    input [4:0] n;
    input ena;
    if(ena == 1'b0) decoder = 32'h00000000;
    else begin
      case(n)
       5'b00000: decoder = 32'h00000001;
       5'b00001: decoder = 32'h00000002;
       5'b00010: decoder = 32'h00000004;
       5'b00011: decoder = 32'h00000008;
       5'b00100: decoder = 32'h00000010;
       5'b00101: decoder = 32'h00000020;
       5'b00110: decoder = 32'h00000040;
       5'b00111: decoder = 32'h00000080;
       5'b01000: decoder = 32'h00000100;
       5'b01001: decoder = 32'h00000200;
       5'b01010: decoder = 32'h00000400;
       5'b01011: decoder = 32'h00000800;
       5'b01100: decoder = 32'h00001000;
       5'b01101: decoder = 32'h00002000;
       5'b01110: decoder = 32'h00004000;
       5'b01111: decoder = 32'h00008000;
       5'b10000: decoder = 32'h00010000;
       5'b10001: decoder = 32'h00020000;
       5'b10010: decoder = 32'h00040000;
       5'b10011: decoder = 32'h00080000;
       5'b10100: decoder = 32'h00100000;
       5'b10101: decoder = 32'h00200000;
       5'b10110: decoder = 32'h00400000;
       5'b10111: decoder = 32'h00800000;
       5'b11000: decoder = 32'h01000000;
       5'b11001: decoder = 32'h02000000;
       5'b11010: decoder = 32'h04000000;
       5'b11011: decoder = 32'h08000000;
       5'b11100: decoder = 32'h10000000;
       5'b11101: decoder = 32'h20000000;
       5'b11110: decoder = 32'h40000000;
       5'b11111: decoder = 32'h80000000;
    endcase
    end
  endfunction
  assign e = decoder(n, ena);
endmodule