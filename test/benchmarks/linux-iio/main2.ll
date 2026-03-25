; ModuleID = 'main2.c'
source_filename = "main2.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@mutex0 = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@trigger_use_count_SHARED = common global i32 0, align 4
@trig_subirqs_enabled_SHARED = common global i32 0, align 4
@trigger_has_ops_SHARED = common global i32 0, align 4
@trigger_ops_has_tryreenable_function_SHARED = common global i32 0, align 4
@trigger_reenable_function_SHARED = common global i32 0, align 4
@CONFIG_IIO_CONSUMERS_PER_TRIGGER_SHARED = common global i32 0, align 4
@__func__.main = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main2.c\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thread1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  store i32 0, ptr %5, align 4
  %6 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  %7 = load i32, ptr @trigger_use_count_SHARED, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %52

9:                                                ; preds = %1
  %10 = load i32, ptr %4, align 4
  %11 = load i32, ptr @trig_subirqs_enabled_SHARED, align 4
  %12 = icmp slt i32 %10, %11
  br i1 %12, label %13, label %17

13:                                               ; preds = %9
  %14 = load i32, ptr @trigger_use_count_SHARED, align 4
  store i32 %14, ptr %3, align 4
  %15 = load i32, ptr %3, align 4
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr @trigger_use_count_SHARED, align 4
  br label %49

17:                                               ; preds = %9
  %18 = load i32, ptr @trigger_use_count_SHARED, align 4
  store i32 %18, ptr %3, align 4
  %19 = load i32, ptr %3, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, ptr @trigger_use_count_SHARED, align 4
  %21 = load i32, ptr @trigger_use_count_SHARED, align 4
  %22 = icmp ne i32 %21, 0
  br i1 %22, label %23, label %48

23:                                               ; preds = %17
  %24 = load i32, ptr @trigger_has_ops_SHARED, align 4
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %26, label %47

26:                                               ; preds = %23
  %27 = load i32, ptr @trigger_ops_has_tryreenable_function_SHARED, align 4
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %29, label %47

29:                                               ; preds = %26
  %30 = load i32, ptr @trigger_reenable_function_SHARED, align 4
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %32, label %46

32:                                               ; preds = %29
  %33 = load i32, ptr @trigger_use_count_SHARED, align 4
  %34 = icmp ne i32 %33, 0
  br i1 %34, label %35, label %45

35:                                               ; preds = %32
  %36 = load i32, ptr %5, align 4
  %37 = icmp slt i32 %36, 4
  br i1 %37, label %38, label %42

38:                                               ; preds = %35
  %39 = load i32, ptr @trigger_use_count_SHARED, align 4
  store i32 %39, ptr %3, align 4
  %40 = load i32, ptr %3, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr @trigger_use_count_SHARED, align 4
  br label %42

42:                                               ; preds = %38, %35
  %43 = load i32, ptr %5, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %5, align 4
  br label %45

45:                                               ; preds = %42, %32
  br label %46

46:                                               ; preds = %45, %29
  br label %47

47:                                               ; preds = %46, %26, %23
  br label %48

48:                                               ; preds = %47, %17
  br label %49

49:                                               ; preds = %48, %13
  %50 = load i32, ptr %4, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, ptr %4, align 4
  br label %52

52:                                               ; preds = %49, %1
  %53 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  ret ptr null
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thread2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %4 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  %5 = load i32, ptr @trigger_use_count_SHARED, align 4
  store i32 %5, ptr %3, align 4
  %6 = load i32, ptr %3, align 4
  %7 = add nsw i32 %6, 1
  store i32 %7, ptr @trigger_use_count_SHARED, align 4
  %8 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  store i32 1, ptr @trigger_use_count_SHARED, align 4
  store i32 0, ptr @trigger_has_ops_SHARED, align 4
  store i32 0, ptr @trigger_reenable_function_SHARED, align 4
  store i32 1, ptr @trigger_ops_has_tryreenable_function_SHARED, align 4
  store i32 1, ptr @CONFIG_IIO_CONSUMERS_PER_TRIGGER_SHARED, align 4
  store i32 0, ptr @trig_subirqs_enabled_SHARED, align 4
  %4 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @thread1, ptr noundef null)
  %5 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @thread2, ptr noundef null)
  %6 = load ptr, ptr %2, align 8
  %7 = call i32 @"\01_pthread_join"(ptr noundef %6, ptr noundef null)
  %8 = load ptr, ptr %3, align 8
  %9 = call i32 @"\01_pthread_join"(ptr noundef %8, ptr noundef null)
  %10 = load i32, ptr @trigger_use_count_SHARED, align 4
  %11 = icmp ne i32 %10, 3
  br i1 %11, label %12, label %13

12:                                               ; preds = %0
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str, i32 noundef 109, ptr noundef @.str.1) #3
  unreachable

13:                                               ; preds = %0
  ret i32 0
}

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

declare i32 @"\01_pthread_join"(ptr noundef, ptr noundef) #1

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
