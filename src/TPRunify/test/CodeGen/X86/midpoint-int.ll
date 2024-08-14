; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=i686-unknown-unknown | FileCheck %s --check-prefix=X86

; These test cases are inspired by C++2a std::midpoint().
; See https://bugs.llvm.org/show_bug.cgi?id=40965

; ---------------------------------------------------------------------------- ;
; 32-bit width
; ---------------------------------------------------------------------------- ;

; Values come from regs

define i32 @scalar_i32_signed_reg_reg(i32 %a1, i32 %a2) nounwind {
; X64-LABEL: scalar_i32_signed_reg_reg:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl %esi, %edi
; X64-NEXT:    setle %al
; X64-NEXT:    leal -1(%rax,%rax), %eax
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    cmovgl %esi, %ecx
; X64-NEXT:    cmovgl %edi, %esi
; X64-NEXT:    subl %ecx, %esi
; X64-NEXT:    shrl %esi
; X64-NEXT:    imull %esi, %eax
; X64-NEXT:    addl %edi, %eax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i32_signed_reg_reg:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    cmpl %eax, %ecx
; X86-NEXT:    setle %dl
; X86-NEXT:    leal -1(%edx,%edx), %edx
; X86-NEXT:    jg .LBB0_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    jmp .LBB0_3
; X86-NEXT:  .LBB0_1:
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB0_3:
; X86-NEXT:    subl %esi, %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    imull %edx, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %t3 = icmp sgt i32 %a1, %a2 ; signed
  %t4 = select i1 %t3, i32 -1, i32 1
  %t5 = select i1 %t3, i32 %a2, i32 %a1
  %t6 = select i1 %t3, i32 %a1, i32 %a2
  %t7 = sub i32 %t6, %t5
  %t8 = lshr i32 %t7, 1
  %t9 = mul nsw i32 %t8, %t4 ; signed
  %a10 = add nsw i32 %t9, %a1 ; signed
  ret i32 %a10
}

define i32 @scalar_i32_unsigned_reg_reg(i32 %a1, i32 %a2) nounwind {
; X64-LABEL: scalar_i32_unsigned_reg_reg:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl %esi, %edi
; X64-NEXT:    setbe %al
; X64-NEXT:    leal -1(%rax,%rax), %eax
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    cmoval %esi, %ecx
; X64-NEXT:    cmoval %edi, %esi
; X64-NEXT:    subl %ecx, %esi
; X64-NEXT:    shrl %esi
; X64-NEXT:    imull %esi, %eax
; X64-NEXT:    addl %edi, %eax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i32_unsigned_reg_reg:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    cmpl %eax, %ecx
; X86-NEXT:    setbe %dl
; X86-NEXT:    leal -1(%edx,%edx), %edx
; X86-NEXT:    ja .LBB1_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    jmp .LBB1_3
; X86-NEXT:  .LBB1_1:
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB1_3:
; X86-NEXT:    subl %esi, %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    imull %edx, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %t3 = icmp ugt i32 %a1, %a2
  %t4 = select i1 %t3, i32 -1, i32 1
  %t5 = select i1 %t3, i32 %a2, i32 %a1
  %t6 = select i1 %t3, i32 %a1, i32 %a2
  %t7 = sub i32 %t6, %t5
  %t8 = lshr i32 %t7, 1
  %t9 = mul i32 %t8, %t4
  %a10 = add i32 %t9, %a1
  ret i32 %a10
}

; Values are loaded. Only check signed case.

define i32 @scalar_i32_signed_mem_reg(i32* %a1_addr, i32 %a2) nounwind {
; X64-LABEL: scalar_i32_signed_mem_reg:
; X64:       # %bb.0:
; X64-NEXT:    movl (%rdi), %ecx
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl %esi, %ecx
; X64-NEXT:    setle %al
; X64-NEXT:    leal -1(%rax,%rax), %eax
; X64-NEXT:    movl %ecx, %edx
; X64-NEXT:    cmovgl %esi, %edx
; X64-NEXT:    cmovgl %ecx, %esi
; X64-NEXT:    subl %edx, %esi
; X64-NEXT:    shrl %esi
; X64-NEXT:    imull %esi, %eax
; X64-NEXT:    addl %ecx, %eax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i32_signed_mem_reg:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl (%ecx), %ecx
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    cmpl %eax, %ecx
; X86-NEXT:    setle %dl
; X86-NEXT:    leal -1(%edx,%edx), %edx
; X86-NEXT:    jg .LBB2_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    jmp .LBB2_3
; X86-NEXT:  .LBB2_1:
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB2_3:
; X86-NEXT:    subl %esi, %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    imull %edx, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %a1 = load i32, i32* %a1_addr
  %t3 = icmp sgt i32 %a1, %a2 ; signed
  %t4 = select i1 %t3, i32 -1, i32 1
  %t5 = select i1 %t3, i32 %a2, i32 %a1
  %t6 = select i1 %t3, i32 %a1, i32 %a2
  %t7 = sub i32 %t6, %t5
  %t8 = lshr i32 %t7, 1
  %t9 = mul nsw i32 %t8, %t4 ; signed
  %a10 = add nsw i32 %t9, %a1 ; signed
  ret i32 %a10
}

