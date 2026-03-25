; ModuleID = 'main2.c'
source_filename = "main2.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_cond_t = type { i64, [40 x i8] }
%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@cond2 = global %struct._opaque_pthread_cond_t { i64 1018212795, [40 x i8] zeroinitializer }, align 8
@cond2_bool = global i32 0, align 4
@mutex2 = global %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer }, align 8
@cond1 = global %struct._opaque_pthread_cond_t { i64 1018212795, [40 x i8] zeroinitializer }, align 8
@cond1_bool = global i32 0, align 4
@mutex1 = global %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer }, align 8
@cond0 = global %struct._opaque_pthread_cond_t { i64 1018212795, [40 x i8] zeroinitializer }, align 8
@cond0_bool = global i32 0, align 4
@mutex0 = global %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer }, align 8
@order1_SHARED = global i32 0, align 4
@order2_SHARED = global i32 0, align 4
@order3_SHARED = global i32 0, align 4
@a_SHARED = internal global i32 0, align 4
@b_SHARED = internal global i32 0, align 4
@__func__.checkThread1 = private unnamed_addr constant [13 x i8] c"checkThread1\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main2.c\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@__func__.checkThread2 = private unnamed_addr constant [13 x i8] c"checkThread2\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  %12 = call i32 @pthread_create(ptr noundef %8, ptr noundef null, ptr noundef @setThread1, ptr noundef null)
  %13 = call i32 @pthread_create(ptr noundef %9, ptr noundef null, ptr noundef @setThread2, ptr noundef null)
  %14 = call i32 @pthread_create(ptr noundef %10, ptr noundef null, ptr noundef @checkThread1, ptr noundef null)
  %15 = call i32 @pthread_create(ptr noundef %11, ptr noundef null, ptr noundef @checkThread2, ptr noundef null)
  %16 = load ptr, ptr %8, align 8
  %17 = call i32 @"\01_pthread_join"(ptr noundef %16, ptr noundef null)
  %18 = load ptr, ptr %9, align 8
  %19 = call i32 @"\01_pthread_join"(ptr noundef %18, ptr noundef null)
  %20 = load ptr, ptr %10, align 8
  %21 = call i32 @"\01_pthread_join"(ptr noundef %20, ptr noundef null)
  %22 = load ptr, ptr %11, align 8
  %23 = call i32 @"\01_pthread_join"(ptr noundef %22, ptr noundef null)
  ret i32 0
}

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @setThread1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 1, ptr @a_SHARED, align 4
  %4 = load i32, ptr @order1_SHARED, align 4
  store i32 %4, ptr %3, align 4
  %5 = load i32, ptr @order2_SHARED, align 4
  store i32 %5, ptr %3, align 4
  %6 = load i32, ptr @order3_SHARED, align 4
  store i32 %6, ptr %3, align 4
  %7 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  store i32 1, ptr @cond0_bool, align 4
  %8 = call i32 @pthread_cond_signal(ptr noundef @cond0)
  %9 = call i32 @pthread_mutex_lock(ptr noundef @mutex1)
  store i32 1, ptr @cond1_bool, align 4
  %10 = call i32 @pthread_cond_signal(ptr noundef @cond1)
  %11 = call i32 @pthread_mutex_lock(ptr noundef @mutex2)
  store i32 1, ptr @cond2_bool, align 4
  %12 = call i32 @pthread_cond_signal(ptr noundef @cond2)
  store i32 -1, ptr @b_SHARED, align 4
  %13 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  %14 = call i32 @pthread_mutex_unlock(ptr noundef @mutex1)
  %15 = call i32 @pthread_mutex_unlock(ptr noundef @mutex2)
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @setThread2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  %4 = load i32, ptr @cond0_bool, align 4
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %8, label %6

6:                                                ; preds = %1
  %7 = call i32 @"\01_pthread_cond_wait"(ptr noundef @cond0, ptr noundef @mutex0)
  br label %8

8:                                                ; preds = %6, %1
  %9 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  store i32 1, ptr @order1_SHARED, align 4
  store i32 1, ptr @a_SHARED, align 4
  store i32 -1, ptr @b_SHARED, align 4
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @checkThread1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = call i32 @pthread_mutex_lock(ptr noundef @mutex1)
  %4 = load i32, ptr @cond1_bool, align 4
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %8, label %6

6:                                                ; preds = %1
  %7 = call i32 @"\01_pthread_cond_wait"(ptr noundef @cond1, ptr noundef @mutex1)
  br label %8

8:                                                ; preds = %6, %1
  %9 = call i32 @pthread_mutex_unlock(ptr noundef @mutex1)
  store i32 1, ptr @order2_SHARED, align 4
  %10 = load i32, ptr @a_SHARED, align 4
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %12, label %15

12:                                               ; preds = %8
  %13 = load i32, ptr @b_SHARED, align 4
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %22, label %15

15:                                               ; preds = %12, %8
  %16 = load i32, ptr @a_SHARED, align 4
  %17 = icmp eq i32 %16, 1
  br i1 %17, label %18, label %21

18:                                               ; preds = %15
  %19 = load i32, ptr @b_SHARED, align 4
  %20 = icmp eq i32 %19, -1
  br i1 %20, label %22, label %21

21:                                               ; preds = %18, %15
  call void @__assert_rtn(ptr noundef @__func__.checkThread1, ptr noundef @.str, i32 noundef 149, ptr noundef @.str.1) #3
  unreachable

22:                                               ; preds = %18, %12
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @checkThread2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = call i32 @pthread_mutex_lock(ptr noundef @mutex2)
  %4 = load i32, ptr @cond2_bool, align 4
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %8, label %6

6:                                                ; preds = %1
  %7 = call i32 @"\01_pthread_cond_wait"(ptr noundef @cond2, ptr noundef @mutex2)
  br label %8

8:                                                ; preds = %6, %1
  %9 = call i32 @pthread_mutex_unlock(ptr noundef @mutex2)
  store i32 1, ptr @order3_SHARED, align 4
  %10 = load i32, ptr @a_SHARED, align 4
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %12, label %15

12:                                               ; preds = %8
  %13 = load i32, ptr @b_SHARED, align 4
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %22, label %15

15:                                               ; preds = %12, %8
  %16 = load i32, ptr @a_SHARED, align 4
  %17 = icmp eq i32 %16, 1
  br i1 %17, label %18, label %21

18:                                               ; preds = %15
  %19 = load i32, ptr @b_SHARED, align 4
  %20 = icmp eq i32 %19, -1
  br i1 %20, label %22, label %21

21:                                               ; preds = %18, %15
  call void @__assert_rtn(ptr noundef @__func__.checkThread2, ptr noundef @.str, i32 noundef 166, ptr noundef @.str.1) #3
  unreachable

22:                                               ; preds = %18, %12
  ret ptr null
}

declare i32 @"\01_pthread_join"(ptr noundef, ptr noundef) #1

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @pthread_cond_signal(ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

declare i32 @"\01_pthread_cond_wait"(ptr noundef, ptr noundef) #1

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #2

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
