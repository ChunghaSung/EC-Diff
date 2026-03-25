; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_cond_t = type { i64, [40 x i8] }
%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@cond0 = global %struct._opaque_pthread_cond_t { i64 1018212795, [40 x i8] zeroinitializer }, align 8
@cond0_bool = global i32 0, align 4
@mutex0 = global %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer }, align 8
@dev_SHARED = global i32 1, align 4
@stats_SHARED = global i32 1, align 4
@buffertoprint_SHARED = global i32 1, align 4
@dev_SHARED_isalive = global i32 1, align 4
@EINVAL = global i32 22, align 4
@rx_packets_SHARED = global i32 1, align 4
@tx_packets_SHARED = global i32 1, align 4
@rx_bytes_SHARED = global i32 1, align 4
@tx_bytes_SHARED = global i32 1, align 4
@rx_errors_SHARED = global i32 1, align 4
@tx_errors_SHARED = global i32 1, align 4
@multicast_SHARED = global i32 1, align 4
@collisions_SHARED = global i32 1, align 4
@length_erros_SHARED = global i32 1, align 4
@rx_over_errors_SHARED = global i32 1, align 4
@rx_frame_errors_SHARED = global i32 1, align 4
@tx_aborted_errors_SHARED = global i32 1, align 4
@tx_carrier_errors_SHARED_SHARED = global i32 1, align 4
@rx_crc_errors_SHARED = global i32 1, align 4
@rx_missed_errors_SHARED = global i32 1, align 4
@tp_rx_dropped_SHARED = global i32 1, align 4
@tp_tx_dropped_SHARED = global i32 1, align 4
@old_stats_SHARED = common global i32 0, align 4
@__func__.thread1 = private unnamed_addr constant [8 x i8] c"thread1\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main1.c\00", align 1
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
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %3, align 4
  %5 = load i32, ptr @EINVAL, align 4
  store i32 %5, ptr %4, align 4
  %6 = load i32, ptr @dev_SHARED_isalive, align 4
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %91

8:                                                ; preds = %1
  %9 = load i32, ptr @stats_SHARED, align 4
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %13, label %11

11:                                               ; preds = %8
  %12 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %12, ptr %4, align 4
  br label %90

