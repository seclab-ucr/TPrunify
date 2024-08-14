; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=sroa -S | FileCheck %s
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-n8:16:32:64"

%S1 = type { i64, [42 x float] }

define i32 @test1(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_0_8_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[X:%.*]], i32 2
; CHECK-NEXT:    [[A_SROA_2_28_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[Y:%.*]], i32 3
; CHECK-NEXT:    [[A_SROA_2_16_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[Y]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[A_SROA_0_8_VEC_EXTRACT]], [[A_SROA_2_28_VEC_EXTRACT]]
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[A_SROA_2_16_VEC_EXTRACT]], [[TMP4]]
; CHECK-NEXT:    ret i32 [[TMP5]]
;
entry:
  %a = alloca [2 x <4 x i32>]

  %a.x = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 0
  store <4 x i32> %x, <4 x i32>* %a.x
  %a.y = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1
  store <4 x i32> %y, <4 x i32>* %a.y

  %a.tmp1 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 0, i64 2
  %tmp1 = load i32, i32* %a.tmp1
  %a.tmp2 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1, i64 3
  %tmp2 = load i32, i32* %a.tmp2
  %a.tmp3 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1, i64 0
  %tmp3 = load i32, i32* %a.tmp3

  %tmp4 = add i32 %tmp1, %tmp2
  %tmp5 = add i32 %tmp3, %tmp4
  ret i32 %tmp5
}

define i32 @test2(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_0_8_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[X:%.*]], i32 2
; CHECK-NEXT:    [[A_SROA_2_28_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[Y:%.*]], i32 3
; CHECK-NEXT:    [[A_SROA_2_16_VEC_EXTRACT:%.*]] = shufflevector <4 x i32> [[Y]], <4 x i32> poison, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <2 x i32> [[A_SROA_2_16_VEC_EXTRACT]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[A_SROA_0_8_VEC_EXTRACT]], [[A_SROA_2_28_VEC_EXTRACT]]
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[TMP3]], [[TMP4]]
; CHECK-NEXT:    ret i32 [[TMP5]]
;
entry:
  %a = alloca [2 x <4 x i32>]

  %a.x = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 0
  store <4 x i32> %x, <4 x i32>* %a.x
  %a.y = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1
  store <4 x i32> %y, <4 x i32>* %a.y

  %a.tmp1 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 0, i64 2
  %tmp1 = load i32, i32* %a.tmp1
  %a.tmp2 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1, i64 3
  %tmp2 = load i32, i32* %a.tmp2
  %a.tmp3 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1, i64 0
  %a.tmp3.cast = bitcast i32* %a.tmp3 to <2 x i32>*
  %tmp3.vec = load <2 x i32>, <2 x i32>* %a.tmp3.cast
  %tmp3 = extractelement <2 x i32> %tmp3.vec, i32 0

  %tmp4 = add i32 %tmp1, %tmp2
  %tmp5 = add i32 %tmp3, %tmp4
  ret i32 %tmp5
}

define i32 @test3(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_0_8_VEC_INSERT:%.*]] = insertelement <4 x i32> [[X:%.*]], i32 -1, i32 2
; CHECK-NEXT:    [[A_SROA_0_8_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[A_SROA_0_8_VEC_INSERT]], i32 2
; CHECK-NEXT:    [[A_SROA_3_28_VEC_EXTRACT:%.*]] = extractelement <4 x i32> zeroinitializer, i32 3
; CHECK-NEXT:    [[A_SROA_3_16_VEC_EXTRACT:%.*]] = extractelement <4 x i32> zeroinitializer, i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[A_SROA_0_8_VEC_EXTRACT]], [[A_SROA_3_28_VEC_EXTRACT]]
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[A_SROA_3_16_VEC_EXTRACT]], [[TMP4]]
; CHECK-NEXT:    ret i32 [[TMP5]]
;
entry:
  %a = alloca [2 x <4 x i32>]

  %a.x = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 0
  store <4 x i32> %x, <4 x i32>* %a.x
  %a.y = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1
  store <4 x i32> %y, <4 x i32>* %a.y

  %a.y.cast = bitcast <4 x i32>* %a.y to i8*
  call void @llvm.memset.p0i8.i32(i8* %a.y.cast, i8 0, i32 16, i1 false)

  %a.tmp1 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 0, i64 2
  %a.tmp1.cast = bitcast i32* %a.tmp1 to i8*
  call void @llvm.memset.p0i8.i32(i8* %a.tmp1.cast, i8 -1, i32 4, i1 false)
  %tmp1 = load i32, i32* %a.tmp1
  %a.tmp2 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1, i64 3
  %tmp2 = load i32, i32* %a.tmp2
  %a.tmp3 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1, i64 0
  %tmp3 = load i32, i32* %a.tmp3

  %tmp4 = add i32 %tmp1, %tmp2
  %tmp5 = add i32 %tmp3, %tmp4
  ret i32 %tmp5
}

