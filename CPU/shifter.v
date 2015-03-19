module shifter(
input [31:0] A, // 32 位原始输入数据
input [31:0] B, // 5 位输入数据，控制移位的位数
//input [1:0] aluc, // 2 位输入控制移位的方式
input aluc1,//aluc[1]
input aluc0,//aluc[0]
output  [31:0] Result,// 32 位输出，由 A 经过 B 位通过 aluc 指定的移位方式移位而得
output Zero,
output Carry,
output Negative,
output Overflow
);
reg [31:0] Result_temp;
reg Zero_temp;
reg Carry_temp;
reg Nagative_temp;
reg Overflow_temp;
reg [4:0] shift_amount;


assign Zero     = Zero_temp;
assign Carry    = Carry_temp;
assign Negative = Nagative_temp;
assign Overflow = Overflow_temp;
assign Result   = Result_temp;

always @(*) begin
    if( aluc1 == 0 && aluc0 == 0 )begin //SRA
        shift_amount = A[4:0];
        Result_temp = $signed(B)>>>shift_amount;
        if( Result_temp == 0 ) 
            Zero_temp = 1;
        else 
            Zero_temp = 0;
        Nagative_temp = B[31];
        if ( shift_amount == 0) 
            Carry_temp = 0;
        else 
            Carry_temp = B[shift_amount -1];
        Overflow_temp = 0;
        Nagative_temp=Result_temp[31];
    end
    else if( aluc1 == 0 && aluc0 == 1 )begin //SRL
        shift_amount = A[4:0];
        Result_temp = B >> shift_amount;
        if(Result_temp==0) 
            Zero_temp=1;
        else 
            Zero_temp=0;
        if(shift_amount==0)
            Carry_temp=0;
        else
        Carry_temp=B[shift_amount-1];
        Overflow_temp=0;
        Nagative_temp = Result_temp[31];
    end
    else if( aluc1 == 1 && aluc0 == 0 )begin  //SLL
        shift_amount = A[4:0];
        Result_temp = B<<shift_amount;
        if ( Result_temp == 0)
            Zero_temp = 1;
        else 
            Zero_temp = 0;
        if ( shift_amount ==0)
            Carry_temp = 0;
        else 
            Carry_temp=B[32-shift_amount]; 
        Overflow_temp = 0;  
        Nagative_temp = Result_temp[31];
    end
    else if( aluc1 == 1 && aluc0 == 1 )begin //SLL
        shift_amount = A[4:0];
        Result_temp=B<<shift_amount;
        if (Result_temp == 0)
            Zero_temp = 1;
        else Zero_temp = 0;
        if (shift_amount ==0)
          Carry_temp = 0;
        else 
        Carry_temp=B[32-shift_amount];
        Overflow_temp = 0;
        Nagative_temp = Result_temp[31];
    end
end
endmodule   