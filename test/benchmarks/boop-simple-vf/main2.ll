; ModuleID = 'main2.c'
source_filename = "main2.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@flag1_SHARED = global i32 0, align 4
@flag2_SHARED = global i32 0, align 4
@release_thr1_SHARED = global i32 0, align 4
@mutex0 = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@usecount_SHARED = common global i32 0, align 4
@locked_SHARED = common global i32 0, align 4
@__func__.thr1 = private unnamed_addr constant [5 x i8] c"thr1\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main2.c\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thr2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  %5 = load i32, ptr @usecount_SHARED, align 4
  %6 = add nsw i32 %5, 1
  store i32 %6, ptr @usecount_SHARED, align 4
  %7 = load i32, ptr @locked_SHARED, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %10

9:                                                ; preds = %1
  store ptr null, ptr %2, align 8
  br label %12

10:                                               ; preds = %1
  store i32 1, ptr @locked_SHARED, align 4
  store i32 1, ptr @flag1_SHARED, align 4
  %11 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  store ptr null, ptr %2, align 8
  br label %12

12:                                               ; preds = %10, %9
  %13 = load ptr, ptr %2, align 8
  ret ptr %13
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thr1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 0, ptr @usecount_SHARED, align 4
  store i32 0, ptr @locked_SHARED, align 4
  %5 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  store i32 1, ptr @release_thr1_SHARED, align 4
  store ptr inttoptr (i64 1 to ptr), ptr %3, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = icmp eq ptr %6, null
  br i1 %7, label %8, label %11

8:                                                ; preds = %1
  store i32 1, ptr %4, align 4
  %9 = load i32, ptr @usecount_SHARED, align 4
  %10 = sub nsw i32 %9, 1
  store i32 %10, ptr @usecount_SHARED, align 4
  store i32 0, ptr @locked_SHARED, align 4
  br label %12

11:                                               ; preds = %1
  store i32 0, ptr %4, align 4
  br label %12

12:                                               ; preds = %11, %8
  %13 = load i32, ptr @usecount_SHARED, align 4
  %14 = sub nsw i32 %13, 1
  store i32 %14, ptr @usecount_SHARED, align 4
  store i32 0, ptr @locked_SHARED, align 4
  %15 = load i32, ptr @usecount_SHARED, align 4
  %16 = icmp ne i32 %15, 0
  br i1 %16, label %17, label %18

17:                                               ; preds = %12
  call void @__assert_rtn(ptr noundef @__func__.thr1, ptr noundef @.str, i32 noundef 111, ptr noundef @.str.1) #3
  unreachable

18:                                               ; preds = %12
  %19 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  ret ptr null
}

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca ptr, align 8
  store i32 0, ptr @flag1_SHARED, align 4
  store i32 0, ptr @flag2_SHARED, align 4
  store i32 0, ptr @release_thr1_SHARED, align 4
  %3 = call i32 @pthread_create(ptr noundef %1, ptr noundef null, ptr noundef @thr1, ptr noundef null)
  %4 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @thr2, ptr noundef null)
  %5 = load ptr, ptr %1, align 8
  %6 = call i32 @"\01_pthread_join"(ptr noundef %5, ptr noundef null)
  %7 = load ptr, ptr %2, align 8
  %8 = call i32 @"\01_pthread_join"(ptr noundef %7, ptr noundef null)
  ret i32 0
}

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

declare i32 @"\01_pthread_join"(ptr noundef, ptr noundef) #1

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #2 = { cold noreturn "disable-tail-calls"="true" "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #3 = { cold noreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Apple clang version 17.0.0 (clang-1700.6.4.2)"}
