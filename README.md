MipsCPU
=======

A single cycle CPU running on Xilinx Spartan 6 XC6LX16-CS324(FPGA), supporting 31 MIPS instructions.

>*  31 MIPS instructions.
>*  Single Cycle, without interruptions and exceptions(maybe add these features later).

Instructions:
>*  R-Type: ``ADD, ADDU, SUB, SUBU, AND, OR, XOR, NOR, SLT, SLTU, SLL, SLLV, SRL, SRLV, SRA, SRAV, JR``
>*  I-Type: ``ADDI, ADDIU, ANDI, ORI, XORI, LW, SW, BEQ, BNE, SLTI, SLTIU, LUI``
>*  J-Type: ``J, JAL``
