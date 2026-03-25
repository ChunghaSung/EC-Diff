; ModuleID = 'main2.c'
source_filename = "main2.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@x_SHARED = common global i32 0, align 4
@temp_SHARED = common global i32 0, align 4
@y_SHARED = common global i32 0, align 4
@z_SHARED = common global i32 0, align 4
@b = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@a = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thread1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @nop1()
  store i32 1, ptr @x_SHARED, align 4
  %4 = load i32, ptr @x_SHARED, align 4
  store i32 %4, ptr @temp_SHARED, align 4
  store i32 1, ptr @y_SHARED, align 4
  store i32 2, ptr @z_SHARED, align 4
  %5 = call i32 @pthread_mutex_lock(ptr noundef @b)
  %6 = load i32, ptr @x_SHARED, align 4
  store i32 %6, ptr @temp_SHARED, align 4
  store i32 2, ptr @y_SHARED, align 4
  %7 = call i32 @pthread_mutex_unlock(ptr noundef @b)
  store i32 3, ptr @z_SHARED, align 4
  call void @nop1()
  %8 = load ptr, ptr %2, align 8
  ret ptr %8
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thread2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @nop1()
  store i32 1, ptr @x_SHARED, align 4
  %4 = load i32, ptr @x_SHARED, align 4
  store i32 %4, ptr @temp_SHARED, align 4
  %5 = load i32, ptr @y_SHARED, align 4
  store i32 %5, ptr @temp_SHARED, align 4
  store i32 4, ptr @z_SHARED, align 4
  %6 = call i32 @pthread_mutex_lock(ptr noundef @b)
  store i32 1, ptr @x_SHARED, align 4
  %7 = load i32, ptr @y_SHARED, align 4
  store i32 %7, ptr @temp_SHARED, align 4
  %8 = call i32 @pthread_mutex_unlock(ptr noundef @b)
  store i32 5, ptr @z_SHARED, align 4
  call void @nop1()
  %9 = load ptr, ptr %2, align 8
  ret ptr %9
}

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