define i32 @scalar_i32_signed_reg_mem(i32 %a1, i32* %a2_addr) nounwind {
; X64-LABEL: scalar_i32_signed_reg_mem:
; X64:       # %bb.0:
; X64-NEXT:    movl (%rsi), %eax
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    cmpl %eax, %edi
; X64-NEXT:    setle %cl
; X64-NEXT:    leal -1(%rcx,%rcx), %ecx
; X64-NEXT:    movl %edi, %edx
; X64-NEXT:    cmovgl %eax, %edx
; X64-NEXT:    cmovgl %edi, %eax
; X64-NEXT:    subl %edx, %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    imull %ecx, %eax
; X64-NEXT:    addl %edi, %eax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i32_signed_reg_mem:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl (%eax), %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    cmpl %eax, %ecx
; X86-NEXT:    setle %dl
; X86-NEXT:    leal -1(%edx,%edx), %edx
; X86-NEXT:    jg .LBB3_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    jmp .LBB3_3
; X86-NEXT:  .LBB3_1:
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB3_3:
; X86-NEXT:    subl %esi, %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    imull %edx, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %a2 = load i32, i32* %a2_addr
  %t3 = icmp sgt i32 %a1, %a2 ; signed
  %t4 = select i1 %t3, i32 -1, i32 1
  %t5 = select i1 %t3, i32 %a2, i32 %a1
  %t6 = select i1 %t3, i32 %a1, i32 %a2
  %t7 = sub i32 %t6, %t5
  %t8 = lshr i32 %t7, 1
  %t9 = mul nsw i32 %t8, %t4 ; signed
  %a10 = add nsw i32 %t9, %a1 ; signed
  ret i32 %a10
}

define i32 @scalar_i32_signed_mem_mem(i32* %a1_addr, i32* %a2_addr) nounwind {
; X64-LABEL: scalar_i32_signed_mem_mem:
; X64:       # %bb.0:
; X64-NEXT:    movl (%rdi), %ecx
; X64-NEXT:    movl (%rsi), %eax
; X64-NEXT:    xorl %edx, %edx
; X64-NEXT:    cmpl %eax, %ecx
; X64-NEXT:    setle %dl
; X64-NEXT:    leal -1(%rdx,%rdx), %edx
; X64-NEXT:    movl %ecx, %esi
; X64-NEXT:    cmovgl %eax, %esi
; X64-NEXT:    cmovgl %ecx, %eax
; X64-NEXT:    subl %esi, %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    imull %edx, %eax
; X64-NEXT:    addl %ecx, %eax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i32_signed_mem_mem:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl (%ecx), %ecx
; X86-NEXT:    movl (%eax), %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    cmpl %eax, %ecx
; X86-NEXT:    setle %dl
; X86-NEXT:    leal -1(%edx,%edx), %edx
; X86-NEXT:    jg .LBB4_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    jmp .LBB4_3
; X86-NEXT:  .LBB4_1:
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB4_3:
; X86-NEXT:    subl %esi, %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    imull %edx, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %a1 = load i32, i32* %a1_addr
  %a2 = load i32, i32* %a2_addr
  %t3 = icmp sgt i32 %a1, %a2 ; signed
  %t4 = select i1 %t3, i32 -1, i32 1
  %t5 = select i1 %t3, i32 %a2, i32 %a1
  %t6 = select i1 %t3, i32 %a1, i32 %a2
  %t7 = sub i32 %t6, %t5
  %t8 = lshr i32 %t7, 1
  %t9 = mul nsw i32 %t8, %t4 ; signed
  %a10 = add nsw i32 %t9, %a1 ; signed
  ret i32 %a10
}

; ---------------------------------------------------------------------------- ;
; 64-bit width
; ---------------------------------------------------------------------------- ;

; Values come from regs

define i64 @scalar_i64_signed_reg_reg(i64 %a1, i64 %a2) nounwind {
; X64-LABEL: scalar_i64_signed_reg_reg:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpq %rsi, %rdi
; X64-NEXT:    setle %al
; X64-NEXT:    leaq -1(%rax,%rax), %rax
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    cmovgq %rsi, %rcx
; X64-NEXT:    cmovgq %rdi, %rsi
; X64-NEXT:    subq %rcx, %rsi
; X64-NEXT:    shrq %rsi
; X64-NEXT:    imulq %rsi, %rax
; X64-NEXT:    addq %rdi, %rax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i64_signed_reg_reg:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    cmpl %ecx, %eax
; X86-NEXT:    movl %edi, %edx
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl $-1, %ebx
; X86-NEXT:    jl .LBB5_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    xorl %ebp, %ebp
; X86-NEXT:    movl $1, %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    jmp .LBB5_3
; X86-NEXT:  .LBB5_1:
; X86-NEXT:    movl $-1, %ebp
; X86-NEXT:    movl %edi, %edx
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB5_3:
; X86-NEXT:    subl %esi, %eax
; X86-NEXT:    sbbl %edx, %edi
; X86-NEXT:    shrdl $1, %edi, %eax
; X86-NEXT:    imull %eax, %ebp
; X86-NEXT:    mull %ebx
; X86-NEXT:    addl %ebp, %edx
; X86-NEXT:    shrl %edi
; X86-NEXT:    imull %ebx, %edi
; X86-NEXT:    addl %edi, %edx
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
  %t3 = icmp sgt i64 %a1, %a2 ; signed
  %t4 = select i1 %t3, i64 -1, i64 1
  %t5 = select i1 %t3, i64 %a2, i64 %a1
  %t6 = select i1 %t3, i64 %a1, i64 %a2
  %t7 = sub i64 %t6, %t5
  %t8 = lshr i64 %t7, 1
  %t9 = mul nsw i64 %t8, %t4 ; signed
  %a10 = add nsw i64 %t9, %a1 ; signed
  ret i64 %a10
}

