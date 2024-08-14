; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

; This test checks that bitcast is moved after insertelement when both vector and scalar are
; bitcast from the same element type.
; inselt (bitcast VecSrc), (bitcast ScalarSrc), IdxOp
;  --> bitcast (inselt VecSrc, ScalarSrc, IdxOp)
define <vscale x 4 x float> @insertelement_bitcast(<vscale x 4 x i32> %vec, i32 %x) {
; CHECK-LABEL: @insertelement_bitcast(
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <vscale x 4 x i32> [[VEC:%.*]], i32 [[X:%.*]], i64 0
; CHECK-NEXT:    [[R:%.*]] = bitcast <vscale x 4 x i32> [[TMP1]] to <vscale x 4 x float>
; CHECK-NEXT:    ret <vscale x 4 x float> [[R]]
;
  %x_cast = bitcast i32 %x to float
  %vec_cast = bitcast <vscale x 4 x i32> %vec to <vscale x 4 x float>
  %r = insertelement <vscale x 4 x float> %vec_cast, float %x_cast, i32 0
  ret <vscale x 4 x float> %r
}

; This test checks that code-path "Try to form a shuffle from a chain of extract-insert ops" is
; not taken when both extract and insert are scalable type.
; For scalable type, the vector length needed to create shuffle mask is not a compile-time constant.
; Meanwhile, for scalable type shuffle mask only support splat and undef in the current code base.
; Otherwise we crash at:
; "Assertion `isValidOperands(V1, V2, Mask) && "Invalid shuffle vector instruction operands!"' failed."
define <vscale x 4 x i32> @insertelement_extractelement(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: @insertelement_extractelement(
; CHECK-NEXT:    [[T0:%.*]] = extractelement <vscale x 4 x i32> [[A:%.*]], i64 1
; CHECK-NEXT:    [[T1:%.*]] = insertelement <vscale x 4 x i32> [[B:%.*]], i32 [[T0]], i64 0
; CHECK-NEXT:    ret <vscale x 4 x i32> [[T1]]
;
  %t0 = extractelement <vscale x 4 x i32> %a, i32 1
  %t1 = insertelement <vscale x 4 x i32> %b, i32 %t0, i32 0
  ret <vscale x 4 x i32> %t1
}

; This test checks that we are not attempting to create a shuffle from extract/insert chain,
; when extract is from a scalable type, and the insert vector is fixed-length.
define <4 x i32> @insertelement_extractelement_fixed_vec_extract_from_scalable(<vscale x 4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: @insertelement_extractelement_fixed_vec_extract_from_scalable(
; CHECK-NEXT:    [[T0:%.*]] = extractelement <vscale x 4 x i32> [[A:%.*]], i64 1
; CHECK-NEXT:    [[T1:%.*]] = insertelement <4 x i32> [[B:%.*]], i32 [[T0]], i64 0
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = extractelement <vscale x 4 x i32> %a, i32 1
  %t1 = insertelement <4 x i32> %b, i32 %t0, i32 0
  ret <4 x i32> %t1
}

; This test checks that the optimization "foldConstantInsEltInfoShuffle" is not taken for scalable type.
; Particularly the fold:
; insertelt (insertelt X, C1, CIndex1), C, CIndex
;  --> shufflevector X, CVec', Mask'
; For scalable type, the vector length needed to create shuffle mask is not a compile-time constant.
; Meanwhile, for scalable type shuffle mask only support splat and undef in the current code base.
; Otherwise we crash at:
; "Assertion `isValidOperands(V1, V2, Mask) && "Invalid shuffle vector instruction operands!"' failed."
define <vscale x 4 x i32> @insertelement_insertelement(<vscale x 4 x i32> %vec) {
; CHECK-LABEL: @insertelement_insertelement(
; CHECK-NEXT:    [[T0:%.*]] = insertelement <vscale x 4 x i32> [[VEC:%.*]], i32 1, i64 1
; CHECK-NEXT:    [[T1:%.*]] = insertelement <vscale x 4 x i32> [[T0]], i32 2, i64 2
; CHECK-NEXT:    ret <vscale x 4 x i32> [[T1]]
;
  %t0 = insertelement <vscale x 4 x i32> %vec, i32 1, i32 1
  %t1 = insertelement <vscale x 4 x i32> %t0, i32 2, i32 2
  ret <vscale x 4 x i32> %t1
}

; This test checks that the following insertelement sequence is not folded into shuffle splat.
; The length of scalable vector is unknown at compile-time. Therefore the following insertelements
; may not form a valid splat.
define <vscale x 4 x float> @insertelement_sequene_may_not_be_splat(float %x) {
; CHECK-LABEL: @insertelement_sequene_may_not_be_splat(
; CHECK-NEXT:    [[T0:%.*]] = insertelement <vscale x 4 x float> poison, float [[X:%.*]], i64 0
; CHECK-NEXT:    [[T1:%.*]] = insertelement <vscale x 4 x float> [[T0]], float [[X]], i64 1
; CHECK-NEXT:    [[T2:%.*]] = insertelement <vscale x 4 x float> [[T1]], float [[X]], i64 2
; CHECK-NEXT:    [[T3:%.*]] = insertelement <vscale x 4 x float> [[T2]], float [[X]], i64 3
; CHECK-NEXT:    ret <vscale x 4 x float> [[T3]]
;
  %t0 = insertelement <vscale x 4 x float> poison, float %x, i32 0
  %t1 = insertelement <vscale x 4 x float> %t0, float %x, i32 1
  %t2 = insertelement <vscale x 4 x float> %t1, float %x, i32 2
  %t3 = insertelement <vscale x 4 x float> %t2, float %x, i32 3
  ret <vscale x 4 x float> %t3
}

; OSS-Fuzz #27416
; https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=27416
define void @ossfuzz_27416(i32 %v) {
; CHECK-LABEL: @ossfuzz_27416(
; CHECK-NEXT:    [[IN:%.*]] = insertelement <vscale x 4 x i32> poison, i32 [[V:%.*]], i64 0
; CHECK-NEXT:    [[SPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[IN]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    [[I1:%.*]] = insertelement <vscale x 4 x i32> [[SPLAT]], i32 undef, i64 128
; CHECK-NEXT:    store <vscale x 4 x i32> [[I1]], <vscale x 4 x i32>* undef, align 16
; CHECK-NEXT:    ret void
;
  %in = insertelement <vscale x 4 x i32> poison, i32 %v, i32 0
  %splat = shufflevector <vscale x 4 x i32> %in, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %I1 = insertelement <vscale x 4 x i32> %splat, i32 undef, i8 -128
  store <vscale x 4 x i32> %I1, <vscale x 4 x i32>* undef, align 16
  ret void
}