13:                                               ; preds = %8
  %14 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %14, ptr %3, align 4
  %15 = load i32, ptr %3, align 4
  %16 = load i32, ptr @rx_packets_SHARED, align 4
  %17 = add nsw i32 %15, %16
  store i32 %17, ptr @stats_SHARED, align 4
  %18 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %18, ptr %3, align 4
  %19 = load i32, ptr %3, align 4
  %20 = load i32, ptr @tx_packets_SHARED, align 4
  %21 = add nsw i32 %19, %20
  store i32 %21, ptr @stats_SHARED, align 4
  %22 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %22, ptr %3, align 4
  %23 = load i32, ptr %3, align 4
  %24 = load i32, ptr @rx_bytes_SHARED, align 4
  %25 = add nsw i32 %23, %24
  store i32 %25, ptr @stats_SHARED, align 4
  %26 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %26, ptr %3, align 4
  %27 = load i32, ptr %3, align 4
  %28 = load i32, ptr @tx_bytes_SHARED, align 4
  %29 = add nsw i32 %27, %28
  store i32 %29, ptr @stats_SHARED, align 4
  %30 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %30, ptr %3, align 4
  %31 = load i32, ptr %3, align 4
  %32 = load i32, ptr @rx_errors_SHARED, align 4
  %33 = add nsw i32 %31, %32
  store i32 %33, ptr @stats_SHARED, align 4
  %34 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %34, ptr %3, align 4
  %35 = load i32, ptr %3, align 4
  %36 = load i32, ptr @tx_errors_SHARED, align 4
  %37 = add nsw i32 %35, %36
  store i32 %37, ptr @stats_SHARED, align 4
  %38 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %38, ptr %3, align 4
  %39 = load i32, ptr %3, align 4
  %40 = load i32, ptr @multicast_SHARED, align 4
  %41 = add nsw i32 %39, %40
  store i32 %41, ptr @stats_SHARED, align 4
  %42 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %42, ptr %3, align 4
  %43 = load i32, ptr %3, align 4
  %44 = load i32, ptr @collisions_SHARED, align 4
  %45 = add nsw i32 %43, %44
  store i32 %45, ptr @stats_SHARED, align 4
  %46 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %46, ptr %3, align 4
  %47 = load i32, ptr %3, align 4
  %48 = load i32, ptr @length_erros_SHARED, align 4
  %49 = add nsw i32 %47, %48
  store i32 %49, ptr @stats_SHARED, align 4
  %50 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %50, ptr %3, align 4
  %51 = load i32, ptr %3, align 4
  %52 = load i32, ptr @rx_over_errors_SHARED, align 4
  %53 = add nsw i32 %51, %52
  store i32 %53, ptr @stats_SHARED, align 4
  %54 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %54, ptr %3, align 4
  %55 = load i32, ptr %3, align 4
  %56 = load i32, ptr @rx_frame_errors_SHARED, align 4
  %57 = add nsw i32 %55, %56
  store i32 %57, ptr @stats_SHARED, align 4
  %58 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %58, ptr %3, align 4
  %59 = load i32, ptr %3, align 4
  %60 = load i32, ptr @tx_aborted_errors_SHARED, align 4
  %61 = add nsw i32 %59, %60
  store i32 %61, ptr @stats_SHARED, align 4
  %62 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %62, ptr %3, align 4
  %63 = load i32, ptr %3, align 4
  %64 = load i32, ptr @tx_carrier_errors_SHARED_SHARED, align 4
  %65 = add nsw i32 %63, %64
  store i32 %65, ptr @stats_SHARED, align 4
  %66 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %66, ptr %3, align 4
  %67 = load i32, ptr %3, align 4
  %68 = load i32, ptr @rx_crc_errors_SHARED, align 4
  %69 = add nsw i32 %67, %68
  store i32 %69, ptr @stats_SHARED, align 4
  %70 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %70, ptr %3, align 4
  %71 = load i32, ptr %3, align 4
  %72 = load i32, ptr @rx_missed_errors_SHARED, align 4
  %73 = add nsw i32 %71, %72
  store i32 %73, ptr @stats_SHARED, align 4
  %74 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %74, ptr %3, align 4
  %75 = load i32, ptr %3, align 4
  %76 = load i32, ptr @tp_rx_dropped_SHARED, align 4
  %77 = add nsw i32 %75, %76
  store i32 %77, ptr @stats_SHARED, align 4
  %78 = load i32, ptr @old_stats_SHARED, align 4
  store i32 %78, ptr %3, align 4
  call void @nop1()
  store i32 1, ptr @cond0_bool, align 4
  %79 = load i32, ptr @stats_SHARED, align 4
  %80 = icmp eq i32 %79, 0
  br i1 %80, label %81, label %82

81:                                               ; preds = %13
  call void @__assert_rtn(ptr noundef @__func__.thread1, ptr noundef @.str, i32 noundef 89, ptr noundef @.str.1) #3
  unreachable

82:                                               ; preds = %13
  call void @nop1()
  call void @nop1()
  %83 = load i32, ptr %3, align 4
  %84 = load i32, ptr @tp_tx_dropped_SHARED, align 4
  %85 = add nsw i32 %83, %84
  store i32 %85, ptr @stats_SHARED, align 4
  %86 = load i32, ptr @buffertoprint_SHARED, align 4
  store i32 %86, ptr %3, align 4
  %87 = load i32, ptr %3, align 4
  %88 = load i32, ptr @stats_SHARED, align 4
  %89 = add nsw i32 %87, %88
  store i32 %89, ptr %4, align 4
  br label %90

90:                                               ; preds = %82, %11
  br label %91

91:                                               ; preds = %90, %1
  ret ptr null
}

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thread2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load i32, ptr @dev_SHARED_isalive, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %14

5:                                                ; preds = %1
  %6 = load i32, ptr @stats_SHARED, align 4
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %13

8:                                                ; preds = %5
  call void @nop1()
  %9 = load i32, ptr @cond0_bool, align 4
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %12, label %11

11:                                               ; preds = %8
  call void @nop1()
  br label %12

12:                                               ; preds = %11, %8
  call void @nop1()
  store i32 0, ptr @stats_SHARED, align 4
  br label %13

13:                                               ; preds = %12, %5
  br label %14

14:                                               ; preds = %13, %1
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca ptr, align 8
  %3 = call i32 @pthread_create(ptr noundef %1, ptr noundef null, ptr noundef @thread1, ptr noundef null)
  %4 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @thread2, ptr noundef null)
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