define i64 @scalar_i64_unsigned_reg_reg(i64 %a1, i64 %a2) nounwind {
; X64-LABEL: scalar_i64_unsigned_reg_reg:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpq %rsi, %rdi
; X64-NEXT:    setbe %al
; X64-NEXT:    leaq -1(%rax,%rax), %rax
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    cmovaq %rsi, %rcx
; X64-NEXT:    cmovaq %rdi, %rsi
; X64-NEXT:    subq %rcx, %rsi
; X64-NEXT:    shrq %rsi
; X64-NEXT:    imulq %rsi, %rax
; X64-NEXT:    addq %rdi, %rax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i64_unsigned_reg_reg:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    cmpl %ecx, %eax
; X86-NEXT:    movl %edi, %edx
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl $-1, %ebx
; X86-NEXT:    jb .LBB6_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    xorl %ebp, %ebp
; X86-NEXT:    movl $1, %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    jmp .LBB6_3
; X86-NEXT:  .LBB6_1:
; X86-NEXT:    movl $-1, %ebp
; X86-NEXT:    movl %edi, %edx
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB6_3:
; X86-NEXT:    subl %esi, %eax
; X86-NEXT:    sbbl %edx, %edi
; X86-NEXT:    shrdl $1, %edi, %eax
; X86-NEXT:    imull %eax, %ebp
; X86-NEXT:    mull %ebx
; X86-NEXT:    addl %ebp, %edx
; X86-NEXT:    shrl %edi
; X86-NEXT:    imull %ebx, %edi
; X86-NEXT:    addl %edi, %edx
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
  %t3 = icmp ugt i64 %a1, %a2
  %t4 = select i1 %t3, i64 -1, i64 1
  %t5 = select i1 %t3, i64 %a2, i64 %a1
  %t6 = select i1 %t3, i64 %a1, i64 %a2
  %t7 = sub i64 %t6, %t5
  %t8 = lshr i64 %t7, 1
  %t9 = mul i64 %t8, %t4
  %a10 = add i64 %t9, %a1
  ret i64 %a10
}

; Values are loaded. Only check signed case.

define i64 @scalar_i64_signed_mem_reg(i64* %a1_addr, i64 %a2) nounwind {
; X64-LABEL: scalar_i64_signed_mem_reg:
; X64:       # %bb.0:
; X64-NEXT:    movq (%rdi), %rcx
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpq %rsi, %rcx
; X64-NEXT:    setle %al
; X64-NEXT:    leaq -1(%rax,%rax), %rax
; X64-NEXT:    movq %rcx, %rdx
; X64-NEXT:    cmovgq %rsi, %rdx
; X64-NEXT:    cmovgq %rcx, %rsi
; X64-NEXT:    subq %rdx, %rsi
; X64-NEXT:    shrq %rsi
; X64-NEXT:    imulq %rsi, %rax
; X64-NEXT:    addq %rcx, %rax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i64_signed_mem_reg:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    pushl %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl (%ecx), %esi
; X86-NEXT:    movl 4(%ecx), %ecx
; X86-NEXT:    cmpl %esi, %eax
; X86-NEXT:    movl %edi, %edx
; X86-NEXT:    sbbl %ecx, %edx
; X86-NEXT:    movl $-1, %ebx
; X86-NEXT:    jl .LBB7_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    xorl %ebp, %ebp
; X86-NEXT:    movl $1, %ebx
; X86-NEXT:    movl %ecx, (%esp) # 4-byte Spill
; X86-NEXT:    movl %esi, %edx
; X86-NEXT:    jmp .LBB7_3
; X86-NEXT:  .LBB7_1:
; X86-NEXT:    movl $-1, %ebp
; X86-NEXT:    movl %edi, (%esp) # 4-byte Spill
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    movl %ecx, %edi
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:  .LBB7_3:
; X86-NEXT:    subl %edx, %eax
; X86-NEXT:    sbbl (%esp), %edi # 4-byte Folded Reload
; X86-NEXT:    shrdl $1, %edi, %eax
; X86-NEXT:    imull %eax, %ebp
; X86-NEXT:    mull %ebx
; X86-NEXT:    addl %ebp, %edx
; X86-NEXT:    shrl %edi
; X86-NEXT:    imull %ebx, %edi
; X86-NEXT:    addl %edi, %edx
; X86-NEXT:    addl %esi, %eax
; X86-NEXT:    adcl %ecx, %edx
; X86-NEXT:    addl $4, %esp
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
  %a1 = load i64, i64* %a1_addr
  %t3 = icmp sgt i64 %a1, %a2 ; signed
  %t4 = select i1 %t3, i64 -1, i64 1
  %t5 = select i1 %t3, i64 %a2, i64 %a1
  %t6 = select i1 %t3, i64 %a1, i64 %a2
  %t7 = sub i64 %t6, %t5
  %t8 = lshr i64 %t7, 1
  %t9 = mul nsw i64 %t8, %t4 ; signed
  %a10 = add nsw i64 %t9, %a1 ; signed
  ret i64 %a10
}

