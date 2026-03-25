; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_cond_t = type { i64, [40 x i8] }
%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@i_SHARED = global i32 1, align 4
@j_SHARED = global i32 1, align 4
@cond0 = global %struct._opaque_pthread_cond_t { i64 1018212795, [40 x i8] zeroinitializer }, align 8
@cond0_bool = global i32 0, align 4
@mutex0 = global %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer }, align 8
@__func__.main = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main1.c\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @t1(ptr noundef %0) #0 {
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
  %10 = load i32, ptr @j_SHARED, align 4
  %11 = load i32, ptr @i_SHARED, align 4
  %12 = add nsw i32 %11, %10
  store i32 %12, ptr @i_SHARED, align 4
  %13 = load i32, ptr @j_SHARED, align 4
  %14 = load i32, ptr @i_SHARED, align 4
  %15 = add nsw i32 %14, %13
  store i32 %15, ptr @i_SHARED, align 4
  %16 = load i32, ptr @j_SHARED, align 4
  %17 = load i32, ptr @i_SHARED, align 4
  %18 = add nsw i32 %17, %16
  store i32 %18, ptr @i_SHARED, align 4
  %19 = load i32, ptr @j_SHARED, align 4
  %20 = load i32, ptr @i_SHARED, align 4
  %21 = add nsw i32 %20, %19
  store i32 %21, ptr @i_SHARED, align 4
  %22 = load i32, ptr @j_SHARED, align 4
  %23 = load i32, ptr @i_SHARED, align 4
  %24 = add nsw i32 %23, %22
  store i32 %24, ptr @i_SHARED, align 4
  %25 = load i32, ptr @j_SHARED, align 4
  %26 = load i32, ptr @i_SHARED, align 4
  %27 = add nsw i32 %26, %25
  store i32 %27, ptr @i_SHARED, align 4
  call void @pthread_exit(ptr noundef null) #4
  unreachable
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @"\01_pthread_cond_wait"(ptr noundef, ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: noreturn
declare void @pthread_exit(ptr noundef) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @t2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load i32, ptr @j_SHARED, align 4
  %4 = load i32, ptr @i_SHARED, align 4
  %5 = add nsw i32 %4, %3
  store i32 %5, ptr @i_SHARED, align 4
  %6 = load i32, ptr @j_SHARED, align 4
  %7 = load i32, ptr @i_SHARED, align 4
  %8 = add nsw i32 %7, %6
  store i32 %8, ptr @i_SHARED, align 4
  %9 = load i32, ptr @j_SHARED, align 4
  %10 = load i32, ptr @i_SHARED, align 4
  %11 = add nsw i32 %10, %9
  store i32 %11, ptr @i_SHARED, align 4
  %12 = load i32, ptr @j_SHARED, align 4
  %13 = load i32, ptr @i_SHARED, align 4
  %14 = add nsw i32 %13, %12
  store i32 %14, ptr @i_SHARED, align 4
  %15 = load i32, ptr @j_SHARED, align 4
  %16 = load i32, ptr @i_SHARED, align 4
  %17 = add nsw i32 %16, %15
  store i32 %17, ptr @i_SHARED, align 4
  %18 = load i32, ptr @j_SHARED, align 4
  %19 = load i32, ptr @i_SHARED, align 4
  %20 = add nsw i32 %19, %18
  store i32 %20, ptr @i_SHARED, align 4
  call void @pthread_exit(ptr noundef null) #4
  unreachable
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  %8 = call i32 @pthread_create(ptr noundef %6, ptr noundef null, ptr noundef @t1, ptr noundef null)
  %9 = call i32 @pthread_create(ptr noundef %7, ptr noundef null, ptr noundef @t2, ptr noundef null)
  %10 = load ptr, ptr %7, align 8
  %11 = call i32 @"\01_pthread_join"(ptr noundef %10, ptr noundef null)
  %12 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  store i32 1, ptr @cond0_bool, align 4
  %13 = call i32 @pthread_cond_signal(ptr noundef @cond0)
  %14 = load i32, ptr @i_SHARED, align 4
  %15 = icmp sge i32 %14, 377
  br i1 %15, label %19, label %16

16:                                               ; preds = %2
  %17 = load i32, ptr @j_SHARED, align 4
  %18 = icmp sge i32 %17, 377
  br i1 %18, label %19, label %21

19:                                               ; preds = %16, %2
  %20 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str, i32 noundef 59, ptr noundef @.str.1) #5
  unreachable

21:                                               ; preds = %16
  ret i32 0
}

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

declare i32 @"\01_pthread_join"(ptr noundef, ptr noundef) #1

declare i32 @pthread_cond_signal(ptr noundef) #1

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #3

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #2 = { noreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #3 = { cold noreturn "disable-tail-calls"="true" "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #4 = { noreturn }
attributes #5 = { cold noreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Apple clang version 17.0.0 (clang-1700.6.4.2)"}