define i32 @test4(<4 x i32> %x, <4 x i32> %y, <4 x i32>* %z) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_3_16_COPYLOAD:%.*]] = load <4 x i32>, <4 x i32>* [[Z:%.*]], align 1
; CHECK-NEXT:    [[A_SROA_0_8_Z_TMP1_CAST_SROA_IDX:%.*]] = getelementptr inbounds <4 x i32>, <4 x i32>* [[Z]], i64 0, i64 2
; CHECK-NEXT:    [[A_SROA_0_8_COPYLOAD:%.*]] = load i32, i32* [[A_SROA_0_8_Z_TMP1_CAST_SROA_IDX]], align 1
; CHECK-NEXT:    [[A_SROA_0_8_VEC_INSERT:%.*]] = insertelement <4 x i32> [[X:%.*]], i32 [[A_SROA_0_8_COPYLOAD]], i32 2
; CHECK-NEXT:    [[A_SROA_0_8_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[A_SROA_0_8_VEC_INSERT]], i32 2
; CHECK-NEXT:    [[A_SROA_3_28_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[A_SROA_3_16_COPYLOAD]], i32 3
; CHECK-NEXT:    [[A_SROA_3_16_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[A_SROA_3_16_COPYLOAD]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[A_SROA_0_8_VEC_EXTRACT]], [[A_SROA_3_28_VEC_EXTRACT]]
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[A_SROA_3_16_VEC_EXTRACT]], [[TMP4]]
; CHECK-NEXT:    ret i32 [[TMP5]]
;
entry:
  %a = alloca [2 x <4 x i32>]

  %a.x = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 0
  store <4 x i32> %x, <4 x i32>* %a.x
  %a.y = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1
  store <4 x i32> %y, <4 x i32>* %a.y

  %a.y.cast = bitcast <4 x i32>* %a.y to i8*
  %z.cast = bitcast <4 x i32>* %z to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %a.y.cast, i8* %z.cast, i32 16, i1 false)

  %a.tmp1 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 0, i64 2
  %a.tmp1.cast = bitcast i32* %a.tmp1 to i8*
  %z.tmp1 = getelementptr inbounds <4 x i32>, <4 x i32>* %z, i64 0, i64 2
  %z.tmp1.cast = bitcast i32* %z.tmp1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %a.tmp1.cast, i8* %z.tmp1.cast, i32 4, i1 false)
  %tmp1 = load i32, i32* %a.tmp1
  %a.tmp2 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1, i64 3
  %tmp2 = load i32, i32* %a.tmp2
  %a.tmp3 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1, i64 0
  %tmp3 = load i32, i32* %a.tmp3

  %tmp4 = add i32 %tmp1, %tmp2
  %tmp5 = add i32 %tmp3, %tmp4
  ret i32 %tmp5
}

declare void @llvm.memcpy.p0i8.p1i8.i32(i8* nocapture, i8 addrspace(1)* nocapture, i32, i1) nounwind