define i64 @scalar_i64_signed_reg_mem(i64 %a1, i64* %a2_addr) nounwind {
; X64-LABEL: scalar_i64_signed_reg_mem:
; X64:       # %bb.0:
; X64-NEXT:    movq (%rsi), %rax
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    cmpq %rax, %rdi
; X64-NEXT:    setle %cl
; X64-NEXT:    leaq -1(%rcx,%rcx), %rcx
; X64-NEXT:    movq %rdi, %rdx
; X64-NEXT:    cmovgq %rax, %rdx
; X64-NEXT:    cmovgq %rdi, %rax
; X64-NEXT:    subq %rdx, %rax
; X64-NEXT:    shrq %rax
; X64-NEXT:    imulq %rcx, %rax
; X64-NEXT:    addq %rdi, %rax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i64_signed_reg_mem:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl (%edx), %eax
; X86-NEXT:    movl 4(%edx), %edi
; X86-NEXT:    cmpl %ecx, %eax
; X86-NEXT:    movl %edi, %edx
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl $-1, %ebx
; X86-NEXT:    jl .LBB8_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    xorl %ebp, %ebp
; X86-NEXT:    movl $1, %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    jmp .LBB8_3
; X86-NEXT:  .LBB8_1:
; X86-NEXT:    movl $-1, %ebp
; X86-NEXT:    movl %edi, %edx
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB8_3:
; X86-NEXT:    subl %esi, %eax
; X86-NEXT:    sbbl %edx, %edi
; X86-NEXT:    shrdl $1, %edi, %eax
; X86-NEXT:    imull %eax, %ebp
; X86-NEXT:    mull %ebx
; X86-NEXT:    addl %ebp, %edx
; X86-NEXT:    shrl %edi
; X86-NEXT:    imull %ebx, %edi
; X86-NEXT:    addl %edi, %edx
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
  %a2 = load i64, i64* %a2_addr
  %t3 = icmp sgt i64 %a1, %a2 ; signed
  %t4 = select i1 %t3, i64 -1, i64 1
  %t5 = select i1 %t3, i64 %a2, i64 %a1
  %t6 = select i1 %t3, i64 %a1, i64 %a2
  %t7 = sub i64 %t6, %t5
  %t8 = lshr i64 %t7, 1
  %t9 = mul nsw i64 %t8, %t4 ; signed
  %a10 = add nsw i64 %t9, %a1 ; signed
  ret i64 %a10
}

define i64 @scalar_i64_signed_mem_mem(i64* %a1_addr, i64* %a2_addr) nounwind {
; X64-LABEL: scalar_i64_signed_mem_mem:
; X64:       # %bb.0:
; X64-NEXT:    movq (%rdi), %rcx
; X64-NEXT:    movq (%rsi), %rax
; X64-NEXT:    xorl %edx, %edx
; X64-NEXT:    cmpq %rax, %rcx
; X64-NEXT:    setle %dl
; X64-NEXT:    leaq -1(%rdx,%rdx), %rdx
; X64-NEXT:    movq %rcx, %rsi
; X64-NEXT:    cmovgq %rax, %rsi
; X64-NEXT:    cmovgq %rcx, %rax
; X64-NEXT:    subq %rsi, %rax
; X64-NEXT:    shrq %rax
; X64-NEXT:    imulq %rdx, %rax
; X64-NEXT:    addq %rcx, %rax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i64_signed_mem_mem:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    pushl %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl (%eax), %esi
; X86-NEXT:    movl 4(%eax), %ecx
; X86-NEXT:    movl (%edx), %eax
; X86-NEXT:    movl 4(%edx), %edi
; X86-NEXT:    cmpl %esi, %eax
; X86-NEXT:    movl %edi, %edx
; X86-NEXT:    sbbl %ecx, %edx
; X86-NEXT:    movl $-1, %ebx
; X86-NEXT:    jl .LBB9_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    xorl %ebp, %ebp
; X86-NEXT:    movl $1, %ebx
; X86-NEXT:    movl %ecx, (%esp) # 4-byte Spill
; X86-NEXT:    movl %esi, %edx
; X86-NEXT:    jmp .LBB9_3
; X86-NEXT:  .LBB9_1:
; X86-NEXT:    movl $-1, %ebp
; X86-NEXT:    movl %edi, (%esp) # 4-byte Spill
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    movl %ecx, %edi
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:  .LBB9_3:
; X86-NEXT:    subl %edx, %eax
; X86-NEXT:    sbbl (%esp), %edi # 4-byte Folded Reload
; X86-NEXT:    shrdl $1, %edi, %eax
; X86-NEXT:    imull %eax, %ebp
; X86-NEXT:    mull %ebx
; X86-NEXT:    addl %ebp, %edx
; X86-NEXT:    shrl %edi
; X86-NEXT:    imull %ebx, %edi
; X86-NEXT:    addl %edi, %edx
; X86-NEXT:    addl %esi, %eax
; X86-NEXT:    adcl %ecx, %edx
; X86-NEXT:    addl $4, %esp
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
  %a1 = load i64, i64* %a1_addr
  %a2 = load i64, i64* %a2_addr
  %t3 = icmp sgt i64 %a1, %a2 ; signed
  %t4 = select i1 %t3, i64 -1, i64 1
  %t5 = select i1 %t3, i64 %a2, i64 %a1
  %t6 = select i1 %t3, i64 %a1, i64 %a2
  %t7 = sub i64 %t6, %t5
  %t8 = lshr i64 %t7, 1
  %t9 = mul nsw i64 %t8, %t4 ; signed
  %a10 = add nsw i64 %t9, %a1 ; signed
  ret i64 %a10
}

