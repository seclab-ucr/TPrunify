; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -csky-no-aliases < %s -mtriple=csky -mattr=+2e3 | FileCheck %s
; RUN: llc -verify-machineinstrs -csky-no-aliases < %s -mtriple=csky -relocation-model=pic -code-model=small -mattr=+2e3 | FileCheck %s --check-prefix=CHECK-PIC-SMALL
; RUN: llc -verify-machineinstrs -csky-no-aliases < %s -mtriple=csky -relocation-model=pic -code-model=large -mattr=+2e3 | FileCheck %s --check-prefix=CHECK-PIC-LARGE

@p_fun = global void (i32, i32)* @bar, align 8

declare void @bar(i32, i32)

define void @foo(i32 %a, i32* %ptr){
; CHECK-LABEL: foo:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    subi16 sp, sp, 4
; CHECK-NEXT:    .cfi_def_cfa_offset 4
; CHECK-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CHECK-NEXT:    .cfi_offset lr, -4
; CHECK-NEXT:    .cfi_def_cfa_offset 4
; CHECK-NEXT:    ld16.w a1, (a1, 0)
; CHECK-NEXT:    jsri32 [.LCPI0_0]
; CHECK-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CHECK-NEXT:    addi16 sp, sp, 4
; CHECK-NEXT:    rts16
;
; CHECK-PIC-SMALL-LABEL: foo:
; CHECK-PIC-SMALL:       # %bb.0: # %entry
; CHECK-PIC-SMALL-NEXT:    subi16 sp, sp, 8
; CHECK-PIC-SMALL-NEXT:    .cfi_def_cfa_offset 8
; CHECK-PIC-SMALL-NEXT:    st32.w rgb, (sp, 4) # 4-byte Folded Spill
; CHECK-PIC-SMALL-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CHECK-PIC-SMALL-NEXT:    .cfi_offset rgb, -4
; CHECK-PIC-SMALL-NEXT:    .cfi_offset lr, -8
; CHECK-PIC-SMALL-NEXT:    .cfi_def_cfa_offset 8
; CHECK-PIC-SMALL-NEXT:    lrw32 rgb, [.LCPI0_0]
; CHECK-PIC-SMALL-NEXT:    ld16.w a1, (a1, 0)
; CHECK-PIC-SMALL-NEXT:    lrw32 a2, [.LCPI0_1]
; CHECK-PIC-SMALL-NEXT:    ldr32.w a2, (rgb, a2 << 0)
; CHECK-PIC-SMALL-NEXT:    jsr16 a2
; CHECK-PIC-SMALL-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CHECK-PIC-SMALL-NEXT:    ld32.w rgb, (sp, 4) # 4-byte Folded Reload
; CHECK-PIC-SMALL-NEXT:    addi16 sp, sp, 8
; CHECK-PIC-SMALL-NEXT:    rts16
;
; CHECK-PIC-LARGE-LABEL: foo:
; CHECK-PIC-LARGE:       # %bb.0: # %entry
; CHECK-PIC-LARGE-NEXT:    subi16 sp, sp, 8
; CHECK-PIC-LARGE-NEXT:    .cfi_def_cfa_offset 8
; CHECK-PIC-LARGE-NEXT:    st32.w rgb, (sp, 4) # 4-byte Folded Spill
; CHECK-PIC-LARGE-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CHECK-PIC-LARGE-NEXT:    .cfi_offset rgb, -4
; CHECK-PIC-LARGE-NEXT:    .cfi_offset lr, -8
; CHECK-PIC-LARGE-NEXT:    .cfi_def_cfa_offset 8
; CHECK-PIC-LARGE-NEXT:    lrw32 rgb, [.LCPI0_0]
; CHECK-PIC-LARGE-NEXT:    ld16.w a1, (a1, 0)
; CHECK-PIC-LARGE-NEXT:    lrw32 a2, [.LCPI0_1]
; CHECK-PIC-LARGE-NEXT:    ldr32.w a2, (rgb, a2 << 0)
; CHECK-PIC-LARGE-NEXT:    jsr16 a2
; CHECK-PIC-LARGE-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CHECK-PIC-LARGE-NEXT:    ld32.w rgb, (sp, 4) # 4-byte Folded Reload
; CHECK-PIC-LARGE-NEXT:    addi16 sp, sp, 8
; CHECK-PIC-LARGE-NEXT:    rts16
; CHECK-PIC-LABEL: foo:
; CHECK-PIC:       # %bb.0: # %entry
; CHECK-PIC-NEXT:    ld32.w a1, a1, 0
; CHECK-PIC-NEXT:    br32 bar
entry:
  %0 = load i32, i32* %ptr
  tail call void (i32, i32) @bar(i32 %a, i32 %0)
  ret void
}