; Same as test4 with a different sized address  space pointer source.
define i32 @test4_as1(<4 x i32> %x, <4 x i32> %y, <4 x i32> addrspace(1)* %z) {
; CHECK-LABEL: @test4_as1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_3_16_COPYLOAD:%.*]] = load <4 x i32>, <4 x i32> addrspace(1)* [[Z:%.*]], align 1
; CHECK-NEXT:    [[A_SROA_0_8_Z_TMP1_CAST_SROA_IDX:%.*]] = getelementptr inbounds <4 x i32>, <4 x i32> addrspace(1)* [[Z]], i64 0, i64 2
; CHECK-NEXT:    [[A_SROA_0_8_COPYLOAD:%.*]] = load i32, i32 addrspace(1)* [[A_SROA_0_8_Z_TMP1_CAST_SROA_IDX]], align 1
; CHECK-NEXT:    [[A_SROA_0_8_VEC_INSERT:%.*]] = insertelement <4 x i32> [[X:%.*]], i32 [[A_SROA_0_8_COPYLOAD]], i32 2
; CHECK-NEXT:    [[A_SROA_0_8_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[A_SROA_0_8_VEC_INSERT]], i32 2
; CHECK-NEXT:    [[A_SROA_3_28_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[A_SROA_3_16_COPYLOAD]], i32 3
; CHECK-NEXT:    [[A_SROA_3_16_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[A_SROA_3_16_COPYLOAD]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[A_SROA_0_8_VEC_EXTRACT]], [[A_SROA_3_28_VEC_EXTRACT]]
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[A_SROA_3_16_VEC_EXTRACT]], [[TMP4]]
; CHECK-NEXT:    ret i32 [[TMP5]]
;
entry:
  %a = alloca [2 x <4 x i32>]

  %a.x = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 0
  store <4 x i32> %x, <4 x i32>* %a.x
  %a.y = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1
  store <4 x i32> %y, <4 x i32>* %a.y

  %a.y.cast = bitcast <4 x i32>* %a.y to i8*
  %z.cast = bitcast <4 x i32> addrspace(1)* %z to i8 addrspace(1)*
  call void @llvm.memcpy.p0i8.p1i8.i32(i8* %a.y.cast, i8 addrspace(1)* %z.cast, i32 16, i1 false)

  %a.tmp1 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 0, i64 2
  %a.tmp1.cast = bitcast i32* %a.tmp1 to i8*
  %z.tmp1 = getelementptr inbounds <4 x i32>, <4 x i32> addrspace(1)* %z, i16 0, i16 2
  %z.tmp1.cast = bitcast i32 addrspace(1)* %z.tmp1 to i8 addrspace(1)*
  call void @llvm.memcpy.p0i8.p1i8.i32(i8* %a.tmp1.cast, i8 addrspace(1)* %z.tmp1.cast, i32 4, i1 false)
  %tmp1 = load i32, i32* %a.tmp1
  %a.tmp2 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1, i64 3
  %tmp2 = load i32, i32* %a.tmp2
  %a.tmp3 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1, i64 0
  %tmp3 = load i32, i32* %a.tmp3

  %tmp4 = add i32 %tmp1, %tmp2
  %tmp5 = add i32 %tmp3, %tmp4
  ret i32 %tmp5
}

define i32 @test5(<4 x i32> %x, <4 x i32> %y, <4 x i32>* %z) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_0_8_A_SROA_0_8_Z_TMP1_CAST_SROA_CAST_SROA_IDX:%.*]] = getelementptr inbounds <4 x i32>, <4 x i32>* [[Z:%.*]], i64 0, i64 2
; CHECK-NEXT:    [[A_SROA_0_8_VEC_EXTRACT2:%.*]] = extractelement <4 x i32> [[Y:%.*]], i32 2
; CHECK-NEXT:    store i32 [[A_SROA_0_8_VEC_EXTRACT2]], i32* [[A_SROA_0_8_A_SROA_0_8_Z_TMP1_CAST_SROA_CAST_SROA_IDX]], align 1
; CHECK-NEXT:    [[A_SROA_0_8_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[Y]], i32 2
; CHECK-NEXT:    [[A_SROA_4_12_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[Y]], i32 3
; CHECK-NEXT:    [[A_SROA_4_0_VEC_EXTRACT:%.*]] = extractelement <4 x i32> [[Y]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[A_SROA_0_8_VEC_EXTRACT]], [[A_SROA_4_12_VEC_EXTRACT]]
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[A_SROA_4_0_VEC_EXTRACT]], [[TMP4]]
; CHECK-NEXT:    ret i32 [[TMP5]]
;
; The same as the above, but with reversed source and destination for the
; element memcpy, and a self copy.
entry:
  %a = alloca [2 x <4 x i32>]

  %a.x = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 0
  store <4 x i32> %x, <4 x i32>* %a.x
  %a.y = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1
  store <4 x i32> %y, <4 x i32>* %a.y

  %a.y.cast = bitcast <4 x i32>* %a.y to i8*
  %a.x.cast = bitcast <4 x i32>* %a.x to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %a.x.cast, i8* %a.y.cast, i32 16, i1 false)

  %a.tmp1 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 0, i64 2
  %a.tmp1.cast = bitcast i32* %a.tmp1 to i8*
  %z.tmp1 = getelementptr inbounds <4 x i32>, <4 x i32>* %z, i64 0, i64 2
  %z.tmp1.cast = bitcast i32* %z.tmp1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %z.tmp1.cast, i8* %a.tmp1.cast, i32 4, i1 false)
  %tmp1 = load i32, i32* %a.tmp1
  %a.tmp2 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1, i64 3
  %tmp2 = load i32, i32* %a.tmp2
  %a.tmp3 = getelementptr inbounds [2 x <4 x i32>], [2 x <4 x i32>]* %a, i64 0, i64 1, i64 0
  %tmp3 = load i32, i32* %a.tmp3

  %tmp4 = add i32 %tmp1, %tmp2
  %tmp5 = add i32 %tmp3, %tmp4
  ret i32 %tmp5
}

declare void @llvm.memcpy.p0i8.p0i8.i32(i8* nocapture, i8* nocapture, i32, i1) nounwind
declare void @llvm.memset.p0i8.i32(i8* nocapture, i8, i32, i1) nounwind

define i64 @test6(<4 x i64> %x, <4 x i64> %y, i64 %n) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    [[TMP:%.*]] = alloca { <4 x i64>, <4 x i64> }, align 32
; CHECK-NEXT:    [[P0:%.*]] = getelementptr inbounds { <4 x i64>, <4 x i64> }, { <4 x i64>, <4 x i64> }* [[TMP]], i32 0, i32 0
; CHECK-NEXT:    store <4 x i64> [[X:%.*]], <4 x i64>* [[P0]], align 32
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds { <4 x i64>, <4 x i64> }, { <4 x i64>, <4 x i64> }* [[TMP]], i32 0, i32 1
; CHECK-NEXT:    store <4 x i64> [[Y:%.*]], <4 x i64>* [[P1]], align 32
; CHECK-NEXT:    [[ADDR:%.*]] = getelementptr inbounds { <4 x i64>, <4 x i64> }, { <4 x i64>, <4 x i64> }* [[TMP]], i32 0, i32 0, i64 [[N:%.*]]
; CHECK-NEXT:    [[RES:%.*]] = load i64, i64* [[ADDR]], align 4
; CHECK-NEXT:    ret i64 [[RES]]
;
; The old scalarrepl pass would wrongly drop the store to the second alloca.
; PR13254
  %tmp = alloca { <4 x i64>, <4 x i64> }
  %p0 = getelementptr inbounds { <4 x i64>, <4 x i64> }, { <4 x i64>, <4 x i64> }* %tmp, i32 0, i32 0
  store <4 x i64> %x, <4 x i64>* %p0
  %p1 = getelementptr inbounds { <4 x i64>, <4 x i64> }, { <4 x i64>, <4 x i64> }* %tmp, i32 0, i32 1
  store <4 x i64> %y, <4 x i64>* %p1
  %addr = getelementptr inbounds { <4 x i64>, <4 x i64> }, { <4 x i64>, <4 x i64> }* %tmp, i32 0, i32 0, i64 %n
  %res = load i64, i64* %addr, align 4
  ret i64 %res
}

