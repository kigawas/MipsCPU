module addsub32(
input [31:0] A,
input [31:0] B,
input aluc1,
input aluc0,
output [31:0]Result,
output Zero,
output Carry,
output Nagative,
output Overflow
);

reg [31:0]Result_temp;
reg Zero_temp;
reg Carry_temp;
reg Nagative_temp;
reg Overflow_temp;

assign Result   = Result_temp;
assign Zero     = Zero_temp;
assign Carry    = Carry_temp;
assign Overflow = Overflow_temp;
assign Nagative = Nagative_temp;

always @* begin
    if( aluc1 == 0 && aluc0 == 0 )begin//无符号数
        Result_temp = A + B;
        if( Result_temp == 0 )//判断Zero标志位
            Zero_temp = 1;
        else
            Zero_temp = 0;
        if ( Result_temp < A || Result_temp < B ) Carry_temp = 1;
        else Carry_temp = 0;                 
        Nagative_temp = 0;
        Overflow_temp = 0;
     end
     else if( aluc1 == 1 && aluc0 == 0 )begin//有符号数
        Result_temp = A + B;
        
        if( Result_temp[31] == 1 )
            Nagative_temp = 1;
         else if( Result_temp[31] == 0 )
            Nagative_temp = 0;
         Carry_temp=0;
         if ( A[31] & ~B[31]) Overflow_temp = 0; //A < 0, B >= 0, overflow = 0
         else if ( ~A[31] & B[31] )  Overflow_temp = 0; // A >= 0, B < 0, overflow = 0
         else if ( A[31] & B[31] & Result_temp[31] ) Overflow_temp = 0; // A < 0, B < 0, C < 0, overflow = 0
         else if ( ~A[31] & ~B[31] & ~Result_temp[31]) Overflow_temp = 0; // A >= 0, B >= 0, C >= 0, overflow = 0
         else begin
                Overflow_temp = 1;
                Result_temp = 0;
                end
        if( Result_temp == 0 )
            Zero_temp = 1;
        else 
            Zero_temp = 0;
     end
     else if( aluc1 == 0 && aluc0 == 1 )begin//无符号数
        Result_temp = A - B;
        if( Result_temp == 0 )
            Zero_temp = 1;
         else 
            Zero_temp = 0;
        if( A >= B )
            Carry_temp = 0;
        else
            Carry_temp = 1;
        Nagative_temp = 0;
        Overflow_temp = 0;
     end
     else if( aluc1 == 1 && aluc0 == 1 )begin//有符号数
        Result_temp = A - B;      
        Carry_temp = 0;
        if ( A[31] & B[31]) Overflow_temp = 0; //A < 0, B < 0, overflow = 0
        else if ( ~A[31] & ~B[31] )  Overflow_temp= 0; //A >= 0, B >= 0, overflow = 0
        else if ( A[31] & ~B[31] & Result_temp[31] ) Overflow_temp = 0; //A < 0, B >= 0, R < 0, overflow = 0
        else if ( ~A[31] & B[31] & ~Result_temp[31] )  Overflow_temp = 0; //A >= 0, B < 0, R > 0, overflow = 0
        else begin
            Overflow_temp = 1;
            Result_temp = 0;
        end
        if( Result_temp == 0 )
           Zero_temp = 1;
        else 
           Zero_temp = 0;
        if( Result_temp[31] == 1 )
           Nagative_temp = 1;
        else if( Result_temp[31] == 0 )
           Nagative_temp = 0; 
     end
end
endmodule