; ---------------------------------------------------------------------------- ;
; 16-bit width
; ---------------------------------------------------------------------------- ;

; Values come from regs

define i16 @scalar_i16_signed_reg_reg(i16 %a1, i16 %a2) nounwind {
; X64-LABEL: scalar_i16_signed_reg_reg:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpw %si, %di
; X64-NEXT:    setle %al
; X64-NEXT:    leal -1(%rax,%rax), %ecx
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    cmovgl %esi, %eax
; X64-NEXT:    cmovgl %edi, %esi
; X64-NEXT:    subl %eax, %esi
; X64-NEXT:    movzwl %si, %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    imull %ecx, %eax
; X64-NEXT:    addl %edi, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i16_signed_reg_reg:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    cmpw %ax, %cx
; X86-NEXT:    setle %dl
; X86-NEXT:    leal -1(%edx,%edx), %edx
; X86-NEXT:    jg .LBB10_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    jmp .LBB10_3
; X86-NEXT:  .LBB10_1:
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB10_3:
; X86-NEXT:    subl %esi, %eax
; X86-NEXT:    movzwl %ax, %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    imull %edx, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %t3 = icmp sgt i16 %a1, %a2 ; signed
  %t4 = select i1 %t3, i16 -1, i16 1
  %t5 = select i1 %t3, i16 %a2, i16 %a1
  %t6 = select i1 %t3, i16 %a1, i16 %a2
  %t7 = sub i16 %t6, %t5
  %t8 = lshr i16 %t7, 1
  %t9 = mul nsw i16 %t8, %t4 ; signed
  %a10 = add nsw i16 %t9, %a1 ; signed
  ret i16 %a10
}

define i16 @scalar_i16_unsigned_reg_reg(i16 %a1, i16 %a2) nounwind {
; X64-LABEL: scalar_i16_unsigned_reg_reg:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpw %si, %di
; X64-NEXT:    setbe %al
; X64-NEXT:    leal -1(%rax,%rax), %ecx
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    cmoval %esi, %eax
; X64-NEXT:    cmoval %edi, %esi
; X64-NEXT:    subl %eax, %esi
; X64-NEXT:    movzwl %si, %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    imull %ecx, %eax
; X64-NEXT:    addl %edi, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i16_unsigned_reg_reg:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    cmpw %ax, %cx
; X86-NEXT:    setbe %dl
; X86-NEXT:    leal -1(%edx,%edx), %edx
; X86-NEXT:    ja .LBB11_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    jmp .LBB11_3
; X86-NEXT:  .LBB11_1:
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB11_3:
; X86-NEXT:    subl %esi, %eax
; X86-NEXT:    movzwl %ax, %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    imull %edx, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %t3 = icmp ugt i16 %a1, %a2
  %t4 = select i1 %t3, i16 -1, i16 1
  %t5 = select i1 %t3, i16 %a2, i16 %a1
  %t6 = select i1 %t3, i16 %a1, i16 %a2
  %t7 = sub i16 %t6, %t5
  %t8 = lshr i16 %t7, 1
  %t9 = mul i16 %t8, %t4
  %a10 = add i16 %t9, %a1
  ret i16 %a10
}

; Values are loaded. Only check signed case.

define i16 @scalar_i16_signed_mem_reg(i16* %a1_addr, i16 %a2) nounwind {
; X64-LABEL: scalar_i16_signed_mem_reg:
; X64:       # %bb.0:
; X64-NEXT:    movzwl (%rdi), %ecx
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpw %si, %cx
; X64-NEXT:    setle %al
; X64-NEXT:    leal -1(%rax,%rax), %edx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    cmovgl %esi, %eax
; X64-NEXT:    cmovgl %ecx, %esi
; X64-NEXT:    subl %eax, %esi
; X64-NEXT:    movzwl %si, %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    imull %edx, %eax
; X64-NEXT:    addl %ecx, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i16_signed_mem_reg:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movzwl (%ecx), %ecx
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    cmpw %ax, %cx
; X86-NEXT:    setle %dl
; X86-NEXT:    leal -1(%edx,%edx), %edx
; X86-NEXT:    jg .LBB12_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    jmp .LBB12_3
; X86-NEXT:  .LBB12_1:
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB12_3:
; X86-NEXT:    subl %esi, %eax
; X86-NEXT:    movzwl %ax, %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    imull %edx, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %a1 = load i16, i16* %a1_addr
  %t3 = icmp sgt i16 %a1, %a2 ; signed
  %t4 = select i1 %t3, i16 -1, i16 1
  %t5 = select i1 %t3, i16 %a2, i16 %a1
  %t6 = select i1 %t3, i16 %a1, i16 %a2
  %t7 = sub i16 %t6, %t5
  %t8 = lshr i16 %t7, 1
  %t9 = mul nsw i16 %t8, %t4 ; signed
  %a10 = add nsw i16 %t9, %a1 ; signed
  ret i16 %a10
}