define <4 x i32> @test_subvec_store() {
; CHECK-LABEL: @test_subvec_store(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_0_VECBLEND:%.*]] = select <4 x i1> <i1 true, i1 true, i1 false, i1 false>, <4 x i32> <i32 0, i32 0, i32 undef, i32 undef>, <4 x i32> undef
; CHECK-NEXT:    [[A_4_VECBLEND:%.*]] = select <4 x i1> <i1 false, i1 true, i1 true, i1 false>, <4 x i32> <i32 undef, i32 1, i32 1, i32 undef>, <4 x i32> [[A_0_VECBLEND]]
; CHECK-NEXT:    [[A_8_VECBLEND:%.*]] = select <4 x i1> <i1 false, i1 false, i1 true, i1 true>, <4 x i32> <i32 undef, i32 undef, i32 2, i32 2>, <4 x i32> [[A_4_VECBLEND]]
; CHECK-NEXT:    [[A_12_VEC_INSERT:%.*]] = insertelement <4 x i32> [[A_8_VECBLEND]], i32 3, i32 3
; CHECK-NEXT:    ret <4 x i32> [[A_12_VEC_INSERT]]
;
entry:
  %a = alloca <4 x i32>

  %a.gep0 = getelementptr <4 x i32>, <4 x i32>* %a, i32 0, i32 0
  %a.cast0 = bitcast i32* %a.gep0 to <2 x i32>*
  store <2 x i32> <i32 0, i32 0>, <2 x i32>* %a.cast0

  %a.gep1 = getelementptr <4 x i32>, <4 x i32>* %a, i32 0, i32 1
  %a.cast1 = bitcast i32* %a.gep1 to <2 x i32>*
  store <2 x i32> <i32 1, i32 1>, <2 x i32>* %a.cast1

  %a.gep2 = getelementptr <4 x i32>, <4 x i32>* %a, i32 0, i32 2
  %a.cast2 = bitcast i32* %a.gep2 to <2 x i32>*
  store <2 x i32> <i32 2, i32 2>, <2 x i32>* %a.cast2

  %a.gep3 = getelementptr <4 x i32>, <4 x i32>* %a, i32 0, i32 3
  store i32 3, i32* %a.gep3

  %ret = load <4 x i32>, <4 x i32>* %a

  ret <4 x i32> %ret
}

define <4 x i32> @test_subvec_load() {
; CHECK-LABEL: @test_subvec_load(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_0_VEC_EXTRACT:%.*]] = shufflevector <4 x i32> <i32 0, i32 1, i32 2, i32 3>, <4 x i32> poison, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[A_4_VEC_EXTRACT:%.*]] = shufflevector <4 x i32> <i32 0, i32 1, i32 2, i32 3>, <4 x i32> poison, <2 x i32> <i32 1, i32 2>
; CHECK-NEXT:    [[A_8_VEC_EXTRACT:%.*]] = shufflevector <4 x i32> <i32 0, i32 1, i32 2, i32 3>, <4 x i32> poison, <2 x i32> <i32 2, i32 3>
; CHECK-NEXT:    [[TMP:%.*]] = shufflevector <2 x i32> [[A_0_VEC_EXTRACT]], <2 x i32> [[A_4_VEC_EXTRACT]], <2 x i32> <i32 0, i32 2>
; CHECK-NEXT:    [[RET:%.*]] = shufflevector <2 x i32> [[TMP]], <2 x i32> [[A_8_VEC_EXTRACT]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    ret <4 x i32> [[RET]]
;
entry:
  %a = alloca <4 x i32>
  store <4 x i32> <i32 0, i32 1, i32 2, i32 3>, <4 x i32>* %a

  %a.gep0 = getelementptr <4 x i32>, <4 x i32>* %a, i32 0, i32 0
  %a.cast0 = bitcast i32* %a.gep0 to <2 x i32>*
  %first = load <2 x i32>, <2 x i32>* %a.cast0

  %a.gep1 = getelementptr <4 x i32>, <4 x i32>* %a, i32 0, i32 1
  %a.cast1 = bitcast i32* %a.gep1 to <2 x i32>*
  %second = load <2 x i32>, <2 x i32>* %a.cast1

  %a.gep2 = getelementptr <4 x i32>, <4 x i32>* %a, i32 0, i32 2
  %a.cast2 = bitcast i32* %a.gep2 to <2 x i32>*
  %third = load <2 x i32>, <2 x i32>* %a.cast2

  %tmp = shufflevector <2 x i32> %first, <2 x i32> %second, <2 x i32> <i32 0, i32 2>
  %ret = shufflevector <2 x i32> %tmp, <2 x i32> %third, <4 x i32> <i32 0, i32 1, i32 2, i32 3>

  ret <4 x i32> %ret
}

