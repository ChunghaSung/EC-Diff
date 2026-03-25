; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_cond_t = type { i64, [40 x i8] }
%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@cond0 = global %struct._opaque_pthread_cond_t { i64 1018212795, [40 x i8] zeroinitializer }, align 8
@cond0_bool = global i32 0, align 4
@mutex0 = global %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer }, align 8
@data_SHARED = global i32 0, align 4
@mutex = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@__func__.thread3 = private unnamed_addr constant [8 x i8] c"thread3\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main1.c\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thread1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %5 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  %6 = load i32, ptr @cond0_bool, align 4
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %10, label %8

8:                                                ; preds = %1
  %9 = call i32 @"\01_pthread_cond_wait"(ptr noundef @cond0, ptr noundef @mutex0)
  br label %10

10:                                               ; preds = %8, %1
  %11 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  %12 = call i32 @pthread_mutex_lock(ptr noundef @mutex)
  %13 = load i32, ptr @data_SHARED, align 4
  store i32 %13, ptr %4, align 4
  %14 = load i32, ptr %4, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, ptr %4, align 4
  %16 = load i32, ptr %4, align 4
  store i32 %16, ptr @data_SHARED, align 4
  %17 = call i32 @pthread_mutex_unlock(ptr noundef @mutex)
  %18 = load ptr, ptr %2, align 8
  ret ptr %18
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @"\01_pthread_cond_wait"(ptr noundef, ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thread2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %5 = call i32 @pthread_mutex_lock(ptr noundef @mutex)
  %6 = load i32, ptr @data_SHARED, align 4
  store i32 %6, ptr %4, align 4
  %7 = load i32, ptr %4, align 4
  %8 = add nsw i32 %7, 2
  store i32 %8, ptr %4, align 4
  %9 = load i32, ptr %4, align 4
  store i32 %9, ptr @data_SHARED, align 4
  %10 = call i32 @pthread_mutex_unlock(ptr noundef @mutex)
  %11 = load ptr, ptr %2, align 8
  ret ptr %11
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thread3(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  store i32 1, ptr @cond0_bool, align 4
  %5 = call i32 @pthread_cond_signal(ptr noundef @cond0)
  %6 = call i32 @pthread_mutex_lock(ptr noundef @mutex)
  %7 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  %8 = load i32, ptr @data_SHARED, align 4
  %9 = icmp sge i32 %8, 3
  br i1 %9, label %10, label %11

10:                                               ; preds = %1
  call void @__assert_rtn(ptr noundef @__func__.thread3, ptr noundef @.str, i32 noundef 53, ptr noundef @.str.1) #3
  unreachable

11:                                               ; preds = %1
  %12 = call i32 @pthread_mutex_unlock(ptr noundef @mutex)
  %13 = load ptr, ptr %2, align 8
  ret ptr %13
}

declare i32 @pthread_cond_signal(ptr noundef) #1

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  %5 = call i32 @pthread_mutex_init(ptr noundef @mutex, ptr noundef null)
  store i32 0, ptr @data_SHARED, align 4
  %6 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @thread1, ptr noundef null)
  %7 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @thread2, ptr noundef null)
  %8 = call i32 @pthread_create(ptr noundef %4, ptr noundef null, ptr noundef @thread3, ptr noundef null)
  %9 = load ptr, ptr %2, align 8
  %10 = call i32 @"\01_pthread_join"(ptr noundef %9, ptr noundef null)
  %11 = load ptr, ptr %3, align 8
  %12 = call i32 @"\01_pthread_join"(ptr noundef %11, ptr noundef null)
  %13 = load ptr, ptr %4, align 8
  %14 = call i32 @"\01_pthread_join"(ptr noundef %13, ptr noundef null)
  ret i32 0
}

declare i32 @pthread_mutex_init(ptr noundef, ptr noundef) #1

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
