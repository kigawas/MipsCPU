MipsCPU
=======

A single cycle CPU running on Xilinx Spartan 6 XC6LX16-CS324(FPGA), supporting 31 MIPS instructions.

>*  31 MIPS instructions.
>*  Single Cycle, without interruptions and exceptions(maybe add these features later).

Instructions:
>*  ``R-Type: ADD, ADDU, SUB, SUBU, AND, OR, XOR, NOR, SLT, SLTU, SLL, SLLV, SRL, SRLV, SRA, SRAV, JR``
>*  ``I-Type: ADDI, ADDIU, ANDI, ORI, XORI, LW, SW, BEQ, BNE, SLTI, SLTIU, LUI``
>*  ``J-Type: J, JAL``

MIPS Instruction specifications:
[MIPS32 Architecture for programmers(English, PDF Format)](http://mips246.tongji.edu.cn/file/reference/MIPS32%E6%8C%87%E4%BB%A4%E9%9B%86.pdf)

Reference book:
[《计算机原理与设计——Verilog HDL版》(Chinese, PDF Format)](http://mips246.tongji.edu.cn/file/reference/%E8%AE%A1%E7%AE%97%E6%9C%BA%E5%8E%9F%E7%90%86%E4%B8%8E%E8%AE%BE%E8%AE%A1%E2%80%94%E2%80%94%20Verilog%20HDL%E7%89%88.pdf)
