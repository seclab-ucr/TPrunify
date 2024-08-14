; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 -mattr=+m | FileCheck %s --check-prefix=RV32I
; RUN: llc < %s -mtriple=riscv64 -mattr=+m | FileCheck %s --check-prefix=RV64I
; RUN: llc < %s -mtriple=riscv32 -mattr=+m,+zbb | FileCheck %s --check-prefixes=RV32IZbb,RV32IZbbNOZbt
; RUN: llc < %s -mtriple=riscv64 -mattr=+m,+zbb | FileCheck %s --check-prefixes=RV64IZbb,RV64IZbbNOZbt
; RUN: llc < %s -mtriple=riscv32 -mattr=+m,+zbb,+experimental-zbt | FileCheck %s --check-prefixes=RV32IZbb,RV32IZbbZbt
; RUN: llc < %s -mtriple=riscv64 -mattr=+m,+zbb,+experimental-zbt | FileCheck %s --check-prefixes=RV64IZbb,RV64IZbbZbt

declare i4 @llvm.sadd.sat.i4(i4, i4)
declare i8 @llvm.sadd.sat.i8(i8, i8)
declare i16 @llvm.sadd.sat.i16(i16, i16)
declare i32 @llvm.sadd.sat.i32(i32, i32)
declare i64 @llvm.sadd.sat.i64(i64, i64)

define signext i32 @func(i32 signext %x, i32 signext %y) nounwind {
; RV32I-LABEL: func:
; RV32I:       # %bb.0:
; RV32I-NEXT:    mv a2, a0
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    slt a2, a0, a2
; RV32I-NEXT:    slti a1, a1, 0
; RV32I-NEXT:    beq a1, a2, .LBB0_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    srai a0, a0, 31
; RV32I-NEXT:    lui a1, 524288
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:  .LBB0_2:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: func:
; RV64I:       # %bb.0:
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    lui a1, 524288
; RV64I-NEXT:    addiw a2, a1, -1
; RV64I-NEXT:    bge a0, a2, .LBB0_3
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    bge a1, a0, .LBB0_4
; RV64I-NEXT:  .LBB0_2:
; RV64I-NEXT:    ret
; RV64I-NEXT:  .LBB0_3:
; RV64I-NEXT:    mv a0, a2
; RV64I-NEXT:    blt a1, a0, .LBB0_2
; RV64I-NEXT:  .LBB0_4:
; RV64I-NEXT:    lui a0, 524288
; RV64I-NEXT:    ret
;
; RV32IZbbNOZbt-LABEL: func:
; RV32IZbbNOZbt:       # %bb.0:
; RV32IZbbNOZbt-NEXT:    mv a2, a0
; RV32IZbbNOZbt-NEXT:    add a0, a0, a1
; RV32IZbbNOZbt-NEXT:    slt a2, a0, a2
; RV32IZbbNOZbt-NEXT:    slti a1, a1, 0
; RV32IZbbNOZbt-NEXT:    beq a1, a2, .LBB0_2
; RV32IZbbNOZbt-NEXT:  # %bb.1:
; RV32IZbbNOZbt-NEXT:    srai a0, a0, 31
; RV32IZbbNOZbt-NEXT:    lui a1, 524288
; RV32IZbbNOZbt-NEXT:    xor a0, a0, a1
; RV32IZbbNOZbt-NEXT:  .LBB0_2:
; RV32IZbbNOZbt-NEXT:    ret
;
; RV64IZbb-LABEL: func:
; RV64IZbb:       # %bb.0:
; RV64IZbb-NEXT:    add a0, a0, a1
; RV64IZbb-NEXT:    lui a1, 524288
; RV64IZbb-NEXT:    addiw a2, a1, -1
; RV64IZbb-NEXT:    min a0, a0, a2
; RV64IZbb-NEXT:    max a0, a0, a1
; RV64IZbb-NEXT:    ret
;
; RV32IZbbZbt-LABEL: func:
; RV32IZbbZbt:       # %bb.0:
; RV32IZbbZbt-NEXT:    add a2, a0, a1
; RV32IZbbZbt-NEXT:    slt a0, a2, a0
; RV32IZbbZbt-NEXT:    slti a1, a1, 0
; RV32IZbbZbt-NEXT:    xor a0, a1, a0
; RV32IZbbZbt-NEXT:    srai a1, a2, 31
; RV32IZbbZbt-NEXT:    lui a3, 524288
; RV32IZbbZbt-NEXT:    xor a1, a1, a3
; RV32IZbbZbt-NEXT:    cmov a0, a0, a1, a2
; RV32IZbbZbt-NEXT:    ret
  %tmp = call i32 @llvm.sadd.sat.i32(i32 %x, i32 %y);
  ret i32 %tmp;
}