define i16 @scalar_i16_signed_reg_mem(i16 %a1, i16* %a2_addr) nounwind {
; X64-LABEL: scalar_i16_signed_reg_mem:
; X64:       # %bb.0:
; X64-NEXT:    movzwl (%rsi), %eax
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    cmpw %ax, %di
; X64-NEXT:    setle %cl
; X64-NEXT:    leal -1(%rcx,%rcx), %ecx
; X64-NEXT:    movl %edi, %edx
; X64-NEXT:    cmovgl %eax, %edx
; X64-NEXT:    cmovgl %edi, %eax
; X64-NEXT:    subl %edx, %eax
; X64-NEXT:    movzwl %ax, %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    imull %ecx, %eax
; X64-NEXT:    addl %edi, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i16_signed_reg_mem:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movzwl (%eax), %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    cmpw %ax, %cx
; X86-NEXT:    setle %dl
; X86-NEXT:    leal -1(%edx,%edx), %edx
; X86-NEXT:    jg .LBB13_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    jmp .LBB13_3
; X86-NEXT:  .LBB13_1:
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB13_3:
; X86-NEXT:    subl %esi, %eax
; X86-NEXT:    movzwl %ax, %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    imull %edx, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %a2 = load i16, i16* %a2_addr
  %t3 = icmp sgt i16 %a1, %a2 ; signed
  %t4 = select i1 %t3, i16 -1, i16 1
  %t5 = select i1 %t3, i16 %a2, i16 %a1
  %t6 = select i1 %t3, i16 %a1, i16 %a2
  %t7 = sub i16 %t6, %t5
  %t8 = lshr i16 %t7, 1
  %t9 = mul nsw i16 %t8, %t4 ; signed
  %a10 = add nsw i16 %t9, %a1 ; signed
  ret i16 %a10
}

define i16 @scalar_i16_signed_mem_mem(i16* %a1_addr, i16* %a2_addr) nounwind {
; X64-LABEL: scalar_i16_signed_mem_mem:
; X64:       # %bb.0:
; X64-NEXT:    movzwl (%rdi), %ecx
; X64-NEXT:    movzwl (%rsi), %eax
; X64-NEXT:    xorl %edx, %edx
; X64-NEXT:    cmpw %ax, %cx
; X64-NEXT:    setle %dl
; X64-NEXT:    leal -1(%rdx,%rdx), %edx
; X64-NEXT:    movl %ecx, %esi
; X64-NEXT:    cmovgl %eax, %esi
; X64-NEXT:    cmovgl %ecx, %eax
; X64-NEXT:    subl %esi, %eax
; X64-NEXT:    movzwl %ax, %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    imull %edx, %eax
; X64-NEXT:    addl %ecx, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i16_signed_mem_mem:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movzwl (%ecx), %ecx
; X86-NEXT:    movzwl (%eax), %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    cmpw %ax, %cx
; X86-NEXT:    setle %dl
; X86-NEXT:    leal -1(%edx,%edx), %edx
; X86-NEXT:    jg .LBB14_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    jmp .LBB14_3
; X86-NEXT:  .LBB14_1:
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:  .LBB14_3:
; X86-NEXT:    subl %esi, %eax
; X86-NEXT:    movzwl %ax, %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    imull %edx, %eax
; X86-NEXT:    addl %ecx, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %a1 = load i16, i16* %a1_addr
  %a2 = load i16, i16* %a2_addr
  %t3 = icmp sgt i16 %a1, %a2 ; signed
  %t4 = select i1 %t3, i16 -1, i16 1
  %t5 = select i1 %t3, i16 %a2, i16 %a1
  %t6 = select i1 %t3, i16 %a1, i16 %a2
  %t7 = sub i16 %t6, %t5
  %t8 = lshr i16 %t7, 1
  %t9 = mul nsw i16 %t8, %t4 ; signed
  %a10 = add nsw i16 %t9, %a1 ; signed
  ret i16 %a10
}

; ---------------------------------------------------------------------------- ;
; 8-bit width
; ---------------------------------------------------------------------------- ;

; Values come from regs

