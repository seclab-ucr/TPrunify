; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -ppc-asm-full-reg-names -O3 < %s \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu -mcpu=pwr9 | FileCheck %s
; RUN: llc -verify-machineinstrs -ppc-asm-full-reg-names -O3 < %s \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu -mcpu=pwr8 | FileCheck %s --check-prefix=CHECK-P8
; RUN: llc -verify-machineinstrs -ppc-asm-full-reg-names -ppc-fma-rp-factor=0.0 -O3 < %s \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu -mcpu=pwr9 | FileCheck %s --check-prefix=CHECK-FMA

@global_val = external global float, align 4

define float @foo_float(float %0, float %1, float %2, float %3) {
; CHECK-LABEL: foo_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addis r3, r2, .LCPI0_0@toc@ha
; CHECK-NEXT:    xsmulsp f1, f2, f1
; CHECK-NEXT:    xssubsp f0, f3, f4
; CHECK-NEXT:    lfs f2, .LCPI0_0@toc@l(r3)
; CHECK-NEXT:    xsmaddasp f1, f0, f2
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: foo_float:
; CHECK-P8:       # %bb.0:
; CHECK-P8-NEXT:    xsmulsp f1, f2, f1
; CHECK-P8-NEXT:    addis r3, r2, .LCPI0_0@toc@ha
; CHECK-P8-NEXT:    xssubsp f0, f3, f4
; CHECK-P8-NEXT:    lfs f2, .LCPI0_0@toc@l(r3)
; CHECK-P8-NEXT:    xsmaddasp f1, f0, f2
; CHECK-P8-NEXT:    blr
;
; CHECK-FMA-LABEL: foo_float:
; CHECK-FMA:       # %bb.0:
; CHECK-FMA-NEXT:    addis r3, r2, .LCPI0_0@toc@ha
; CHECK-FMA-NEXT:    xsmulsp f1, f2, f1
; CHECK-FMA-NEXT:    lfs f0, .LCPI0_0@toc@l(r3)
; CHECK-FMA-NEXT:    addis r3, r2, .LCPI0_1@toc@ha
; CHECK-FMA-NEXT:    lfs f2, .LCPI0_1@toc@l(r3)
; CHECK-FMA-NEXT:    xsmaddasp f1, f4, f2
; CHECK-FMA-NEXT:    xsmaddasp f1, f3, f0
; CHECK-FMA-NEXT:    blr
  %5 = fmul contract reassoc nsz float %1, %0
  %6 = fsub contract reassoc nsz float %2, %3
  %7 = fmul contract reassoc nsz float %6, 0x3DB2533FE0000000
  %8 = fadd contract reassoc nsz float %7, %5
  ret float %8
}

define double @foo_double(double %0, double %1, double %2, double %3) {
; CHECK-LABEL: foo_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xsmuldp f1, f2, f1
; CHECK-NEXT:    xssubdp f0, f3, f4
; CHECK-NEXT:    addis r3, r2, .LCPI1_0@toc@ha
; CHECK-NEXT:    lfd f2, .LCPI1_0@toc@l(r3)
; CHECK-NEXT:    xsmaddadp f1, f0, f2
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: foo_double:
; CHECK-P8:       # %bb.0:
; CHECK-P8-NEXT:    xsmuldp f1, f2, f1
; CHECK-P8-NEXT:    addis r3, r2, .LCPI1_0@toc@ha
; CHECK-P8-NEXT:    xssubdp f0, f3, f4
; CHECK-P8-NEXT:    lfd f2, .LCPI1_0@toc@l(r3)
; CHECK-P8-NEXT:    xsmaddadp f1, f0, f2
; CHECK-P8-NEXT:    blr
;
; CHECK-FMA-LABEL: foo_double:
; CHECK-FMA:       # %bb.0:
; CHECK-FMA-NEXT:    addis r3, r2, .LCPI1_0@toc@ha
; CHECK-FMA-NEXT:    xsmuldp f1, f2, f1
; CHECK-FMA-NEXT:    lfd f0, .LCPI1_0@toc@l(r3)
; CHECK-FMA-NEXT:    addis r3, r2, .LCPI1_1@toc@ha
; CHECK-FMA-NEXT:    lfd f2, .LCPI1_1@toc@l(r3)
; CHECK-FMA-NEXT:    xsmaddadp f1, f4, f2
; CHECK-FMA-NEXT:    xsmaddadp f1, f3, f0
; CHECK-FMA-NEXT:    blr
  %5 = fmul contract reassoc nsz double %1, %0
  %6 = fsub contract reassoc nsz double %2, %3
  %7 = fmul contract reassoc nsz double %6, 0x3DB2533FE68CADDE
  %8 = fadd contract reassoc nsz double %7, %5
  ret double %8
}

