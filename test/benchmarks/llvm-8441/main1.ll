; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_cond_t = type { i64, [40 x i8] }
%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@cond0 = global %struct._opaque_pthread_cond_t { i64 1018212795, [40 x i8] zeroinitializer }, align 8
@cond0_bool = global i32 0, align 4
@mutex0 = global %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer }, align 8
@mutex1 = global %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer }, align 8
@ref_count_g_SHARED = common global i8 0, align 1
@data_g_SHARED = common global i8 0, align 1
@destroyed_t1_g_SHARED = common global i8 0, align 1
@destroyed_t2_g_SHARED = common global i8 0, align 1
@__func__.main = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main1.c\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @t1_main(ptr noundef %0) #0 {
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
  %10 = call i32 @pthread_mutex_lock(ptr noundef @mutex1)
  %11 = load i8, ptr @ref_count_g_SHARED, align 1
  %12 = add i8 %11, 1
  store i8 %12, ptr @ref_count_g_SHARED, align 1
  store i8 97, ptr @data_g_SHARED, align 1
  %13 = load i8, ptr @ref_count_g_SHARED, align 1
  %14 = add i8 %13, -1
  store i8 %14, ptr @ref_count_g_SHARED, align 1
  %15 = load i8, ptr @ref_count_g_SHARED, align 1
  %16 = zext i8 %15 to i32
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %19

18:                                               ; preds = %8
  store i8 1, ptr @destroyed_t1_g_SHARED, align 1
  br label %19

19:                                               ; preds = %18, %8
  %20 = call i32 @pthread_mutex_unlock(ptr noundef @mutex1)
  ret ptr null
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @"\01_pthread_cond_wait"(ptr noundef, ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @t2_main(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = call i32 @pthread_mutex_lock(ptr noundef @mutex1)
  %4 = load i8, ptr @ref_count_g_SHARED, align 1
  %5 = add i8 %4, 1
  store i8 %5, ptr @ref_count_g_SHARED, align 1
  store i8 97, ptr @data_g_SHARED, align 1
  %6 = load i8, ptr @ref_count_g_SHARED, align 1
  %7 = add i8 %6, -1
  store i8 %7, ptr @ref_count_g_SHARED, align 1
  %8 = load i8, ptr @ref_count_g_SHARED, align 1
  %9 = zext i8 %8 to i32
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %1
  store i8 1, ptr @destroyed_t2_g_SHARED, align 1
  br label %12

12:                                               ; preds = %11, %1
  %13 = call i32 @pthread_mutex_unlock(ptr noundef @mutex1)
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  store i8 120, ptr @data_g_SHARED, align 1
  store i8 0, ptr @ref_count_g_SHARED, align 1
  store i8 0, ptr @destroyed_t1_g_SHARED, align 1
  %4 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @t1_main, ptr noundef null)
  %5 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @t2_main, ptr noundef null)
  %6 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  store i32 1, ptr @cond0_bool, align 4
  %7 = call i32 @pthread_cond_signal(ptr noundef @cond0)
  %8 = load i8, ptr @destroyed_t1_g_SHARED, align 1
  %9 = trunc i8 %8 to i1
  br i1 %9, label %10, label %14

10:                                               ; preds = %0
  %11 = load i8, ptr @destroyed_t2_g_SHARED, align 1
  %12 = trunc i8 %11 to i1
  br i1 %12, label %13, label %14

13:                                               ; preds = %10
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str, i32 noundef 121, ptr noundef @.str.1) #3
  unreachable

14:                                               ; preds = %10, %0
  %15 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  ret i32 0
}

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

declare i32 @pthread_cond_signal(ptr noundef) #1

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
