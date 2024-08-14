// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -o /dev/null %s
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svlsr_u8_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.sel.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> zeroinitializer)
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.nxv16i8(<vscale x 16 x i1> [[PG]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z15test_svlsr_u8_zu10__SVBool_tu11__SVUint8_tu11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.sel.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> zeroinitializer)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.nxv16i8(<vscale x 16 x i1> [[PG]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
svuint8_t test_svlsr_u8_z(svbool_t pg, svuint8_t op1, svuint8_t op2)
{
  return SVE_ACLE_FUNC(svlsr,_u8,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_u16_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.sel.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> zeroinitializer)
// CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z16test_svlsr_u16_zu10__SVBool_tu12__SVUint16_tu12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.sel.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> zeroinitializer)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
svuint16_t test_svlsr_u16_z(svbool_t pg, svuint16_t op1, svuint16_t op2)
{
  return SVE_ACLE_FUNC(svlsr,_u16,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_u32_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.sel.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> zeroinitializer)
// CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[TMP1]], <vscale x 4 x i32> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z16test_svlsr_u32_zu10__SVBool_tu12__SVUint32_tu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.sel.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> zeroinitializer)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[TMP1]], <vscale x 4 x i32> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svlsr_u32_z(svbool_t pg, svuint32_t op1, svuint32_t op2)
{
  return SVE_ACLE_FUNC(svlsr,_u32,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_u64_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.sel.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> zeroinitializer)
// CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.lsr.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[TMP1]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z16test_svlsr_u64_zu10__SVBool_tu12__SVUint64_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.sel.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> zeroinitializer)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.lsr.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[TMP1]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svuint64_t test_svlsr_u64_z(svbool_t pg, svuint64_t op1, svuint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr,_u64,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_u8_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svlsr_u8_mu10__SVBool_tu11__SVUint8_tu11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svlsr_u8_m(svbool_t pg, svuint8_t op1, svuint8_t op2)
{
  return SVE_ACLE_FUNC(svlsr,_u8,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_u16_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svlsr_u16_mu10__SVBool_tu12__SVUint16_tu12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svlsr_u16_m(svbool_t pg, svuint16_t op1, svuint16_t op2)
{
  return SVE_ACLE_FUNC(svlsr,_u16,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_u32_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svlsr_u32_mu10__SVBool_tu12__SVUint32_tu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svuint32_t test_svlsr_u32_m(svbool_t pg, svuint32_t op1, svuint32_t op2)
{
  return SVE_ACLE_FUNC(svlsr,_u32,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_u64_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.lsr.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svlsr_u64_mu10__SVBool_tu12__SVUint64_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.lsr.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
svuint64_t test_svlsr_u64_m(svbool_t pg, svuint64_t op1, svuint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr,_u64,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_u8_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svlsr_u8_xu10__SVBool_tu11__SVUint8_tu11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svlsr_u8_x(svbool_t pg, svuint8_t op1, svuint8_t op2)
{
  return SVE_ACLE_FUNC(svlsr,_u8,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_u16_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svlsr_u16_xu10__SVBool_tu12__SVUint16_tu12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svlsr_u16_x(svbool_t pg, svuint16_t op1, svuint16_t op2)
{
  return SVE_ACLE_FUNC(svlsr,_u16,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_u32_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svlsr_u32_xu10__SVBool_tu12__SVUint32_tu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svuint32_t test_svlsr_u32_x(svbool_t pg, svuint32_t op1, svuint32_t op2)
{
  return SVE_ACLE_FUNC(svlsr,_u32,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_u64_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.lsr.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svlsr_u64_xu10__SVBool_tu12__SVUint64_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 2 x i64> @llvm.aarch64.sve.lsr.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
svuint64_t test_svlsr_u64_x(svbool_t pg, svuint64_t op1, svuint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr,_u64,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_u8_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.sel.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> zeroinitializer)
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<vscale x 16 x i1> [[PG]], <vscale x 16 x i8> [[TMP0]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z20test_svlsr_wide_u8_zu10__SVBool_tu11__SVUint8_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.sel.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> zeroinitializer)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<vscale x 16 x i1> [[PG]], <vscale x 16 x i8> [[TMP0]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
svuint8_t test_svlsr_wide_u8_z(svbool_t pg, svuint8_t op1, svuint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_u8,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_u16_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.sel.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> zeroinitializer)
// CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z21test_svlsr_wide_u16_zu10__SVBool_tu12__SVUint16_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.sel.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> zeroinitializer)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
svuint16_t test_svlsr_wide_u16_z(svbool_t pg, svuint16_t op1, svuint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_u16,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_u32_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.sel.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> zeroinitializer)
// CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[TMP1]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z21test_svlsr_wide_u32_zu10__SVBool_tu12__SVUint32_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.sel.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> zeroinitializer)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[TMP1]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svlsr_wide_u32_z(svbool_t pg, svuint32_t op1, svuint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_u32,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_u8_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z20test_svlsr_wide_u8_mu10__SVBool_tu11__SVUint8_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svlsr_wide_u8_m(svbool_t pg, svuint8_t op1, svuint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_u8,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_u16_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z21test_svlsr_wide_u16_mu10__SVBool_tu12__SVUint16_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svlsr_wide_u16_m(svbool_t pg, svuint16_t op1, svuint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_u16,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_u32_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z21test_svlsr_wide_u32_mu10__SVBool_tu12__SVUint32_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svuint32_t test_svlsr_wide_u32_m(svbool_t pg, svuint32_t op1, svuint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_u32,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_u8_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z20test_svlsr_wide_u8_xu10__SVBool_tu11__SVUint8_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svlsr_wide_u8_x(svbool_t pg, svuint8_t op1, svuint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_u8,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_u16_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z21test_svlsr_wide_u16_xu10__SVBool_tu12__SVUint16_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svlsr_wide_u16_x(svbool_t pg, svuint16_t op1, svuint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_u16,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_u32_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z21test_svlsr_wide_u32_xu10__SVBool_tu12__SVUint32_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svuint32_t test_svlsr_wide_u32_x(svbool_t pg, svuint32_t op1, svuint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_u32,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_n_u8_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 2 x i64> [[TMP0]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svlsr_wide_n_u8_mu10__SVBool_tu11__SVUint8_tm(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 2 x i64> [[TMP0]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
svuint8_t test_svlsr_wide_n_u8_m(svbool_t pg, svuint8_t op1, uint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_n_u8,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_n_u16_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 2 x i64> [[TMP1]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z23test_svlsr_wide_n_u16_mu10__SVBool_tu12__SVUint16_tm(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 2 x i64> [[TMP1]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
svuint16_t test_svlsr_wide_n_u16_m(svbool_t pg, svuint16_t op1, uint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_n_u16,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_n_u32_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 2 x i64> [[TMP1]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z23test_svlsr_wide_n_u32_mu10__SVBool_tu12__SVUint32_tm(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 2 x i64> [[TMP1]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svlsr_wide_n_u32_m(svbool_t pg, svuint32_t op1, uint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_n_u32,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_n_u8_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.sel.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> zeroinitializer)
// CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<vscale x 16 x i1> [[PG]], <vscale x 16 x i8> [[TMP1]], <vscale x 2 x i64> [[TMP0]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z22test_svlsr_wide_n_u8_zu10__SVBool_tu11__SVUint8_tm(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.sel.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> zeroinitializer)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<vscale x 16 x i1> [[PG]], <vscale x 16 x i8> [[TMP1]], <vscale x 2 x i64> [[TMP0]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP2]]
//
svuint8_t test_svlsr_wide_n_u8_z(svbool_t pg, svuint8_t op1, uint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_n_u8,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_n_u16_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.sel.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> zeroinitializer)
// CHECK-NEXT:    [[TMP3:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[TMP2]], <vscale x 2 x i64> [[TMP1]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z23test_svlsr_wide_n_u16_zu10__SVBool_tu12__SVUint16_tm(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.sel.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> zeroinitializer)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[TMP2]], <vscale x 2 x i64> [[TMP1]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP3]]
//
svuint16_t test_svlsr_wide_n_u16_z(svbool_t pg, svuint16_t op1, uint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_n_u16,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_n_u32_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.sel.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> zeroinitializer)
// CHECK-NEXT:    [[TMP3:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[TMP2]], <vscale x 2 x i64> [[TMP1]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z23test_svlsr_wide_n_u32_zu10__SVBool_tu12__SVUint32_tm(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.sel.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> zeroinitializer)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[TMP2]], <vscale x 2 x i64> [[TMP1]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP3]]
//
svuint32_t test_svlsr_wide_n_u32_z(svbool_t pg, svuint32_t op1, uint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_n_u32,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_n_u8_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 2 x i64> [[TMP0]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z22test_svlsr_wide_n_u8_xu10__SVBool_tu11__SVUint8_tm(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 2 x i64> [[TMP0]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
svuint8_t test_svlsr_wide_n_u8_x(svbool_t pg, svuint8_t op1, uint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_n_u8,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_n_u16_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 2 x i64> [[TMP1]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z23test_svlsr_wide_n_u16_xu10__SVBool_tu12__SVUint16_tm(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 2 x i64> [[TMP1]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
svuint16_t test_svlsr_wide_n_u16_x(svbool_t pg, svuint16_t op1, uint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_n_u16,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svlsr_wide_n_u32_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 2 x i64> [[TMP1]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z23test_svlsr_wide_n_u32_xu10__SVBool_tu12__SVUint32_tm(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 2 x i64> [[TMP1]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svlsr_wide_n_u32_x(svbool_t pg, svuint32_t op1, uint64_t op2)
{
  return SVE_ACLE_FUNC(svlsr_wide,_n_u32,_x,)(pg, op1, op2);
}
