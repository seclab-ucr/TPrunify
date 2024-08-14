; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mcpu=core2 | FileCheck %s --check-prefix=CORE2
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mcpu=nehalem | FileCheck %s --check-prefix=NEHALEM
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mcpu=bdver2 | FileCheck %s --check-prefix=BDVER2
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mcpu=btver2 | FileCheck %s --check-prefix=BTVER2

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i1)

define void @copy16bytes(i8* nocapture %a, i8* nocapture readonly %b) {
; CORE2-LABEL: copy16bytes:
; CORE2:       ## %bb.0:
; CORE2-NEXT:    movq (%rsi), %rax
; CORE2-NEXT:    movq 8(%rsi), %rcx
; CORE2-NEXT:    movq %rcx, 8(%rdi)
; CORE2-NEXT:    movq %rax, (%rdi)
; CORE2-NEXT:    retq
;
; NEHALEM-LABEL: copy16bytes:
; NEHALEM:       ## %bb.0:
; NEHALEM-NEXT:    movups (%rsi), %xmm0
; NEHALEM-NEXT:    movups %xmm0, (%rdi)
; NEHALEM-NEXT:    retq
;
; BDVER2-LABEL: copy16bytes:
; BDVER2:       ## %bb.0:
; BDVER2-NEXT:    vmovups (%rsi), %xmm0
; BDVER2-NEXT:    vmovups %xmm0, (%rdi)
; BDVER2-NEXT:    retq
;
; BTVER2-LABEL: copy16bytes:
; BTVER2:       ## %bb.0:
; BTVER2-NEXT:    vmovups (%rsi), %xmm0
; BTVER2-NEXT:    vmovups %xmm0, (%rdi)
; BTVER2-NEXT:    retq
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %a, i8* %b, i64 16, i1 false)
  ret void

  ; CHECK-LABEL: copy16bytes


}