define void @foo_indirect(i32 %a, i32* %ptr) {
; CHECK-LABEL: foo_indirect:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    subi16 sp, sp, 4
; CHECK-NEXT:    .cfi_def_cfa_offset 4
; CHECK-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CHECK-NEXT:    .cfi_offset lr, -4
; CHECK-NEXT:    .cfi_def_cfa_offset 4
; CHECK-NEXT:    lrw32 a2, [.LCPI1_0]
; CHECK-NEXT:    ld16.w a2, (a2, 0)
; CHECK-NEXT:    ld16.w a1, (a1, 0)
; CHECK-NEXT:    jsr16 a2
; CHECK-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CHECK-NEXT:    addi16 sp, sp, 4
; CHECK-NEXT:    rts16
;
; CHECK-PIC-SMALL-LABEL: foo_indirect:
; CHECK-PIC-SMALL:       # %bb.0: # %entry
; CHECK-PIC-SMALL-NEXT:    subi16 sp, sp, 8
; CHECK-PIC-SMALL-NEXT:    .cfi_def_cfa_offset 8
; CHECK-PIC-SMALL-NEXT:    st32.w rgb, (sp, 4) # 4-byte Folded Spill
; CHECK-PIC-SMALL-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CHECK-PIC-SMALL-NEXT:    .cfi_offset rgb, -4
; CHECK-PIC-SMALL-NEXT:    .cfi_offset lr, -8
; CHECK-PIC-SMALL-NEXT:    .cfi_def_cfa_offset 8
; CHECK-PIC-SMALL-NEXT:    lrw32 rgb, [.LCPI1_0]
; CHECK-PIC-SMALL-NEXT:    lrw32 a2, [.LCPI1_1]
; CHECK-PIC-SMALL-NEXT:    ldr32.w a2, (rgb, a2 << 0)
; CHECK-PIC-SMALL-NEXT:    ld16.w a2, (a2, 0)
; CHECK-PIC-SMALL-NEXT:    ld16.w a1, (a1, 0)
; CHECK-PIC-SMALL-NEXT:    jsr16 a2
; CHECK-PIC-SMALL-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CHECK-PIC-SMALL-NEXT:    ld32.w rgb, (sp, 4) # 4-byte Folded Reload
; CHECK-PIC-SMALL-NEXT:    addi16 sp, sp, 8
; CHECK-PIC-SMALL-NEXT:    rts16
;
; CHECK-PIC-LARGE-LABEL: foo_indirect:
; CHECK-PIC-LARGE:       # %bb.0: # %entry
; CHECK-PIC-LARGE-NEXT:    subi16 sp, sp, 8
; CHECK-PIC-LARGE-NEXT:    .cfi_def_cfa_offset 8
; CHECK-PIC-LARGE-NEXT:    st32.w rgb, (sp, 4) # 4-byte Folded Spill
; CHECK-PIC-LARGE-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CHECK-PIC-LARGE-NEXT:    .cfi_offset rgb, -4
; CHECK-PIC-LARGE-NEXT:    .cfi_offset lr, -8
; CHECK-PIC-LARGE-NEXT:    .cfi_def_cfa_offset 8
; CHECK-PIC-LARGE-NEXT:    lrw32 rgb, [.LCPI1_0]
; CHECK-PIC-LARGE-NEXT:    lrw32 a2, [.LCPI1_1]
; CHECK-PIC-LARGE-NEXT:    ldr32.w a2, (rgb, a2 << 0)
; CHECK-PIC-LARGE-NEXT:    ld16.w a2, (a2, 0)
; CHECK-PIC-LARGE-NEXT:    ld16.w a1, (a1, 0)
; CHECK-PIC-LARGE-NEXT:    jsr16 a2
; CHECK-PIC-LARGE-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CHECK-PIC-LARGE-NEXT:    ld32.w rgb, (sp, 4) # 4-byte Folded Reload
; CHECK-PIC-LARGE-NEXT:    addi16 sp, sp, 8
; CHECK-PIC-LARGE-NEXT:    rts16
; CHECK-PIC-LABEL: foo_indirect:
; CHECK-PIC:       # %bb.0: # %entry
; CHECK-PIC-NEXT:    movi32 a2, p_fun
; CHECK-PIC-NEXT:    movih32 a3, p_fun
; CHECK-PIC-NEXT:    or32 a2, a3, a2
; CHECK-PIC-NEXT:    ld32.w a2, a2, 0
; CHECK-PIC-NEXT:    ld32.w a1, a1, 0
; CHECK-PIC-NEXT:    jmp32 a2
entry:
  %0 = load void (i32, i32)*, void (i32, i32)** @p_fun, align 8
  %1 = load i32, i32* %ptr
  tail call void (i32, i32) %0(i32 %a, i32 %1)
  ret void
}
