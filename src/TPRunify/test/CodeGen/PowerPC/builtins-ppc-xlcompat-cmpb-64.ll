; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-unknown -mcpu=pwr7 < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-unknown -mcpu=pwr8 < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-aix -mcpu=pwr7 < %s | FileCheck %s

define i64 @test_cmpb(i64 %a, i64 %b) {
; CHECK-LABEL: test_cmpb:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpb 3, 3, 4
; CHECK-NEXT:    blr
entry:
  %cmpb = tail call i64 @llvm.ppc.cmpb.i64.i64.i64(i64 %a, i64 %b)
  ret i64 %cmpb
}

declare i64 @llvm.ppc.cmpb.i64.i64.i64(i64, i64)
