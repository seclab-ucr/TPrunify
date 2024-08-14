; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:     -mcpu=pwr10 -ppc-vsr-nums-as-vr -ppc-asm-full-reg-names \
; RUN:     < %s | FileCheck %s --check-prefix=CHECK-LE

; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:     -mcpu=pwr10 -ppc-vsr-nums-as-vr -ppc-asm-full-reg-names \
; RUN:     < %s | FileCheck %s --check-prefix=CHECK-BE

define void @test1(<4 x i32> %A, i32* %a) {
; CHECK-LE-LABEL: test1:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    stxvrwx v2, 0, r5
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: test1:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, v2, v2, 3
; CHECK-BE-NEXT:    stfiwx f0, 0, r5
; CHECK-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x i32> %A, i32 0
  store i32 %vecext, i32* %a, align 4
  ret void
}

define void @test2(<4 x float> %A, float* %a) {
; CHECK-LE-LABEL: test2:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    stxvrwx v2, 0, r5
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: test2:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, v2, v2, 3
; CHECK-BE-NEXT:    stfiwx f0, 0, r5
; CHECK-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x float> %A, i32 0
  store float %vecext, float* %a, align 4
  ret void
}

define void @test3(<2 x double> %A, double* %a) {
; CHECK-LE-LABEL: test3:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    stxvrdx v2, 0, r5
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: test3:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    stxsd v2, 0(r5)
; CHECK-BE-NEXT:    blr
entry:
  %vecext = extractelement <2 x double> %A, i32 0
  store double %vecext, double* %a, align 8
  ret void
}

define void @test4(<2 x i64> %A, i64* %a) {
; CHECK-LE-LABEL: test4:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    stxvrdx v2, 0, r5
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: test4:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    stxsd v2, 0(r5)
; CHECK-BE-NEXT:    blr
entry:
  %vecext = extractelement <2 x i64> %A, i32 0
  store i64 %vecext, i64* %a, align 8
  ret void
}

define void @test5(<8 x i16> %A, i16* %a) {
; CHECK-LE-LABEL: test5:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    stxvrhx v2, 0, r5
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: test5:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    vsldoi v2, v2, v2, 10
; CHECK-BE-NEXT:    stxsihx v2, 0, r5
; CHECK-BE-NEXT:    blr
entry:
  %vecext = extractelement <8 x i16> %A, i32 0
  store i16 %vecext, i16* %a, align 2
  ret void
}

define void @test6(<16 x i8> %A, i8* %a) {
; CHECK-LE-LABEL: test6:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    stxvrbx v2, 0, r5
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: test6:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    vsldoi v2, v2, v2, 9
; CHECK-BE-NEXT:    stxsibx v2, 0, r5
; CHECK-BE-NEXT:    blr
entry:
  %vecext = extractelement <16 x i8> %A, i32 0
  store i8 %vecext, i8* %a, align 1
  ret void
}

