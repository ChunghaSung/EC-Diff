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
@count_SHARED = global i32 0, align 4
@c_SHARED = common global i32 0, align 4

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thr1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  store i32 1, ptr @cond0_bool, align 4
  %5 = call i32 @pthread_cond_signal(ptr noundef @cond0)
  %6 = call i32 @pthread_mutex_lock(ptr noundef @mutex1)
  store i32 1, ptr @cond1_bool, align 4
  %7 = call i32 @pthread_cond_signal(ptr noundef @cond1)
  %8 = call i32 @pthread_mutex_lock(ptr noundef @mutex2)
  %9 = load i32, ptr @cond2_bool, align 4
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %13, label %11

11:                                               ; preds = %1
  %12 = call i32 @"\01_pthread_cond_wait"(ptr noundef @cond2, ptr noundef @mutex2)
  br label %13

13:                                               ; preds = %11, %1
  %14 = call i32 @pthread_mutex_unlock(ptr noundef @mutex2)
  %15 = load volatile i32, ptr @count_SHARED, align 4
  %16 = add i32 %15, 1
  store volatile i32 %16, ptr @count_SHARED, align 4
  %17 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  %18 = call i32 @pthread_mutex_unlock(ptr noundef @mutex1)
  %19 = load volatile i32, ptr @count_SHARED, align 4
  %20 = icmp eq i32 %19, 3
  br i1 %20, label %21, label %22

21:                                               ; preds = %13
  store i32 1, ptr @c_SHARED, align 4
  store volatile i32 0, ptr @count_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %23

22:                                               ; preds = %13
  store i32 0, ptr @c_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %23

23:                                               ; preds = %22, %21
  %24 = load ptr, ptr %2, align 8
  ret ptr %24
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @pthread_cond_signal(ptr noundef) #1

declare i32 @"\01_pthread_cond_wait"(ptr noundef, ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thr2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  %5 = load i32, ptr @cond0_bool, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %9, label %7

7:                                                ; preds = %1
  %8 = call i32 @"\01_pthread_cond_wait"(ptr noundef @cond0, ptr noundef @mutex0)
  br label %9

9:                                                ; preds = %7, %1
  %10 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  %11 = load volatile i32, ptr @count_SHARED, align 4
  %12 = add i32 %11, 1
  store volatile i32 %12, ptr @count_SHARED, align 4
  %13 = call i32 @pthread_mutex_lock(ptr noundef @mutex2)
  store i32 1, ptr @cond2_bool, align 4
  %14 = call i32 @pthread_cond_signal(ptr noundef @cond2)
  %15 = load volatile i32, ptr @count_SHARED, align 4
  %16 = icmp eq i32 %15, 3
  br i1 %16, label %17, label %18

17:                                               ; preds = %9
  store i32 1, ptr @c_SHARED, align 4
  store volatile i32 0, ptr @count_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %20

18:                                               ; preds = %9
  %19 = call i32 @pthread_mutex_unlock(ptr noundef @mutex2)
  store i32 0, ptr @c_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %20

20:                                               ; preds = %18, %17
  %21 = load ptr, ptr %2, align 8
  ret ptr %21
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thr3(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = call i32 @pthread_mutex_lock(ptr noundef @mutex1)
  %5 = load i32, ptr @cond1_bool, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %9, label %7

7:                                                ; preds = %1
  %8 = call i32 @"\01_pthread_cond_wait"(ptr noundef @cond1, ptr noundef @mutex1)
  br label %9

9:                                                ; preds = %7, %1
  %10 = call i32 @pthread_mutex_unlock(ptr noundef @mutex1)
  %11 = load volatile i32, ptr @count_SHARED, align 4
  %12 = add i32 %11, 1
  store volatile i32 %12, ptr @count_SHARED, align 4
  %13 = load volatile i32, ptr @count_SHARED, align 4
  %14 = icmp eq i32 %13, 3
  br i1 %14, label %15, label %16

15:                                               ; preds = %9
  store i32 1, ptr @c_SHARED, align 4
  store volatile i32 0, ptr @count_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %17

16:                                               ; preds = %9
  store i32 0, ptr @c_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %17

17:                                               ; preds = %16, %15
  %18 = load ptr, ptr %2, align 8
  ret ptr %18
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  %5 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @thr1, ptr noundef null)
  %6 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @thr2, ptr noundef null)
  %7 = call i32 @pthread_create(ptr noundef %4, ptr noundef null, ptr noundef @thr3, ptr noundef null)
  ret i32 0
}

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Apple clang version 17.0.0 (clang-1700.6.4.2)"}