declare void @llvm.memset.p0i32.i32(i32* nocapture, i32, i32, i1) nounwind

define <4 x float> @test_subvec_memset() {
; CHECK-LABEL: @test_subvec_memset(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_0_VECBLEND:%.*]] = select <4 x i1> <i1 true, i1 true, i1 false, i1 false>, <4 x float> <float 0.000000e+00, float 0.000000e+00, float undef, float undef>, <4 x float> undef
; CHECK-NEXT:    [[A_4_VECBLEND:%.*]] = select <4 x i1> <i1 false, i1 true, i1 true, i1 false>, <4 x float> <float undef, float 0x3820202020000000, float 0x3820202020000000, float undef>, <4 x float> [[A_0_VECBLEND]]
; CHECK-NEXT:    [[A_8_VECBLEND:%.*]] = select <4 x i1> <i1 false, i1 false, i1 true, i1 true>, <4 x float> <float undef, float undef, float 0x3860606060000000, float 0x3860606060000000>, <4 x float> [[A_4_VECBLEND]]
; CHECK-NEXT:    [[A_12_VEC_INSERT:%.*]] = insertelement <4 x float> [[A_8_VECBLEND]], float 0x38E0E0E0E0000000, i32 3
; CHECK-NEXT:    ret <4 x float> [[A_12_VEC_INSERT]]
;
entry:
  %a = alloca <4 x float>

  %a.gep0 = getelementptr <4 x float>, <4 x float>* %a, i32 0, i32 0
  %a.cast0 = bitcast float* %a.gep0 to i8*
  call void @llvm.memset.p0i8.i32(i8* %a.cast0, i8 0, i32 8, i1 false)

  %a.gep1 = getelementptr <4 x float>, <4 x float>* %a, i32 0, i32 1
  %a.cast1 = bitcast float* %a.gep1 to i8*
  call void @llvm.memset.p0i8.i32(i8* %a.cast1, i8 1, i32 8, i1 false)

  %a.gep2 = getelementptr <4 x float>, <4 x float>* %a, i32 0, i32 2
  %a.cast2 = bitcast float* %a.gep2 to i8*
  call void @llvm.memset.p0i8.i32(i8* %a.cast2, i8 3, i32 8, i1 false)

  %a.gep3 = getelementptr <4 x float>, <4 x float>* %a, i32 0, i32 3
  %a.cast3 = bitcast float* %a.gep3 to i8*
  call void @llvm.memset.p0i8.i32(i8* %a.cast3, i8 7, i32 4, i1 false)

  %ret = load <4 x float>, <4 x float>* %a

  ret <4 x float> %ret
}