define i64 @func2(i64 %x, i64 %y) nounwind {
; RV32I-LABEL: func2:
; RV32I:       # %bb.0:
; RV32I-NEXT:    mv a4, a1
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:    add a5, a4, a3
; RV32I-NEXT:    add a0, a0, a2
; RV32I-NEXT:    sltu a1, a0, a1
; RV32I-NEXT:    add a1, a5, a1
; RV32I-NEXT:    xor a2, a4, a1
; RV32I-NEXT:    xor a3, a4, a3
; RV32I-NEXT:    not a3, a3
; RV32I-NEXT:    and a2, a3, a2
; RV32I-NEXT:    bgez a2, .LBB1_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    srai a0, a1, 31
; RV32I-NEXT:    lui a1, 524288
; RV32I-NEXT:    xor a1, a0, a1
; RV32I-NEXT:  .LBB1_2:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: func2:
; RV64I:       # %bb.0:
; RV64I-NEXT:    mv a2, a0
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    slt a2, a0, a2
; RV64I-NEXT:    slti a1, a1, 0
; RV64I-NEXT:    beq a1, a2, .LBB1_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    srai a0, a0, 63
; RV64I-NEXT:    li a1, -1
; RV64I-NEXT:    slli a1, a1, 63
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:  .LBB1_2:
; RV64I-NEXT:    ret
;
; RV32IZbbNOZbt-LABEL: func2:
; RV32IZbbNOZbt:       # %bb.0:
; RV32IZbbNOZbt-NEXT:    mv a4, a1
; RV32IZbbNOZbt-NEXT:    mv a1, a0
; RV32IZbbNOZbt-NEXT:    add a5, a4, a3
; RV32IZbbNOZbt-NEXT:    add a0, a0, a2
; RV32IZbbNOZbt-NEXT:    sltu a1, a0, a1
; RV32IZbbNOZbt-NEXT:    add a1, a5, a1
; RV32IZbbNOZbt-NEXT:    xor a2, a4, a1
; RV32IZbbNOZbt-NEXT:    xor a3, a4, a3
; RV32IZbbNOZbt-NEXT:    andn a2, a2, a3
; RV32IZbbNOZbt-NEXT:    bgez a2, .LBB1_2
; RV32IZbbNOZbt-NEXT:  # %bb.1:
; RV32IZbbNOZbt-NEXT:    srai a0, a1, 31
; RV32IZbbNOZbt-NEXT:    lui a1, 524288
; RV32IZbbNOZbt-NEXT:    xor a1, a0, a1
; RV32IZbbNOZbt-NEXT:  .LBB1_2:
; RV32IZbbNOZbt-NEXT:    ret
;
; RV64IZbbNOZbt-LABEL: func2:
; RV64IZbbNOZbt:       # %bb.0:
; RV64IZbbNOZbt-NEXT:    mv a2, a0
; RV64IZbbNOZbt-NEXT:    add a0, a0, a1
; RV64IZbbNOZbt-NEXT:    slt a2, a0, a2
; RV64IZbbNOZbt-NEXT:    slti a1, a1, 0
; RV64IZbbNOZbt-NEXT:    beq a1, a2, .LBB1_2
; RV64IZbbNOZbt-NEXT:  # %bb.1:
; RV64IZbbNOZbt-NEXT:    srai a0, a0, 63
; RV64IZbbNOZbt-NEXT:    li a1, -1
; RV64IZbbNOZbt-NEXT:    slli a1, a1, 63
; RV64IZbbNOZbt-NEXT:    xor a0, a0, a1
; RV64IZbbNOZbt-NEXT:  .LBB1_2:
; RV64IZbbNOZbt-NEXT:    ret
;
; RV32IZbbZbt-LABEL: func2:
; RV32IZbbZbt:       # %bb.0:
; RV32IZbbZbt-NEXT:    add a4, a1, a3
; RV32IZbbZbt-NEXT:    add a2, a0, a2
; RV32IZbbZbt-NEXT:    sltu a0, a2, a0
; RV32IZbbZbt-NEXT:    add a0, a4, a0
; RV32IZbbZbt-NEXT:    srai a4, a0, 31
; RV32IZbbZbt-NEXT:    lui a5, 524288
; RV32IZbbZbt-NEXT:    xor a5, a4, a5
; RV32IZbbZbt-NEXT:    xor a6, a1, a0
; RV32IZbbZbt-NEXT:    xor a1, a1, a3
; RV32IZbbZbt-NEXT:    andn a1, a6, a1
; RV32IZbbZbt-NEXT:    slti a3, a1, 0
; RV32IZbbZbt-NEXT:    cmov a1, a3, a5, a0
; RV32IZbbZbt-NEXT:    cmov a0, a3, a4, a2
; RV32IZbbZbt-NEXT:    ret
;
; RV64IZbbZbt-LABEL: func2:
; RV64IZbbZbt:       # %bb.0:
; RV64IZbbZbt-NEXT:    add a2, a0, a1
; RV64IZbbZbt-NEXT:    slt a0, a2, a0
; RV64IZbbZbt-NEXT:    slti a1, a1, 0
; RV64IZbbZbt-NEXT:    xor a0, a1, a0
; RV64IZbbZbt-NEXT:    srai a1, a2, 63
; RV64IZbbZbt-NEXT:    li a3, -1
; RV64IZbbZbt-NEXT:    slli a3, a3, 63
; RV64IZbbZbt-NEXT:    xor a1, a1, a3
; RV64IZbbZbt-NEXT:    cmov a0, a0, a1, a2
; RV64IZbbZbt-NEXT:    ret
  %tmp = call i64 @llvm.sadd.sat.i64(i64 %x, i64 %y);
  ret i64 %tmp;
}

