module mux2x5(a0, a1, s, y);
  input [4:0] a0, a1;
  input s;
  output [4:0] y;
  assign y = s ? a1 : a0;
endmodule

module mux2x16(a0, a1, s, y);
  input [15:0] a0, a1;
  input s;
  output [15:0] y;
  assign y = s ? a1 : a0;
endmodule

module mux2x32(a0, a1, s, y);
  input [31:0] a0, a1;
  input s;
  output [31:0] y;
  assign y = s ? a1 : a0;
endmodule

module mux4x32(a0, a1, a2, a3, s, y);
  input [31:0] a0, a1, a2, a3;
  input [1:0] s;
  output [31:0] y;
  
  function [31:0] select;
    input [31:0] a0, a1, a2, a3;
     input [1:0] s;
     case(s)
       2'b00: select = a0;
       2'b01: select = a1; 
       2'b10: select = a2;
       2'b11: select = a3;
     endcase
  endfunction
  assign y = select(a0, a1, a2, a3, s);
endmodule