define i8 @scalar_i8_signed_reg_reg(i8 %a1, i8 %a2) nounwind {
; X64-LABEL: scalar_i8_signed_reg_reg:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    cmpb %al, %dil
; X64-NEXT:    setle %cl
; X64-NEXT:    movl %edi, %edx
; X64-NEXT:    cmovgl %esi, %edx
; X64-NEXT:    cmovgl %edi, %eax
; X64-NEXT:    addb %cl, %cl
; X64-NEXT:    decb %cl
; X64-NEXT:    subb %dl, %al
; X64-NEXT:    shrb %al
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    mulb %cl
; X64-NEXT:    addb %dil, %al
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i8_signed_reg_reg:
; X86:       # %bb.0:
; X86-NEXT:    movb {{[0-9]+}}(%esp), %al
; X86-NEXT:    movb {{[0-9]+}}(%esp), %cl
; X86-NEXT:    cmpb %al, %cl
; X86-NEXT:    setle %dl
; X86-NEXT:    jg .LBB15_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movb %cl, %ah
; X86-NEXT:    jmp .LBB15_3
; X86-NEXT:  .LBB15_1:
; X86-NEXT:    movb %al, %ah
; X86-NEXT:    movb %cl, %al
; X86-NEXT:  .LBB15_3:
; X86-NEXT:    subb %ah, %al
; X86-NEXT:    addb %dl, %dl
; X86-NEXT:    decb %dl
; X86-NEXT:    shrb %al
; X86-NEXT:    mulb %dl
; X86-NEXT:    addb %cl, %al
; X86-NEXT:    retl
  %t3 = icmp sgt i8 %a1, %a2 ; signed
  %t4 = select i1 %t3, i8 -1, i8 1
  %t5 = select i1 %t3, i8 %a2, i8 %a1
  %t6 = select i1 %t3, i8 %a1, i8 %a2
  %t7 = sub i8 %t6, %t5
  %t8 = lshr i8 %t7, 1
  %t9 = mul nsw i8 %t8, %t4 ; signed
  %a10 = add nsw i8 %t9, %a1 ; signed
  ret i8 %a10
}

define i8 @scalar_i8_unsigned_reg_reg(i8 %a1, i8 %a2) nounwind {
; X64-LABEL: scalar_i8_unsigned_reg_reg:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    cmpb %al, %dil
; X64-NEXT:    setbe %cl
; X64-NEXT:    movl %edi, %edx
; X64-NEXT:    cmoval %esi, %edx
; X64-NEXT:    cmoval %edi, %eax
; X64-NEXT:    addb %cl, %cl
; X64-NEXT:    decb %cl
; X64-NEXT:    subb %dl, %al
; X64-NEXT:    shrb %al
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    mulb %cl
; X64-NEXT:    addb %dil, %al
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i8_unsigned_reg_reg:
; X86:       # %bb.0:
; X86-NEXT:    movb {{[0-9]+}}(%esp), %al
; X86-NEXT:    movb {{[0-9]+}}(%esp), %cl
; X86-NEXT:    cmpb %al, %cl
; X86-NEXT:    setbe %dl
; X86-NEXT:    ja .LBB16_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movb %cl, %ah
; X86-NEXT:    jmp .LBB16_3
; X86-NEXT:  .LBB16_1:
; X86-NEXT:    movb %al, %ah
; X86-NEXT:    movb %cl, %al
; X86-NEXT:  .LBB16_3:
; X86-NEXT:    subb %ah, %al
; X86-NEXT:    addb %dl, %dl
; X86-NEXT:    decb %dl
; X86-NEXT:    shrb %al
; X86-NEXT:    mulb %dl
; X86-NEXT:    addb %cl, %al
; X86-NEXT:    retl
  %t3 = icmp ugt i8 %a1, %a2
  %t4 = select i1 %t3, i8 -1, i8 1
  %t5 = select i1 %t3, i8 %a2, i8 %a1
  %t6 = select i1 %t3, i8 %a1, i8 %a2
  %t7 = sub i8 %t6, %t5
  %t8 = lshr i8 %t7, 1
  %t9 = mul i8 %t8, %t4
  %a10 = add i8 %t9, %a1
  ret i8 %a10
}

; Values are loaded. Only check signed case.

define i8 @scalar_i8_signed_mem_reg(i8* %a1_addr, i8 %a2) nounwind {
; X64-LABEL: scalar_i8_signed_mem_reg:
; X64:       # %bb.0:
; X64-NEXT:    movzbl (%rdi), %ecx
; X64-NEXT:    cmpb %sil, %cl
; X64-NEXT:    setle %dl
; X64-NEXT:    movl %ecx, %edi
; X64-NEXT:    cmovgl %esi, %edi
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    cmovlel %esi, %eax
; X64-NEXT:    addb %dl, %dl
; X64-NEXT:    decb %dl
; X64-NEXT:    subb %dil, %al
; X64-NEXT:    shrb %al
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    mulb %dl
; X64-NEXT:    addb %cl, %al
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i8_signed_mem_reg:
; X86:       # %bb.0:
; X86-NEXT:    movb {{[0-9]+}}(%esp), %al
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movb (%ecx), %cl
; X86-NEXT:    cmpb %al, %cl
; X86-NEXT:    setle %dl
; X86-NEXT:    jg .LBB17_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movb %cl, %ah
; X86-NEXT:    jmp .LBB17_3
; X86-NEXT:  .LBB17_1:
; X86-NEXT:    movb %al, %ah
; X86-NEXT:    movb %cl, %al
; X86-NEXT:  .LBB17_3:
; X86-NEXT:    subb %ah, %al
; X86-NEXT:    addb %dl, %dl
; X86-NEXT:    decb %dl
; X86-NEXT:    shrb %al
; X86-NEXT:    mulb %dl
; X86-NEXT:    addb %cl, %al
; X86-NEXT:    retl
  %a1 = load i8, i8* %a1_addr
  %t3 = icmp sgt i8 %a1, %a2 ; signed
  %t4 = select i1 %t3, i8 -1, i8 1
  %t5 = select i1 %t3, i8 %a2, i8 %a1
  %t6 = select i1 %t3, i8 %a1, i8 %a2
  %t7 = sub i8 %t6, %t5
  %t8 = lshr i8 %t7, 1
  %t9 = mul nsw i8 %t8, %t4 ; signed
  %a10 = add nsw i8 %t9, %a1 ; signed
  ret i8 %a10
}