define signext i16 @func16(i16 signext %x, i16 signext %y) nounwind {
; RV32I-LABEL: func16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 8
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    bge a0, a1, .LBB2_3
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    lui a1, 1048568
; RV32I-NEXT:    bge a1, a0, .LBB2_4
; RV32I-NEXT:  .LBB2_2:
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB2_3:
; RV32I-NEXT:    mv a0, a1
; RV32I-NEXT:    lui a1, 1048568
; RV32I-NEXT:    blt a1, a0, .LBB2_2
; RV32I-NEXT:  .LBB2_4:
; RV32I-NEXT:    lui a0, 1048568
; RV32I-NEXT:    ret
;
; RV64I-LABEL: func16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    lui a1, 8
; RV64I-NEXT:    addiw a1, a1, -1
; RV64I-NEXT:    bge a0, a1, .LBB2_3
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    lui a1, 1048568
; RV64I-NEXT:    bge a1, a0, .LBB2_4
; RV64I-NEXT:  .LBB2_2:
; RV64I-NEXT:    ret
; RV64I-NEXT:  .LBB2_3:
; RV64I-NEXT:    mv a0, a1
; RV64I-NEXT:    lui a1, 1048568
; RV64I-NEXT:    blt a1, a0, .LBB2_2
; RV64I-NEXT:  .LBB2_4:
; RV64I-NEXT:    lui a0, 1048568
; RV64I-NEXT:    ret
;
; RV32IZbb-LABEL: func16:
; RV32IZbb:       # %bb.0:
; RV32IZbb-NEXT:    add a0, a0, a1
; RV32IZbb-NEXT:    lui a1, 8
; RV32IZbb-NEXT:    addi a1, a1, -1
; RV32IZbb-NEXT:    min a0, a0, a1
; RV32IZbb-NEXT:    lui a1, 1048568
; RV32IZbb-NEXT:    max a0, a0, a1
; RV32IZbb-NEXT:    ret
;
; RV64IZbb-LABEL: func16:
; RV64IZbb:       # %bb.0:
; RV64IZbb-NEXT:    add a0, a0, a1
; RV64IZbb-NEXT:    lui a1, 8
; RV64IZbb-NEXT:    addiw a1, a1, -1
; RV64IZbb-NEXT:    min a0, a0, a1
; RV64IZbb-NEXT:    lui a1, 1048568
; RV64IZbb-NEXT:    max a0, a0, a1
; RV64IZbb-NEXT:    ret
  %tmp = call i16 @llvm.sadd.sat.i16(i16 %x, i16 %y);
  ret i16 %tmp;
}

