; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -loop-unroll -unroll-allow-partial -S %s -verify-loop-info -verify-dom-info -verify-loop-lcssa | FileCheck %s

@table = internal unnamed_addr global [344 x i32] zeroinitializer, align 16

define i32 @test_partial_unroll_with_breakout_at_iter0() {
;
;
; CHECK-LABEL: @test_partial_unroll_with_breakout_at_iter0(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_HEADER:%.*]]
; CHECK:       for.header:
; CHECK-NEXT:    [[RED:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[RED_NEXT_3:%.*]], [[FOR_LATCH_3:%.*]] ]
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ 0, [[ENTRY]] ], [ [[IV_NEXT_3:%.*]], [[FOR_LATCH_3]] ]
; CHECK-NEXT:    [[RED_NEXT:%.*]] = add nuw nsw i32 10, [[RED]]
; CHECK-NEXT:    [[IV_NEXT:%.*]] = add nuw nsw i64 [[IV]], 2
; CHECK-NEXT:    [[PTR:%.*]] = getelementptr inbounds [344 x i32], [344 x i32]* @table, i64 0, i64 [[IV_NEXT]]
; CHECK-NEXT:    store i32 [[RED_NEXT]], i32* [[PTR]], align 4
; CHECK-NEXT:    br label [[FOR_LATCH:%.*]]
; CHECK:       for.latch:
; CHECK-NEXT:    [[RED_NEXT_1:%.*]] = add nuw nsw i32 10, [[RED_NEXT]]
; CHECK-NEXT:    [[IV_NEXT_1:%.*]] = add nuw nsw i64 [[IV_NEXT]], 2
; CHECK-NEXT:    [[PTR_1:%.*]] = getelementptr inbounds [344 x i32], [344 x i32]* @table, i64 0, i64 [[IV_NEXT_1]]
; CHECK-NEXT:    store i32 [[RED_NEXT_1]], i32* [[PTR_1]], align 4
; CHECK-NEXT:    br label [[FOR_LATCH_1:%.*]]
; CHECK:       for.latch.1:
; CHECK-NEXT:    [[RED_NEXT_2:%.*]] = add nuw nsw i32 10, [[RED_NEXT_1]]
; CHECK-NEXT:    [[IV_NEXT_2:%.*]] = add nuw nsw i64 [[IV_NEXT_1]], 2
; CHECK-NEXT:    [[PTR_2:%.*]] = getelementptr inbounds [344 x i32], [344 x i32]* @table, i64 0, i64 [[IV_NEXT_2]]
; CHECK-NEXT:    store i32 [[RED_NEXT_2]], i32* [[PTR_2]], align 4
; CHECK-NEXT:    br label [[FOR_LATCH_2:%.*]]
; CHECK:       for.latch.2:
; CHECK-NEXT:    [[RED_NEXT_3]] = add nuw nsw i32 10, [[RED_NEXT_2]]
; CHECK-NEXT:    [[IV_NEXT_3]] = add nuw nsw i64 [[IV_NEXT_2]], 2
; CHECK-NEXT:    [[PTR_3:%.*]] = getelementptr inbounds [344 x i32], [344 x i32]* @table, i64 0, i64 [[IV_NEXT_3]]
; CHECK-NEXT:    store i32 [[RED_NEXT_3]], i32* [[PTR_3]], align 4
; CHECK-NEXT:    [[EXITCOND_1_I_3:%.*]] = icmp eq i64 [[IV_NEXT_3]], 344
; CHECK-NEXT:    br i1 [[EXITCOND_1_I_3]], label [[EXIT:%.*]], label [[FOR_LATCH_3]]
; CHECK:       for.latch.3:
; CHECK-NEXT:    br label [[FOR_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %for.header

for.header:                                     ; preds = %for.body28.i.for.body28.i_crit_edge, %for.body.i
  %red = phi i32 [ 0, %entry ], [ %red.next, %for.latch ]
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.latch ]
  %red.next = add i32 10, %red
  %iv.next = add nuw nsw i64 %iv, 2
  %ptr = getelementptr inbounds [344 x i32], [344 x i32]* @table, i64 0, i64 %iv.next
  store i32 %red.next, i32* %ptr, align 4
  %exitcond.1.i = icmp eq i64 %iv.next, 344
  br i1 %exitcond.1.i, label %exit, label %for.latch

for.latch:              ; preds = %for.header
  br label %for.header

exit:
  ret i32 0
}
