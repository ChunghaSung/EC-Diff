; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@tail_SHARED = common global i8 0, align 1
@size_SHARED = common global i8 0, align 1
@items_SHARED = common global [5 x i8] zeroinitializer, align 1
@head_SHARED = common global i8 0, align 1
@head_SHAREDLock = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@__func__.main = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main1.c\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@mutex0 = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @t1_main(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load i8, ptr @tail_SHARED, align 1
  %4 = sext i8 %3 to i32
  %5 = add nsw i32 %4, 1
  %6 = trunc i32 %5 to i8
  store i8 %6, ptr @tail_SHARED, align 1
  call void @nop1()
  %7 = load i8, ptr @size_SHARED, align 1
  %8 = add i8 %7, 1
  store i8 %8, ptr @size_SHARED, align 1
  call void @nop1()
  %9 = load i8, ptr @tail_SHARED, align 1
  %10 = sext i8 %9 to i64
  %11 = getelementptr inbounds [5 x i8], ptr @items_SHARED, i64 0, i64 %10
  store i8 1, ptr %11, align 1
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @t2_main(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load i8, ptr @tail_SHARED, align 1
  %4 = sext i8 %3 to i32
  %5 = add nsw i32 %4, 1
  %6 = trunc i32 %5 to i8
  store i8 %6, ptr @tail_SHARED, align 1
  call void @nop1()
  %7 = load i8, ptr @size_SHARED, align 1
  %8 = add i8 %7, 1
  store i8 %8, ptr @size_SHARED, align 1
  call void @nop1()
  %9 = load i8, ptr @tail_SHARED, align 1
  %10 = sext i8 %9 to i64
  %11 = getelementptr inbounds [5 x i8], ptr @items_SHARED, i64 0, i64 %10
  store i8 2, ptr %11, align 1
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i8, align 1
  %5 = alloca i8, align 1
  %6 = alloca i32, align 4
  %7 = alloca i8, align 1
  %8 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i8 0, ptr @head_SHARED, align 1
  store i8 0, ptr @tail_SHARED, align 1
  store i8 0, ptr @size_SHARED, align 1
  %9 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @t1_main, ptr noundef null)
  %10 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @t2_main, ptr noundef null)
  %11 = load ptr, ptr %2, align 8
  %12 = call i32 @"\01_pthread_join"(ptr noundef %11, ptr noundef null)
  %13 = load ptr, ptr %3, align 8
  %14 = call i32 @"\01_pthread_join"(ptr noundef %13, ptr noundef null)
  %15 = call i32 @pthread_mutex_lock(ptr noundef @head_SHAREDLock)
  %16 = load i8, ptr @head_SHARED, align 1
  store i8 %16, ptr %7, align 1
  %17 = load i8, ptr @size_SHARED, align 1
  %18 = sext i8 %17 to i32
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %22

20:                                               ; preds = %0
  %21 = call i32 @pthread_mutex_unlock(ptr noundef @head_SHAREDLock)
  store i32 -1, ptr %6, align 4
  br label %30

22:                                               ; preds = %0
  store i32 0, ptr %6, align 4
  %23 = load i8, ptr @head_SHARED, align 1
  %24 = sext i8 %23 to i32
  %25 = add nsw i32 %24, 1
  %26 = trunc i32 %25 to i8
  store i8 %26, ptr @head_SHARED, align 1
  %27 = load i8, ptr @size_SHARED, align 1
  %28 = add i8 %27, -1
  store i8 %28, ptr @size_SHARED, align 1
  %29 = call i32 @pthread_mutex_unlock(ptr noundef @head_SHAREDLock)
  br label %30

30:                                               ; preds = %22, %20
  %31 = call i32 @pthread_mutex_lock(ptr noundef @head_SHAREDLock)
  %32 = load i8, ptr @head_SHARED, align 1
  store i8 %32, ptr %7, align 1
  %33 = load i8, ptr @size_SHARED, align 1
  %34 = sext i8 %33 to i32
  %35 = icmp eq i32 %34, 0
  br i1 %35, label %36, label %38

36:                                               ; preds = %30
  %37 = call i32 @pthread_mutex_unlock(ptr noundef @head_SHAREDLock)
  store i32 -1, ptr %8, align 4
  br label %46

38:                                               ; preds = %30
  store i32 0, ptr %8, align 4
  %39 = load i8, ptr @head_SHARED, align 1
  %40 = sext i8 %39 to i32
  %41 = add nsw i32 %40, 1
  %42 = trunc i32 %41 to i8
  store i8 %42, ptr @head_SHARED, align 1
  %43 = load i8, ptr @size_SHARED, align 1
  %44 = add i8 %43, -1
  store i8 %44, ptr @size_SHARED, align 1
  %45 = call i32 @pthread_mutex_unlock(ptr noundef @head_SHAREDLock)
  br label %46

46:                                               ; preds = %38, %36
  %47 = load i32, ptr %6, align 4
  %48 = icmp eq i32 %47, -1
  br i1 %48, label %49, label %50

49:                                               ; preds = %46
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str, i32 noundef 109, ptr noundef @.str.1) #3
  unreachable

50:                                               ; preds = %46
  %51 = load i32, ptr %8, align 4
  %52 = icmp eq i32 %51, -1
  br i1 %52, label %53, label %54

53:                                               ; preds = %50
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str, i32 noundef 112, ptr noundef @.str.1) #3
  unreachable

54:                                               ; preds = %50
  ret i32 0
}

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

declare i32 @"\01_pthread_join"(ptr noundef, ptr noundef) #1

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

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
