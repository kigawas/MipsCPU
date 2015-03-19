module scinstmem #(parameter DEPTH = 1000)(
  input [31:0] pc,
  output [31:0] inst
  );
  
  reg [31:0] ram [DEPTH-1:0];
  assign inst = ram[pc[31:2]];
  
  integer i;
  initial
    begin 
     for(i=0; i<32; i=i+1)
      ram[i] = 0;  
      $readmemh("C:/Users/Lumit/Downloads/CPUtest/_2_lwsw.hex.txt", ram);
    end
endmodule