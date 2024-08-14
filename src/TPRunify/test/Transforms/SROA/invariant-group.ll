; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=sroa -S -o - < %s | FileCheck %s

%t = type { i32, i32 }

declare i8* @llvm.launder.invariant.group.p0i8(i8* %a)
declare i8* @llvm.strip.invariant.group.p0i8(i8* %a)
declare void @h(i32 %a)
declare i32 @somevalue()

define void @f() {
; CHECK-LABEL: @f(
; CHECK-NEXT:    [[SV1:%.*]] = call i32 @somevalue()
; CHECK-NEXT:    [[SV2:%.*]] = call i32 @somevalue()
; CHECK-NEXT:    call void @h(i32 [[SV1]])
; CHECK-NEXT:    call void @h(i32 [[SV2]])
; CHECK-NEXT:    ret void
;
  %a = alloca %t

  %a1 = getelementptr inbounds %t, %t* %a, i32 0, i32 0
  %a1_i8 = bitcast i32* %a1 to i8*
  %a1_i8_inv = call i8* @llvm.launder.invariant.group.p0i8(i8* %a1_i8)
  %a1_inv = bitcast i8* %a1_i8_inv to i32*
  %a2 = getelementptr inbounds %t, %t* %a, i32 0, i32 1

  %sv1 = call i32 @somevalue()
  %sv2 = call i32 @somevalue()

  store i32 %sv1, i32* %a1_inv, !invariant.group !0
  store i32 %sv2, i32* %a2

  %v1 = load i32, i32* %a1_inv, !invariant.group !0
  %v2 = load i32, i32* %a2

  call void @h(i32 %v1)
  call void @h(i32 %v2)

  ret void
}

define void @g() {
; CHECK-LABEL: @g(
; CHECK-NEXT:    [[A:%.*]] = alloca [[T:%.*]], align 8
; CHECK-NEXT:    [[A1:%.*]] = getelementptr inbounds [[T]], %t* [[A]], i32 0, i32 0
; CHECK-NEXT:    [[A1_I8:%.*]] = bitcast i32* [[A1]] to i8*
; CHECK-NEXT:    [[A1_I8_INV:%.*]] = call i8* @llvm.launder.invariant.group.p0i8(i8* [[A1_I8]])
; CHECK-NEXT:    [[A1_INV:%.*]] = bitcast i8* [[A1_I8_INV]] to i32*
; CHECK-NEXT:    [[A2:%.*]] = getelementptr inbounds [[T]], %t* [[A]], i32 0, i32 1
; CHECK-NEXT:    [[SV1:%.*]] = call i32 @somevalue()
; CHECK-NEXT:    [[SV2:%.*]] = call i32 @somevalue()
; CHECK-NEXT:    store i32 [[SV1]], i32* [[A1_INV]], align 4, !invariant.group !0
; CHECK-NEXT:    store i32 [[SV2]], i32* [[A2]], align 4
; CHECK-NEXT:    [[V1:%.*]] = load i32, i32* [[A1_INV]], align 4, !invariant.group !0
; CHECK-NEXT:    [[V2:%.*]] = load i32, i32* [[A2]], align 4
; CHECK-NEXT:    call void @h(i32 [[V1]])
; CHECK-NEXT:    call void @h(i32 [[V2]])
; CHECK-NEXT:    [[A1_STRIPPED:%.*]] = call i8* @llvm.strip.invariant.group.p0i8(i8* [[A1_I8]])
; CHECK-NEXT:    [[A1_INT:%.*]] = ptrtoint i8* [[A1_STRIPPED]] to i32
; CHECK-NEXT:    call void @h(i32 [[A1_INT]])
; CHECK-NEXT:    ret void
;
  %a = alloca %t

  %a1 = getelementptr inbounds %t, %t* %a, i32 0, i32 0
  %a1_i8 = bitcast i32* %a1 to i8*
  %a1_i8_inv = call i8* @llvm.launder.invariant.group.p0i8(i8* %a1_i8)
  %a1_inv = bitcast i8* %a1_i8_inv to i32*
  %a2 = getelementptr inbounds %t, %t* %a, i32 0, i32 1

  %sv1 = call i32 @somevalue()
  %sv2 = call i32 @somevalue()

  store i32 %sv1, i32* %a1_inv, !invariant.group !0
  store i32 %sv2, i32* %a2

  %v1 = load i32, i32* %a1_inv, !invariant.group !0
  %v2 = load i32, i32* %a2

  call void @h(i32 %v1)
  call void @h(i32 %v2)

  %a1_stripped = call i8* @llvm.strip.invariant.group.p0i8(i8* %a1_i8)
  %a1_int = ptrtoint i8* %a1_stripped to i32
  call void @h(i32 %a1_int)

  ret void
}

!0 = !{}