define <4 x float> @test_subvec_memcpy(i8* %x, i8* %y, i8* %z, i8* %f, i8* %out) {
; CHECK-LABEL: @test_subvec_memcpy(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_0_X_SROA_CAST:%.*]] = bitcast i8* [[X:%.*]] to <2 x float>*
; CHECK-NEXT:    [[A_0_COPYLOAD:%.*]] = load <2 x float>, <2 x float>* [[A_0_X_SROA_CAST]], align 1
; CHECK-NEXT:    [[A_0_VEC_EXPAND:%.*]] = shufflevector <2 x float> [[A_0_COPYLOAD]], <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
; CHECK-NEXT:    [[A_0_VECBLEND:%.*]] = select <4 x i1> <i1 true, i1 true, i1 false, i1 false>, <4 x float> [[A_0_VEC_EXPAND]], <4 x float> undef
; CHECK-NEXT:    [[A_4_Y_SROA_CAST:%.*]] = bitcast i8* [[Y:%.*]] to <2 x float>*
; CHECK-NEXT:    [[A_4_COPYLOAD:%.*]] = load <2 x float>, <2 x float>* [[A_4_Y_SROA_CAST]], align 1
; CHECK-NEXT:    [[A_4_VEC_EXPAND:%.*]] = shufflevector <2 x float> [[A_4_COPYLOAD]], <2 x float> poison, <4 x i32> <i32 undef, i32 0, i32 1, i32 undef>
; CHECK-NEXT:    [[A_4_VECBLEND:%.*]] = select <4 x i1> <i1 false, i1 true, i1 true, i1 false>, <4 x float> [[A_4_VEC_EXPAND]], <4 x float> [[A_0_VECBLEND]]
; CHECK-NEXT:    [[A_8_Z_SROA_CAST:%.*]] = bitcast i8* [[Z:%.*]] to <2 x float>*
; CHECK-NEXT:    [[A_8_COPYLOAD:%.*]] = load <2 x float>, <2 x float>* [[A_8_Z_SROA_CAST]], align 1
; CHECK-NEXT:    [[A_8_VEC_EXPAND:%.*]] = shufflevector <2 x float> [[A_8_COPYLOAD]], <2 x float> poison, <4 x i32> <i32 undef, i32 undef, i32 0, i32 1>
; CHECK-NEXT:    [[A_8_VECBLEND:%.*]] = select <4 x i1> <i1 false, i1 false, i1 true, i1 true>, <4 x float> [[A_8_VEC_EXPAND]], <4 x float> [[A_4_VECBLEND]]
; CHECK-NEXT:    [[A_12_F_SROA_CAST:%.*]] = bitcast i8* [[F:%.*]] to float*
; CHECK-NEXT:    [[A_12_COPYLOAD:%.*]] = load float, float* [[A_12_F_SROA_CAST]], align 1
; CHECK-NEXT:    [[A_12_VEC_INSERT:%.*]] = insertelement <4 x float> [[A_8_VECBLEND]], float [[A_12_COPYLOAD]], i32 3
; CHECK-NEXT:    [[A_8_OUT_SROA_CAST:%.*]] = bitcast i8* [[OUT:%.*]] to <2 x float>*
; CHECK-NEXT:    [[A_8_VEC_EXTRACT:%.*]] = shufflevector <4 x float> [[A_12_VEC_INSERT]], <4 x float> poison, <2 x i32> <i32 2, i32 3>
; CHECK-NEXT:    store <2 x float> [[A_8_VEC_EXTRACT]], <2 x float>* [[A_8_OUT_SROA_CAST]], align 1
; CHECK-NEXT:    ret <4 x float> [[A_12_VEC_INSERT]]
;
entry:
  %a = alloca <4 x float>

  %a.gep0 = getelementptr <4 x float>, <4 x float>* %a, i32 0, i32 0
  %a.cast0 = bitcast float* %a.gep0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %a.cast0, i8* %x, i32 8, i1 false)

  %a.gep1 = getelementptr <4 x float>, <4 x float>* %a, i32 0, i32 1
  %a.cast1 = bitcast float* %a.gep1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %a.cast1, i8* %y, i32 8, i1 false)

  %a.gep2 = getelementptr <4 x float>, <4 x float>* %a, i32 0, i32 2
  %a.cast2 = bitcast float* %a.gep2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %a.cast2, i8* %z, i32 8, i1 false)

  %a.gep3 = getelementptr <4 x float>, <4 x float>* %a, i32 0, i32 3
  %a.cast3 = bitcast float* %a.gep3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %a.cast3, i8* %f, i32 4, i1 false)

  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %out, i8* %a.cast2, i32 8, i1 false)

  %ret = load <4 x float>, <4 x float>* %a

  ret <4 x float> %ret
}

define i32 @PR14212() {
; CHECK-LABEL: @PR14212(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <3 x i8> undef to i24
; CHECK-NEXT:    [[RETVAL_SROA_2_0_INSERT_EXT:%.*]] = zext i8 undef to i32
; CHECK-NEXT:    [[RETVAL_SROA_2_0_INSERT_SHIFT:%.*]] = shl i32 [[RETVAL_SROA_2_0_INSERT_EXT]], 24
; CHECK-NEXT:    [[RETVAL_SROA_2_0_INSERT_MASK:%.*]] = and i32 undef, 16777215
; CHECK-NEXT:    [[RETVAL_SROA_2_0_INSERT_INSERT:%.*]] = or i32 [[RETVAL_SROA_2_0_INSERT_MASK]], [[RETVAL_SROA_2_0_INSERT_SHIFT]]
; CHECK-NEXT:    [[RETVAL_0_INSERT_EXT:%.*]] = zext i24 [[TMP0]] to i32
; CHECK-NEXT:    [[RETVAL_0_INSERT_MASK:%.*]] = and i32 [[RETVAL_SROA_2_0_INSERT_INSERT]], -16777216
; CHECK-NEXT:    [[RETVAL_0_INSERT_INSERT:%.*]] = or i32 [[RETVAL_0_INSERT_MASK]], [[RETVAL_0_INSERT_EXT]]
; CHECK-NEXT:    ret i32 [[RETVAL_0_INSERT_INSERT]]
;
; This caused a crash when "splitting" the load of the i32 in order to promote
; the store of <3 x i8> properly. Heavily reduced from an OpenCL test case.
entry:
  %retval = alloca <3 x i8>, align 4

  store <3 x i8> undef, <3 x i8>* %retval, align 4
  %cast = bitcast <3 x i8>* %retval to i32*
  %load = load i32, i32* %cast, align 4
  ret i32 %load
}

define <2 x i8> @PR14349.1(i32 %x) {
; CHECK-LABEL: @PR14349.1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_0_0_EXTRACT_TRUNC:%.*]] = trunc i32 [[X:%.*]] to i16
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i16 [[A_SROA_0_0_EXTRACT_TRUNC]] to <2 x i8>
; CHECK-NEXT:    [[A_SROA_2_0_EXTRACT_SHIFT:%.*]] = lshr i32 [[X]], 16
; CHECK-NEXT:    [[A_SROA_2_0_EXTRACT_TRUNC:%.*]] = trunc i32 [[A_SROA_2_0_EXTRACT_SHIFT]] to i16
; CHECK-NEXT:    ret <2 x i8> [[TMP0]]
;
; The first testcase for broken SROA rewriting of split integer loads and
; stores due to smaller vector loads and stores. This particular test ensures
; that we can rewrite a split store of an integer to a store of a vector.
entry:
  %a = alloca i32

  store i32 %x, i32* %a

  %cast = bitcast i32* %a to <2 x i8>*
  %vec = load <2 x i8>, <2 x i8>* %cast

  ret <2 x i8> %vec
}

