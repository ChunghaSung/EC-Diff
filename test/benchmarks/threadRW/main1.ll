; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_cond_t = type { i64, [40 x i8] }
%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@cond1 = global %struct._opaque_pthread_cond_t { i64 1018212795, [40 x i8] zeroinitializer }, align 8
@cond1_bool = global i32 0, align 4
@mutex1 = global %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer }, align 8
@cond0 = global %struct._opaque_pthread_cond_t { i64 1018212795, [40 x i8] zeroinitializer }, align 8
@cond0_bool = global i32 0, align 4
@mutex0 = global %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer }, align 8
@order1_SHARED = global i32 0, align 4
@order2_SHARED = global i32 0, align 4
@w_SHARED = global i32 0, align 4
@r_SHARED = global i32 0, align 4
@x_SHARED = common global i32 0, align 4
@y_SHARED = common global i32 0, align 4
@__func__.reader1 = private unnamed_addr constant [8 x i8] c"reader1\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main1.c\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@__func__.reader2 = private unnamed_addr constant [8 x i8] c"reader2\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @writer1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %4 = load i32, ptr @order1_SHARED, align 4
  store i32 %4, ptr %3, align 4
  %5 = load i32, ptr @order2_SHARED, align 4
  store i32 %5, ptr %3, align 4
  store i32 1, ptr @w_SHARED, align 4
  store i32 2, ptr @r_SHARED, align 4
  call void @nop1()
  store i32 1, ptr @cond0_bool, align 4
  call void @nop1()
  call void @nop1()
  store i32 1, ptr @cond1_bool, align 4
  call void @nop1()
  call void @nop1()
  call void @nop1()
  store i32 3, ptr @x_SHARED, align 4
  store i32 0, ptr @w_SHARED, align 4
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @writer2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  store i32 1, ptr @w_SHARED, align 4
  store i32 3, ptr @x_SHARED, align 4
  store i32 0, ptr @w_SHARED, align 4
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @reader1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %5 = load i32, ptr @r_SHARED, align 4
  store i32 %5, ptr %4, align 4
  %6 = load i32, ptr %4, align 4
  %7 = add nsw i32 %6, 1
  store i32 %7, ptr %4, align 4
  %8 = load i32, ptr %4, align 4
  store i32 %8, ptr @r_SHARED, align 4
  call void @nop1()
  %9 = load i32, ptr @cond0_bool, align 4
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %12, label %11

11:                                               ; preds = %1
  call void @nop1()
  br label %12

12:                                               ; preds = %11, %1
  call void @nop1()
  store i32 1, ptr @order1_SHARED, align 4
  %13 = load i32, ptr @x_SHARED, align 4
  store i32 %13, ptr %3, align 4
  %14 = load i32, ptr %3, align 4
  store i32 %14, ptr @y_SHARED, align 4
  %15 = load i32, ptr @y_SHARED, align 4
  %16 = load i32, ptr @x_SHARED, align 4
  %17 = icmp ne i32 %15, %16
  br i1 %17, label %18, label %19

18:                                               ; preds = %12
  call void @__assert_rtn(ptr noundef @__func__.reader1, ptr noundef @.str, i32 noundef 87, ptr noundef @.str.1) #3
  unreachable

19:                                               ; preds = %12
  %20 = load i32, ptr @r_SHARED, align 4
  %21 = sub nsw i32 %20, 1
  store i32 %21, ptr %3, align 4
  %22 = load i32, ptr %3, align 4
  store i32 %22, ptr @r_SHARED, align 4
  ret ptr null
}

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @reader2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %5 = load i32, ptr @r_SHARED, align 4
  store i32 %5, ptr %4, align 4
  %6 = load i32, ptr %4, align 4
  %7 = add nsw i32 %6, 1
  store i32 %7, ptr %4, align 4
  %8 = load i32, ptr %4, align 4
  store i32 %8, ptr @r_SHARED, align 4
  call void @nop1()
  %9 = load i32, ptr @cond1_bool, align 4
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %12, label %11

11:                                               ; preds = %1
  call void @nop1()
  br label %12

12:                                               ; preds = %11, %1
  call void @nop1()
  store i32 2, ptr @order2_SHARED, align 4
  %13 = load i32, ptr @x_SHARED, align 4
  store i32 %13, ptr %3, align 4
  %14 = load i32, ptr %3, align 4
  store i32 %14, ptr @y_SHARED, align 4
  %15 = load i32, ptr @y_SHARED, align 4
  %16 = load i32, ptr @x_SHARED, align 4
  %17 = icmp ne i32 %15, %16
  br i1 %17, label %18, label %19

18:                                               ; preds = %12
  call void @__assert_rtn(ptr noundef @__func__.reader2, ptr noundef @.str, i32 noundef 122, ptr noundef @.str.1) #3
  unreachable

19:                                               ; preds = %12
  %20 = load i32, ptr @r_SHARED, align 4
  %21 = sub nsw i32 %20, 1
  store i32 %21, ptr %3, align 4
  %22 = load i32, ptr %3, align 4
  store i32 %22, ptr @r_SHARED, align 4
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  %6 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @writer1, ptr noundef null)
  %7 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @reader1, ptr noundef null)
  %8 = call i32 @pthread_create(ptr noundef %4, ptr noundef null, ptr noundef @writer2, ptr noundef null)
  %9 = call i32 @pthread_create(ptr noundef %5, ptr noundef null, ptr noundef @reader2, ptr noundef null)
  ret i32 0
}

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #2

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { cold noreturn "disable-tail-calls"="true" "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #3 = { cold noreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Apple clang version 17.0.0 (clang-1700.6.4.2)"}
