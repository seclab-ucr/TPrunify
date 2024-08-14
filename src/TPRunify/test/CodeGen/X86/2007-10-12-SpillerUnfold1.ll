; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-- -mattr=+sse2 | FileCheck %s

define fastcc void @fht(float* %fz, i16 signext  %n) {
; CHECK-LABEL: fht:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movss {{.*#+}} xmm3 = mem[0],zero,zero,zero
; CHECK-NEXT:    xorps %xmm0, %xmm0
; CHECK-NEXT:    xorps %xmm1, %xmm1
; CHECK-NEXT:    subss %xmm3, %xmm1
; CHECK-NEXT:    movaps %xmm3, %xmm4
; CHECK-NEXT:    mulss %xmm0, %xmm4
; CHECK-NEXT:    addss %xmm3, %xmm4
; CHECK-NEXT:    movaps %xmm3, %xmm2
; CHECK-NEXT:    subss %xmm4, %xmm2
; CHECK-NEXT:    addss %xmm3, %xmm4
; CHECK-NEXT:    xorps %xmm5, %xmm5
; CHECK-NEXT:    subss %xmm1, %xmm5
; CHECK-NEXT:    addss %xmm0, %xmm1
; CHECK-NEXT:    mulss %xmm0, %xmm4
; CHECK-NEXT:    mulss %xmm0, %xmm5
; CHECK-NEXT:    addss %xmm4, %xmm5
; CHECK-NEXT:    addss %xmm0, %xmm5
; CHECK-NEXT:    movss %xmm5, 0
; CHECK-NEXT:    movss %xmm3, (%ecx)
; CHECK-NEXT:    addss %xmm0, %xmm3
; CHECK-NEXT:    movss %xmm3, 0
; CHECK-NEXT:    mulss %xmm0, %xmm1
; CHECK-NEXT:    mulss %xmm0, %xmm2
; CHECK-NEXT:    addss %xmm1, %xmm2
; CHECK-NEXT:    addss %xmm0, %xmm2
; CHECK-NEXT:    movss %xmm2, (%ecx)
; CHECK-NEXT:    retl
entry:
	br i1 true, label %bb171.preheader, label %bb431

bb171.preheader:		; preds = %entry
	%tmp176 = fadd float 0.000000e+00, 1.000000e+00		; <float> [#uses=2]
	%gi.1 = getelementptr float, float* %fz, i32 0		; <float*> [#uses=2]
	%tmp240 = load float, float* %gi.1, align 4		; <float> [#uses=1]
	%tmp242 = fsub float %tmp240, 0.000000e+00		; <float> [#uses=2]
	%tmp251 = getelementptr float, float* %fz, i32 0		; <float*> [#uses=1]
	%tmp252 = load float, float* %tmp251, align 4		; <float> [#uses=1]
	%tmp258 = getelementptr float, float* %fz, i32 0		; <float*> [#uses=2]
	%tmp259 = load float, float* %tmp258, align 4		; <float> [#uses=2]
	%tmp261 = fmul float %tmp259, %tmp176		; <float> [#uses=1]
	%tmp262 = fsub float 0.000000e+00, %tmp261		; <float> [#uses=2]
	%tmp269 = fmul float %tmp252, %tmp176		; <float> [#uses=1]
	%tmp276 = fmul float %tmp259, 0.000000e+00		; <float> [#uses=1]
	%tmp277 = fadd float %tmp269, %tmp276		; <float> [#uses=2]
	%tmp281 = getelementptr float, float* %fz, i32 0		; <float*> [#uses=1]
	%tmp282 = load float, float* %tmp281, align 4		; <float> [#uses=2]
	%tmp284 = fsub float %tmp282, %tmp277		; <float> [#uses=1]
	%tmp291 = fadd float %tmp282, %tmp277		; <float> [#uses=1]
	%tmp298 = fsub float 0.000000e+00, %tmp262		; <float> [#uses=1]
	%tmp305 = fadd float 0.000000e+00, %tmp262		; <float> [#uses=1]
	%tmp315 = fmul float 0.000000e+00, %tmp291		; <float> [#uses=1]
	%tmp318 = fmul float 0.000000e+00, %tmp298		; <float> [#uses=1]
	%tmp319 = fadd float %tmp315, %tmp318		; <float> [#uses=1]
	%tmp329 = fadd float 0.000000e+00, %tmp319		; <float> [#uses=1]
	store float %tmp329, float* null, align 4
	%tmp336 = fsub float %tmp242, 0.000000e+00		; <float> [#uses=1]
	store float %tmp336, float* %tmp258, align 4
	%tmp343 = fadd float %tmp242, 0.000000e+00		; <float> [#uses=1]
	store float %tmp343, float* null, align 4
	%tmp355 = fmul float 0.000000e+00, %tmp305		; <float> [#uses=1]
	%tmp358 = fmul float 0.000000e+00, %tmp284		; <float> [#uses=1]
	%tmp359 = fadd float %tmp355, %tmp358		; <float> [#uses=1]
	%tmp369 = fadd float 0.000000e+00, %tmp359		; <float> [#uses=1]
	store float %tmp369, float* %gi.1, align 4
	ret void

bb431:		; preds = %entry
	ret void
}
