; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@shared_SHARED = common global i32 0, align 4
@__func__.main = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main1.c\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"shared_SHARED == 0\00", align 1
@mutex0 = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @t1_main(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @nop1()
  %3 = load i32, ptr @shared_SHARED, align 4
  %4 = add nsw i32 %3, 1
  store i32 %4, ptr @shared_SHARED, align 4
  %5 = load i32, ptr @shared_SHARED, align 4
  %6 = add nsw i32 %5, 1
  store i32 %6, ptr @shared_SHARED, align 4
  %7 = load i32, ptr @shared_SHARED, align 4
  %8 = add nsw i32 %7, 1
  store i32 %8, ptr @shared_SHARED, align 4
  %9 = load i32, ptr @shared_SHARED, align 4
  %10 = add nsw i32 %9, 1
  store i32 %10, ptr @shared_SHARED, align 4
  %11 = load i32, ptr @shared_SHARED, align 4
  %12 = add nsw i32 %11, 1
  store i32 %12, ptr @shared_SHARED, align 4
  %13 = load i32, ptr @shared_SHARED, align 4
  %14 = add nsw i32 %13, 1
  store i32 %14, ptr @shared_SHARED, align 4
  %15 = load i32, ptr @shared_SHARED, align 4
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr @shared_SHARED, align 4
  %17 = load i32, ptr @shared_SHARED, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, ptr @shared_SHARED, align 4
  %19 = load i32, ptr @shared_SHARED, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, ptr @shared_SHARED, align 4
  %21 = load i32, ptr @shared_SHARED, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr @shared_SHARED, align 4
  call void @nop1()
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @t2_main(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @nop1()
  %3 = load i32, ptr @shared_SHARED, align 4
  %4 = add nsw i32 %3, -1
  store i32 %4, ptr @shared_SHARED, align 4
  %5 = load i32, ptr @shared_SHARED, align 4
  %6 = add nsw i32 %5, -1
  store i32 %6, ptr @shared_SHARED, align 4
  %7 = load i32, ptr @shared_SHARED, align 4
  %8 = add nsw i32 %7, -1
  store i32 %8, ptr @shared_SHARED, align 4
  %9 = load i32, ptr @shared_SHARED, align 4
  %10 = add nsw i32 %9, -1
  store i32 %10, ptr @shared_SHARED, align 4
  %11 = load i32, ptr @shared_SHARED, align 4
  %12 = add nsw i32 %11, -1
  store i32 %12, ptr @shared_SHARED, align 4
  %13 = load i32, ptr @shared_SHARED, align 4
  %14 = add nsw i32 %13, -1
  store i32 %14, ptr @shared_SHARED, align 4
  %15 = load i32, ptr @shared_SHARED, align 4
  %16 = add nsw i32 %15, -1
  store i32 %16, ptr @shared_SHARED, align 4
  %17 = load i32, ptr @shared_SHARED, align 4
  %18 = add nsw i32 %17, -1
  store i32 %18, ptr @shared_SHARED, align 4
  %19 = load i32, ptr @shared_SHARED, align 4
  %20 = add nsw i32 %19, -1
  store i32 %20, ptr @shared_SHARED, align 4
  %21 = load i32, ptr @shared_SHARED, align 4
  %22 = add nsw i32 %21, -1
  store i32 %22, ptr @shared_SHARED, align 4
  call void @nop1()
  ret ptr null
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
  store i32 0, ptr @shared_SHARED, align 4
  %8 = call i32 @pthread_create(ptr noundef %6, ptr noundef null, ptr noundef @t1_main, ptr noundef null)
  %9 = call i32 @pthread_create(ptr noundef %7, ptr noundef null, ptr noundef @t2_main, ptr noundef null)
  %10 = load ptr, ptr %6, align 8
  %11 = call i32 @"\01_pthread_join"(ptr noundef %10, ptr noundef null)
  %12 = load ptr, ptr %7, align 8
  %13 = call i32 @"\01_pthread_join"(ptr noundef %12, ptr noundef null)
  %14 = load i32, ptr @shared_SHARED, align 4
  %15 = icmp eq i32 %14, 0
  %16 = xor i1 %15, true
  %17 = zext i1 %16 to i32
  %18 = sext i32 %17 to i64
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %20, label %22

20:                                               ; preds = %2
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str, i32 noundef 91, ptr noundef @.str.1) #3
  unreachable

21:                                               ; No predecessors!
  br label %23

22:                                               ; preds = %2
  br label %23

23:                                               ; preds = %22, %21
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