define i8 @scalar_i8_signed_reg_mem(i8 %a1, i8* %a2_addr) nounwind {
; X64-LABEL: scalar_i8_signed_reg_mem:
; X64:       # %bb.0:
; X64-NEXT:    movzbl (%rsi), %eax
; X64-NEXT:    cmpb %al, %dil
; X64-NEXT:    setle %cl
; X64-NEXT:    movl %edi, %edx
; X64-NEXT:    cmovgl %eax, %edx
; X64-NEXT:    cmovgl %edi, %eax
; X64-NEXT:    addb %cl, %cl
; X64-NEXT:    decb %cl
; X64-NEXT:    subb %dl, %al
; X64-NEXT:    shrb %al
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    mulb %cl
; X64-NEXT:    addb %dil, %al
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i8_signed_reg_mem:
; X86:       # %bb.0:
; X86-NEXT:    movb {{[0-9]+}}(%esp), %cl
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movb (%eax), %al
; X86-NEXT:    cmpb %al, %cl
; X86-NEXT:    setle %dl
; X86-NEXT:    jg .LBB18_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movb %cl, %ah
; X86-NEXT:    jmp .LBB18_3
; X86-NEXT:  .LBB18_1:
; X86-NEXT:    movb %al, %ah
; X86-NEXT:    movb %cl, %al
; X86-NEXT:  .LBB18_3:
; X86-NEXT:    subb %ah, %al
; X86-NEXT:    addb %dl, %dl
; X86-NEXT:    decb %dl
; X86-NEXT:    shrb %al
; X86-NEXT:    mulb %dl
; X86-NEXT:    addb %cl, %al
; X86-NEXT:    retl
  %a2 = load i8, i8* %a2_addr
  %t3 = icmp sgt i8 %a1, %a2 ; signed
  %t4 = select i1 %t3, i8 -1, i8 1
  %t5 = select i1 %t3, i8 %a2, i8 %a1
  %t6 = select i1 %t3, i8 %a1, i8 %a2
  %t7 = sub i8 %t6, %t5
  %t8 = lshr i8 %t7, 1
  %t9 = mul nsw i8 %t8, %t4 ; signed
  %a10 = add nsw i8 %t9, %a1 ; signed
  ret i8 %a10
}

define i8 @scalar_i8_signed_mem_mem(i8* %a1_addr, i8* %a2_addr) nounwind {
; X64-LABEL: scalar_i8_signed_mem_mem:
; X64:       # %bb.0:
; X64-NEXT:    movzbl (%rdi), %ecx
; X64-NEXT:    movzbl (%rsi), %eax
; X64-NEXT:    cmpb %al, %cl
; X64-NEXT:    setle %dl
; X64-NEXT:    movl %ecx, %esi
; X64-NEXT:    cmovgl %eax, %esi
; X64-NEXT:    cmovgl %ecx, %eax
; X64-NEXT:    addb %dl, %dl
; X64-NEXT:    decb %dl
; X64-NEXT:    subb %sil, %al
; X64-NEXT:    shrb %al
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    mulb %dl
; X64-NEXT:    addb %cl, %al
; X64-NEXT:    retq
;
; X86-LABEL: scalar_i8_signed_mem_mem:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movb (%ecx), %cl
; X86-NEXT:    movb (%eax), %al
; X86-NEXT:    cmpb %al, %cl
; X86-NEXT:    setle %dl
; X86-NEXT:    jg .LBB19_1
; X86-NEXT:  # %bb.2:
; X86-NEXT:    movb %cl, %ah
; X86-NEXT:    jmp .LBB19_3
; X86-NEXT:  .LBB19_1:
; X86-NEXT:    movb %al, %ah
; X86-NEXT:    movb %cl, %al
; X86-NEXT:  .LBB19_3:
; X86-NEXT:    subb %ah, %al
; X86-NEXT:    addb %dl, %dl
; X86-NEXT:    decb %dl
; X86-NEXT:    shrb %al
; X86-NEXT:    mulb %dl
; X86-NEXT:    addb %cl, %al
; X86-NEXT:    retl
  %a1 = load i8, i8* %a1_addr
  %a2 = load i8, i8* %a2_addr
  %t3 = icmp sgt i8 %a1, %a2 ; signed
  %t4 = select i1 %t3, i8 -1, i8 1
  %t5 = select i1 %t3, i8 %a2, i8 %a1
  %t6 = select i1 %t3, i8 %a1, i8 %a2
  %t7 = sub i8 %t6, %t5
  %t8 = lshr i8 %t7, 1
  %t9 = mul nsw i8 %t8, %t4 ; signed
  %a10 = add nsw i8 %t9, %a1 ; signed
  ret i8 %a10
}
