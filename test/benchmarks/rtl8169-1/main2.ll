; ModuleID = 'main2.c'
source_filename = "main2.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@registered_SHARED_BUSY = global i32 0, align 4
@netif_running_SHARED = global i32 0, align 4
@irq_enabled_SHARED = global i32 0, align 4
@napi_enabled_SHARED = global i32 0, align 4
@napi_scheduled_SHARED = global i32 0, align 4
@reset_task_ready_SHARED = global i32 0, align 4
@sysfs_registered_SHARED = global i32 0, align 4
@dev_on_SHARED = global i32 0, align 4
@sysfs_lock = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@hw_start_SHARED = common global i32 0, align 4
@dev_lock = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@rtnl_lock = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@IntrMask_SHARED = common global i8 0, align 1
@intr_mask_SHARED = common global i8 0, align 1
@napi_sem = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@irq_sem = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@IntrStatus_SHARED = common global i8 0, align 1
@napi = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @pci_thread(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %6 = call i32 @pthread_mutex_lock(ptr noundef @sysfs_lock)
  store i32 1, ptr @sysfs_registered_SHARED, align 4
  %7 = call i32 @pthread_mutex_unlock(ptr noundef @sysfs_lock)
  store i32 1, ptr @hw_start_SHARED, align 4
  store i32 1, ptr @registered_SHARED_BUSY, align 4
  store i32 0, ptr %5, align 4
  %8 = load i32, ptr %5, align 4
  %9 = icmp slt i32 %8, 0
  br i1 %9, label %10, label %12

10:                                               ; preds = %1
  %11 = load i32, ptr %5, align 4
  store i32 %11, ptr %4, align 4
  br label %13

12:                                               ; preds = %1
  store i32 0, ptr %4, align 4
  br label %13

13:                                               ; preds = %12, %10
  %14 = call i32 @pthread_mutex_lock(ptr noundef @dev_lock)
  br label %15

15:                                               ; preds = %18, %13
  %16 = load i32, ptr @netif_running_SHARED, align 4
  %17 = icmp ne i32 %16, 0
  br i1 %17, label %18, label %19

18:                                               ; preds = %15
  br label %15, !llvm.loop !6

19:                                               ; preds = %15
  %20 = call i32 @pthread_mutex_lock(ptr noundef @sysfs_lock)
  store i32 0, ptr @sysfs_registered_SHARED, align 4
  %21 = call i32 @pthread_mutex_unlock(ptr noundef @sysfs_lock)
  %22 = call i32 @pthread_mutex_unlock(ptr noundef @dev_lock)
  %23 = load ptr, ptr %2, align 8
  ret ptr %23
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @network_thread(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  br label %9

9:                                                ; preds = %1, %37
  store i32 0, ptr %3, align 4
  %10 = call i32 @pthread_mutex_lock(ptr noundef @rtnl_lock)
  %11 = load i32, ptr @registered_SHARED_BUSY, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %23

13:                                               ; preds = %9
  %14 = load i32, ptr @hw_start_SHARED, align 4
  store i32 %14, ptr %6, align 4
  store i8 0, ptr @IntrMask_SHARED, align 1
  store i32 1, ptr @irq_enabled_SHARED, align 4
  store i32 0, ptr %5, align 4
  %15 = load i32, ptr %5, align 4
  %16 = icmp slt i32 %15, 0
  br i1 %16, label %17, label %19

17:                                               ; preds = %13
  %18 = load i32, ptr %5, align 4
  store i32 %18, ptr %3, align 4
  br label %22

19:                                               ; preds = %13
  store i32 1, ptr @napi_enabled_SHARED, align 4
  store i32 1, ptr @dev_on_SHARED, align 4
  %20 = load i32, ptr @dev_on_SHARED, align 4
  store i32 %20, ptr %7, align 4
  store i8 1, ptr @IntrMask_SHARED, align 1
  store i8 1, ptr @intr_mask_SHARED, align 1
  %21 = load i32, ptr %5, align 4
  store i32 %21, ptr %3, align 4
  br label %22

22:                                               ; preds = %19, %17
  store i32 1, ptr @netif_running_SHARED, align 4
  br label %23

23:                                               ; preds = %22, %9
  %24 = call i32 @pthread_mutex_unlock(ptr noundef @rtnl_lock)
  %25 = load i32, ptr %3, align 4
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %37, label %27

27:                                               ; preds = %23
  store i32 1, ptr @reset_task_ready_SHARED, align 4
  %28 = call i32 @pthread_mutex_lock(ptr noundef @rtnl_lock)
  %29 = load i32, ptr @netif_running_SHARED, align 4
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %31, label %35

31:                                               ; preds = %27
  store i32 0, ptr @netif_running_SHARED, align 4
  %32 = load i32, ptr @dev_on_SHARED, align 4
  store i32 %32, ptr %8, align 4
  store i8 0, ptr @IntrMask_SHARED, align 1
  store i32 0, ptr @dev_on_SHARED, align 4
  store i32 0, ptr @napi_enabled_SHARED, align 4
  %33 = call i32 @pthread_mutex_lock(ptr noundef @napi_sem)
  store i32 1, ptr @dev_on_SHARED, align 4
  %34 = call i32 @pthread_mutex_unlock(ptr noundef @napi_sem)
  store i32 0, ptr @irq_enabled_SHARED, align 4
  br label %35

35:                                               ; preds = %31, %27
  %36 = call i32 @pthread_mutex_unlock(ptr noundef @rtnl_lock)
  br label %37

37:                                               ; preds = %35, %23
  br label %9
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @irq_thread(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i8, align 1
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  br label %8

8:                                                ; preds = %1, %49
  %9 = call i32 @pthread_mutex_lock(ptr noundef @irq_sem)
  %10 = load i32, ptr @irq_enabled_SHARED, align 4
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %49

12:                                               ; preds = %8
  %13 = load i8, ptr @IntrStatus_SHARED, align 1
  %14 = zext i8 %13 to i32
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %16, label %49

16:                                               ; preds = %12
  %17 = load i8, ptr @IntrMask_SHARED, align 1
  %18 = zext i8 %17 to i32
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %20, label %49

20:                                               ; preds = %16
  %21 = load i8, ptr @IntrStatus_SHARED, align 1
  store i8 %21, ptr %4, align 1
  br label %22

22:                                               ; preds = %37, %20
  %23 = load i8, ptr %4, align 1
  %24 = icmp ne i8 %23, 0
  br i1 %24, label %25, label %47

25:                                               ; preds = %22
  %26 = load i8, ptr @intr_mask_SHARED, align 1
  %27 = zext i8 %26 to i32
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %29, label %37

29:                                               ; preds = %25
  %30 = load i32, ptr @dev_on_SHARED, align 4
  store i32 %30, ptr %5, align 4
  store i8 -1, ptr @IntrMask_SHARED, align 1
  store i8 0, ptr @intr_mask_SHARED, align 1
  %31 = call i32 @pthread_mutex_lock(ptr noundef @napi)
  %32 = load i32, ptr @napi_enabled_SHARED, align 4
  %33 = icmp ne i32 %32, 0
  br i1 %33, label %34, label %35

34:                                               ; preds = %29
  store i32 1, ptr @napi_scheduled_SHARED, align 4
  br label %35

35:                                               ; preds = %34, %29
  %36 = call i32 @pthread_mutex_unlock(ptr noundef @napi)
  store i32 1, ptr %3, align 4
  br label %37

37:                                               ; preds = %35, %25
  %38 = load i32, ptr @dev_on_SHARED, align 4
  store i32 %38, ptr %6, align 4
  %39 = load i8, ptr @IntrStatus_SHARED, align 1
  %40 = zext i8 %39 to i32
  %41 = load i8, ptr %4, align 1
  %42 = zext i8 %41 to i32
  %43 = xor i32 %42, -1
  %44 = and i32 %40, %43
  %45 = trunc i32 %44 to i8
  store i8 %45, ptr @IntrStatus_SHARED, align 1
  %46 = load i8, ptr @IntrStatus_SHARED, align 1
  store i8 %46, ptr %4, align 1
  br label %22, !llvm.loop !8

47:                                               ; preds = %22
  %48 = load i32, ptr %3, align 4
  store i32 %48, ptr %7, align 4
  br label %49

49:                                               ; preds = %47, %16, %12, %8
  %50 = call i32 @pthread_mutex_unlock(ptr noundef @irq_sem)
  br label %8
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @dev_thread(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  br label %3

3:                                                ; preds = %1, %3
  store i8 1, ptr @IntrStatus_SHARED, align 1
  br label %3
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @napi_thread(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  br label %5

5:                                                ; preds = %1, %12
  %6 = call i32 @pthread_mutex_lock(ptr noundef @napi_sem)
  br label %7

7:                                                ; preds = %10, %5
  %8 = load i32, ptr @napi_scheduled_SHARED, align 4
  %9 = icmp ne i32 %8, 0
  br i1 %9, label %10, label %12

10:                                               ; preds = %7
  store i8 0, ptr @IntrStatus_SHARED, align 1
  store i32 0, ptr @napi_scheduled_SHARED, align 4
  %11 = load i32, ptr @dev_on_SHARED, align 4
  store i32 %11, ptr %4, align 4
  store i8 -1, ptr @IntrMask_SHARED, align 1
  store i8 -1, ptr @intr_mask_SHARED, align 1
  br label %7, !llvm.loop !9

12:                                               ; preds = %7
  %13 = call i32 @pthread_mutex_unlock(ptr noundef @napi_sem)
  br label %5
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @workqueue_thread(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  br label %5

5:                                                ; preds = %1, %12, %21
  %6 = load i32, ptr @reset_task_ready_SHARED, align 4
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %21

8:                                                ; preds = %5
  %9 = call i32 @pthread_mutex_lock(ptr noundef @rtnl_lock)
  %10 = load i32, ptr @netif_running_SHARED, align 4
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %12, label %13

12:                                               ; preds = %8
  br label %5

13:                                               ; preds = %8
  store i32 0, ptr @napi_enabled_SHARED, align 4
  %14 = call i32 @pthread_mutex_lock(ptr noundef @napi_sem)
  %15 = load i32, ptr @dev_on_SHARED, align 4
  store i32 %15, ptr %3, align 4
  store i8 0, ptr @IntrMask_SHARED, align 1
  %16 = call i32 @pthread_mutex_lock(ptr noundef @irq_sem)
  %17 = call i32 @pthread_mutex_unlock(ptr noundef @irq_sem)
  store i32 0, ptr @dev_on_SHARED, align 4
  store i32 1, ptr @dev_on_SHARED, align 4
  %18 = load i32, ptr @dev_on_SHARED, align 4
  store i32 %18, ptr %4, align 4
  store i8 1, ptr @IntrMask_SHARED, align 1
  store i8 1, ptr @intr_mask_SHARED, align 1
  %19 = call i32 @pthread_mutex_unlock(ptr noundef @napi_sem)
  store i32 1, ptr @napi_enabled_SHARED, align 4
  %20 = call i32 @pthread_mutex_unlock(ptr noundef @rtnl_lock)
  store i32 0, ptr @reset_task_ready_SHARED, align 4
  br label %21

21:                                               ; preds = %13, %5
  br label %5
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @sysfs_thread(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  br label %3

3:                                                ; preds = %1, %9
  %4 = call i32 @pthread_mutex_lock(ptr noundef @sysfs_lock)
  %5 = call i32 @pthread_mutex_lock(ptr noundef @dev_lock)
  %6 = load i32, ptr @sysfs_registered_SHARED, align 4
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %3
  br label %9

9:                                                ; preds = %8, %3
  %10 = call i32 @pthread_mutex_unlock(ptr noundef @dev_lock)
  %11 = call i32 @pthread_mutex_unlock(ptr noundef @sysfs_lock)
  br label %3
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @main() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  store i32 0, ptr @registered_SHARED_BUSY, align 4
  store i32 0, ptr @netif_running_SHARED, align 4
  store i32 0, ptr @hw_start_SHARED, align 4
  store i32 0, ptr @irq_enabled_SHARED, align 4
  store i32 0, ptr @napi_enabled_SHARED, align 4
  store i32 0, ptr @napi_scheduled_SHARED, align 4
  store i32 0, ptr @reset_task_ready_SHARED, align 4
  store i32 0, ptr @sysfs_registered_SHARED, align 4
  store i32 0, ptr @dev_on_SHARED, align 4
  %8 = call i32 @pthread_create(ptr noundef %1, ptr noundef null, ptr noundef @pci_thread, ptr noundef null)
  %9 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @network_thread, ptr noundef null)
  %10 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @irq_thread, ptr noundef null)
  %11 = call i32 @pthread_create(ptr noundef %4, ptr noundef null, ptr noundef @napi_thread, ptr noundef null)
  %12 = call i32 @pthread_create(ptr noundef %5, ptr noundef null, ptr noundef @workqueue_thread, ptr noundef null)
  %13 = call i32 @pthread_create(ptr noundef %6, ptr noundef null, ptr noundef @sysfs_thread, ptr noundef null)
  %14 = call i32 @pthread_create(ptr noundef %7, ptr noundef null, ptr noundef @dev_thread, ptr noundef null)
  ret void
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
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
