// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +f -target-feature +d \
// RUN:   -target-feature +v -target-feature +zfh \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | opt -S -mem2reg | FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: @test_vundefined_i8mf8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 1 x i8> undef
//
vint8mf8_t test_vundefined_i8mf8() { return vundefined_i8mf8(); }

// CHECK-RV64-LABEL: @test_vundefined_i8mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 2 x i8> undef
//
vint8mf4_t test_vundefined_i8mf4() { return vundefined_i8mf4(); }

// CHECK-RV64-LABEL: @test_vundefined_i8mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 4 x i8> undef
//
vint8mf2_t test_vundefined_i8mf2() { return vundefined_i8mf2(); }

// CHECK-RV64-LABEL: @test_vundefined_i8m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> undef
//
vint8m1_t test_vundefined_i8m1() { return vundefined_i8m1(); }

// CHECK-RV64-LABEL: @test_vundefined_i8m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> undef
//
vint8m2_t test_vundefined_i8m2() { return vundefined_i8m2(); }

// CHECK-RV64-LABEL: @test_vundefined_i8m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> undef
//
vint8m4_t test_vundefined_i8m4() { return vundefined_i8m4(); }

// CHECK-RV64-LABEL: @test_vundefined_i8m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> undef
//
vint8m8_t test_vundefined_i8m8() { return vundefined_i8m8(); }

// CHECK-RV64-LABEL: @test_vundefined_i16mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 1 x i16> undef
//
vint16mf4_t test_vundefined_i16mf4() { return vundefined_i16mf4(); }

// CHECK-RV64-LABEL: @test_vundefined_i16mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 2 x i16> undef
//
vint16mf2_t test_vundefined_i16mf2() { return vundefined_i16mf2(); }

// CHECK-RV64-LABEL: @test_vundefined_i16m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> undef
//
vint16m1_t test_vundefined_i16m1() { return vundefined_i16m1(); }

// CHECK-RV64-LABEL: @test_vundefined_i16m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> undef
//
vint16m2_t test_vundefined_i16m2() { return vundefined_i16m2(); }

// CHECK-RV64-LABEL: @test_vundefined_i16m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> undef
//
vint16m4_t test_vundefined_i16m4() { return vundefined_i16m4(); }

// CHECK-RV64-LABEL: @test_vundefined_i16m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> undef
//
vint16m8_t test_vundefined_i16m8() { return vundefined_i16m8(); }

// CHECK-RV64-LABEL: @test_vundefined_i32mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> undef
//
vint32mf2_t test_vundefined_i32mf2() { return vundefined_i32mf2(); }

// CHECK-RV64-LABEL: @test_vundefined_i32m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> undef
//
vint32m1_t test_vundefined_i32m1() { return vundefined_i32m1(); }

// CHECK-RV64-LABEL: @test_vundefined_i32m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> undef
//
vint32m2_t test_vundefined_i32m2() { return vundefined_i32m2(); }

// CHECK-RV64-LABEL: @test_vundefined_i32m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> undef
//
vint32m4_t test_vundefined_i32m4() { return vundefined_i32m4(); }

// CHECK-RV64-LABEL: @test_vundefined_i32m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> undef
//
vint32m8_t test_vundefined_i32m8() { return vundefined_i32m8(); }

// CHECK-RV64-LABEL: @test_vundefined_i64m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> undef
//
vint64m1_t test_vundefined_i64m1() { return vundefined_i64m1(); }

// CHECK-RV64-LABEL: @test_vundefined_i64m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> undef
//
vint64m2_t test_vundefined_i64m2() { return vundefined_i64m2(); }

// CHECK-RV64-LABEL: @test_vundefined_i64m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> undef
//
vint64m4_t test_vundefined_i64m4() { return vundefined_i64m4(); }

// CHECK-RV64-LABEL: @test_vundefined_i64m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> undef
//
vint64m8_t test_vundefined_i64m8() { return vundefined_i64m8(); }

// CHECK-RV64-LABEL: @test_vundefined_u8mf8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 1 x i8> undef
//
vuint8mf8_t test_vundefined_u8mf8() { return vundefined_u8mf8(); }

// CHECK-RV64-LABEL: @test_vundefined_u8mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 2 x i8> undef
//
vuint8mf4_t test_vundefined_u8mf4() { return vundefined_u8mf4(); }

// CHECK-RV64-LABEL: @test_vundefined_u8mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 4 x i8> undef
//
vuint8mf2_t test_vundefined_u8mf2() { return vundefined_u8mf2(); }

// CHECK-RV64-LABEL: @test_vundefined_u8m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> undef
//
vuint8m1_t test_vundefined_u8m1() { return vundefined_u8m1(); }

// CHECK-RV64-LABEL: @test_vundefined_u8m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> undef
//
vuint8m2_t test_vundefined_u8m2() { return vundefined_u8m2(); }

// CHECK-RV64-LABEL: @test_vundefined_u8m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> undef
//
vuint8m4_t test_vundefined_u8m4() { return vundefined_u8m4(); }

// CHECK-RV64-LABEL: @test_vundefined_u8m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> undef
//
vuint8m8_t test_vundefined_u8m8() { return vundefined_u8m8(); }

// CHECK-RV64-LABEL: @test_vundefined_u16mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 1 x i16> undef
//
vuint16mf4_t test_vundefined_u16mf4() { return vundefined_u16mf4(); }

