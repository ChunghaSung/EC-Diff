; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@mutex0 = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@length_SHARED = common global i32 0, align 4
@__func__.t1_main = private unnamed_addr constant [8 x i8] c"t1_main\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main1.c\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@capacity_SHARED = common global i32 0, align 4
@ref_count_SHARED = common global i32 0, align 4
@__func__.t2_main = private unnamed_addr constant [8 x i8] c"t2_main\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @t1_main(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %5 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  store i32 1, ptr @length_SHARED, align 4
  %6 = load i32, ptr @length_SHARED, align 4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %1
  store ptr null, ptr %2, align 8
  br label %16

9:                                                ; preds = %1
  %10 = load i32, ptr @length_SHARED, align 4
  store i32 %10, ptr %4, align 4
  store i32 0, ptr @length_SHARED, align 4
  %11 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  %12 = load i32, ptr %4, align 4
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %14, label %15

14:                                               ; preds = %9
  call void @__assert_rtn(ptr noundef @__func__.t1_main, ptr noundef @.str, i32 noundef 50, ptr noundef @.str.1) #3
  unreachable

15:                                               ; preds = %9
  store i32 0, ptr @capacity_SHARED, align 4
  store i32 0, ptr @ref_count_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %16

16:                                               ; preds = %15, %8
  %17 = load ptr, ptr %2, align 8
  ret ptr %17
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @t2_main(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %5 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  store i32 1, ptr @length_SHARED, align 4
  %6 = load i32, ptr @length_SHARED, align 4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %1
  store ptr null, ptr %2, align 8
  br label %16

9:                                                ; preds = %1
  %10 = load i32, ptr @length_SHARED, align 4
  store i32 %10, ptr %4, align 4
  store i32 0, ptr @length_SHARED, align 4
  %11 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  %12 = load i32, ptr %4, align 4
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %14, label %15

14:                                               ; preds = %9
  call void @__assert_rtn(ptr noundef @__func__.t2_main, ptr noundef @.str, i32 noundef 74, ptr noundef @.str.1) #3
  unreachable

15:                                               ; preds = %9
  store i32 0, ptr @capacity_SHARED, align 4
  store i32 0, ptr @ref_count_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %16

16:                                               ; preds = %15, %8
  %17 = load ptr, ptr %2, align 8
  ret ptr %17
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  store i32 1, ptr @length_SHARED, align 4
  store i32 1, ptr @capacity_SHARED, align 4
  store i32 1, ptr @ref_count_SHARED, align 4
  %4 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @t1_main, ptr noundef null)
  %5 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @t2_main, ptr noundef null)
  %6 = load ptr, ptr %2, align 8
  %7 = call i32 @"\01_pthread_join"(ptr noundef %6, ptr noundef null)
  %8 = load ptr, ptr %3, align 8
  %9 = call i32 @"\01_pthread_join"(ptr noundef %8, ptr noundef null)
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
