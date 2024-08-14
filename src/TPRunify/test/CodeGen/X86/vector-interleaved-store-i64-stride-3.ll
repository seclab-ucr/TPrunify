; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=+sse2 | FileCheck %s --check-prefixes=SSE
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx  | FileCheck %s --check-prefixes=AVX1
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2 | FileCheck %s --check-prefixes=AVX2
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX2
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX2
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512bw,+avx512vl | FileCheck %s --check-prefixes=AVX512

; These patterns are produced by LoopVectorizer for interleaved stores.

define void @store_i64_stride3_vf2(<2 x i64>* %in.vecptr0, <2 x i64>* %in.vecptr1, <2 x i64>* %in.vecptr2, <6 x i64>* %out.vec) nounwind {
; SSE-LABEL: store_i64_stride3_vf2:
; SSE:       # %bb.0:
; SSE-NEXT:    movapd (%rdi), %xmm0
; SSE-NEXT:    movapd (%rsi), %xmm1
; SSE-NEXT:    movapd (%rdx), %xmm2
; SSE-NEXT:    movapd %xmm0, %xmm3
; SSE-NEXT:    unpcklpd {{.*#+}} xmm3 = xmm3[0],xmm1[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm2[1]
; SSE-NEXT:    movsd {{.*#+}} xmm0 = xmm2[0],xmm0[1]
; SSE-NEXT:    movapd %xmm0, 16(%rcx)
; SSE-NEXT:    movapd %xmm1, 32(%rcx)
; SSE-NEXT:    movapd %xmm3, (%rcx)
; SSE-NEXT:    retq
;
; AVX1-LABEL: store_i64_stride3_vf2:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovaps (%rdi), %xmm0
; AVX1-NEXT:    vmovaps (%rsi), %xmm1
; AVX1-NEXT:    vmovaps (%rdx), %xmm2
; AVX1-NEXT:    vinsertf128 $1, %xmm0, %ymm1, %ymm3
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; AVX1-NEXT:    vshufpd {{.*#+}} ymm0 = ymm0[0],ymm3[0],ymm0[2],ymm3[3]
; AVX1-NEXT:    vunpckhpd {{.*#+}} xmm1 = xmm1[1],xmm2[1]
; AVX1-NEXT:    vmovaps %xmm1, 32(%rcx)
; AVX1-NEXT:    vmovapd %ymm0, (%rcx)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: store_i64_stride3_vf2:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovaps (%rdi), %xmm0
; AVX2-NEXT:    vmovaps (%rsi), %xmm1
; AVX2-NEXT:    vmovaps (%rdx), %xmm2
; AVX2-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX2-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm3
; AVX2-NEXT:    vpermpd {{.*#+}} ymm0 = ymm0[0,2,2,1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm0 = ymm0[0,1,2,3],ymm3[4,5],ymm0[6,7]
; AVX2-NEXT:    vunpckhpd {{.*#+}} xmm1 = xmm1[1],xmm2[1]
; AVX2-NEXT:    vmovaps %xmm1, 32(%rcx)
; AVX2-NEXT:    vmovaps %ymm0, (%rcx)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: store_i64_stride3_vf2:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovaps (%rdi), %xmm0
; AVX512-NEXT:    vmovaps (%rdx), %xmm1
; AVX512-NEXT:    vinsertf128 $1, (%rsi), %ymm0, %ymm0
; AVX512-NEXT:    vinsertf64x4 $1, %ymm1, %zmm0, %zmm0
; AVX512-NEXT:    vmovaps {{.*#+}} zmm1 = <0,2,4,1,3,5,u,u>
; AVX512-NEXT:    vpermpd %zmm0, %zmm1, %zmm0
; AVX512-NEXT:    vextractf32x4 $2, %zmm0, 32(%rcx)
; AVX512-NEXT:    vmovaps %ymm0, (%rcx)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %in.vec0 = load <2 x i64>, <2 x i64>* %in.vecptr0, align 32
  %in.vec1 = load <2 x i64>, <2 x i64>* %in.vecptr1, align 32
  %in.vec2 = load <2 x i64>, <2 x i64>* %in.vecptr2, align 32

  %concat01 = shufflevector <2 x i64> %in.vec0, <2 x i64> %in.vec1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %concat2u = shufflevector <2 x i64> %in.vec2, <2 x i64> poison, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %concat012 = shufflevector <4 x i64> %concat01, <4 x i64> %concat2u, <6 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>
  %interleaved.vec = shufflevector <6 x i64> %concat012, <6 x i64> poison, <6 x i32> <i32 0, i32 2, i32 4, i32 1, i32 3, i32 5>

  store <6 x i64> %interleaved.vec, <6 x i64>* %out.vec, align 32

  ret void
}

define void @store_i64_stride3_vf4(<4 x i64>* %in.vecptr0, <4 x i64>* %in.vecptr1, <4 x i64>* %in.vecptr2, <12 x i64>* %out.vec) nounwind {
; SSE-LABEL: store_i64_stride3_vf4:
; SSE:       # %bb.0:
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    movaps 16(%rdi), %xmm1
; SSE-NEXT:    movaps (%rsi), %xmm2
; SSE-NEXT:    movaps 16(%rsi), %xmm3
; SSE-NEXT:    movaps (%rdx), %xmm4
; SSE-NEXT:    movaps 16(%rdx), %xmm5
; SSE-NEXT:    movaps %xmm3, %xmm6
; SSE-NEXT:    unpckhpd {{.*#+}} xmm6 = xmm6[1],xmm5[1]
; SSE-NEXT:    shufps {{.*#+}} xmm5 = xmm5[0,1],xmm1[2,3]
; SSE-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm3[0]
; SSE-NEXT:    movaps %xmm2, %xmm3
; SSE-NEXT:    unpckhpd {{.*#+}} xmm3 = xmm3[1],xmm4[1]
; SSE-NEXT:    shufps {{.*#+}} xmm4 = xmm4[0,1],xmm0[2,3]
; SSE-NEXT:    movlhps {{.*#+}} xmm0 = xmm0[0],xmm2[0]
; SSE-NEXT:    movaps %xmm0, (%rcx)
; SSE-NEXT:    movaps %xmm4, 16(%rcx)
; SSE-NEXT:    movaps %xmm3, 32(%rcx)
; SSE-NEXT:    movaps %xmm1, 48(%rcx)
; SSE-NEXT:    movaps %xmm5, 64(%rcx)
; SSE-NEXT:    movaps %xmm6, 80(%rcx)
; SSE-NEXT:    retq
;
; AVX1-LABEL: store_i64_stride3_vf4:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovapd (%rdi), %ymm0
; AVX1-NEXT:    vmovapd (%rdx), %ymm1
; AVX1-NEXT:    vinsertf128 $1, (%rdx), %ymm0, %ymm2
; AVX1-NEXT:    vmovaps (%rdi), %xmm3
; AVX1-NEXT:    vunpcklpd {{.*#+}} xmm4 = xmm3[0],mem[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm3, %ymm4, %ymm3
; AVX1-NEXT:    vblendps {{.*#+}} ymm2 = ymm3[0,1,2,3],ymm2[4,5],ymm3[6,7]
; AVX1-NEXT:    vmovapd 16(%rdx), %xmm3
; AVX1-NEXT:    vperm2f128 {{.*#+}} ymm4 = ymm0[2,3],ymm1[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm3 = ymm3[0],ymm4[1,2,3]
; AVX1-NEXT:    vbroadcastsd 24(%rsi), %ymm4
; AVX1-NEXT:    vblendpd {{.*#+}} ymm3 = ymm3[0,1],ymm4[2],ymm3[3]
; AVX1-NEXT:    vpermilpd {{.*#+}} ymm4 = mem[1,0,2,2]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm1 = ymm4[0],ymm1[1],ymm4[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm0 = ymm1[0,1],ymm0[2],ymm1[3]
; AVX1-NEXT:    vmovapd %ymm0, 32(%rcx)
; AVX1-NEXT:    vmovapd %ymm3, 64(%rcx)
; AVX1-NEXT:    vmovaps %ymm2, (%rcx)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: store_i64_stride3_vf4:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovaps (%rdi), %ymm0
; AVX2-NEXT:    vmovaps (%rdx), %ymm1
; AVX2-NEXT:    vperm2f128 {{.*#+}} ymm2 = ymm0[2,3],ymm1[2,3]
; AVX2-NEXT:    vmovaps 16(%rdx), %xmm3
; AVX2-NEXT:    vblendps {{.*#+}} ymm2 = ymm3[0,1],ymm2[2,3],ymm3[4,5],ymm2[6,7]
; AVX2-NEXT:    vbroadcastsd 24(%rsi), %ymm3
; AVX2-NEXT:    vblendps {{.*#+}} ymm2 = ymm2[0,1,2,3],ymm3[4,5],ymm2[6,7]
; AVX2-NEXT:    vinsertf128 $1, (%rdx), %ymm0, %ymm3
; AVX2-NEXT:    vmovddup {{.*#+}} xmm4 = mem[0,0]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm5 = ymm0[0,1,2,1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm4 = ymm5[0,1],ymm4[2,3],ymm5[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm3 = ymm4[0,1,2,3],ymm3[4,5],ymm4[6,7]
; AVX2-NEXT:    vpermilps {{.*#+}} ymm4 = mem[2,3,0,1,6,7,4,5]
; AVX2-NEXT:    vblendps {{.*#+}} ymm1 = ymm4[0,1],ymm1[2,3],ymm4[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm0 = ymm1[0,1,2,3],ymm0[4,5],ymm1[6,7]
; AVX2-NEXT:    vmovaps %ymm0, 32(%rcx)
; AVX2-NEXT:    vmovaps %ymm3, (%rcx)
; AVX2-NEXT:    vmovaps %ymm2, 64(%rcx)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: store_i64_stride3_vf4:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512-NEXT:    vmovdqa (%rdx), %ymm1
; AVX512-NEXT:    vinserti64x4 $1, (%rsi), %zmm0, %zmm0
; AVX512-NEXT:    vmovdqa {{.*#+}} ymm2 = [2,11,15,3]
; AVX512-NEXT:    vpermi2q %zmm0, %zmm1, %zmm2
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm3 = [0,4,8,1,5,9,2,6]
; AVX512-NEXT:    vpermi2q %zmm1, %zmm0, %zmm3
; AVX512-NEXT:    vmovdqu64 %zmm3, (%rcx)
; AVX512-NEXT:    vmovdqa %ymm2, 64(%rcx)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %in.vec0 = load <4 x i64>, <4 x i64>* %in.vecptr0, align 32
  %in.vec1 = load <4 x i64>, <4 x i64>* %in.vecptr1, align 32
  %in.vec2 = load <4 x i64>, <4 x i64>* %in.vecptr2, align 32

  %concat01 = shufflevector <4 x i64> %in.vec0, <4 x i64> %in.vec1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %concat2u = shufflevector <4 x i64> %in.vec2, <4 x i64> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
  %concat012 = shufflevector <8 x i64> %concat01, <8 x i64> %concat2u, <12 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11>
  %interleaved.vec = shufflevector <12 x i64> %concat012, <12 x i64> poison, <12 x i32> <i32 0, i32 4, i32 8, i32 1, i32 5, i32 9, i32 2, i32 6, i32 10, i32 3, i32 7, i32 11>

  store <12 x i64> %interleaved.vec, <12 x i64>* %out.vec, align 32

  ret void
}

define void @store_i64_stride3_vf8(<8 x i64>* %in.vecptr0, <8 x i64>* %in.vecptr1, <8 x i64>* %in.vecptr2, <24 x i64>* %out.vec) nounwind {
; SSE-LABEL: store_i64_stride3_vf8:
; SSE:       # %bb.0:
; SSE-NEXT:    movaps (%rdi), %xmm3
; SSE-NEXT:    movaps 16(%rdi), %xmm2
; SSE-NEXT:    movaps 32(%rdi), %xmm13
; SSE-NEXT:    movaps 48(%rdi), %xmm12
; SSE-NEXT:    movaps (%rsi), %xmm8
; SSE-NEXT:    movaps 16(%rsi), %xmm9
; SSE-NEXT:    movaps 32(%rsi), %xmm11
; SSE-NEXT:    movaps 48(%rsi), %xmm4
; SSE-NEXT:    movaps (%rdx), %xmm7
; SSE-NEXT:    movaps 16(%rdx), %xmm0
; SSE-NEXT:    movaps 32(%rdx), %xmm6
; SSE-NEXT:    movaps 48(%rdx), %xmm5
; SSE-NEXT:    movaps %xmm4, %xmm10
; SSE-NEXT:    unpckhpd {{.*#+}} xmm10 = xmm10[1],xmm5[1]
; SSE-NEXT:    shufps {{.*#+}} xmm5 = xmm5[0,1],xmm12[2,3]
; SSE-NEXT:    movlhps {{.*#+}} xmm12 = xmm12[0],xmm4[0]
; SSE-NEXT:    movaps %xmm11, %xmm14
; SSE-NEXT:    unpckhpd {{.*#+}} xmm14 = xmm14[1],xmm6[1]
; SSE-NEXT:    shufps {{.*#+}} xmm6 = xmm6[0,1],xmm13[2,3]
; SSE-NEXT:    movlhps {{.*#+}} xmm13 = xmm13[0],xmm11[0]
; SSE-NEXT:    movaps %xmm9, %xmm1
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE-NEXT:    shufps {{.*#+}} xmm0 = xmm0[0,1],xmm2[2,3]
; SSE-NEXT:    movlhps {{.*#+}} xmm2 = xmm2[0],xmm9[0]
; SSE-NEXT:    movaps %xmm8, %xmm4
; SSE-NEXT:    unpckhpd {{.*#+}} xmm4 = xmm4[1],xmm7[1]
; SSE-NEXT:    shufps {{.*#+}} xmm7 = xmm7[0,1],xmm3[2,3]
; SSE-NEXT:    movlhps {{.*#+}} xmm3 = xmm3[0],xmm8[0]
; SSE-NEXT:    movaps %xmm3, (%rcx)
; SSE-NEXT:    movaps %xmm7, 16(%rcx)
; SSE-NEXT:    movaps %xmm4, 32(%rcx)
; SSE-NEXT:    movaps %xmm2, 48(%rcx)
; SSE-NEXT:    movaps %xmm0, 64(%rcx)
; SSE-NEXT:    movaps %xmm1, 80(%rcx)
; SSE-NEXT:    movaps %xmm13, 96(%rcx)
; SSE-NEXT:    movaps %xmm6, 112(%rcx)
; SSE-NEXT:    movaps %xmm14, 128(%rcx)
; SSE-NEXT:    movaps %xmm12, 144(%rcx)
; SSE-NEXT:    movaps %xmm5, 160(%rcx)
; SSE-NEXT:    movaps %xmm10, 176(%rcx)
; SSE-NEXT:    retq
;
; AVX1-LABEL: store_i64_stride3_vf8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovapd 32(%rdi), %ymm0
; AVX1-NEXT:    vmovapd (%rdi), %ymm1
; AVX1-NEXT:    vmovapd 32(%rdx), %ymm2
; AVX1-NEXT:    vmovapd (%rdx), %ymm3
; AVX1-NEXT:    vinsertf128 $1, 32(%rdx), %ymm0, %ymm4
; AVX1-NEXT:    vmovaps (%rdi), %xmm5
; AVX1-NEXT:    vmovaps 32(%rdi), %xmm6
; AVX1-NEXT:    vunpcklpd {{.*#+}} xmm7 = xmm6[0],mem[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm6, %ymm7, %ymm6
; AVX1-NEXT:    vblendps {{.*#+}} ymm4 = ymm6[0,1,2,3],ymm4[4,5],ymm6[6,7]
; AVX1-NEXT:    vinsertf128 $1, (%rdx), %ymm0, %ymm6
; AVX1-NEXT:    vunpcklpd {{.*#+}} xmm7 = xmm5[0],mem[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm5, %ymm7, %ymm5
; AVX1-NEXT:    vblendps {{.*#+}} ymm5 = ymm5[0,1,2,3],ymm6[4,5],ymm5[6,7]
; AVX1-NEXT:    vmovapd 16(%rdx), %xmm6
; AVX1-NEXT:    vperm2f128 {{.*#+}} ymm7 = ymm1[2,3],ymm3[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm6 = ymm6[0],ymm7[1,2,3]
; AVX1-NEXT:    vbroadcastsd 24(%rsi), %ymm7
; AVX1-NEXT:    vblendpd {{.*#+}} ymm6 = ymm6[0,1],ymm7[2],ymm6[3]
; AVX1-NEXT:    vmovapd 48(%rdx), %xmm7
; AVX1-NEXT:    vperm2f128 {{.*#+}} ymm8 = ymm0[2,3],ymm2[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm7 = ymm7[0],ymm8[1,2,3]
; AVX1-NEXT:    vbroadcastsd 56(%rsi), %ymm8
; AVX1-NEXT:    vblendpd {{.*#+}} ymm7 = ymm7[0,1],ymm8[2],ymm7[3]
; AVX1-NEXT:    vpermilpd {{.*#+}} ymm8 = mem[1,0,2,2]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm2 = ymm8[0],ymm2[1],ymm8[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm0 = ymm2[0,1],ymm0[2],ymm2[3]
; AVX1-NEXT:    vpermilpd {{.*#+}} ymm2 = mem[1,0,2,2]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm2 = ymm2[0],ymm3[1],ymm2[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm1 = ymm2[0,1],ymm1[2],ymm2[3]
; AVX1-NEXT:    vmovapd %ymm1, 32(%rcx)
; AVX1-NEXT:    vmovapd %ymm0, 128(%rcx)
; AVX1-NEXT:    vmovapd %ymm7, 160(%rcx)
; AVX1-NEXT:    vmovapd %ymm6, 64(%rcx)
; AVX1-NEXT:    vmovaps %ymm5, (%rcx)
; AVX1-NEXT:    vmovaps %ymm4, 96(%rcx)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: store_i64_stride3_vf8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovaps (%rdi), %ymm0
; AVX2-NEXT:    vmovaps 32(%rdi), %ymm1
; AVX2-NEXT:    vmovaps 32(%rdx), %ymm2
; AVX2-NEXT:    vmovaps (%rdx), %ymm3
; AVX2-NEXT:    vperm2f128 {{.*#+}} ymm4 = ymm0[2,3],ymm3[2,3]
; AVX2-NEXT:    vmovaps 16(%rdx), %xmm5
; AVX2-NEXT:    vblendps {{.*#+}} ymm4 = ymm5[0,1],ymm4[2,3],ymm5[4,5],ymm4[6,7]
; AVX2-NEXT:    vbroadcastsd 24(%rsi), %ymm5
; AVX2-NEXT:    vblendps {{.*#+}} ymm4 = ymm4[0,1,2,3],ymm5[4,5],ymm4[6,7]
; AVX2-NEXT:    vinsertf128 $1, 32(%rdx), %ymm0, %ymm5
; AVX2-NEXT:    vmovddup {{.*#+}} xmm6 = mem[0,0]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm7 = ymm1[0,1,2,1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm6 = ymm7[0,1],ymm6[2,3],ymm7[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm5 = ymm6[0,1,2,3],ymm5[4,5],ymm6[6,7]
; AVX2-NEXT:    vperm2f128 {{.*#+}} ymm6 = ymm1[2,3],ymm2[2,3]
; AVX2-NEXT:    vmovaps 48(%rdx), %xmm7
; AVX2-NEXT:    vblendps {{.*#+}} ymm6 = ymm7[0,1],ymm6[2,3],ymm7[4,5],ymm6[6,7]
; AVX2-NEXT:    vbroadcastsd 56(%rsi), %ymm7
; AVX2-NEXT:    vblendps {{.*#+}} ymm6 = ymm6[0,1,2,3],ymm7[4,5],ymm6[6,7]
; AVX2-NEXT:    vinsertf128 $1, (%rdx), %ymm0, %ymm7
; AVX2-NEXT:    vmovddup {{.*#+}} xmm8 = mem[0,0]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm9 = ymm0[0,1,2,1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm8 = ymm9[0,1],ymm8[2,3],ymm9[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm7 = ymm8[0,1,2,3],ymm7[4,5],ymm8[6,7]
; AVX2-NEXT:    vpermilps {{.*#+}} ymm8 = mem[2,3,0,1,6,7,4,5]
; AVX2-NEXT:    vblendps {{.*#+}} ymm2 = ymm8[0,1],ymm2[2,3],ymm8[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm1 = ymm2[0,1,2,3],ymm1[4,5],ymm2[6,7]
; AVX2-NEXT:    vpermilps {{.*#+}} ymm2 = mem[2,3,0,1,6,7,4,5]
; AVX2-NEXT:    vblendps {{.*#+}} ymm2 = ymm2[0,1],ymm3[2,3],ymm2[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm0 = ymm2[0,1,2,3],ymm0[4,5],ymm2[6,7]
; AVX2-NEXT:    vmovaps %ymm0, 32(%rcx)
; AVX2-NEXT:    vmovaps %ymm1, 128(%rcx)
; AVX2-NEXT:    vmovaps %ymm7, (%rcx)
; AVX2-NEXT:    vmovaps %ymm6, 160(%rcx)
; AVX2-NEXT:    vmovaps %ymm5, 96(%rcx)
; AVX2-NEXT:    vmovaps %ymm4, 64(%rcx)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: store_i64_stride3_vf8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovdqu64 (%rdi), %zmm0
; AVX512-NEXT:    vmovdqu64 (%rsi), %zmm1
; AVX512-NEXT:    vmovdqu64 (%rdx), %zmm2
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm3 = <0,8,u,1,9,u,2,10>
; AVX512-NEXT:    vpermi2q %zmm1, %zmm0, %zmm3
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm4 = [0,1,8,3,4,9,6,7]
; AVX512-NEXT:    vpermi2q %zmm2, %zmm3, %zmm4
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm3 = <2,11,u,3,12,u,4,13>
; AVX512-NEXT:    vpermi2q %zmm0, %zmm2, %zmm3
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm5 = [0,1,11,3,4,12,6,7]
; AVX512-NEXT:    vpermi2q %zmm1, %zmm3, %zmm5
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm3 = <5,13,u,6,14,u,7,15>
; AVX512-NEXT:    vpermi2q %zmm2, %zmm1, %zmm3
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm1 = [0,1,14,3,4,15,6,7]
; AVX512-NEXT:    vpermi2q %zmm0, %zmm3, %zmm1
; AVX512-NEXT:    vmovdqu64 %zmm1, 128(%rcx)
; AVX512-NEXT:    vmovdqu64 %zmm5, 64(%rcx)
; AVX512-NEXT:    vmovdqu64 %zmm4, (%rcx)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %in.vec0 = load <8 x i64>, <8 x i64>* %in.vecptr0, align 32
  %in.vec1 = load <8 x i64>, <8 x i64>* %in.vecptr1, align 32
  %in.vec2 = load <8 x i64>, <8 x i64>* %in.vecptr2, align 32

  %concat01 = shufflevector <8 x i64> %in.vec0, <8 x i64> %in.vec1, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %concat2u = shufflevector <8 x i64> %in.vec2, <8 x i64> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %concat012 = shufflevector <16 x i64> %concat01, <16 x i64> %concat2u, <24 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
  %interleaved.vec = shufflevector <24 x i64> %concat012, <24 x i64> poison, <24 x i32> <i32 0, i32 8, i32 16, i32 1, i32 9, i32 17, i32 2, i32 10, i32 18, i32 3, i32 11, i32 19, i32 4, i32 12, i32 20, i32 5, i32 13, i32 21, i32 6, i32 14, i32 22, i32 7, i32 15, i32 23>

  store <24 x i64> %interleaved.vec, <24 x i64>* %out.vec, align 32

  ret void
}

define void @store_i64_stride3_vf16(<16 x i64>* %in.vecptr0, <16 x i64>* %in.vecptr1, <16 x i64>* %in.vecptr2, <48 x i64>* %out.vec) nounwind {
; SSE-LABEL: store_i64_stride3_vf16:
; SSE:       # %bb.0:
; SSE-NEXT:    subq $24, %rsp
; SSE-NEXT:    movapd 64(%rdi), %xmm9
; SSE-NEXT:    movapd (%rdi), %xmm3
; SSE-NEXT:    movapd 16(%rdi), %xmm13
; SSE-NEXT:    movapd 32(%rdi), %xmm8
; SSE-NEXT:    movapd 48(%rdi), %xmm10
; SSE-NEXT:    movapd 64(%rsi), %xmm12
; SSE-NEXT:    movapd (%rsi), %xmm7
; SSE-NEXT:    movapd 16(%rsi), %xmm14
; SSE-NEXT:    movapd 32(%rsi), %xmm15
; SSE-NEXT:    movapd 48(%rsi), %xmm11
; SSE-NEXT:    movapd 64(%rdx), %xmm6
; SSE-NEXT:    movapd (%rdx), %xmm2
; SSE-NEXT:    movapd 16(%rdx), %xmm4
; SSE-NEXT:    movapd 32(%rdx), %xmm5
; SSE-NEXT:    movapd 48(%rdx), %xmm0
; SSE-NEXT:    movapd %xmm3, %xmm1
; SSE-NEXT:    unpcklpd {{.*#+}} xmm1 = xmm1[0],xmm7[0]
; SSE-NEXT:    movapd %xmm1, (%rsp) # 16-byte Spill
; SSE-NEXT:    movsd {{.*#+}} xmm3 = xmm2[0],xmm3[1]
; SSE-NEXT:    movapd %xmm3, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    unpckhpd {{.*#+}} xmm7 = xmm7[1],xmm2[1]
; SSE-NEXT:    movapd %xmm7, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movapd %xmm13, %xmm3
; SSE-NEXT:    unpcklpd {{.*#+}} xmm3 = xmm3[0],xmm14[0]
; SSE-NEXT:    movapd %xmm3, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movsd {{.*#+}} xmm13 = xmm4[0],xmm13[1]
; SSE-NEXT:    movapd %xmm13, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    unpckhpd {{.*#+}} xmm14 = xmm14[1],xmm4[1]
; SSE-NEXT:    movapd %xmm14, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movapd %xmm8, %xmm13
; SSE-NEXT:    unpcklpd {{.*#+}} xmm13 = xmm13[0],xmm15[0]
; SSE-NEXT:    movsd {{.*#+}} xmm8 = xmm5[0],xmm8[1]
; SSE-NEXT:    movapd %xmm8, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    unpckhpd {{.*#+}} xmm15 = xmm15[1],xmm5[1]
; SSE-NEXT:    movapd %xmm10, %xmm1
; SSE-NEXT:    unpcklpd {{.*#+}} xmm10 = xmm10[0],xmm11[0]
; SSE-NEXT:    movsd {{.*#+}} xmm1 = xmm0[0],xmm1[1]
; SSE-NEXT:    movapd %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    unpckhpd {{.*#+}} xmm11 = xmm11[1],xmm0[1]
; SSE-NEXT:    movapd %xmm9, %xmm14
; SSE-NEXT:    unpcklpd {{.*#+}} xmm14 = xmm14[0],xmm12[0]
; SSE-NEXT:    movsd {{.*#+}} xmm9 = xmm6[0],xmm9[1]
; SSE-NEXT:    movapd %xmm9, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    unpckhpd {{.*#+}} xmm12 = xmm12[1],xmm6[1]
; SSE-NEXT:    movapd 80(%rdi), %xmm8
; SSE-NEXT:    movapd 80(%rsi), %xmm6
; SSE-NEXT:    movapd %xmm8, %xmm9
; SSE-NEXT:    unpcklpd {{.*#+}} xmm9 = xmm9[0],xmm6[0]
; SSE-NEXT:    movapd 80(%rdx), %xmm0
; SSE-NEXT:    movsd {{.*#+}} xmm8 = xmm0[0],xmm8[1]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm6 = xmm6[1],xmm0[1]
; SSE-NEXT:    movapd 96(%rdi), %xmm5
; SSE-NEXT:    movapd 96(%rsi), %xmm1
; SSE-NEXT:    movapd %xmm5, %xmm7
; SSE-NEXT:    unpcklpd {{.*#+}} xmm7 = xmm7[0],xmm1[0]
; SSE-NEXT:    movapd 96(%rdx), %xmm2
; SSE-NEXT:    movsd {{.*#+}} xmm5 = xmm2[0],xmm5[1]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm2[1]
; SSE-NEXT:    movapd 112(%rdi), %xmm2
; SSE-NEXT:    movapd 112(%rsi), %xmm0
; SSE-NEXT:    movapd %xmm2, %xmm3
; SSE-NEXT:    unpcklpd {{.*#+}} xmm3 = xmm3[0],xmm0[0]
; SSE-NEXT:    movapd 112(%rdx), %xmm4
; SSE-NEXT:    movsd {{.*#+}} xmm2 = xmm4[0],xmm2[1]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm0 = xmm0[1],xmm4[1]
; SSE-NEXT:    movapd %xmm0, 368(%rcx)
; SSE-NEXT:    movapd %xmm2, 352(%rcx)
; SSE-NEXT:    movapd %xmm3, 336(%rcx)
; SSE-NEXT:    movapd %xmm1, 320(%rcx)
; SSE-NEXT:    movapd %xmm5, 304(%rcx)
; SSE-NEXT:    movapd %xmm7, 288(%rcx)
; SSE-NEXT:    movapd %xmm6, 272(%rcx)
; SSE-NEXT:    movapd %xmm8, 256(%rcx)
; SSE-NEXT:    movapd %xmm9, 240(%rcx)
; SSE-NEXT:    movapd %xmm12, 224(%rcx)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    movaps %xmm0, 208(%rcx)
; SSE-NEXT:    movapd %xmm14, 192(%rcx)
; SSE-NEXT:    movapd %xmm11, 176(%rcx)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    movaps %xmm0, 160(%rcx)
; SSE-NEXT:    movapd %xmm10, 144(%rcx)
; SSE-NEXT:    movapd %xmm15, 128(%rcx)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    movaps %xmm0, 112(%rcx)
; SSE-NEXT:    movapd %xmm13, 96(%rcx)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    movaps %xmm0, 80(%rcx)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    movaps %xmm0, 64(%rcx)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    movaps %xmm0, 48(%rcx)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    movaps %xmm0, 32(%rcx)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE-NEXT:    movaps %xmm0, 16(%rcx)
; SSE-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; SSE-NEXT:    movaps %xmm0, (%rcx)
; SSE-NEXT:    addq $24, %rsp
; SSE-NEXT:    retq
;
; AVX1-LABEL: store_i64_stride3_vf16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovapd (%rdi), %ymm13
; AVX1-NEXT:    vmovapd 96(%rdi), %ymm14
; AVX1-NEXT:    vmovapd 32(%rdi), %ymm4
; AVX1-NEXT:    vmovapd 64(%rdi), %ymm7
; AVX1-NEXT:    vmovapd (%rdx), %ymm3
; AVX1-NEXT:    vmovapd 96(%rdx), %ymm5
; AVX1-NEXT:    vmovapd 32(%rdx), %ymm8
; AVX1-NEXT:    vmovapd 64(%rdx), %ymm10
; AVX1-NEXT:    vinsertf128 $1, (%rdx), %ymm0, %ymm1
; AVX1-NEXT:    vmovaps (%rdi), %xmm6
; AVX1-NEXT:    vmovaps 32(%rdi), %xmm0
; AVX1-NEXT:    vmovaps 64(%rdi), %xmm2
; AVX1-NEXT:    vunpcklpd {{.*#+}} xmm9 = xmm6[0],mem[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm6, %ymm9, %ymm6
; AVX1-NEXT:    vblendps {{.*#+}} ymm1 = ymm6[0,1,2,3],ymm1[4,5],ymm6[6,7]
; AVX1-NEXT:    vmovups %ymm1, {{[-0-9]+}}(%r{{[sb]}}p) # 32-byte Spill
; AVX1-NEXT:    vinsertf128 $1, 64(%rdx), %ymm0, %ymm6
; AVX1-NEXT:    vunpcklpd {{.*#+}} xmm9 = xmm2[0],mem[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm9, %ymm2
; AVX1-NEXT:    vblendps {{.*#+}} ymm6 = ymm2[0,1,2,3],ymm6[4,5],ymm2[6,7]
; AVX1-NEXT:    vinsertf128 $1, 32(%rdx), %ymm0, %ymm2
; AVX1-NEXT:    vunpcklpd {{.*#+}} xmm9 = xmm0[0],mem[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm0, %ymm9, %ymm0
; AVX1-NEXT:    vblendps {{.*#+}} ymm9 = ymm0[0,1,2,3],ymm2[4,5],ymm0[6,7]
; AVX1-NEXT:    vinsertf128 $1, 96(%rdx), %ymm0, %ymm0
; AVX1-NEXT:    vmovaps 96(%rdi), %xmm2
; AVX1-NEXT:    vunpcklpd {{.*#+}} xmm11 = xmm2[0],mem[0]
; AVX1-NEXT:    vinsertf128 $1, %xmm2, %ymm11, %ymm2
; AVX1-NEXT:    vblendps {{.*#+}} ymm11 = ymm2[0,1,2,3],ymm0[4,5],ymm2[6,7]
; AVX1-NEXT:    vmovapd 80(%rdx), %xmm0
; AVX1-NEXT:    vperm2f128 {{.*#+}} ymm2 = ymm7[2,3],ymm10[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm0 = ymm0[0],ymm2[1,2,3]
; AVX1-NEXT:    vbroadcastsd 88(%rsi), %ymm2
; AVX1-NEXT:    vblendpd {{.*#+}} ymm12 = ymm0[0,1],ymm2[2],ymm0[3]
; AVX1-NEXT:    vmovapd 48(%rdx), %xmm0
; AVX1-NEXT:    vperm2f128 {{.*#+}} ymm2 = ymm4[2,3],ymm8[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm0 = ymm0[0],ymm2[1,2,3]
; AVX1-NEXT:    vbroadcastsd 56(%rsi), %ymm2
; AVX1-NEXT:    vblendpd {{.*#+}} ymm0 = ymm0[0,1],ymm2[2],ymm0[3]
; AVX1-NEXT:    vmovapd 112(%rdx), %xmm2
; AVX1-NEXT:    vperm2f128 {{.*#+}} ymm15 = ymm14[2,3],ymm5[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm2 = ymm2[0],ymm15[1,2,3]
; AVX1-NEXT:    vbroadcastsd 120(%rsi), %ymm15
; AVX1-NEXT:    vblendpd {{.*#+}} ymm2 = ymm2[0,1],ymm15[2],ymm2[3]
; AVX1-NEXT:    vmovapd 16(%rdx), %xmm15
; AVX1-NEXT:    vperm2f128 {{.*#+}} ymm1 = ymm13[2,3],ymm3[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm1 = ymm15[0],ymm1[1,2,3]
; AVX1-NEXT:    vbroadcastsd 24(%rsi), %ymm15
; AVX1-NEXT:    vblendpd {{.*#+}} ymm1 = ymm1[0,1],ymm15[2],ymm1[3]
; AVX1-NEXT:    vpermilpd {{.*#+}} ymm15 = mem[1,0,2,2]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm10 = ymm15[0],ymm10[1],ymm15[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm7 = ymm10[0,1],ymm7[2],ymm10[3]
; AVX1-NEXT:    vpermilpd {{.*#+}} ymm10 = mem[1,0,2,2]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm8 = ymm10[0],ymm8[1],ymm10[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm4 = ymm8[0,1],ymm4[2],ymm8[3]
; AVX1-NEXT:    vpermilpd {{.*#+}} ymm8 = mem[1,0,2,2]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm5 = ymm8[0],ymm5[1],ymm8[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm5 = ymm5[0,1],ymm14[2],ymm5[3]
; AVX1-NEXT:    vpermilpd {{.*#+}} ymm8 = mem[1,0,2,2]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm3 = ymm8[0],ymm3[1],ymm8[2,3]
; AVX1-NEXT:    vblendpd {{.*#+}} ymm3 = ymm3[0,1],ymm13[2],ymm3[3]
; AVX1-NEXT:    vmovapd %ymm3, 32(%rcx)
; AVX1-NEXT:    vmovapd %ymm5, 320(%rcx)
; AVX1-NEXT:    vmovapd %ymm4, 128(%rcx)
; AVX1-NEXT:    vmovapd %ymm7, 224(%rcx)
; AVX1-NEXT:    vmovapd %ymm1, 64(%rcx)
; AVX1-NEXT:    vmovapd %ymm2, 352(%rcx)
; AVX1-NEXT:    vmovapd %ymm0, 160(%rcx)
; AVX1-NEXT:    vmovapd %ymm12, 256(%rcx)
; AVX1-NEXT:    vmovaps %ymm11, 288(%rcx)
; AVX1-NEXT:    vmovaps %ymm9, 96(%rcx)
; AVX1-NEXT:    vmovaps %ymm6, 192(%rcx)
; AVX1-NEXT:    vmovups {{[-0-9]+}}(%r{{[sb]}}p), %ymm0 # 32-byte Reload
; AVX1-NEXT:    vmovaps %ymm0, (%rcx)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: store_i64_stride3_vf16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovaps (%rdi), %ymm0
; AVX2-NEXT:    vmovaps 32(%rdi), %ymm4
; AVX2-NEXT:    vmovaps 64(%rdi), %ymm7
; AVX2-NEXT:    vmovaps 96(%rdi), %ymm3
; AVX2-NEXT:    vmovaps (%rdx), %ymm2
; AVX2-NEXT:    vmovaps 96(%rdx), %ymm6
; AVX2-NEXT:    vmovaps 32(%rdx), %ymm8
; AVX2-NEXT:    vmovaps 64(%rdx), %ymm10
; AVX2-NEXT:    vinsertf128 $1, (%rdx), %ymm0, %ymm1
; AVX2-NEXT:    vmovddup {{.*#+}} xmm5 = mem[0,0]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm9 = ymm0[0,1,2,1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm5 = ymm9[0,1],ymm5[2,3],ymm9[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm1 = ymm5[0,1,2,3],ymm1[4,5],ymm5[6,7]
; AVX2-NEXT:    vmovups %ymm1, {{[-0-9]+}}(%r{{[sb]}}p) # 32-byte Spill
; AVX2-NEXT:    vinsertf128 $1, 64(%rdx), %ymm0, %ymm5
; AVX2-NEXT:    vmovddup {{.*#+}} xmm9 = mem[0,0]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm11 = ymm7[0,1,2,1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm9 = ymm11[0,1],ymm9[2,3],ymm11[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm5 = ymm9[0,1,2,3],ymm5[4,5],ymm9[6,7]
; AVX2-NEXT:    vperm2f128 {{.*#+}} ymm9 = ymm7[2,3],ymm10[2,3]
; AVX2-NEXT:    vmovaps 80(%rdx), %xmm11
; AVX2-NEXT:    vblendps {{.*#+}} ymm9 = ymm11[0,1],ymm9[2,3],ymm11[4,5],ymm9[6,7]
; AVX2-NEXT:    vbroadcastsd 88(%rsi), %ymm11
; AVX2-NEXT:    vblendps {{.*#+}} ymm9 = ymm9[0,1,2,3],ymm11[4,5],ymm9[6,7]
; AVX2-NEXT:    vinsertf128 $1, 32(%rdx), %ymm0, %ymm11
; AVX2-NEXT:    vmovddup {{.*#+}} xmm12 = mem[0,0]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm13 = ymm4[0,1,2,1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm12 = ymm13[0,1],ymm12[2,3],ymm13[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm11 = ymm12[0,1,2,3],ymm11[4,5],ymm12[6,7]
; AVX2-NEXT:    vperm2f128 {{.*#+}} ymm12 = ymm4[2,3],ymm8[2,3]
; AVX2-NEXT:    vmovaps 48(%rdx), %xmm13
; AVX2-NEXT:    vblendps {{.*#+}} ymm12 = ymm13[0,1],ymm12[2,3],ymm13[4,5],ymm12[6,7]
; AVX2-NEXT:    vbroadcastsd 56(%rsi), %ymm13
; AVX2-NEXT:    vblendps {{.*#+}} ymm12 = ymm12[0,1,2,3],ymm13[4,5],ymm12[6,7]
; AVX2-NEXT:    vinsertf128 $1, 96(%rdx), %ymm0, %ymm13
; AVX2-NEXT:    vmovddup {{.*#+}} xmm14 = mem[0,0]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm15 = ymm3[0,1,2,1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm14 = ymm15[0,1],ymm14[2,3],ymm15[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm13 = ymm14[0,1,2,3],ymm13[4,5],ymm14[6,7]
; AVX2-NEXT:    vperm2f128 {{.*#+}} ymm14 = ymm3[2,3],ymm6[2,3]
; AVX2-NEXT:    vmovaps 112(%rdx), %xmm15
; AVX2-NEXT:    vblendps {{.*#+}} ymm14 = ymm15[0,1],ymm14[2,3],ymm15[4,5],ymm14[6,7]
; AVX2-NEXT:    vbroadcastsd 120(%rsi), %ymm15
; AVX2-NEXT:    vblendps {{.*#+}} ymm14 = ymm14[0,1,2,3],ymm15[4,5],ymm14[6,7]
; AVX2-NEXT:    vperm2f128 {{.*#+}} ymm15 = ymm0[2,3],ymm2[2,3]
; AVX2-NEXT:    vmovaps 16(%rdx), %xmm1
; AVX2-NEXT:    vblendps {{.*#+}} ymm1 = ymm1[0,1],ymm15[2,3],ymm1[4,5],ymm15[6,7]
; AVX2-NEXT:    vbroadcastsd 24(%rsi), %ymm15
; AVX2-NEXT:    vblendps {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm15[4,5],ymm1[6,7]
; AVX2-NEXT:    vpermilps {{.*#+}} ymm15 = mem[2,3,0,1,6,7,4,5]
; AVX2-NEXT:    vblendps {{.*#+}} ymm10 = ymm15[0,1],ymm10[2,3],ymm15[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm7 = ymm10[0,1,2,3],ymm7[4,5],ymm10[6,7]
; AVX2-NEXT:    vpermilps {{.*#+}} ymm10 = mem[2,3,0,1,6,7,4,5]
; AVX2-NEXT:    vblendps {{.*#+}} ymm8 = ymm10[0,1],ymm8[2,3],ymm10[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm4 = ymm8[0,1,2,3],ymm4[4,5],ymm8[6,7]
; AVX2-NEXT:    vpermilps {{.*#+}} ymm8 = mem[2,3,0,1,6,7,4,5]
; AVX2-NEXT:    vblendps {{.*#+}} ymm6 = ymm8[0,1],ymm6[2,3],ymm8[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm3 = ymm6[0,1,2,3],ymm3[4,5],ymm6[6,7]
; AVX2-NEXT:    vpermilps {{.*#+}} ymm6 = mem[2,3,0,1,6,7,4,5]
; AVX2-NEXT:    vblendps {{.*#+}} ymm2 = ymm6[0,1],ymm2[2,3],ymm6[4,5,6,7]
; AVX2-NEXT:    vblendps {{.*#+}} ymm0 = ymm2[0,1,2,3],ymm0[4,5],ymm2[6,7]
; AVX2-NEXT:    vmovaps %ymm0, 32(%rcx)
; AVX2-NEXT:    vmovaps %ymm3, 320(%rcx)
; AVX2-NEXT:    vmovaps %ymm4, 128(%rcx)
; AVX2-NEXT:    vmovaps %ymm7, 224(%rcx)
; AVX2-NEXT:    vmovaps %ymm1, 64(%rcx)
; AVX2-NEXT:    vmovaps %ymm14, 352(%rcx)
; AVX2-NEXT:    vmovaps %ymm13, 288(%rcx)
; AVX2-NEXT:    vmovaps %ymm12, 160(%rcx)
; AVX2-NEXT:    vmovaps %ymm11, 96(%rcx)
; AVX2-NEXT:    vmovaps %ymm9, 256(%rcx)
; AVX2-NEXT:    vmovaps %ymm5, 192(%rcx)
; AVX2-NEXT:    vmovups {{[-0-9]+}}(%r{{[sb]}}p), %ymm0 # 32-byte Reload
; AVX2-NEXT:    vmovaps %ymm0, (%rcx)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: store_i64_stride3_vf16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovdqu64 (%rdi), %zmm0
; AVX512-NEXT:    vmovdqu64 64(%rdi), %zmm1
; AVX512-NEXT:    vmovdqu64 (%rsi), %zmm2
; AVX512-NEXT:    vmovdqu64 64(%rsi), %zmm3
; AVX512-NEXT:    vmovdqu64 (%rdx), %zmm4
; AVX512-NEXT:    vmovdqu64 64(%rdx), %zmm5
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm6 = <0,8,u,1,9,u,2,10>
; AVX512-NEXT:    vmovdqa64 %zmm0, %zmm7
; AVX512-NEXT:    vpermt2q %zmm2, %zmm6, %zmm7
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm8 = [0,1,8,3,4,9,6,7]
; AVX512-NEXT:    vpermt2q %zmm4, %zmm8, %zmm7
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm9 = <5,13,u,6,14,u,7,15>
; AVX512-NEXT:    vmovdqa64 %zmm3, %zmm10
; AVX512-NEXT:    vpermt2q %zmm5, %zmm9, %zmm10
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm11 = [0,1,14,3,4,15,6,7]
; AVX512-NEXT:    vpermt2q %zmm1, %zmm11, %zmm10
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm12 = <2,11,u,3,12,u,4,13>
; AVX512-NEXT:    vmovdqa64 %zmm5, %zmm13
; AVX512-NEXT:    vpermt2q %zmm1, %zmm12, %zmm13
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm14 = [0,1,11,3,4,12,6,7]
; AVX512-NEXT:    vpermt2q %zmm3, %zmm14, %zmm13
; AVX512-NEXT:    vpermt2q %zmm3, %zmm6, %zmm1
; AVX512-NEXT:    vpermt2q %zmm5, %zmm8, %zmm1
; AVX512-NEXT:    vpermi2q %zmm4, %zmm2, %zmm9
; AVX512-NEXT:    vpermt2q %zmm0, %zmm11, %zmm9
; AVX512-NEXT:    vpermt2q %zmm0, %zmm12, %zmm4
; AVX512-NEXT:    vpermt2q %zmm2, %zmm14, %zmm4
; AVX512-NEXT:    vmovdqu64 %zmm4, 64(%rcx)
; AVX512-NEXT:    vmovdqu64 %zmm9, 128(%rcx)
; AVX512-NEXT:    vmovdqu64 %zmm1, 192(%rcx)
; AVX512-NEXT:    vmovdqu64 %zmm13, 256(%rcx)
; AVX512-NEXT:    vmovdqu64 %zmm10, 320(%rcx)
; AVX512-NEXT:    vmovdqu64 %zmm7, (%rcx)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %in.vec0 = load <16 x i64>, <16 x i64>* %in.vecptr0, align 32
  %in.vec1 = load <16 x i64>, <16 x i64>* %in.vecptr1, align 32
  %in.vec2 = load <16 x i64>, <16 x i64>* %in.vecptr2, align 32

  %concat01 = shufflevector <16 x i64> %in.vec0, <16 x i64> %in.vec1, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %concat2u = shufflevector <16 x i64> %in.vec2, <16 x i64> poison, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %concat012 = shufflevector <32 x i64> %concat01, <32 x i64> %concat2u, <48 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47>
  %interleaved.vec = shufflevector <48 x i64> %concat012, <48 x i64> poison, <48 x i32> <i32 0, i32 16, i32 32, i32 1, i32 17, i32 33, i32 2, i32 18, i32 34, i32 3, i32 19, i32 35, i32 4, i32 20, i32 36, i32 5, i32 21, i32 37, i32 6, i32 22, i32 38, i32 7, i32 23, i32 39, i32 8, i32 24, i32 40, i32 9, i32 25, i32 41, i32 10, i32 26, i32 42, i32 11, i32 27, i32 43, i32 12, i32 28, i32 44, i32 13, i32 29, i32 45, i32 14, i32 30, i32 46, i32 15, i32 31, i32 47>

  store <48 x i64> %interleaved.vec, <48 x i64>* %out.vec, align 32

  ret void
}
