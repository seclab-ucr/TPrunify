; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=arm64-eabi < %s | FileCheck %s
; rdar://10232252

@object = external hidden global i64, section "__DATA, __objc_ivar", align 8

; base + offset (imm9)
define void @t1(i64* %object) {
; CHECK-LABEL: t1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr xzr, [x0, #8]
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i64, i64* %object, i64 1
  %tmp = load volatile i64, i64* %incdec.ptr, align 8
  ret void
}

; base + offset (> imm9)
define void @t2(i64* %object) {
; CHECK-LABEL: t2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub x8, x0, #264
; CHECK-NEXT:    ldr xzr, [x8]
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i64, i64* %object, i64 -33
  %tmp = load volatile i64, i64* %incdec.ptr, align 8
  ret void
}

; base + unsigned offset (> imm9 and <= imm12 * size of type in bytes)
define void @t3(i64* %object) {
; CHECK-LABEL: t3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr xzr, [x0, #32760]
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i64, i64* %object, i64 4095
  %tmp = load volatile i64, i64* %incdec.ptr, align 8
  ret void
}

; base + unsigned offset (> imm12 * size of type in bytes)
define void @t4(i64* %object) {
; CHECK-LABEL: t4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #32768
; CHECK-NEXT:    ldr xzr, [x0, x8]
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i64, i64* %object, i64 4096
  %tmp = load volatile i64, i64* %incdec.ptr, align 8
  ret void
}

; base + reg
define void @t5(i64 %a) {
; CHECK-LABEL: t5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, object
; CHECK-NEXT:    add x8, x8, :lo12:object
; CHECK-NEXT:    ldr xzr, [x8, x0, lsl #3]
; CHECK-NEXT:    ret
  %incdec.ptr = getelementptr inbounds i64, i64* @object, i64 %a
  %tmp = load volatile i64, i64* %incdec.ptr, align 8
  ret void
}

; base + reg + imm
define void @t6(i64 %a, i64* %object) {
; CHECK-LABEL: t6:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #32768
; CHECK-NEXT:    add x9, x1, x0, lsl #3
; CHECK-NEXT:    ldr xzr, [x9, x8]
; CHECK-NEXT:    ret
  %tmp1 = getelementptr inbounds i64, i64* %object, i64 %a
  %incdec.ptr = getelementptr inbounds i64, i64* %tmp1, i64 4096
  %tmp = load volatile i64, i64* %incdec.ptr, align 8
  ret void
}

; Test base + wide immediate
define void @t7(i64 %a) {
; CHECK-LABEL: t7:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #65535
; CHECK-NEXT:    ldr xzr, [x0, x8]
; CHECK-NEXT:    ret
  %1 = add i64 %a, 65535   ;0xffff
  %2 = inttoptr i64 %1 to i64*
  %3 = load volatile i64, i64* %2, align 8
  ret void
}

define void @t8(i64 %a) {
; CHECK-LABEL: t8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-4662
; CHECK-NEXT:    ldr xzr, [x0, x8]
; CHECK-NEXT:    ret
  %1 = sub i64 %a, 4662   ;-4662 is 0xffffffffffffedca
  %2 = inttoptr i64 %1 to i64*
  %3 = load volatile i64, i64* %2, align 8
  ret void
}

define void @t9(i64 %a) {
; CHECK-LABEL: t9:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-305463297
; CHECK-NEXT:    ldr xzr, [x0, x8]
; CHECK-NEXT:    ret
  %1 = add i64 -305463297, %a   ;-305463297 is 0xffffffffedcaffff
  %2 = inttoptr i64 %1 to i64*
  %3 = load volatile i64, i64* %2, align 8
  ret void
}

define void @t10(i64 %a) {
; CHECK-LABEL: t10:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #81909218222800896
; CHECK-NEXT:    ldr xzr, [x0, x8]
; CHECK-NEXT:    ret
  %1 = add i64 %a, 81909218222800896   ;0x123000000000000
  %2 = inttoptr i64 %1 to i64*
  %3 = load volatile i64, i64* %2, align 8
  ret void
}

define void @t11(i64 %a) {
; CHECK-LABEL: t11:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #17767
; CHECK-NEXT:    movk w8, #291, lsl #16
; CHECK-NEXT:    ldr xzr, [x0, x8]
; CHECK-NEXT:    ret
  %1 = add i64 %a, 19088743   ;0x1234567
  %2 = inttoptr i64 %1 to i64*
  %3 = load volatile i64, i64* %2, align 8
  ret void
}

; Test some boundaries that should not use movz/movn/orr
define void @t12(i64 %a) {
; CHECK-LABEL: t12:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add x8, x0, #4095
; CHECK-NEXT:    ldr xzr, [x8]
; CHECK-NEXT:    ret
  %1 = add i64 %a, 4095   ;0xfff
  %2 = inttoptr i64 %1 to i64*
  %3 = load volatile i64, i64* %2, align 8
  ret void
}

define void @t13(i64 %a) {
; CHECK-LABEL: t13:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub x8, x0, #4095
; CHECK-NEXT:    ldr xzr, [x8]
; CHECK-NEXT:    ret
  %1 = add i64 %a, -4095   ;-0xfff
  %2 = inttoptr i64 %1 to i64*
  %3 = load volatile i64, i64* %2, align 8
  ret void
}

define void @t14(i64 %a) {
; CHECK-LABEL: t14:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add x8, x0, #291, lsl #12 // =1191936
; CHECK-NEXT:    ldr xzr, [x8]
; CHECK-NEXT:    ret
  %1 = add i64 %a, 1191936   ;0x123000
  %2 = inttoptr i64 %1 to i64*
  %3 = load volatile i64, i64* %2, align 8
  ret void
}

define void @t15(i64 %a) {
; CHECK-LABEL: t15:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub x8, x0, #291, lsl #12 // =1191936
; CHECK-NEXT:    ldr xzr, [x8]
; CHECK-NEXT:    ret
  %1 = add i64 %a, -1191936   ;0xFFFFFFFFFFEDD000
  %2 = inttoptr i64 %1 to i64*
  %3 = load volatile i64, i64* %2, align 8
  ret void
}

define void @t16(i64 %a) {
; CHECK-LABEL: t16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr xzr, [x0, #28672]
; CHECK-NEXT:    ret
  %1 = add i64 %a, 28672   ;0x7000
  %2 = inttoptr i64 %1 to i64*
  %3 = load volatile i64, i64* %2, align 8
  ret void
}

define void @t17(i64 %a) {
; CHECK-LABEL: t17:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur xzr, [x0, #-256]
; CHECK-NEXT:    ret
  %1 = add i64 %a, -256   ;-0x100
  %2 = inttoptr i64 %1 to i64*
  %3 = load volatile i64, i64* %2, align 8
  ret void
}
