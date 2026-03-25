; ModuleID = 'main2.c'
source_filename = "main2.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }
%struct._opaque_pthread_cond_t = type { i64, [40 x i8] }

@cond0_bool = global i32 0, align 4
@deposit_done_SHARED = global i8 0, align 1
@withdraw_done_SHARED = global i8 0, align 1
@balance_SHARED = common global i32 0, align 4
@y_SHARED = common global i32 0, align 4
@z_SHARED = common global i32 0, align 4
@m = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@x_SHARED = common global i32 0, align 4
@__func__.check_result = private unnamed_addr constant [13 x i8] c"check_result\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main2.c\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@__func__.main = private unnamed_addr constant [5 x i8] c"main\00", align 1
@cond0 = common global %struct._opaque_pthread_cond_t zeroinitializer, align 8
@mutex0 = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @deposit(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @nop1()
  %3 = load i32, ptr @cond0_bool, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %6, label %5

5:                                                ; preds = %1
  call void @nop1()
  br label %6

6:                                                ; preds = %5, %1
  call void @nop1()
  %7 = load i32, ptr @balance_SHARED, align 4
  %8 = load i32, ptr @y_SHARED, align 4
  %9 = add nsw i32 %7, %8
  store i32 %9, ptr @balance_SHARED, align 4
  store i8 1, ptr @deposit_done_SHARED, align 1
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @withdraw(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load i32, ptr @balance_SHARED, align 4
  %4 = load i32, ptr @z_SHARED, align 4
  %5 = sub nsw i32 %3, %4
  store i32 %5, ptr @balance_SHARED, align 4
  store i8 1, ptr @withdraw_done_SHARED, align 1
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @check_result(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = call i32 @pthread_mutex_lock(ptr noundef @m)
  call void @nop1()
  %4 = load i8, ptr @deposit_done_SHARED, align 1
  %5 = trunc i8 %4 to i1
  br i1 %5, label %6, label %18

6:                                                ; preds = %1
  %7 = load i8, ptr @withdraw_done_SHARED, align 1
  %8 = trunc i8 %7 to i1
  br i1 %8, label %9, label %18

9:                                                ; preds = %6
  %10 = load i32, ptr @balance_SHARED, align 4
  %11 = load i32, ptr @x_SHARED, align 4
  %12 = load i32, ptr @y_SHARED, align 4
  %13 = sub nsw i32 %11, %12
  %14 = load i32, ptr @z_SHARED, align 4
  %15 = sub nsw i32 %13, %14
  %16 = icmp ne i32 %10, %15
  br i1 %16, label %17, label %18

17:                                               ; preds = %9
  call void @__assert_rtn(ptr noundef @__func__.check_result, ptr noundef @.str, i32 noundef 44, ptr noundef @.str.1) #3
  unreachable

18:                                               ; preds = %9, %6, %1
  store i32 1, ptr @cond0_bool, align 4
  call void @nop1()
  call void @nop1()
  %19 = call i32 @pthread_mutex_unlock(ptr noundef @m)
  ret ptr null
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #2

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  store i32 1, ptr @x_SHARED, align 4
  store i32 2, ptr @y_SHARED, align 4
  store i32 4, ptr @z_SHARED, align 4
  %5 = load i32, ptr @x_SHARED, align 4
  store i32 %5, ptr @balance_SHARED, align 4
  %6 = call i32 @pthread_create(ptr noundef %4, ptr noundef null, ptr noundef @check_result, ptr noundef null)
  %7 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @deposit, ptr noundef null)
  %8 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @withdraw, ptr noundef null)
  %9 = load ptr, ptr %4, align 8
  %10 = call i32 @"\01_pthread_join"(ptr noundef %9, ptr noundef null)
  %11 = load ptr, ptr %2, align 8
  %12 = call i32 @"\01_pthread_join"(ptr noundef %11, ptr noundef null)
  %13 = load ptr, ptr %3, align 8
  %14 = call i32 @"\01_pthread_join"(ptr noundef %13, ptr noundef null)
  %15 = load i32, ptr @balance_SHARED, align 4
  %16 = load i32, ptr @x_SHARED, align 4
  %17 = load i32, ptr @y_SHARED, align 4
  %18 = add nsw i32 %16, %17
  %19 = load i32, ptr @z_SHARED, align 4
  %20 = sub nsw i32 %18, %19
  %21 = icmp ne i32 %15, %20
  br i1 %21, label %22, label %23

22:                                               ; preds = %0
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str, i32 noundef 76, ptr noundef @.str.1) #3
  unreachable

23:                                               ; preds = %0
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