define signext i8 @func8(i8 signext %x, i8 signext %y) nounwind {
; RV32I-LABEL: func8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    li a1, 127
; RV32I-NEXT:    bge a0, a1, .LBB3_3
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    li a1, -128
; RV32I-NEXT:    bge a1, a0, .LBB3_4
; RV32I-NEXT:  .LBB3_2:
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB3_3:
; RV32I-NEXT:    li a0, 127
; RV32I-NEXT:    li a1, -128
; RV32I-NEXT:    blt a1, a0, .LBB3_2
; RV32I-NEXT:  .LBB3_4:
; RV32I-NEXT:    li a0, -128
; RV32I-NEXT:    ret
;
; RV64I-LABEL: func8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    li a1, 127
; RV64I-NEXT:    bge a0, a1, .LBB3_3
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    li a1, -128
; RV64I-NEXT:    bge a1, a0, .LBB3_4
; RV64I-NEXT:  .LBB3_2:
; RV64I-NEXT:    ret
; RV64I-NEXT:  .LBB3_3:
; RV64I-NEXT:    li a0, 127
; RV64I-NEXT:    li a1, -128
; RV64I-NEXT:    blt a1, a0, .LBB3_2
; RV64I-NEXT:  .LBB3_4:
; RV64I-NEXT:    li a0, -128
; RV64I-NEXT:    ret
;
; RV32IZbb-LABEL: func8:
; RV32IZbb:       # %bb.0:
; RV32IZbb-NEXT:    add a0, a0, a1
; RV32IZbb-NEXT:    li a1, 127
; RV32IZbb-NEXT:    min a0, a0, a1
; RV32IZbb-NEXT:    li a1, -128
; RV32IZbb-NEXT:    max a0, a0, a1
; RV32IZbb-NEXT:    ret
;
; RV64IZbb-LABEL: func8:
; RV64IZbb:       # %bb.0:
; RV64IZbb-NEXT:    add a0, a0, a1
; RV64IZbb-NEXT:    li a1, 127
; RV64IZbb-NEXT:    min a0, a0, a1
; RV64IZbb-NEXT:    li a1, -128
; RV64IZbb-NEXT:    max a0, a0, a1
; RV64IZbb-NEXT:    ret
  %tmp = call i8 @llvm.sadd.sat.i8(i8 %x, i8 %y);
  ret i8 %tmp;
}

define signext i4 @func3(i4 signext %x, i4 signext %y) nounwind {
; RV32I-LABEL: func3:
; RV32I:       # %bb.0:
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    li a1, 7
; RV32I-NEXT:    bge a0, a1, .LBB4_3
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    li a1, -8
; RV32I-NEXT:    bge a1, a0, .LBB4_4
; RV32I-NEXT:  .LBB4_2:
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB4_3:
; RV32I-NEXT:    li a0, 7
; RV32I-NEXT:    li a1, -8
; RV32I-NEXT:    blt a1, a0, .LBB4_2
; RV32I-NEXT:  .LBB4_4:
; RV32I-NEXT:    li a0, -8
; RV32I-NEXT:    ret
;
; RV64I-LABEL: func3:
; RV64I:       # %bb.0:
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    li a1, 7
; RV64I-NEXT:    bge a0, a1, .LBB4_3
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    li a1, -8
; RV64I-NEXT:    bge a1, a0, .LBB4_4
; RV64I-NEXT:  .LBB4_2:
; RV64I-NEXT:    ret
; RV64I-NEXT:  .LBB4_3:
; RV64I-NEXT:    li a0, 7
; RV64I-NEXT:    li a1, -8
; RV64I-NEXT:    blt a1, a0, .LBB4_2
; RV64I-NEXT:  .LBB4_4:
; RV64I-NEXT:    li a0, -8
; RV64I-NEXT:    ret
;
; RV32IZbb-LABEL: func3:
; RV32IZbb:       # %bb.0:
; RV32IZbb-NEXT:    add a0, a0, a1
; RV32IZbb-NEXT:    li a1, 7
; RV32IZbb-NEXT:    min a0, a0, a1
; RV32IZbb-NEXT:    li a1, -8
; RV32IZbb-NEXT:    max a0, a0, a1
; RV32IZbb-NEXT:    ret
;
; RV64IZbb-LABEL: func3:
; RV64IZbb:       # %bb.0:
; RV64IZbb-NEXT:    add a0, a0, a1
; RV64IZbb-NEXT:    li a1, 7
; RV64IZbb-NEXT:    min a0, a0, a1
; RV64IZbb-NEXT:    li a1, -8
; RV64IZbb-NEXT:    max a0, a0, a1
; RV64IZbb-NEXT:    ret
  %tmp = call i4 @llvm.sadd.sat.i4(i4 %x, i4 %y);
  ret i4 %tmp;
}
