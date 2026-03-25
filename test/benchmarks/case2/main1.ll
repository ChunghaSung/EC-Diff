; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }
%struct._opaque_pthread_cond_t = type { i64, [40 x i8] }

@a = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@y_SHARED = common global i32 0, align 4
@cond0_bool = common global i32 0, align 4
@cond0 = common global %struct._opaque_pthread_cond_t zeroinitializer, align 8
@x_SHARED = common global i32 0, align 4
@z_SHARED = common global i32 0, align 4
@b = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@temp_SHARED = common global i32 0, align 4

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
  %5 = call i32 @pthread_mutex_lock(ptr noundef @a)
  store i32 1, ptr @y_SHARED, align 4
  %6 = load i32, ptr @y_SHARED, align 4
  store i32 %6, ptr %4, align 4
  %7 = load i32, ptr @cond0_bool, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %11, label %9

9:                                                ; preds = %1
  %10 = call i32 @"\01_pthread_cond_wait"(ptr noundef @cond0, ptr noundef @a)
  br label %11

11:                                               ; preds = %9, %1
  store i32 1, ptr @x_SHARED, align 4
  %12 = load i32, ptr @z_SHARED, align 4
  store i32 %12, ptr %4, align 4
  store i32 1, ptr @z_SHARED, align 4
  %13 = call i32 @pthread_mutex_unlock(ptr noundef @a)
  %14 = load ptr, ptr %2, align 8
  ret ptr %14
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
  %5 = call i32 @pthread_mutex_lock(ptr noundef @a)
  store i32 1, ptr @y_SHARED, align 4
  %6 = load i32, ptr @y_SHARED, align 4
  store i32 %6, ptr %4, align 4
  %7 = load i32, ptr @x_SHARED, align 4
  store i32 %7, ptr %4, align 4
  store i32 1, ptr @cond0_bool, align 4
  %8 = call i32 @pthread_cond_signal(ptr noundef @cond0)
  %9 = load i32, ptr @z_SHARED, align 4
  store i32 %9, ptr %4, align 4
  store i32 1, ptr @z_SHARED, align 4
  store i32 1, ptr @x_SHARED, align 4
  %10 = call i32 @pthread_mutex_lock(ptr noundef @a)
  %11 = load ptr, ptr %2, align 8
  ret ptr %11
}

declare i32 @pthread_cond_signal(ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  %4 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @thread1, ptr noundef null)
  %5 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @thread2, ptr noundef null)
  ret i32 0
}

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Apple clang version 17.0.0 (clang-1700.6.4.2)"}
