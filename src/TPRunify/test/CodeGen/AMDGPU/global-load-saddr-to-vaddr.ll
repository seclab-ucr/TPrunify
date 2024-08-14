; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN %s

; The first load produces address in a VGPR which is used in address calculation
; of the second load (one inside the loop). The value is uniform and the inner
; load correctly selected to use SADDR form, however the address is promoted to
; vector registers because it all starts with a VGPR produced by the entry block
; load.
;
; Check that we are changing SADDR form of a load to VADDR and do not have to use
; readfirstlane instructions to move address from VGPRs into SGPRs.

define amdgpu_kernel void @test_move_load_address_to_vgpr(i32 addrspace(1)* nocapture %arg) {
; GCN-LABEL: test_move_load_address_to_vgpr:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    global_load_dword v0, v1, s[0:1] glc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v3, s1
; GCN-NEXT:    v_add_u32_e32 v2, 0xffffff00, v0
; GCN-NEXT:    v_lshlrev_b64 v[0:1], 2, v[0:1]
; GCN-NEXT:    v_add_co_u32_e32 v0, vcc, s0, v0
; GCN-NEXT:    v_addc_co_u32_e32 v1, vcc, v3, v1, vcc
; GCN-NEXT:  .LBB0_1: ; %bb3
; GCN-NEXT:    ; =>This Inner Loop Header: Depth=1
; GCN-NEXT:    global_load_dword v3, v[0:1], off glc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_add_co_u32_e32 v2, vcc, 1, v2
; GCN-NEXT:    v_add_co_u32_e64 v0, s[0:1], 4, v0
; GCN-NEXT:    v_addc_co_u32_e64 v1, s[0:1], 0, v1, s[0:1]
; GCN-NEXT:    s_and_b64 vcc, exec, vcc
; GCN-NEXT:    s_cbranch_vccz .LBB0_1
; GCN-NEXT:  ; %bb.2: ; %bb2
; GCN-NEXT:    s_endpgm
bb:
  %i1 = getelementptr inbounds i32, i32 addrspace(1)* %arg, i32 0
  %i2 = load volatile i32, i32 addrspace(1)* %i1, align 4
  br label %bb3

bb2:                                              ; preds = %bb3
  ret void

bb3:                                              ; preds = %bb3, %bb
  %i = phi i32 [ %i2, %bb ], [ %i8, %bb3 ]
  %i4 = zext i32 %i to i64
  %i5 = getelementptr inbounds i32, i32 addrspace(1)* %arg, i64 %i4
  %i6 = load volatile i32, i32 addrspace(1)* %i5, align 4
  %i8 = add nuw nsw i32 %i, 1
  %i9 = icmp eq i32 %i8, 256
  br i1 %i9, label %bb2, label %bb3
}

define amdgpu_kernel void @test_move_load_address_to_vgpr_d16_hi(i16 addrspace(1)* nocapture %arg) {
; GCN-LABEL: test_move_load_address_to_vgpr_d16_hi:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_movk_i32 s2, 0x100
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    global_load_ushort v0, v1, s[0:1] glc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:  .LBB1_1: ; %bb3
; GCN-NEXT:    ; =>This Inner Loop Header: Depth=1
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_lshlrev_b64 v[2:3], 1, v[0:1]
; GCN-NEXT:    v_mov_b32_e32 v0, s1
; GCN-NEXT:    v_add_co_u32_e32 v2, vcc, s0, v2
; GCN-NEXT:    v_addc_co_u32_e32 v3, vcc, v0, v3, vcc
; GCN-NEXT:    global_load_short_d16_hi v0, v[2:3], off glc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, s2, v0
; GCN-NEXT:    s_and_b64 vcc, exec, vcc
; GCN-NEXT:    s_cbranch_vccz .LBB1_1
; GCN-NEXT:  ; %bb.2: ; %bb2
; GCN-NEXT:    s_endpgm
bb:
  %i1 = getelementptr inbounds i16, i16 addrspace(1)* %arg, i64 0
  %load.pre = load volatile i16, i16 addrspace(1)* %i1, align 4
  %i2 = zext i16 %load.pre to i32
  br label %bb3

bb2:                                              ; preds = %bb3
  ret void

bb3:                                              ; preds = %bb3, %bb
  %i = phi i32 [ %i2, %bb ], [ %i8, %bb3 ]
  %i4 = zext i32 %i to i64
  %i5 = getelementptr inbounds i16, i16 addrspace(1)* %arg, i64 %i4
  %i6 = load volatile i16, i16 addrspace(1)* %i5, align 4
  %insertelt = insertelement <2 x i16> undef, i16 %i6, i32 1
  %i8 =  bitcast <2 x i16> %insertelt to i32
  %i9 = icmp eq i32 %i8, 256
  br i1 %i9, label %bb2, label %bb3
}