define i32 @PR14349.2(<2 x i8> %x) {
; CHECK-LABEL: @PR14349.2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <2 x i8> [[X:%.*]] to i16
; CHECK-NEXT:    [[A_SROA_2_0_INSERT_EXT:%.*]] = zext i16 undef to i32
; CHECK-NEXT:    [[A_SROA_2_0_INSERT_SHIFT:%.*]] = shl i32 [[A_SROA_2_0_INSERT_EXT]], 16
; CHECK-NEXT:    [[A_SROA_2_0_INSERT_MASK:%.*]] = and i32 undef, 65535
; CHECK-NEXT:    [[A_SROA_2_0_INSERT_INSERT:%.*]] = or i32 [[A_SROA_2_0_INSERT_MASK]], [[A_SROA_2_0_INSERT_SHIFT]]
; CHECK-NEXT:    [[A_SROA_0_0_INSERT_EXT:%.*]] = zext i16 [[TMP0]] to i32
; CHECK-NEXT:    [[A_SROA_0_0_INSERT_MASK:%.*]] = and i32 [[A_SROA_2_0_INSERT_INSERT]], -65536
; CHECK-NEXT:    [[A_SROA_0_0_INSERT_INSERT:%.*]] = or i32 [[A_SROA_0_0_INSERT_MASK]], [[A_SROA_0_0_INSERT_EXT]]
; CHECK-NEXT:    ret i32 [[A_SROA_0_0_INSERT_INSERT]]
;
; The first testcase for broken SROA rewriting of split integer loads and
; stores due to smaller vector loads and stores. This particular test ensures
; that we can rewrite a split load of an integer to a load of a vector.
entry:
  %a = alloca i32

  %cast = bitcast i32* %a to <2 x i8>*
  store <2 x i8> %x, <2 x i8>* %cast

  %int = load i32, i32* %a

  ret i32 %int
}

define i32 @test7(<2 x i32> %x, <2 x i32> %y) {
; Test that we can promote to vectors when the alloca doesn't mention any vector types.
; CHECK-LABEL: @test7(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_0_4_VEC_EXTRACT:%.*]] = extractelement <2 x i32> [[X:%.*]], i32 1
; CHECK-NEXT:    [[A_SROA_2_12_VEC_EXTRACT:%.*]] = extractelement <2 x i32> [[Y:%.*]], i32 1
; CHECK-NEXT:    [[A_SROA_2_8_VEC_EXTRACT:%.*]] = extractelement <2 x i32> [[Y]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[A_SROA_0_4_VEC_EXTRACT]], [[A_SROA_2_12_VEC_EXTRACT]]
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[A_SROA_2_8_VEC_EXTRACT]], [[TMP4]]
; CHECK-NEXT:    ret i32 [[TMP5]]
;
entry:
  %a = alloca [2 x i64]
  %a.cast = bitcast [2 x i64]* %a to [2 x <2 x i32>]*

  %a.x = getelementptr inbounds [2 x <2 x i32>], [2 x <2 x i32>]* %a.cast, i64 0, i64 0
  store <2 x i32> %x, <2 x i32>* %a.x
  %a.y = getelementptr inbounds [2 x <2 x i32>], [2 x <2 x i32>]* %a.cast, i64 0, i64 1
  store <2 x i32> %y, <2 x i32>* %a.y

  %a.tmp1 = getelementptr inbounds [2 x <2 x i32>], [2 x <2 x i32>]* %a.cast, i64 0, i64 0, i64 1
  %tmp1 = load i32, i32* %a.tmp1
  %a.tmp2 = getelementptr inbounds [2 x <2 x i32>], [2 x <2 x i32>]* %a.cast, i64 0, i64 1, i64 1
  %tmp2 = load i32, i32* %a.tmp2
  %a.tmp3 = getelementptr inbounds [2 x <2 x i32>], [2 x <2 x i32>]* %a.cast, i64 0, i64 1, i64 0
  %tmp3 = load i32, i32* %a.tmp3

  %tmp4 = add i32 %tmp1, %tmp2
  %tmp5 = add i32 %tmp3, %tmp4
  ret i32 %tmp5
}

