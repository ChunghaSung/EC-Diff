; ModuleID = 'main2.c'
source_filename = "main2.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@p0_SHARED = common global i32 0, align 4
@var0_SHARED = common global i32 0, align 4
@c0_SHARED = common global i32 0, align 4
@result_SHARED = common global i32 0, align 4
@__func__.main = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main2.c\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@mutex0 = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thread1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %3, align 4
  call void @nop1()
  %5 = load i32, ptr @p0_SHARED, align 4
  store i32 %5, ptr %3, align 4
  %6 = load i32, ptr @p0_SHARED, align 4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %12

8:                                                ; preds = %1
  %9 = load i32, ptr @var0_SHARED, align 4
  %10 = load i32, ptr @c0_SHARED, align 4
  %11 = mul nsw i32 %9, %10
  store i32 %11, ptr %3, align 4
  br label %12

12:                                               ; preds = %8, %1
  %13 = load i32, ptr %3, align 4
  store i32 %13, ptr @p0_SHARED, align 4
  call void @nop1()
  %14 = load i32, ptr @p0_SHARED, align 4
  store i32 %14, ptr %4, align 4
  %15 = load i32, ptr %4, align 4
  store i32 %15, ptr @result_SHARED, align 4
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thread2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %3, align 4
  call void @nop1()
  %5 = load i32, ptr @p0_SHARED, align 4
  store i32 %5, ptr %3, align 4
  %6 = load i32, ptr @p0_SHARED, align 4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %12

8:                                                ; preds = %1
  %9 = load i32, ptr @var0_SHARED, align 4
  %10 = load i32, ptr @c0_SHARED, align 4
  %11 = mul nsw i32 %9, %10
  store i32 %11, ptr %3, align 4
  br label %12

12:                                               ; preds = %8, %1
  %13 = load i32, ptr %3, align 4
  store i32 %13, ptr @p0_SHARED, align 4
  call void @nop1()
  %14 = load i32, ptr @p0_SHARED, align 4
  store i32 %14, ptr %4, align 4
  %15 = load i32, ptr %4, align 4
  store i32 %15, ptr @result_SHARED, align 4
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @main() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca ptr, align 8
  store i32 2, ptr @var0_SHARED, align 4
  store i32 4, ptr @c0_SHARED, align 4
  store i32 0, ptr @p0_SHARED, align 4
  store i32 0, ptr @result_SHARED, align 4
  %3 = call i32 @pthread_create(ptr noundef %1, ptr noundef null, ptr noundef @thread1, ptr noundef null)
  %4 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @thread2, ptr noundef null)
  %5 = load ptr, ptr %1, align 8
  %6 = call i32 @"\01_pthread_join"(ptr noundef %5, ptr noundef null)
  %7 = load ptr, ptr %2, align 8
  %8 = call i32 @"\01_pthread_join"(ptr noundef %7, ptr noundef null)
  %9 = load i32, ptr @result_SHARED, align 4
  %10 = load i32, ptr @p0_SHARED, align 4
  %11 = icmp ne i32 %9, %10
  br i1 %11, label %12, label %13

12:                                               ; preds = %0
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str, i32 noundef 86, ptr noundef @.str.1) #3
  unreachable

13:                                               ; preds = %0
  ret void
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