define float @foo_float_reuse_const(float %0, float %1, float %2, float %3) {
; CHECK-LABEL: foo_float_reuse_const:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addis r3, r2, .LCPI2_0@toc@ha
; CHECK-NEXT:    xsmulsp f1, f2, f1
; CHECK-NEXT:    xssubsp f0, f3, f4
; CHECK-NEXT:    lfs f3, .LCPI2_0@toc@l(r3)
; CHECK-NEXT:    addis r3, r2, .LCPI2_1@toc@ha
; CHECK-NEXT:    xsmaddasp f1, f0, f3
; CHECK-NEXT:    lfs f0, .LCPI2_1@toc@l(r3)
; CHECK-NEXT:    addis r3, r2, .LC0@toc@ha
; CHECK-NEXT:    ld r3, .LC0@toc@l(r3)
; CHECK-NEXT:    xsmulsp f0, f2, f0
; CHECK-NEXT:    stfs f0, 0(r3)
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: foo_float_reuse_const:
; CHECK-P8:       # %bb.0:
; CHECK-P8-NEXT:    xsmulsp f1, f2, f1
; CHECK-P8-NEXT:    addis r3, r2, .LCPI2_0@toc@ha
; CHECK-P8-NEXT:    xssubsp f0, f3, f4
; CHECK-P8-NEXT:    lfs f3, .LCPI2_0@toc@l(r3)
; CHECK-P8-NEXT:    addis r3, r2, .LCPI2_1@toc@ha
; CHECK-P8-NEXT:    lfs f4, .LCPI2_1@toc@l(r3)
; CHECK-P8-NEXT:    addis r3, r2, .LC0@toc@ha
; CHECK-P8-NEXT:    ld r3, .LC0@toc@l(r3)
; CHECK-P8-NEXT:    xsmaddasp f1, f0, f3
; CHECK-P8-NEXT:    xsmulsp f0, f2, f4
; CHECK-P8-NEXT:    stfs f0, 0(r3)
; CHECK-P8-NEXT:    blr
;
; CHECK-FMA-LABEL: foo_float_reuse_const:
; CHECK-FMA:       # %bb.0:
; CHECK-FMA-NEXT:    addis r3, r2, .LCPI2_0@toc@ha
; CHECK-FMA-NEXT:    xsmulsp f1, f2, f1
; CHECK-FMA-NEXT:    lfs f0, .LCPI2_0@toc@l(r3)
; CHECK-FMA-NEXT:    addis r3, r2, .LCPI2_1@toc@ha
; CHECK-FMA-NEXT:    lfs f5, .LCPI2_1@toc@l(r3)
; CHECK-FMA-NEXT:    addis r3, r2, .LC0@toc@ha
; CHECK-FMA-NEXT:    ld r3, .LC0@toc@l(r3)
; CHECK-FMA-NEXT:    xsmaddasp f1, f4, f5
; CHECK-FMA-NEXT:    xsmaddasp f1, f3, f0
; CHECK-FMA-NEXT:    xsmulsp f0, f2, f5
; CHECK-FMA-NEXT:    stfs f0, 0(r3)
; CHECK-FMA-NEXT:    blr
  %5 = fmul contract reassoc nsz float %1, %0
  %6 = fsub contract reassoc nsz float %2, %3
  %7 = fmul contract reassoc nsz float %6, 0x3DB2533FE0000000
  %8 = fadd contract reassoc nsz float %7, %5
  %9 = fmul contract reassoc nsz float %1, 0xBDB2533FE0000000
  store float %9, float* @global_val, align 4
  ret float %8
}