define i32 @test8(<2 x i32> %x) {
; Ensure that we can promote an alloca that doesn't mention a vector type based
; on a single store with a vector type.
; CHECK-LABEL: @test8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_0_0_VEC_EXTRACT:%.*]] = extractelement <2 x i32> [[X:%.*]], i32 0
; CHECK-NEXT:    [[A_SROA_0_4_VEC_EXTRACT:%.*]] = extractelement <2 x i32> [[X]], i32 1
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[A_SROA_0_0_VEC_EXTRACT]], [[A_SROA_0_4_VEC_EXTRACT]]
; CHECK-NEXT:    ret i32 [[TMP4]]
;
entry:
  %a = alloca i64
  %a.vec = bitcast i64* %a to <2 x i32>*
  %a.i32 = bitcast i64* %a to i32*

  store <2 x i32> %x, <2 x i32>* %a.vec

  %tmp1 = load i32, i32* %a.i32
  %a.tmp2 = getelementptr inbounds i32, i32* %a.i32, i64 1
  %tmp2 = load i32, i32* %a.tmp2

  %tmp4 = add i32 %tmp1, %tmp2
  ret i32 %tmp4
}

define <2 x i32> @test9(i32 %x, i32 %y) {
; Ensure that we can promote an alloca that doesn't mention a vector type based
; on a single load with a vector type.
; CHECK-LABEL: @test9(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_SROA_0_0_VEC_INSERT:%.*]] = insertelement <2 x i32> undef, i32 [[X:%.*]], i32 0
; CHECK-NEXT:    [[A_SROA_0_4_VEC_INSERT:%.*]] = insertelement <2 x i32> [[A_SROA_0_0_VEC_INSERT]], i32 [[Y:%.*]], i32 1
; CHECK-NEXT:    ret <2 x i32> [[A_SROA_0_4_VEC_INSERT]]
;
entry:
  %a = alloca i64
  %a.vec = bitcast i64* %a to <2 x i32>*
  %a.i32 = bitcast i64* %a to i32*

  store i32 %x, i32* %a.i32
  %a.tmp2 = getelementptr inbounds i32, i32* %a.i32, i64 1
  store i32 %y, i32* %a.tmp2

  %result = load <2 x i32>, <2 x i32>* %a.vec

  ret <2 x i32> %result
}

define <2 x i32> @test10(<4 x i16> %x, i32 %y) {
; If there are multiple different vector types used, we should select the one
; with the widest elements.
; CHECK-LABEL: @test10(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <4 x i16> [[X:%.*]] to <2 x i32>
; CHECK-NEXT:    [[A_SROA_0_4_VEC_INSERT:%.*]] = insertelement <2 x i32> [[TMP0]], i32 [[Y:%.*]], i32 1
; CHECK-NEXT:    ret <2 x i32> [[A_SROA_0_4_VEC_INSERT]]
;
entry:
  %a = alloca i64
  %a.vec1 = bitcast i64* %a to <2 x i32>*
  %a.vec2 = bitcast i64* %a to <4 x i16>*
  %a.i32 = bitcast i64* %a to i32*

  store <4 x i16> %x, <4 x i16>* %a.vec2
  %a.tmp2 = getelementptr inbounds i32, i32* %a.i32, i64 1
  store i32 %y, i32* %a.tmp2

  %result = load <2 x i32>, <2 x i32>* %a.vec1

  ret <2 x i32> %result
}

define <2 x float> @test11(<4 x i16> %x, i32 %y) {
; If there are multiple different element types for different vector types,
; pick the integer types. This isn't really important, but seems like the best
; heuristic for making a deterministic decision.
; CHECK-LABEL: @test11(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32 [[Y:%.*]] to <2 x i16>
; CHECK-NEXT:    [[A_SROA_0_4_VEC_EXPAND:%.*]] = shufflevector <2 x i16> [[TMP0]], <2 x i16> poison, <4 x i32> <i32 undef, i32 undef, i32 0, i32 1>
; CHECK-NEXT:    [[A_SROA_0_4_VECBLEND:%.*]] = select <4 x i1> <i1 false, i1 false, i1 true, i1 true>, <4 x i16> [[A_SROA_0_4_VEC_EXPAND]], <4 x i16> [[X:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x i16> [[A_SROA_0_4_VECBLEND]] to <2 x float>
; CHECK-NEXT:    ret <2 x float> [[TMP1]]
;
entry:
  %a = alloca i64
  %a.vec1 = bitcast i64* %a to <2 x float>*
  %a.vec2 = bitcast i64* %a to <4 x i16>*
  %a.i32 = bitcast i64* %a to i32*

  store <4 x i16> %x, <4 x i16>* %a.vec2
  %a.tmp2 = getelementptr inbounds i32, i32* %a.i32, i64 1
  store i32 %y, i32* %a.tmp2

  %result = load <2 x float>, <2 x float>* %a.vec1

  ret <2 x float> %result
}

define <4 x float> @test12() {
; CHECK-LABEL: @test12(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x i32> undef to <4 x float>
; CHECK-NEXT:    ret <4 x float> [[TMP1]]
;
  %a = alloca <3 x i32>, align 16

  %cast1 = bitcast <3 x i32>* %a to <4 x i32>*
  store <4 x i32> undef, <4 x i32>* %cast1, align 16

  %cast2 = bitcast <3 x i32>* %a to <3 x float>*
  %cast3 = bitcast <3 x float>* %cast2 to <4 x float>*
  %vec = load <4 x float>, <4 x float>* %cast3

  ret <4 x float> %vec
}
