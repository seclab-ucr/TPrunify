// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +f -target-feature +d -target-feature +v \
// RUN:   -target-feature +zfh -disable-O0-optnone -fallow-half-arguments-and-returns -emit-llvm %s -o - | opt -S -mem2reg | FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: @test_vnot_v_i8mf8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i8> @llvm.riscv.vxor.nxv1i8.i8.i64(<vscale x 1 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i8> [[TMP0]]
//
vint8mf8_t test_vnot_v_i8mf8 (vint8mf8_t op1, size_t vl) {
  return vnot_v_i8mf8(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i8mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i8> @llvm.riscv.vxor.nxv2i8.i8.i64(<vscale x 2 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i8> [[TMP0]]
//
vint8mf4_t test_vnot_v_i8mf4 (vint8mf4_t op1, size_t vl) {
  return vnot_v_i8mf4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i8mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i8> @llvm.riscv.vxor.nxv4i8.i8.i64(<vscale x 4 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i8> [[TMP0]]
//
vint8mf2_t test_vnot_v_i8mf2 (vint8mf2_t op1, size_t vl) {
  return vnot_v_i8mf2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i8m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.vxor.nxv8i8.i8.i64(<vscale x 8 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_vnot_v_i8m1 (vint8m1_t op1, size_t vl) {
  return vnot_v_i8m1(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i8m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.vxor.nxv16i8.i8.i64(<vscale x 16 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_vnot_v_i8m2 (vint8m2_t op1, size_t vl) {
  return vnot_v_i8m2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i8m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.vxor.nxv32i8.i8.i64(<vscale x 32 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_vnot_v_i8m4 (vint8m4_t op1, size_t vl) {
  return vnot_v_i8m4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i8m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.vxor.nxv64i8.i8.i64(<vscale x 64 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_vnot_v_i8m8 (vint8m8_t op1, size_t vl) {
  return vnot_v_i8m8(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i16mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i16> @llvm.riscv.vxor.nxv1i16.i16.i64(<vscale x 1 x i16> [[OP1:%.*]], i16 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i16> [[TMP0]]
//
vint16mf4_t test_vnot_v_i16mf4 (vint16mf4_t op1, size_t vl) {
  return vnot_v_i16mf4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i16mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i16> @llvm.riscv.vxor.nxv2i16.i16.i64(<vscale x 2 x i16> [[OP1:%.*]], i16 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i16> [[TMP0]]
//
vint16mf2_t test_vnot_v_i16mf2 (vint16mf2_t op1, size_t vl) {
  return vnot_v_i16mf2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i16m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.vxor.nxv4i16.i16.i64(<vscale x 4 x i16> [[OP1:%.*]], i16 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vnot_v_i16m1 (vint16m1_t op1, size_t vl) {
  return vnot_v_i16m1(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i16m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.vxor.nxv8i16.i16.i64(<vscale x 8 x i16> [[OP1:%.*]], i16 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vnot_v_i16m2 (vint16m2_t op1, size_t vl) {
  return vnot_v_i16m2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i16m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.vxor.nxv16i16.i16.i64(<vscale x 16 x i16> [[OP1:%.*]], i16 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vnot_v_i16m4 (vint16m4_t op1, size_t vl) {
  return vnot_v_i16m4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i16m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.vxor.nxv32i16.i16.i64(<vscale x 32 x i16> [[OP1:%.*]], i16 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_vnot_v_i16m8 (vint16m8_t op1, size_t vl) {
  return vnot_v_i16m8(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i32mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vxor.nxv1i32.i32.i64(<vscale x 1 x i32> [[OP1:%.*]], i32 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vint32mf2_t test_vnot_v_i32mf2 (vint32mf2_t op1, size_t vl) {
  return vnot_v_i32mf2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i32m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.vxor.nxv2i32.i32.i64(<vscale x 2 x i32> [[OP1:%.*]], i32 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vnot_v_i32m1 (vint32m1_t op1, size_t vl) {
  return vnot_v_i32m1(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i32m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.vxor.nxv4i32.i32.i64(<vscale x 4 x i32> [[OP1:%.*]], i32 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vnot_v_i32m2 (vint32m2_t op1, size_t vl) {
  return vnot_v_i32m2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i32m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.vxor.nxv8i32.i32.i64(<vscale x 8 x i32> [[OP1:%.*]], i32 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vnot_v_i32m4 (vint32m4_t op1, size_t vl) {
  return vnot_v_i32m4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i32m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.vxor.nxv16i32.i32.i64(<vscale x 16 x i32> [[OP1:%.*]], i32 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_vnot_v_i32m8 (vint32m8_t op1, size_t vl) {
  return vnot_v_i32m8(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i64m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.vxor.nxv1i64.i64.i64(<vscale x 1 x i64> [[OP1:%.*]], i64 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vnot_v_i64m1 (vint64m1_t op1, size_t vl) {
  return vnot_v_i64m1(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i64m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.vxor.nxv2i64.i64.i64(<vscale x 2 x i64> [[OP1:%.*]], i64 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_vnot_v_i64m2 (vint64m2_t op1, size_t vl) {
  return vnot_v_i64m2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i64m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.vxor.nxv4i64.i64.i64(<vscale x 4 x i64> [[OP1:%.*]], i64 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_vnot_v_i64m4 (vint64m4_t op1, size_t vl) {
  return vnot_v_i64m4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i64m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.vxor.nxv8i64.i64.i64(<vscale x 8 x i64> [[OP1:%.*]], i64 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_vnot_v_i64m8 (vint64m8_t op1, size_t vl) {
  return vnot_v_i64m8(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8mf8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i8> @llvm.riscv.vxor.nxv1i8.i8.i64(<vscale x 1 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i8> [[TMP0]]
//
vuint8mf8_t test_vnot_v_u8mf8 (vuint8mf8_t op1, size_t vl) {
  return vnot_v_u8mf8(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i8> @llvm.riscv.vxor.nxv2i8.i8.i64(<vscale x 2 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i8> [[TMP0]]
//
vuint8mf4_t test_vnot_v_u8mf4 (vuint8mf4_t op1, size_t vl) {
  return vnot_v_u8mf4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i8> @llvm.riscv.vxor.nxv4i8.i8.i64(<vscale x 4 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i8> [[TMP0]]
//
vuint8mf2_t test_vnot_v_u8mf2 (vuint8mf2_t op1, size_t vl) {
  return vnot_v_u8mf2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.vxor.nxv8i8.i8.i64(<vscale x 8 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_vnot_v_u8m1 (vuint8m1_t op1, size_t vl) {
  return vnot_v_u8m1(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.vxor.nxv16i8.i8.i64(<vscale x 16 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_vnot_v_u8m2 (vuint8m2_t op1, size_t vl) {
  return vnot_v_u8m2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.vxor.nxv32i8.i8.i64(<vscale x 32 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_vnot_v_u8m4 (vuint8m4_t op1, size_t vl) {
  return vnot_v_u8m4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.vxor.nxv64i8.i8.i64(<vscale x 64 x i8> [[OP1:%.*]], i8 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_vnot_v_u8m8 (vuint8m8_t op1, size_t vl) {
  return vnot_v_u8m8(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u16mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i16> @llvm.riscv.vxor.nxv1i16.i16.i64(<vscale x 1 x i16> [[OP1:%.*]], i16 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i16> [[TMP0]]
//
vuint16mf4_t test_vnot_v_u16mf4 (vuint16mf4_t op1, size_t vl) {
  return vnot_v_u16mf4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u16mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i16> @llvm.riscv.vxor.nxv2i16.i16.i64(<vscale x 2 x i16> [[OP1:%.*]], i16 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i16> [[TMP0]]
//
vuint16mf2_t test_vnot_v_u16mf2 (vuint16mf2_t op1, size_t vl) {
  return vnot_v_u16mf2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u16m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.vxor.nxv4i16.i16.i64(<vscale x 4 x i16> [[OP1:%.*]], i16 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_vnot_v_u16m1 (vuint16m1_t op1, size_t vl) {
  return vnot_v_u16m1(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u16m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.vxor.nxv8i16.i16.i64(<vscale x 8 x i16> [[OP1:%.*]], i16 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vnot_v_u16m2 (vuint16m2_t op1, size_t vl) {
  return vnot_v_u16m2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u16m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.vxor.nxv16i16.i16.i64(<vscale x 16 x i16> [[OP1:%.*]], i16 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vnot_v_u16m4 (vuint16m4_t op1, size_t vl) {
  return vnot_v_u16m4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u16m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.vxor.nxv32i16.i16.i64(<vscale x 32 x i16> [[OP1:%.*]], i16 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_vnot_v_u16m8 (vuint16m8_t op1, size_t vl) {
  return vnot_v_u16m8(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u32mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vxor.nxv1i32.i32.i64(<vscale x 1 x i32> [[OP1:%.*]], i32 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnot_v_u32mf2 (vuint32mf2_t op1, size_t vl) {
  return vnot_v_u32mf2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u32m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.vxor.nxv2i32.i32.i64(<vscale x 2 x i32> [[OP1:%.*]], i32 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_vnot_v_u32m1 (vuint32m1_t op1, size_t vl) {
  return vnot_v_u32m1(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u32m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.vxor.nxv4i32.i32.i64(<vscale x 4 x i32> [[OP1:%.*]], i32 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vnot_v_u32m2 (vuint32m2_t op1, size_t vl) {
  return vnot_v_u32m2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u32m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.vxor.nxv8i32.i32.i64(<vscale x 8 x i32> [[OP1:%.*]], i32 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vnot_v_u32m4 (vuint32m4_t op1, size_t vl) {
  return vnot_v_u32m4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u32m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.vxor.nxv16i32.i32.i64(<vscale x 16 x i32> [[OP1:%.*]], i32 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_vnot_v_u32m8 (vuint32m8_t op1, size_t vl) {
  return vnot_v_u32m8(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u64m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.vxor.nxv1i64.i64.i64(<vscale x 1 x i64> [[OP1:%.*]], i64 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vuint64m1_t test_vnot_v_u64m1 (vuint64m1_t op1, size_t vl) {
  return vnot_v_u64m1(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u64m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.vxor.nxv2i64.i64.i64(<vscale x 2 x i64> [[OP1:%.*]], i64 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_vnot_v_u64m2 (vuint64m2_t op1, size_t vl) {
  return vnot_v_u64m2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u64m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.vxor.nxv4i64.i64.i64(<vscale x 4 x i64> [[OP1:%.*]], i64 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_vnot_v_u64m4 (vuint64m4_t op1, size_t vl) {
  return vnot_v_u64m4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u64m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.vxor.nxv8i64.i64.i64(<vscale x 8 x i64> [[OP1:%.*]], i64 -1, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_vnot_v_u64m8 (vuint64m8_t op1, size_t vl) {
  return vnot_v_u64m8(op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i8mf8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i8> @llvm.riscv.vxor.mask.nxv1i8.i8.i64(<vscale x 1 x i8> [[MASKEDOFF:%.*]], <vscale x 1 x i8> [[OP1:%.*]], i8 -1, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i8> [[TMP0]]
//
vint8mf8_t test_vnot_v_i8mf8_m (vbool64_t mask, vint8mf8_t maskedoff, vint8mf8_t op1, size_t vl) {
  return vnot_v_i8mf8_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i8mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i8> @llvm.riscv.vxor.mask.nxv2i8.i8.i64(<vscale x 2 x i8> [[MASKEDOFF:%.*]], <vscale x 2 x i8> [[OP1:%.*]], i8 -1, <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i8> [[TMP0]]
//
vint8mf4_t test_vnot_v_i8mf4_m (vbool32_t mask, vint8mf4_t maskedoff, vint8mf4_t op1, size_t vl) {
  return vnot_v_i8mf4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i8mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i8> @llvm.riscv.vxor.mask.nxv4i8.i8.i64(<vscale x 4 x i8> [[MASKEDOFF:%.*]], <vscale x 4 x i8> [[OP1:%.*]], i8 -1, <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i8> [[TMP0]]
//
vint8mf2_t test_vnot_v_i8mf2_m (vbool16_t mask, vint8mf2_t maskedoff, vint8mf2_t op1, size_t vl) {
  return vnot_v_i8mf2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i8m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.vxor.mask.nxv8i8.i8.i64(<vscale x 8 x i8> [[MASKEDOFF:%.*]], <vscale x 8 x i8> [[OP1:%.*]], i8 -1, <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_vnot_v_i8m1_m (vbool8_t mask, vint8m1_t maskedoff, vint8m1_t op1, size_t vl) {
  return vnot_v_i8m1_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i8m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.vxor.mask.nxv16i8.i8.i64(<vscale x 16 x i8> [[MASKEDOFF:%.*]], <vscale x 16 x i8> [[OP1:%.*]], i8 -1, <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_vnot_v_i8m2_m (vbool4_t mask, vint8m2_t maskedoff, vint8m2_t op1, size_t vl) {
  return vnot_v_i8m2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i8m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.vxor.mask.nxv32i8.i8.i64(<vscale x 32 x i8> [[MASKEDOFF:%.*]], <vscale x 32 x i8> [[OP1:%.*]], i8 -1, <vscale x 32 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_vnot_v_i8m4_m (vbool2_t mask, vint8m4_t maskedoff, vint8m4_t op1, size_t vl) {
  return vnot_v_i8m4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i8m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.vxor.mask.nxv64i8.i8.i64(<vscale x 64 x i8> [[MASKEDOFF:%.*]], <vscale x 64 x i8> [[OP1:%.*]], i8 -1, <vscale x 64 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_vnot_v_i8m8_m (vbool1_t mask, vint8m8_t maskedoff, vint8m8_t op1, size_t vl) {
  return vnot_v_i8m8_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i16mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i16> @llvm.riscv.vxor.mask.nxv1i16.i16.i64(<vscale x 1 x i16> [[MASKEDOFF:%.*]], <vscale x 1 x i16> [[OP1:%.*]], i16 -1, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i16> [[TMP0]]
//
vint16mf4_t test_vnot_v_i16mf4_m (vbool64_t mask, vint16mf4_t maskedoff, vint16mf4_t op1, size_t vl) {
  return vnot_v_i16mf4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i16mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i16> @llvm.riscv.vxor.mask.nxv2i16.i16.i64(<vscale x 2 x i16> [[MASKEDOFF:%.*]], <vscale x 2 x i16> [[OP1:%.*]], i16 -1, <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i16> [[TMP0]]
//
vint16mf2_t test_vnot_v_i16mf2_m (vbool32_t mask, vint16mf2_t maskedoff, vint16mf2_t op1, size_t vl) {
  return vnot_v_i16mf2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i16m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.vxor.mask.nxv4i16.i16.i64(<vscale x 4 x i16> [[MASKEDOFF:%.*]], <vscale x 4 x i16> [[OP1:%.*]], i16 -1, <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vnot_v_i16m1_m (vbool16_t mask, vint16m1_t maskedoff, vint16m1_t op1, size_t vl) {
  return vnot_v_i16m1_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i16m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.vxor.mask.nxv8i16.i16.i64(<vscale x 8 x i16> [[MASKEDOFF:%.*]], <vscale x 8 x i16> [[OP1:%.*]], i16 -1, <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vnot_v_i16m2_m (vbool8_t mask, vint16m2_t maskedoff, vint16m2_t op1, size_t vl) {
  return vnot_v_i16m2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i16m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.vxor.mask.nxv16i16.i16.i64(<vscale x 16 x i16> [[MASKEDOFF:%.*]], <vscale x 16 x i16> [[OP1:%.*]], i16 -1, <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vnot_v_i16m4_m (vbool4_t mask, vint16m4_t maskedoff, vint16m4_t op1, size_t vl) {
  return vnot_v_i16m4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i16m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.vxor.mask.nxv32i16.i16.i64(<vscale x 32 x i16> [[MASKEDOFF:%.*]], <vscale x 32 x i16> [[OP1:%.*]], i16 -1, <vscale x 32 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_vnot_v_i16m8_m (vbool2_t mask, vint16m8_t maskedoff, vint16m8_t op1, size_t vl) {
  return vnot_v_i16m8_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i32mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vxor.mask.nxv1i32.i32.i64(<vscale x 1 x i32> [[MASKEDOFF:%.*]], <vscale x 1 x i32> [[OP1:%.*]], i32 -1, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vint32mf2_t test_vnot_v_i32mf2_m (vbool64_t mask, vint32mf2_t maskedoff, vint32mf2_t op1, size_t vl) {
  return vnot_v_i32mf2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i32m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.vxor.mask.nxv2i32.i32.i64(<vscale x 2 x i32> [[MASKEDOFF:%.*]], <vscale x 2 x i32> [[OP1:%.*]], i32 -1, <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vnot_v_i32m1_m (vbool32_t mask, vint32m1_t maskedoff, vint32m1_t op1, size_t vl) {
  return vnot_v_i32m1_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i32m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.vxor.mask.nxv4i32.i32.i64(<vscale x 4 x i32> [[MASKEDOFF:%.*]], <vscale x 4 x i32> [[OP1:%.*]], i32 -1, <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vnot_v_i32m2_m (vbool16_t mask, vint32m2_t maskedoff, vint32m2_t op1, size_t vl) {
  return vnot_v_i32m2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i32m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.vxor.mask.nxv8i32.i32.i64(<vscale x 8 x i32> [[MASKEDOFF:%.*]], <vscale x 8 x i32> [[OP1:%.*]], i32 -1, <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vnot_v_i32m4_m (vbool8_t mask, vint32m4_t maskedoff, vint32m4_t op1, size_t vl) {
  return vnot_v_i32m4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i32m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.vxor.mask.nxv16i32.i32.i64(<vscale x 16 x i32> [[MASKEDOFF:%.*]], <vscale x 16 x i32> [[OP1:%.*]], i32 -1, <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_vnot_v_i32m8_m (vbool4_t mask, vint32m8_t maskedoff, vint32m8_t op1, size_t vl) {
  return vnot_v_i32m8_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i64m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.vxor.mask.nxv1i64.i64.i64(<vscale x 1 x i64> [[MASKEDOFF:%.*]], <vscale x 1 x i64> [[OP1:%.*]], i64 -1, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vnot_v_i64m1_m (vbool64_t mask, vint64m1_t maskedoff, vint64m1_t op1, size_t vl) {
  return vnot_v_i64m1_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i64m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.vxor.mask.nxv2i64.i64.i64(<vscale x 2 x i64> [[MASKEDOFF:%.*]], <vscale x 2 x i64> [[OP1:%.*]], i64 -1, <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_vnot_v_i64m2_m (vbool32_t mask, vint64m2_t maskedoff, vint64m2_t op1, size_t vl) {
  return vnot_v_i64m2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i64m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.vxor.mask.nxv4i64.i64.i64(<vscale x 4 x i64> [[MASKEDOFF:%.*]], <vscale x 4 x i64> [[OP1:%.*]], i64 -1, <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_vnot_v_i64m4_m (vbool16_t mask, vint64m4_t maskedoff, vint64m4_t op1, size_t vl) {
  return vnot_v_i64m4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_i64m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.vxor.mask.nxv8i64.i64.i64(<vscale x 8 x i64> [[MASKEDOFF:%.*]], <vscale x 8 x i64> [[OP1:%.*]], i64 -1, <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_vnot_v_i64m8_m (vbool8_t mask, vint64m8_t maskedoff, vint64m8_t op1, size_t vl) {
  return vnot_v_i64m8_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8mf8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i8> @llvm.riscv.vxor.mask.nxv1i8.i8.i64(<vscale x 1 x i8> [[MASKEDOFF:%.*]], <vscale x 1 x i8> [[OP1:%.*]], i8 -1, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i8> [[TMP0]]
//
vuint8mf8_t test_vnot_v_u8mf8_m (vbool64_t mask, vuint8mf8_t maskedoff, vuint8mf8_t op1, size_t vl) {
  return vnot_v_u8mf8_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i8> @llvm.riscv.vxor.mask.nxv2i8.i8.i64(<vscale x 2 x i8> [[MASKEDOFF:%.*]], <vscale x 2 x i8> [[OP1:%.*]], i8 -1, <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i8> [[TMP0]]
//
vuint8mf4_t test_vnot_v_u8mf4_m (vbool32_t mask, vuint8mf4_t maskedoff, vuint8mf4_t op1, size_t vl) {
  return vnot_v_u8mf4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i8> @llvm.riscv.vxor.mask.nxv4i8.i8.i64(<vscale x 4 x i8> [[MASKEDOFF:%.*]], <vscale x 4 x i8> [[OP1:%.*]], i8 -1, <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i8> [[TMP0]]
//
vuint8mf2_t test_vnot_v_u8mf2_m (vbool16_t mask, vuint8mf2_t maskedoff, vuint8mf2_t op1, size_t vl) {
  return vnot_v_u8mf2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.vxor.mask.nxv8i8.i8.i64(<vscale x 8 x i8> [[MASKEDOFF:%.*]], <vscale x 8 x i8> [[OP1:%.*]], i8 -1, <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_vnot_v_u8m1_m (vbool8_t mask, vuint8m1_t maskedoff, vuint8m1_t op1, size_t vl) {
  return vnot_v_u8m1_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.vxor.mask.nxv16i8.i8.i64(<vscale x 16 x i8> [[MASKEDOFF:%.*]], <vscale x 16 x i8> [[OP1:%.*]], i8 -1, <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_vnot_v_u8m2_m (vbool4_t mask, vuint8m2_t maskedoff, vuint8m2_t op1, size_t vl) {
  return vnot_v_u8m2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.vxor.mask.nxv32i8.i8.i64(<vscale x 32 x i8> [[MASKEDOFF:%.*]], <vscale x 32 x i8> [[OP1:%.*]], i8 -1, <vscale x 32 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_vnot_v_u8m4_m (vbool2_t mask, vuint8m4_t maskedoff, vuint8m4_t op1, size_t vl) {
  return vnot_v_u8m4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u8m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.vxor.mask.nxv64i8.i8.i64(<vscale x 64 x i8> [[MASKEDOFF:%.*]], <vscale x 64 x i8> [[OP1:%.*]], i8 -1, <vscale x 64 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_vnot_v_u8m8_m (vbool1_t mask, vuint8m8_t maskedoff, vuint8m8_t op1, size_t vl) {
  return vnot_v_u8m8_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u16mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i16> @llvm.riscv.vxor.mask.nxv1i16.i16.i64(<vscale x 1 x i16> [[MASKEDOFF:%.*]], <vscale x 1 x i16> [[OP1:%.*]], i16 -1, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i16> [[TMP0]]
//
vuint16mf4_t test_vnot_v_u16mf4_m (vbool64_t mask, vuint16mf4_t maskedoff, vuint16mf4_t op1, size_t vl) {
  return vnot_v_u16mf4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u16mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i16> @llvm.riscv.vxor.mask.nxv2i16.i16.i64(<vscale x 2 x i16> [[MASKEDOFF:%.*]], <vscale x 2 x i16> [[OP1:%.*]], i16 -1, <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i16> [[TMP0]]
//
vuint16mf2_t test_vnot_v_u16mf2_m (vbool32_t mask, vuint16mf2_t maskedoff, vuint16mf2_t op1, size_t vl) {
  return vnot_v_u16mf2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u16m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.vxor.mask.nxv4i16.i16.i64(<vscale x 4 x i16> [[MASKEDOFF:%.*]], <vscale x 4 x i16> [[OP1:%.*]], i16 -1, <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_vnot_v_u16m1_m (vbool16_t mask, vuint16m1_t maskedoff, vuint16m1_t op1, size_t vl) {
  return vnot_v_u16m1_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u16m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.vxor.mask.nxv8i16.i16.i64(<vscale x 8 x i16> [[MASKEDOFF:%.*]], <vscale x 8 x i16> [[OP1:%.*]], i16 -1, <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vnot_v_u16m2_m (vbool8_t mask, vuint16m2_t maskedoff, vuint16m2_t op1, size_t vl) {
  return vnot_v_u16m2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u16m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.vxor.mask.nxv16i16.i16.i64(<vscale x 16 x i16> [[MASKEDOFF:%.*]], <vscale x 16 x i16> [[OP1:%.*]], i16 -1, <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vnot_v_u16m4_m (vbool4_t mask, vuint16m4_t maskedoff, vuint16m4_t op1, size_t vl) {
  return vnot_v_u16m4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u16m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.vxor.mask.nxv32i16.i16.i64(<vscale x 32 x i16> [[MASKEDOFF:%.*]], <vscale x 32 x i16> [[OP1:%.*]], i16 -1, <vscale x 32 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_vnot_v_u16m8_m (vbool2_t mask, vuint16m8_t maskedoff, vuint16m8_t op1, size_t vl) {
  return vnot_v_u16m8_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u32mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vxor.mask.nxv1i32.i32.i64(<vscale x 1 x i32> [[MASKEDOFF:%.*]], <vscale x 1 x i32> [[OP1:%.*]], i32 -1, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnot_v_u32mf2_m (vbool64_t mask, vuint32mf2_t maskedoff, vuint32mf2_t op1, size_t vl) {
  return vnot_v_u32mf2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u32m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.vxor.mask.nxv2i32.i32.i64(<vscale x 2 x i32> [[MASKEDOFF:%.*]], <vscale x 2 x i32> [[OP1:%.*]], i32 -1, <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_vnot_v_u32m1_m (vbool32_t mask, vuint32m1_t maskedoff, vuint32m1_t op1, size_t vl) {
  return vnot_v_u32m1_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u32m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.vxor.mask.nxv4i32.i32.i64(<vscale x 4 x i32> [[MASKEDOFF:%.*]], <vscale x 4 x i32> [[OP1:%.*]], i32 -1, <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vnot_v_u32m2_m (vbool16_t mask, vuint32m2_t maskedoff, vuint32m2_t op1, size_t vl) {
  return vnot_v_u32m2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u32m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.vxor.mask.nxv8i32.i32.i64(<vscale x 8 x i32> [[MASKEDOFF:%.*]], <vscale x 8 x i32> [[OP1:%.*]], i32 -1, <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vnot_v_u32m4_m (vbool8_t mask, vuint32m4_t maskedoff, vuint32m4_t op1, size_t vl) {
  return vnot_v_u32m4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u32m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.vxor.mask.nxv16i32.i32.i64(<vscale x 16 x i32> [[MASKEDOFF:%.*]], <vscale x 16 x i32> [[OP1:%.*]], i32 -1, <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_vnot_v_u32m8_m (vbool4_t mask, vuint32m8_t maskedoff, vuint32m8_t op1, size_t vl) {
  return vnot_v_u32m8_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u64m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.vxor.mask.nxv1i64.i64.i64(<vscale x 1 x i64> [[MASKEDOFF:%.*]], <vscale x 1 x i64> [[OP1:%.*]], i64 -1, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vuint64m1_t test_vnot_v_u64m1_m (vbool64_t mask, vuint64m1_t maskedoff, vuint64m1_t op1, size_t vl) {
  return vnot_v_u64m1_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u64m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.vxor.mask.nxv2i64.i64.i64(<vscale x 2 x i64> [[MASKEDOFF:%.*]], <vscale x 2 x i64> [[OP1:%.*]], i64 -1, <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_vnot_v_u64m2_m (vbool32_t mask, vuint64m2_t maskedoff, vuint64m2_t op1, size_t vl) {
  return vnot_v_u64m2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u64m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.vxor.mask.nxv4i64.i64.i64(<vscale x 4 x i64> [[MASKEDOFF:%.*]], <vscale x 4 x i64> [[OP1:%.*]], i64 -1, <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_vnot_v_u64m4_m (vbool16_t mask, vuint64m4_t maskedoff, vuint64m4_t op1, size_t vl) {
  return vnot_v_u64m4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vnot_v_u64m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.vxor.mask.nxv8i64.i64.i64(<vscale x 8 x i64> [[MASKEDOFF:%.*]], <vscale x 8 x i64> [[OP1:%.*]], i64 -1, <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_vnot_v_u64m8_m (vbool8_t mask, vuint64m8_t maskedoff, vuint64m8_t op1, size_t vl) {
  return vnot_v_u64m8_m(mask, maskedoff, op1, vl);
}