// CHECK-RV64-LABEL: @test_vundefined_u16mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 2 x i16> undef
//
vuint16mf2_t test_vundefined_u16mf2() { return vundefined_u16mf2(); }

// CHECK-RV64-LABEL: @test_vundefined_u16m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> undef
//
vuint16m1_t test_vundefined_u16m1() { return vundefined_u16m1(); }

// CHECK-RV64-LABEL: @test_vundefined_u16m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> undef
//
vuint16m2_t test_vundefined_u16m2() { return vundefined_u16m2(); }

// CHECK-RV64-LABEL: @test_vundefined_u16m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> undef
//
vuint16m4_t test_vundefined_u16m4() { return vundefined_u16m4(); }

// CHECK-RV64-LABEL: @test_vundefined_u16m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> undef
//
vuint16m8_t test_vundefined_u16m8() { return vundefined_u16m8(); }

// CHECK-RV64-LABEL: @test_vundefined_u32mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> undef
//
vuint32mf2_t test_vundefined_u32mf2() { return vundefined_u32mf2(); }

// CHECK-RV64-LABEL: @test_vundefined_u32m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> undef
//
vuint32m1_t test_vundefined_u32m1() { return vundefined_u32m1(); }

// CHECK-RV64-LABEL: @test_vundefined_u32m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> undef
//
vuint32m2_t test_vundefined_u32m2() { return vundefined_u32m2(); }

// CHECK-RV64-LABEL: @test_vundefined_u32m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> undef
//
vuint32m4_t test_vundefined_u32m4() { return vundefined_u32m4(); }

// CHECK-RV64-LABEL: @test_vundefined_u32m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> undef
//
vuint32m8_t test_vundefined_u32m8() { return vundefined_u32m8(); }

// CHECK-RV64-LABEL: @test_vundefined_u64m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> undef
//
vuint64m1_t test_vundefined_u64m1() { return vundefined_u64m1(); }

// CHECK-RV64-LABEL: @test_vundefined_u64m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> undef
//
vuint64m2_t test_vundefined_u64m2() { return vundefined_u64m2(); }

// CHECK-RV64-LABEL: @test_vundefined_u64m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> undef
//
vuint64m4_t test_vundefined_u64m4() { return vundefined_u64m4(); }

// CHECK-RV64-LABEL: @test_vundefined_u64m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> undef
//
vuint64m8_t test_vundefined_u64m8() { return vundefined_u64m8(); }

// CHECK-RV64-LABEL: @test_vundefined_f32mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 1 x float> undef
//
vfloat32mf2_t test_vundefined_f32mf2() { return vundefined_f32mf2(); }

// CHECK-RV64-LABEL: @test_vundefined_f32m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 2 x float> undef
//
vfloat32m1_t test_vundefined_f32m1() { return vundefined_f32m1(); }

// CHECK-RV64-LABEL: @test_vundefined_f32m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 4 x float> undef
//
vfloat32m2_t test_vundefined_f32m2() { return vundefined_f32m2(); }

// CHECK-RV64-LABEL: @test_vundefined_f32m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 8 x float> undef
//
vfloat32m4_t test_vundefined_f32m4() { return vundefined_f32m4(); }

// CHECK-RV64-LABEL: @test_vundefined_f32m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 16 x float> undef
//
vfloat32m8_t test_vundefined_f32m8() { return vundefined_f32m8(); }

// CHECK-RV64-LABEL: @test_vundefined_f64m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 1 x double> undef
//
vfloat64m1_t test_vundefined_f64m1() { return vundefined_f64m1(); }

// CHECK-RV64-LABEL: @test_vundefined_f64m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 2 x double> undef
//
vfloat64m2_t test_vundefined_f64m2() { return vundefined_f64m2(); }

// CHECK-RV64-LABEL: @test_vundefined_f64m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 4 x double> undef
//
vfloat64m4_t test_vundefined_f64m4() { return vundefined_f64m4(); }

// CHECK-RV64-LABEL: @test_vundefined_f64m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 8 x double> undef
//
vfloat64m8_t test_vundefined_f64m8() { return vundefined_f64m8(); }

// CHECK-RV64-LABEL: @test_vundefined_f16mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 1 x half> undef
//
vfloat16mf4_t test_vundefined_f16mf4 () {
  return vundefined_f16mf4();
}

// CHECK-RV64-LABEL: @test_vundefined_f16mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 2 x half> undef
//
vfloat16mf2_t test_vundefined_f16mf2 () {
  return vundefined_f16mf2();
}

// CHECK-RV64-LABEL: @test_vundefined_f16m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 4 x half> undef
//
vfloat16m1_t test_vundefined_f16m1 () {
  return vundefined_f16m1();
}

// CHECK-RV64-LABEL: @test_vundefined_f16m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 8 x half> undef
//
vfloat16m2_t test_vundefined_f16m2 () {
  return vundefined_f16m2();
}

// CHECK-RV64-LABEL: @test_vundefined_f16m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 16 x half> undef
//
vfloat16m4_t test_vundefined_f16m4 () {
  return vundefined_f16m4();
}

// CHECK-RV64-LABEL: @test_vundefined_f16m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    ret <vscale x 32 x half> undef
//
vfloat16m8_t test_vundefined_f16m8 () {
  return vundefined_f16m8();
}
