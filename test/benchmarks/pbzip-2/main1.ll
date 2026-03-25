; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }
%struct._opaque_pthread_cond_t = type { i64, [40 x i8] }

@queue_mut_SHARED = global i32 0, align 4
@queue_mut = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@queue_empty_SHARED = common global i32 0, align 4
@allDone_SHARED = internal global i32 0, align 4
@queue_notEmpty = common global %struct._opaque_pthread_cond_t zeroinitializer, align 8
@queue_buf_SHARED = common global ptr null, align 8
@queue_head_SHARED = common global i64 0, align 8
@FileData_SHARED = internal global ptr null, align 8
@queue_bufSize_SHARED = common global ptr null, align 8
@queue_blockNum_SHARED = common global ptr null, align 8
@QUEUESIZE_SHARED = internal global i32 2, align 4
@queue_tail_SHARED = common global i64 0, align 8
@queue_full_SHARED = common global i32 0, align 4
@queue_notFull = common global %struct._opaque_pthread_cond_t zeroinitializer, align 8
@MemMutex = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@.str = private unnamed_addr constant [5 x i8] c"test\00", align 1
@CompressedData_SHARED = internal global ptr null, align 8
@.str.1 = private unnamed_addr constant [66 x i8] c"ERROR: Could not allocate memory (CompressedData)! Skipping ....\0A\00", align 1
@OutMutex = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@OutputBuffer_SHARED = internal global i32 0, align 4
@sigOutFilename_SHARED = internal global ptr null, align 8
@OutputStdOut_SHARED = internal global i32 0, align 4
@.str.2 = private unnamed_addr constant [37 x i8] c"ERROR: Could not create output file\0A\00", align 1
@NumBlocks_SHARED = internal global i32 0, align 4
@.str.3 = private unnamed_addr constant [46 x i8] c"ERROR: Could not write to file! Skipping ...\0A\00", align 1
@QuietMode_SHARED = internal global i32 0, align 4
@.str.4 = private unnamed_addr constant [11 x i8] c"Completed\0A\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"Output Size : \0A\00", align 1
@.str.6 = private unnamed_addr constant [59 x i8] c"ERROR: Could not allocate memory (FileData)! Skipping ...\0A\00", align 1
@.str.7 = private unnamed_addr constant [18 x i8] c" -> Bytes To Read\00", align 1
@.str.8 = private unnamed_addr constant [58 x i8] c"ERROR: Could not read from fibz2NumBlocksle! Skipping...\0A\00", align 1
@.str.9 = private unnamed_addr constant [42 x i8] c"WARNING: Compressed block size is large.\0A\00", align 1
@.str.10 = private unnamed_addr constant [24 x i8] c"Decompressing data ...\0A\00", align 1
@.str.11 = private unnamed_addr constant [22 x i8] c"Compressing data ...\0A\00", align 1
@sigInFilename_SHARED = internal global ptr null, align 8
@.str.12 = private unnamed_addr constant [52 x i8] c"--------------------------------------------------\0A\00", align 1
@patchVar_SHARED = internal global i32 0, align 4
@.str.13 = private unnamed_addr constant [21 x i8] c"Wall Clock: seconds\0A\00", align 1
@patchLock = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@patchCond = common global %struct._opaque_pthread_cond_t zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @consumer_decompress1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %13 = load i32, ptr @queue_mut_SHARED, align 4
  store i32 %13, ptr %9, align 4
  %14 = load i32, ptr %9, align 4
  store i32 %14, ptr @queue_mut_SHARED, align 4
  %15 = call i32 @pthread_mutex_lock(ptr noundef @queue_mut)
  br label %16

16:                                               ; preds = %26, %1
  %17 = load i32, ptr @queue_empty_SHARED, align 4
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %28

19:                                               ; preds = %16
  %20 = load i32, ptr @allDone_SHARED, align 4
  %21 = icmp eq i32 %20, 1
  br i1 %21, label %22, label %26

22:                                               ; preds = %19
  %23 = call i32 @pthread_mutex_unlock(ptr noundef @queue_mut)
  %24 = load i32, ptr @queue_mut_SHARED, align 4
  store i32 %24, ptr %9, align 4
  %25 = load i32, ptr %9, align 4
  store i32 %25, ptr @queue_mut_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %80

26:                                               ; preds = %19
  %27 = call i32 @"\01_pthread_cond_wait"(ptr noundef @queue_notEmpty, ptr noundef @queue_mut)
  br label %16, !llvm.loop !6

28:                                               ; preds = %16
  %29 = load ptr, ptr @queue_buf_SHARED, align 8
  %30 = load i64, ptr @queue_head_SHARED, align 8
  %31 = getelementptr inbounds ptr, ptr %29, i64 %30
  %32 = load ptr, ptr %31, align 8
  store ptr %32, ptr @FileData_SHARED, align 8
  %33 = load ptr, ptr @queue_bufSize_SHARED, align 8
  %34 = load i64, ptr @queue_head_SHARED, align 8
  %35 = getelementptr inbounds i32, ptr %33, i64 %34
  %36 = load i32, ptr %35, align 4
  store i32 %36, ptr %4, align 4
  %37 = load ptr, ptr @queue_blockNum_SHARED, align 8
  %38 = load i64, ptr @queue_head_SHARED, align 8
  %39 = getelementptr inbounds i32, ptr %37, i64 %38
  %40 = load i32, ptr %39, align 4
  store i32 %40, ptr %5, align 4
  %41 = load i64, ptr @queue_head_SHARED, align 8
  %42 = add nsw i64 %41, 1
  store i64 %42, ptr @queue_head_SHARED, align 8
  %43 = load i64, ptr @queue_head_SHARED, align 8
  %44 = load i32, ptr @QUEUESIZE_SHARED, align 4
  %45 = sext i32 %44 to i64
  %46 = icmp eq i64 %43, %45
  br i1 %46, label %47, label %48

47:                                               ; preds = %28
  store i64 0, ptr @queue_head_SHARED, align 8
  br label %48

48:                                               ; preds = %47, %28
  %49 = load i64, ptr @queue_head_SHARED, align 8
  %50 = load i64, ptr @queue_tail_SHARED, align 8
  %51 = icmp eq i64 %49, %50
  br i1 %51, label %52, label %53

52:                                               ; preds = %48
  store i32 1, ptr @queue_empty_SHARED, align 4
  br label %53

53:                                               ; preds = %52, %48
  store i32 0, ptr @queue_full_SHARED, align 4
  %54 = call i32 @pthread_mutex_unlock(ptr noundef @queue_mut)
  %55 = load i32, ptr @queue_mut_SHARED, align 4
  store i32 %55, ptr %9, align 4
  %56 = load i32, ptr %9, align 4
  store i32 %56, ptr @queue_mut_SHARED, align 4
  %57 = call i32 @pthread_cond_signal(ptr noundef @queue_notFull)
  %58 = load i32, ptr %7, align 4
  %59 = sitofp i32 %58 to double
  %60 = call double @llvm.fmuladd.f64(double %59, double 1.010000e+00, double 6.000000e+02)
  %61 = fptosi double %60 to i32
  store i32 %61, ptr %6, align 4
  %62 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  store ptr @.str, ptr @CompressedData_SHARED, align 8
  %63 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  %64 = load ptr, ptr @CompressedData_SHARED, align 8
  %65 = icmp eq ptr %64, null
  br i1 %65, label %66, label %68

66:                                               ; preds = %53
  %67 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store ptr null, ptr %2, align 8
  br label %80

68:                                               ; preds = %53
  store i32 3, ptr %8, align 4
  %69 = call i32 @pthread_mutex_lock(ptr noundef @OutMutex)
  %70 = load i32, ptr %5, align 4
  store i32 %70, ptr %10, align 4
  %71 = load ptr, ptr @CompressedData_SHARED, align 8
  store ptr %71, ptr %11, align 8
  %72 = load i32, ptr %6, align 4
  store i32 %72, ptr %12, align 4
  store i32 2, ptr @OutputBuffer_SHARED, align 4
  store i32 1, ptr @OutputBuffer_SHARED, align 4
  %73 = call i32 @pthread_mutex_unlock(ptr noundef @OutMutex)
  %74 = load ptr, ptr @FileData_SHARED, align 8
  %75 = icmp ne ptr %74, null
  br i1 %75, label %76, label %79

76:                                               ; preds = %68
  %77 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  store ptr null, ptr @FileData_SHARED, align 8
  %78 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  br label %79

79:                                               ; preds = %76, %68
  store ptr null, ptr %2, align 8
  br label %80

80:                                               ; preds = %79, %66, %22
  %81 = load ptr, ptr %2, align 8
  ret ptr %81
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

declare i32 @"\01_pthread_cond_wait"(ptr noundef, ptr noundef) #1

declare i32 @pthread_cond_signal(ptr noundef) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #2

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @consumer_decompress2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %13 = load i32, ptr @queue_mut_SHARED, align 4
  store i32 %13, ptr %9, align 4
  %14 = load i32, ptr %9, align 4
  store i32 %14, ptr @queue_mut_SHARED, align 4
  %15 = call i32 @pthread_mutex_lock(ptr noundef @queue_mut)
  br label %16

16:                                               ; preds = %26, %1
  %17 = load i32, ptr @queue_empty_SHARED, align 4
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %28

19:                                               ; preds = %16
  %20 = load i32, ptr @allDone_SHARED, align 4
  %21 = icmp eq i32 %20, 1
  br i1 %21, label %22, label %26

22:                                               ; preds = %19
  %23 = call i32 @pthread_mutex_unlock(ptr noundef @queue_mut)
  %24 = load i32, ptr @queue_mut_SHARED, align 4
  store i32 %24, ptr %9, align 4
  %25 = load i32, ptr %9, align 4
  store i32 %25, ptr @queue_mut_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %80

26:                                               ; preds = %19
  %27 = call i32 @"\01_pthread_cond_wait"(ptr noundef @queue_notEmpty, ptr noundef @queue_mut)
  br label %16, !llvm.loop !8

28:                                               ; preds = %16
  %29 = load ptr, ptr @queue_buf_SHARED, align 8
  %30 = load i64, ptr @queue_head_SHARED, align 8
  %31 = getelementptr inbounds ptr, ptr %29, i64 %30
  %32 = load ptr, ptr %31, align 8
  store ptr %32, ptr @FileData_SHARED, align 8
  %33 = load ptr, ptr @queue_bufSize_SHARED, align 8
  %34 = load i64, ptr @queue_head_SHARED, align 8
  %35 = getelementptr inbounds i32, ptr %33, i64 %34
  %36 = load i32, ptr %35, align 4
  store i32 %36, ptr %4, align 4
  %37 = load ptr, ptr @queue_blockNum_SHARED, align 8
  %38 = load i64, ptr @queue_head_SHARED, align 8
  %39 = getelementptr inbounds i32, ptr %37, i64 %38
  %40 = load i32, ptr %39, align 4
  store i32 %40, ptr %5, align 4
  %41 = load i64, ptr @queue_head_SHARED, align 8
  %42 = add nsw i64 %41, 1
  store i64 %42, ptr @queue_head_SHARED, align 8
  %43 = load i64, ptr @queue_head_SHARED, align 8
  %44 = load i32, ptr @QUEUESIZE_SHARED, align 4
  %45 = sext i32 %44 to i64
  %46 = icmp eq i64 %43, %45
  br i1 %46, label %47, label %48

47:                                               ; preds = %28
  store i64 0, ptr @queue_head_SHARED, align 8
  br label %48

48:                                               ; preds = %47, %28
  %49 = load i64, ptr @queue_head_SHARED, align 8
  %50 = load i64, ptr @queue_tail_SHARED, align 8
  %51 = icmp eq i64 %49, %50
  br i1 %51, label %52, label %53

52:                                               ; preds = %48
  store i32 1, ptr @queue_empty_SHARED, align 4
  br label %53

53:                                               ; preds = %52, %48
  store i32 0, ptr @queue_full_SHARED, align 4
  %54 = call i32 @pthread_mutex_unlock(ptr noundef @queue_mut)
  %55 = load i32, ptr @queue_mut_SHARED, align 4
  store i32 %55, ptr %9, align 4
  %56 = load i32, ptr %9, align 4
  store i32 %56, ptr @queue_mut_SHARED, align 4
  %57 = call i32 @pthread_cond_signal(ptr noundef @queue_notFull)
  %58 = load i32, ptr %7, align 4
  %59 = sitofp i32 %58 to double
  %60 = call double @llvm.fmuladd.f64(double %59, double 1.010000e+00, double 6.000000e+02)
  %61 = fptosi double %60 to i32
  store i32 %61, ptr %6, align 4
  %62 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  store ptr @.str, ptr @CompressedData_SHARED, align 8
  %63 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  %64 = load ptr, ptr @CompressedData_SHARED, align 8
  %65 = icmp eq ptr %64, null
  br i1 %65, label %66, label %68

66:                                               ; preds = %53
  %67 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store ptr null, ptr %2, align 8
  br label %80

68:                                               ; preds = %53
  store i32 3, ptr %8, align 4
  %69 = call i32 @pthread_mutex_lock(ptr noundef @OutMutex)
  %70 = load i32, ptr %5, align 4
  store i32 %70, ptr %10, align 4
  %71 = load ptr, ptr @CompressedData_SHARED, align 8
  store ptr %71, ptr %11, align 8
  %72 = load i32, ptr %6, align 4
  store i32 %72, ptr %12, align 4
  store i32 2, ptr @OutputBuffer_SHARED, align 4
  store i32 1, ptr @OutputBuffer_SHARED, align 4
  %73 = call i32 @pthread_mutex_unlock(ptr noundef @OutMutex)
  %74 = load ptr, ptr @FileData_SHARED, align 8
  %75 = icmp ne ptr %74, null
  br i1 %75, label %76, label %79

76:                                               ; preds = %68
  %77 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  store ptr null, ptr @FileData_SHARED, align 8
  %78 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  br label %79

79:                                               ; preds = %76, %68
  store ptr null, ptr %2, align 8
  br label %80

80:                                               ; preds = %79, %66, %22
  %81 = load ptr, ptr %2, align 8
  ret ptr %81
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @fileWriter1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i64, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 1, ptr %5, align 4
  %12 = load ptr, ptr @sigOutFilename_SHARED, align 8
  store ptr %12, ptr %4, align 8
  %13 = load i32, ptr @OutputStdOut_SHARED, align 4
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %15, label %21

15:                                               ; preds = %1
  store i32 2, ptr %5, align 4
  %16 = load i32, ptr %5, align 4
  %17 = icmp eq i32 %16, -1
  br i1 %17, label %18, label %20

18:                                               ; preds = %15
  %19 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  store ptr null, ptr %2, align 8
  br label %84

20:                                               ; preds = %15
  br label %21

21:                                               ; preds = %20, %1
  br label %22

22:                                               ; preds = %73, %34, %21
  %23 = load i32, ptr %6, align 4
  %24 = load i32, ptr @NumBlocks_SHARED, align 4
  %25 = icmp slt i32 %23, %24
  br i1 %25, label %29, label %26

26:                                               ; preds = %22
  %27 = load i32, ptr @allDone_SHARED, align 4
  %28 = icmp eq i32 %27, 0
  br label %29

29:                                               ; preds = %26, %22
  %30 = phi i1 [ true, %22 ], [ %28, %26 ]
  br i1 %30, label %31, label %74

31:                                               ; preds = %29
  %32 = load i32, ptr @OutputBuffer_SHARED, align 4
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %34, label %35

34:                                               ; preds = %31
  br label %22, !llvm.loop !9

35:                                               ; preds = %31
  %36 = load i32, ptr @OutputBuffer_SHARED, align 4
  store i32 %36, ptr %10, align 4
  %37 = load i32, ptr %5, align 4
  store i32 %37, ptr %11, align 4
  store i32 1, ptr %9, align 4
  %38 = load i32, ptr %9, align 4
  %39 = load i32, ptr %7, align 4
  %40 = add nsw i32 %39, %38
  store i32 %40, ptr %7, align 4
  %41 = load i32, ptr %9, align 4
  %42 = icmp sle i32 %41, 0
  br i1 %42, label %43, label %55

43:                                               ; preds = %35
  %44 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %45 = load i32, ptr @OutputStdOut_SHARED, align 4
  %46 = icmp eq i32 %45, 0
  br i1 %46, label %47, label %48

47:                                               ; preds = %43
  store i32 0, ptr %5, align 4
  br label %48

48:                                               ; preds = %47, %43
  %49 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  %50 = load i32, ptr @OutputBuffer_SHARED, align 4
  %51 = icmp ne i32 %50, 0
  br i1 %51, label %52, label %53

52:                                               ; preds = %48
  store i32 0, ptr @OutputBuffer_SHARED, align 4
  br label %53

53:                                               ; preds = %52, %48
  %54 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  store ptr null, ptr %2, align 8
  br label %84

55:                                               ; preds = %35
  %56 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  %57 = load i32, ptr @OutputBuffer_SHARED, align 4
  %58 = icmp ne i32 %57, 0
  br i1 %58, label %59, label %60

59:                                               ; preds = %55
  store i32 0, ptr @OutputBuffer_SHARED, align 4
  br label %60

60:                                               ; preds = %59, %55
  %61 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  %62 = load i32, ptr %6, align 4
  %63 = add nsw i32 %62, 1
  store i32 %63, ptr %6, align 4
  %64 = load i32, ptr %6, align 4
  %65 = mul nsw i32 100, %64
  %66 = load i32, ptr @NumBlocks_SHARED, align 4
  %67 = sdiv i32 %65, %66
  %68 = sext i32 %67 to i64
  store i64 %68, ptr %8, align 8
  %69 = load i32, ptr @QuietMode_SHARED, align 4
  %70 = icmp ne i32 %69, 1
  br i1 %70, label %71, label %73

71:                                               ; preds = %60
  %72 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  br label %73

73:                                               ; preds = %71, %60
  br label %22, !llvm.loop !9

74:                                               ; preds = %29
  %75 = load i32, ptr @OutputStdOut_SHARED, align 4
  %76 = icmp eq i32 %75, 0
  br i1 %76, label %77, label %78

77:                                               ; preds = %74
  store i32 0, ptr %5, align 4
  br label %78

78:                                               ; preds = %77, %74
  %79 = load i32, ptr @QuietMode_SHARED, align 4
  %80 = icmp ne i32 %79, 1
  br i1 %80, label %81, label %83

81:                                               ; preds = %78
  %82 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  br label %83

83:                                               ; preds = %81, %78
  store ptr null, ptr %2, align 8
  br label %84

84:                                               ; preds = %83, %53, %18
  %85 = load ptr, ptr %2, align 8
  ret ptr %85
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @fileWriter2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i64, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 1, ptr %5, align 4
  %12 = load ptr, ptr @sigOutFilename_SHARED, align 8
  store ptr %12, ptr %4, align 8
  %13 = load i32, ptr @OutputStdOut_SHARED, align 4
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %15, label %21

15:                                               ; preds = %1
  store i32 2, ptr %5, align 4
  %16 = load i32, ptr %5, align 4
  %17 = icmp eq i32 %16, -1
  br i1 %17, label %18, label %20

18:                                               ; preds = %15
  %19 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  store ptr null, ptr %2, align 8
  br label %84

20:                                               ; preds = %15
  br label %21

21:                                               ; preds = %20, %1
  br label %22

22:                                               ; preds = %73, %34, %21
  %23 = load i32, ptr %6, align 4
  %24 = load i32, ptr @NumBlocks_SHARED, align 4
  %25 = icmp slt i32 %23, %24
  br i1 %25, label %29, label %26

26:                                               ; preds = %22
  %27 = load i32, ptr @allDone_SHARED, align 4
  %28 = icmp eq i32 %27, 0
  br label %29

29:                                               ; preds = %26, %22
  %30 = phi i1 [ true, %22 ], [ %28, %26 ]
  br i1 %30, label %31, label %74

31:                                               ; preds = %29
  %32 = load i32, ptr @OutputBuffer_SHARED, align 4
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %34, label %35

34:                                               ; preds = %31
  br label %22, !llvm.loop !10

35:                                               ; preds = %31
  %36 = load i32, ptr @OutputBuffer_SHARED, align 4
  store i32 %36, ptr %10, align 4
  %37 = load i32, ptr %5, align 4
  store i32 %37, ptr %11, align 4
  store i32 1, ptr %9, align 4
  %38 = load i32, ptr %9, align 4
  %39 = load i32, ptr %7, align 4
  %40 = add nsw i32 %39, %38
  store i32 %40, ptr %7, align 4
  %41 = load i32, ptr %9, align 4
  %42 = icmp sle i32 %41, 0
  br i1 %42, label %43, label %55

43:                                               ; preds = %35
  %44 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %45 = load i32, ptr @OutputStdOut_SHARED, align 4
  %46 = icmp eq i32 %45, 0
  br i1 %46, label %47, label %48

47:                                               ; preds = %43
  store i32 0, ptr %5, align 4
  br label %48

48:                                               ; preds = %47, %43
  %49 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  %50 = load i32, ptr @OutputBuffer_SHARED, align 4
  %51 = icmp ne i32 %50, 0
  br i1 %51, label %52, label %53

52:                                               ; preds = %48
  store i32 0, ptr @OutputBuffer_SHARED, align 4
  br label %53

53:                                               ; preds = %52, %48
  %54 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  store ptr null, ptr %2, align 8
  br label %84

55:                                               ; preds = %35
  %56 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  %57 = load i32, ptr @OutputBuffer_SHARED, align 4
  %58 = icmp ne i32 %57, 0
  br i1 %58, label %59, label %60

59:                                               ; preds = %55
  store i32 0, ptr @OutputBuffer_SHARED, align 4
  br label %60

60:                                               ; preds = %59, %55
  %61 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  %62 = load i32, ptr %6, align 4
  %63 = add nsw i32 %62, 1
  store i32 %63, ptr %6, align 4
  %64 = load i32, ptr %6, align 4
  %65 = mul nsw i32 100, %64
  %66 = load i32, ptr @NumBlocks_SHARED, align 4
  %67 = sdiv i32 %65, %66
  %68 = sext i32 %67 to i64
  store i64 %68, ptr %8, align 8
  %69 = load i32, ptr @QuietMode_SHARED, align 4
  %70 = icmp ne i32 %69, 1
  br i1 %70, label %71, label %73

71:                                               ; preds = %60
  %72 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  br label %73

73:                                               ; preds = %71, %60
  br label %22, !llvm.loop !10

74:                                               ; preds = %29
  %75 = load i32, ptr @OutputStdOut_SHARED, align 4
  %76 = icmp eq i32 %75, 0
  br i1 %76, label %77, label %78

77:                                               ; preds = %74
  store i32 0, ptr %5, align 4
  br label %78

78:                                               ; preds = %77, %74
  %79 = load i32, ptr @QuietMode_SHARED, align 4
  %80 = icmp ne i32 %79, 1
  br i1 %80, label %81, label %83

81:                                               ; preds = %78
  %82 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  br label %83

83:                                               ; preds = %81, %78
  store ptr null, ptr %2, align 8
  br label %84

84:                                               ; preds = %83, %53, %18
  %85 = load ptr, ptr %2, align 8
  ret ptr %85
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @consumer1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %13 = load i32, ptr @queue_mut_SHARED, align 4
  store i32 %13, ptr %9, align 4
  %14 = load i32, ptr %9, align 4
  store i32 %14, ptr @queue_mut_SHARED, align 4
  %15 = call i32 @pthread_mutex_lock(ptr noundef @queue_mut)
  %16 = load i32, ptr @queue_empty_SHARED, align 4
  %17 = icmp ne i32 %16, 0
  br i1 %17, label %18, label %27

18:                                               ; preds = %1
  %19 = load i32, ptr @allDone_SHARED, align 4
  %20 = icmp eq i32 %19, 1
  br i1 %20, label %21, label %25

21:                                               ; preds = %18
  %22 = call i32 @pthread_mutex_unlock(ptr noundef @queue_mut)
  %23 = load i32, ptr @queue_mut_SHARED, align 4
  store i32 %23, ptr %9, align 4
  %24 = load i32, ptr %9, align 4
  store i32 %24, ptr @queue_mut_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %79

25:                                               ; preds = %18
  %26 = call i32 @"\01_pthread_cond_wait"(ptr noundef @queue_notEmpty, ptr noundef @queue_mut)
  br label %27

27:                                               ; preds = %25, %1
  %28 = load ptr, ptr @queue_buf_SHARED, align 8
  %29 = load i64, ptr @queue_head_SHARED, align 8
  %30 = getelementptr inbounds ptr, ptr %28, i64 %29
  %31 = load ptr, ptr %30, align 8
  store ptr %31, ptr @FileData_SHARED, align 8
  %32 = load ptr, ptr @queue_bufSize_SHARED, align 8
  %33 = load i64, ptr @queue_head_SHARED, align 8
  %34 = getelementptr inbounds i32, ptr %32, i64 %33
  %35 = load i32, ptr %34, align 4
  store i32 %35, ptr %4, align 4
  %36 = load ptr, ptr @queue_blockNum_SHARED, align 8
  %37 = load i64, ptr @queue_head_SHARED, align 8
  %38 = getelementptr inbounds i32, ptr %36, i64 %37
  %39 = load i32, ptr %38, align 4
  store i32 %39, ptr %5, align 4
  %40 = load i64, ptr @queue_head_SHARED, align 8
  %41 = add nsw i64 %40, 1
  store i64 %41, ptr @queue_head_SHARED, align 8
  %42 = load i64, ptr @queue_head_SHARED, align 8
  %43 = load i32, ptr @QUEUESIZE_SHARED, align 4
  %44 = sext i32 %43 to i64
  %45 = icmp eq i64 %42, %44
  br i1 %45, label %46, label %47

46:                                               ; preds = %27
  store i64 0, ptr @queue_head_SHARED, align 8
  br label %47

47:                                               ; preds = %46, %27
  %48 = load i64, ptr @queue_head_SHARED, align 8
  %49 = load i64, ptr @queue_tail_SHARED, align 8
  %50 = icmp eq i64 %48, %49
  br i1 %50, label %51, label %52

51:                                               ; preds = %47
  store i32 1, ptr @queue_empty_SHARED, align 4
  br label %52

52:                                               ; preds = %51, %47
  store i32 0, ptr @queue_full_SHARED, align 4
  %53 = call i32 @pthread_mutex_unlock(ptr noundef @queue_mut)
  %54 = load i32, ptr @queue_mut_SHARED, align 4
  store i32 %54, ptr %9, align 4
  %55 = load i32, ptr %9, align 4
  store i32 %55, ptr @queue_mut_SHARED, align 4
  %56 = call i32 @pthread_cond_signal(ptr noundef @queue_notFull)
  %57 = load i32, ptr %7, align 4
  %58 = sitofp i32 %57 to double
  %59 = call double @llvm.fmuladd.f64(double %58, double 1.010000e+00, double 6.000000e+02)
  %60 = fptosi double %59 to i32
  store i32 %60, ptr %6, align 4
  %61 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  store ptr @.str, ptr @CompressedData_SHARED, align 8
  %62 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  %63 = load ptr, ptr @CompressedData_SHARED, align 8
  %64 = icmp eq ptr %63, null
  br i1 %64, label %65, label %67

65:                                               ; preds = %52
  %66 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store ptr null, ptr %2, align 8
  br label %79

67:                                               ; preds = %52
  store i32 3, ptr %8, align 4
  %68 = call i32 @pthread_mutex_lock(ptr noundef @OutMutex)
  %69 = load i32, ptr %5, align 4
  store i32 %69, ptr %10, align 4
  %70 = load ptr, ptr @CompressedData_SHARED, align 8
  store ptr %70, ptr %11, align 8
  %71 = load i32, ptr %6, align 4
  store i32 %71, ptr %12, align 4
  store i32 2, ptr @OutputBuffer_SHARED, align 4
  store i32 1, ptr @OutputBuffer_SHARED, align 4
  %72 = call i32 @pthread_mutex_unlock(ptr noundef @OutMutex)
  %73 = load ptr, ptr @FileData_SHARED, align 8
  %74 = icmp ne ptr %73, null
  br i1 %74, label %75, label %78

75:                                               ; preds = %67
  %76 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  store ptr null, ptr @FileData_SHARED, align 8
  %77 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  br label %78

78:                                               ; preds = %75, %67
  store ptr null, ptr %2, align 8
  br label %79

79:                                               ; preds = %78, %65, %21
  %80 = load ptr, ptr %2, align 8
  ret ptr %80
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @consumer2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %13 = load i32, ptr @queue_mut_SHARED, align 4
  store i32 %13, ptr %9, align 4
  %14 = load i32, ptr %9, align 4
  store i32 %14, ptr @queue_mut_SHARED, align 4
  %15 = call i32 @pthread_mutex_lock(ptr noundef @queue_mut)
  br label %16

16:                                               ; preds = %26, %1
  %17 = load i32, ptr @queue_empty_SHARED, align 4
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %28

19:                                               ; preds = %16
  %20 = load i32, ptr @allDone_SHARED, align 4
  %21 = icmp eq i32 %20, 1
  br i1 %21, label %22, label %26

22:                                               ; preds = %19
  %23 = call i32 @pthread_mutex_unlock(ptr noundef @queue_mut)
  %24 = load i32, ptr @queue_mut_SHARED, align 4
  store i32 %24, ptr %9, align 4
  %25 = load i32, ptr %9, align 4
  store i32 %25, ptr @queue_mut_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %80

26:                                               ; preds = %19
  %27 = call i32 @"\01_pthread_cond_wait"(ptr noundef @queue_notEmpty, ptr noundef @queue_mut)
  br label %16, !llvm.loop !11

28:                                               ; preds = %16
  %29 = load ptr, ptr @queue_buf_SHARED, align 8
  %30 = load i64, ptr @queue_head_SHARED, align 8
  %31 = getelementptr inbounds ptr, ptr %29, i64 %30
  %32 = load ptr, ptr %31, align 8
  store ptr %32, ptr @FileData_SHARED, align 8
  %33 = load ptr, ptr @queue_bufSize_SHARED, align 8
  %34 = load i64, ptr @queue_head_SHARED, align 8
  %35 = getelementptr inbounds i32, ptr %33, i64 %34
  %36 = load i32, ptr %35, align 4
  store i32 %36, ptr %4, align 4
  %37 = load ptr, ptr @queue_blockNum_SHARED, align 8
  %38 = load i64, ptr @queue_head_SHARED, align 8
  %39 = getelementptr inbounds i32, ptr %37, i64 %38
  %40 = load i32, ptr %39, align 4
  store i32 %40, ptr %5, align 4
  %41 = load i64, ptr @queue_head_SHARED, align 8
  %42 = add nsw i64 %41, 1
  store i64 %42, ptr @queue_head_SHARED, align 8
  %43 = load i64, ptr @queue_head_SHARED, align 8
  %44 = load i32, ptr @QUEUESIZE_SHARED, align 4
  %45 = sext i32 %44 to i64
  %46 = icmp eq i64 %43, %45
  br i1 %46, label %47, label %48

47:                                               ; preds = %28
  store i64 0, ptr @queue_head_SHARED, align 8
  br label %48

48:                                               ; preds = %47, %28
  %49 = load i64, ptr @queue_head_SHARED, align 8
  %50 = load i64, ptr @queue_tail_SHARED, align 8
  %51 = icmp eq i64 %49, %50
  br i1 %51, label %52, label %53

52:                                               ; preds = %48
  store i32 1, ptr @queue_empty_SHARED, align 4
  br label %53

53:                                               ; preds = %52, %48
  store i32 0, ptr @queue_full_SHARED, align 4
  %54 = call i32 @pthread_mutex_unlock(ptr noundef @queue_mut)
  %55 = load i32, ptr @queue_mut_SHARED, align 4
  store i32 %55, ptr %9, align 4
  %56 = load i32, ptr %9, align 4
  store i32 %56, ptr @queue_mut_SHARED, align 4
  %57 = call i32 @pthread_cond_signal(ptr noundef @queue_notFull)
  %58 = load i32, ptr %7, align 4
  %59 = sitofp i32 %58 to double
  %60 = call double @llvm.fmuladd.f64(double %59, double 1.010000e+00, double 6.000000e+02)
  %61 = fptosi double %60 to i32
  store i32 %61, ptr %6, align 4
  %62 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  store ptr @.str, ptr @CompressedData_SHARED, align 8
  %63 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  %64 = load ptr, ptr @CompressedData_SHARED, align 8
  %65 = icmp eq ptr %64, null
  br i1 %65, label %66, label %68

66:                                               ; preds = %53
  %67 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store ptr null, ptr %2, align 8
  br label %80

68:                                               ; preds = %53
  store i32 3, ptr %8, align 4
  %69 = call i32 @pthread_mutex_lock(ptr noundef @OutMutex)
  %70 = load i32, ptr %5, align 4
  store i32 %70, ptr %10, align 4
  %71 = load ptr, ptr @CompressedData_SHARED, align 8
  store ptr %71, ptr %11, align 8
  %72 = load i32, ptr %6, align 4
  store i32 %72, ptr %12, align 4
  store i32 2, ptr @OutputBuffer_SHARED, align 4
  store i32 1, ptr @OutputBuffer_SHARED, align 4
  %73 = call i32 @pthread_mutex_unlock(ptr noundef @OutMutex)
  %74 = load ptr, ptr @FileData_SHARED, align 8
  %75 = icmp ne ptr %74, null
  br i1 %75, label %76, label %79

76:                                               ; preds = %68
  %77 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  store ptr null, ptr @FileData_SHARED, align 8
  %78 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  br label %79

79:                                               ; preds = %76, %68
  store ptr null, ptr %2, align 8
  br label %80

80:                                               ; preds = %79, %66, %22
  %81 = load ptr, ptr %2, align 8
  ret ptr %81
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @producer(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca ptr, align 8
  %14 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 0, ptr %4, align 4
  store i32 0, ptr %5, align 4
  store i32 0, ptr %6, align 4
  store i32 0, ptr %7, align 4
  store i32 -1, ptr %8, align 4
  %15 = load i32, ptr %9, align 4
  store i32 %15, ptr %5, align 4
  br label %16

16:                                               ; preds = %98, %1
  %17 = load i32, ptr %5, align 4
  %18 = icmp sgt i32 %17, 0
  br i1 %18, label %19, label %103

19:                                               ; preds = %16
  %20 = load i32, ptr %5, align 4
  %21 = load i32, ptr %11, align 4
  %22 = icmp sgt i32 %20, %21
  br i1 %22, label %23, label %25

23:                                               ; preds = %19
  %24 = load i32, ptr %11, align 4
  store i32 %24, ptr %4, align 4
  br label %27

25:                                               ; preds = %19
  %26 = load i32, ptr %5, align 4
  store i32 %26, ptr %4, align 4
  br label %27

27:                                               ; preds = %25, %23
  %28 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  store ptr null, ptr @FileData_SHARED, align 8
  %29 = load i32, ptr %4, align 4
  store i32 %29, ptr %12, align 4
  store ptr @.str, ptr @FileData_SHARED, align 8
  %30 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  %31 = load ptr, ptr @FileData_SHARED, align 8
  %32 = icmp eq ptr %31, null
  br i1 %32, label %33, label %34

33:                                               ; preds = %27
  store i32 1, ptr @allDone_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %104

34:                                               ; preds = %27
  %35 = load ptr, ptr @FileData_SHARED, align 8
  store ptr %35, ptr %13, align 8
  %36 = load i32, ptr %4, align 4
  store i32 %36, ptr %14, align 4
  store i32 1, ptr %7, align 4
  %37 = load i32, ptr %7, align 4
  %38 = icmp eq i32 %37, 0
  br i1 %38, label %39, label %46

39:                                               ; preds = %34
  %40 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  %41 = load ptr, ptr @FileData_SHARED, align 8
  %42 = icmp ne ptr %41, null
  br i1 %42, label %43, label %44

43:                                               ; preds = %39
  store ptr null, ptr @FileData_SHARED, align 8
  br label %44

44:                                               ; preds = %43, %39
  %45 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  br label %103

46:                                               ; preds = %34
  %47 = load i32, ptr %7, align 4
  %48 = icmp slt i32 %47, 0
  br i1 %48, label %49, label %56

49:                                               ; preds = %46
  %50 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  %51 = load ptr, ptr @FileData_SHARED, align 8
  %52 = icmp ne ptr %51, null
  br i1 %52, label %53, label %54

53:                                               ; preds = %49
  store ptr null, ptr @FileData_SHARED, align 8
  br label %54

54:                                               ; preds = %53, %49
  %55 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  store i32 1, ptr @allDone_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %104

56:                                               ; preds = %46
  br label %57

57:                                               ; preds = %56
  %58 = load i32, ptr %7, align 4
  %59 = load i32, ptr %5, align 4
  %60 = sub nsw i32 %59, %58
  store i32 %60, ptr %5, align 4
  %61 = load i32, ptr %7, align 4
  %62 = load i32, ptr %4, align 4
  %63 = icmp ne i32 %61, %62
  br i1 %63, label %64, label %66

64:                                               ; preds = %57
  %65 = load i32, ptr %7, align 4
  store i32 %65, ptr %4, align 4
  br label %66

66:                                               ; preds = %64, %57
  %67 = call i32 @pthread_mutex_lock(ptr noundef @queue_mut)
  br label %68

68:                                               ; preds = %71, %66
  %69 = load i32, ptr @queue_full_SHARED, align 4
  %70 = icmp ne i32 %69, 0
  br i1 %70, label %71, label %73

71:                                               ; preds = %68
  %72 = call i32 @"\01_pthread_cond_wait"(ptr noundef @queue_notFull, ptr noundef @queue_mut)
  br label %68, !llvm.loop !12

73:                                               ; preds = %68
  %74 = load ptr, ptr @FileData_SHARED, align 8
  %75 = load ptr, ptr @queue_buf_SHARED, align 8
  %76 = load i64, ptr @queue_tail_SHARED, align 8
  %77 = getelementptr inbounds ptr, ptr %75, i64 %76
  store ptr %74, ptr %77, align 8
  %78 = load i32, ptr %4, align 4
  %79 = load ptr, ptr @queue_bufSize_SHARED, align 8
  %80 = load i64, ptr @queue_tail_SHARED, align 8
  %81 = getelementptr inbounds i32, ptr %79, i64 %80
  store i32 %78, ptr %81, align 4
  %82 = load i32, ptr %6, align 4
  %83 = load ptr, ptr @queue_blockNum_SHARED, align 8
  %84 = load i64, ptr @queue_tail_SHARED, align 8
  %85 = getelementptr inbounds i32, ptr %83, i64 %84
  store i32 %82, ptr %85, align 4
  %86 = load i64, ptr @queue_tail_SHARED, align 8
  %87 = add nsw i64 %86, 1
  store i64 %87, ptr @queue_tail_SHARED, align 8
  %88 = load i64, ptr @queue_tail_SHARED, align 8
  %89 = load i32, ptr @QUEUESIZE_SHARED, align 4
  %90 = sext i32 %89 to i64
  %91 = icmp eq i64 %88, %90
  br i1 %91, label %92, label %93

92:                                               ; preds = %73
  store i64 0, ptr @queue_tail_SHARED, align 8
  br label %93

93:                                               ; preds = %92, %73
  %94 = load i64, ptr @queue_tail_SHARED, align 8
  %95 = load i64, ptr @queue_head_SHARED, align 8
  %96 = icmp eq i64 %94, %95
  br i1 %96, label %97, label %98

97:                                               ; preds = %93
  store i32 1, ptr @queue_full_SHARED, align 4
  br label %98

98:                                               ; preds = %97, %93
  store i32 0, ptr @queue_empty_SHARED, align 4
  %99 = call i32 @pthread_mutex_unlock(ptr noundef @queue_mut)
  %100 = call i32 @pthread_cond_signal(ptr noundef @queue_notEmpty)
  %101 = load i32, ptr %6, align 4
  %102 = add nsw i32 %101, 1
  store i32 %102, ptr %6, align 4
  br label %16, !llvm.loop !13

103:                                              ; preds = %44, %16
  store i32 1, ptr @allDone_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %104

104:                                              ; preds = %103, %54, %33
  %105 = load ptr, ptr %2, align 8
  ret ptr %105
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @producer_decompress(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca ptr, align 8
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca ptr, align 8
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca ptr, align 8
  %26 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 100000, ptr %6, align 4
  store i32 0, ptr %13, align 4
  store i32 0, ptr %8, align 4
  %27 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  store ptr null, ptr @FileData_SHARED, align 8
  %28 = load i32, ptr %6, align 4
  store i32 %28, ptr %16, align 4
  store ptr @.str, ptr @FileData_SHARED, align 8
  %29 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  %30 = load ptr, ptr @FileData_SHARED, align 8
  %31 = icmp eq ptr %30, null
  br i1 %31, label %32, label %34

32:                                               ; preds = %1
  %33 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  store i32 1, ptr @allDone_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %257

34:                                               ; preds = %1
  %35 = load i32, ptr %5, align 4
  store i32 %35, ptr %7, align 4
  br label %36

36:                                               ; preds = %109, %34
  %37 = load i32, ptr %7, align 4
  %38 = icmp sgt i32 %37, 0
  br i1 %38, label %39, label %116

39:                                               ; preds = %36
  %40 = load i32, ptr %9, align 4
  %41 = icmp eq i32 %40, 0
  br i1 %41, label %42, label %46

42:                                               ; preds = %39
  %43 = load i32, ptr %4, align 4
  store i32 %43, ptr %17, align 4
  %44 = load ptr, ptr @FileData_SHARED, align 8
  store ptr %44, ptr %18, align 8
  %45 = load i32, ptr %6, align 4
  store i32 %45, ptr %19, align 4
  store i32 1, ptr %8, align 4
  br label %52

46:                                               ; preds = %39
  %47 = load i32, ptr %6, align 4
  store i32 %47, ptr %20, align 4
  %48 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  %49 = load i32, ptr %4, align 4
  store i32 %49, ptr %21, align 4
  %50 = load ptr, ptr @FileData_SHARED, align 8
  store ptr %50, ptr %22, align 8
  %51 = load i32, ptr %6, align 4
  store i32 %51, ptr %23, align 4
  store i32 1, ptr %8, align 4
  br label %52

52:                                               ; preds = %46, %42
  %53 = load i32, ptr %8, align 4
  %54 = icmp slt i32 %53, 0
  br i1 %54, label %55, label %63

55:                                               ; preds = %52
  %56 = call i32 (ptr, ...) @printf(ptr noundef @.str.8)
  %57 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  %58 = load ptr, ptr @FileData_SHARED, align 8
  %59 = icmp ne ptr %58, null
  br i1 %59, label %60, label %61

60:                                               ; preds = %55
  store ptr null, ptr @FileData_SHARED, align 8
  br label %61

61:                                               ; preds = %60, %55
  %62 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  store i32 1, ptr @allDone_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %257

63:                                               ; preds = %52
  %64 = load i32, ptr %9, align 4
  %65 = icmp eq i32 %64, 0
  br i1 %65, label %66, label %67

66:                                               ; preds = %63
  store i32 0, ptr %10, align 4
  br label %68

67:                                               ; preds = %63
  store i32 1, ptr %10, align 4
  br label %68

68:                                               ; preds = %67, %66
  br label %69

69:                                               ; preds = %108, %68
  %70 = load i32, ptr %10, align 4
  %71 = icmp ne i32 %70, 0
  br i1 %71, label %72, label %109

72:                                               ; preds = %69
  %73 = load i32, ptr %9, align 4
  %74 = icmp eq i32 %73, 0
  br i1 %74, label %75, label %82

75:                                               ; preds = %72
  %76 = load i32, ptr %10, align 4
  %77 = load ptr, ptr @FileData_SHARED, align 8
  %78 = ptrtoint ptr %77 to i32
  %79 = sub nsw i32 %76, %78
  %80 = load i32, ptr %9, align 4
  %81 = add nsw i32 %79, %80
  store i32 %81, ptr %11, align 4
  br label %90

82:                                               ; preds = %72
  %83 = load i32, ptr %10, align 4
  %84 = load ptr, ptr @FileData_SHARED, align 8
  %85 = ptrtoint ptr %84 to i32
  %86 = sub nsw i32 %83, %85
  %87 = load i32, ptr %9, align 4
  %88 = add nsw i32 %86, %87
  %89 = add nsw i32 %88, 1
  store i32 %89, ptr %11, align 4
  br label %90

90:                                               ; preds = %82, %75
  %91 = load i32, ptr %9, align 4
  %92 = icmp eq i32 %91, 0
  br i1 %92, label %93, label %100

93:                                               ; preds = %90
  %94 = load i32, ptr %10, align 4
  %95 = load ptr, ptr @FileData_SHARED, align 8
  %96 = ptrtoint ptr %95 to i32
  %97 = sub nsw i32 %94, %96
  %98 = load i32, ptr %9, align 4
  %99 = add nsw i32 %97, %98
  store i32 %99, ptr %11, align 4
  br label %108

100:                                              ; preds = %90
  %101 = load i32, ptr %10, align 4
  %102 = load ptr, ptr @FileData_SHARED, align 8
  %103 = ptrtoint ptr %102 to i32
  %104 = sub nsw i32 %101, %103
  %105 = load i32, ptr %9, align 4
  %106 = add nsw i32 %104, %105
  %107 = add nsw i32 %106, 1
  store i32 %107, ptr %11, align 4
  br label %108

108:                                              ; preds = %100, %93
  br label %69, !llvm.loop !14

109:                                              ; preds = %69
  %110 = load i32, ptr %8, align 4
  %111 = load i32, ptr %9, align 4
  %112 = add nsw i32 %111, %110
  store i32 %112, ptr %9, align 4
  %113 = load i32, ptr %8, align 4
  %114 = load i32, ptr %7, align 4
  %115 = sub nsw i32 %114, %113
  store i32 %115, ptr %7, align 4
  br label %36, !llvm.loop !15

116:                                              ; preds = %36
  %117 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  %118 = load ptr, ptr @FileData_SHARED, align 8
  %119 = icmp ne ptr %118, null
  br i1 %119, label %120, label %121

120:                                              ; preds = %116
  store ptr null, ptr @FileData_SHARED, align 8
  br label %121

121:                                              ; preds = %120, %116
  store i32 0, ptr @NumBlocks_SHARED, align 4
  %122 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  store i32 0, ptr %12, align 4
  br label %123

123:                                              ; preds = %147, %121
  %124 = load i32, ptr %12, align 4
  %125 = load i32, ptr %13, align 4
  %126 = icmp slt i32 %124, %125
  br i1 %126, label %127, label %150

127:                                              ; preds = %123
  %128 = load i32, ptr %12, align 4
  %129 = load i32, ptr %13, align 4
  %130 = sub nsw i32 %129, 1
  %131 = icmp eq i32 %128, %130
  br i1 %131, label %132, label %136

132:                                              ; preds = %127
  %133 = load i32, ptr %5, align 4
  %134 = load i32, ptr %15, align 4
  %135 = sub nsw i32 %133, %134
  store i32 %135, ptr %15, align 4
  br label %146

136:                                              ; preds = %127
  %137 = load i32, ptr %12, align 4
  %138 = icmp eq i32 %137, 0
  br i1 %138, label %139, label %141

139:                                              ; preds = %136
  %140 = load i32, ptr %15, align 4
  store i32 %140, ptr %15, align 4
  br label %145

141:                                              ; preds = %136
  %142 = load i32, ptr %15, align 4
  %143 = load i32, ptr %15, align 4
  %144 = sub nsw i32 %142, %143
  store i32 %144, ptr %15, align 4
  br label %145

145:                                              ; preds = %141, %139
  br label %146

146:                                              ; preds = %145, %132
  br label %147

147:                                              ; preds = %146
  %148 = load i32, ptr %12, align 4
  %149 = add nsw i32 %148, 1
  store i32 %149, ptr %12, align 4
  br label %123, !llvm.loop !16

150:                                              ; preds = %123
  store i32 0, ptr %12, align 4
  br label %151

151:                                              ; preds = %253, %150
  %152 = load i32, ptr %12, align 4
  %153 = load i32, ptr %13, align 4
  %154 = icmp slt i32 %152, %153
  br i1 %154, label %155, label %256

155:                                              ; preds = %151
  %156 = load i32, ptr %15, align 4
  store i32 %156, ptr %24, align 4
  store i32 0, ptr %8, align 4
  %157 = load i32, ptr %8, align 4
  %158 = load i32, ptr %15, align 4
  %159 = icmp ne i32 %157, %158
  br i1 %159, label %160, label %161

160:                                              ; preds = %155
  store i32 1, ptr @allDone_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %257

161:                                              ; preds = %155
  %162 = load i32, ptr %15, align 4
  store i32 %162, ptr %6, align 4
  %163 = load i32, ptr @QuietMode_SHARED, align 4
  %164 = icmp ne i32 %163, 1
  br i1 %164, label %165, label %171

165:                                              ; preds = %161
  %166 = load i32, ptr %6, align 4
  %167 = icmp sgt i32 %166, 250000000
  br i1 %167, label %168, label %170

168:                                              ; preds = %165
  %169 = call i32 (ptr, ...) @printf(ptr noundef @.str.9)
  br label %170

170:                                              ; preds = %168, %165
  br label %171

171:                                              ; preds = %170, %161
  %172 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  store ptr null, ptr @FileData_SHARED, align 8
  store ptr @.str, ptr @FileData_SHARED, align 8
  %173 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  %174 = load ptr, ptr @FileData_SHARED, align 8
  %175 = icmp eq ptr %174, null
  br i1 %175, label %176, label %177

176:                                              ; preds = %171
  store i32 1, ptr @allDone_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %257

177:                                              ; preds = %171
  %178 = load ptr, ptr @FileData_SHARED, align 8
  store ptr %178, ptr %25, align 8
  %179 = load i32, ptr %6, align 4
  store i32 %179, ptr %26, align 4
  store i32 1, ptr %8, align 4
  %180 = load i32, ptr %8, align 4
  %181 = icmp eq i32 %180, 0
  br i1 %181, label %182, label %189

182:                                              ; preds = %177
  %183 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  %184 = load ptr, ptr @FileData_SHARED, align 8
  %185 = icmp ne ptr %184, null
  br i1 %185, label %186, label %187

186:                                              ; preds = %182
  store ptr null, ptr @FileData_SHARED, align 8
  br label %187

187:                                              ; preds = %186, %182
  %188 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  store i32 1, ptr @allDone_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %257

189:                                              ; preds = %177
  %190 = load i32, ptr %8, align 4
  %191 = icmp slt i32 %190, 0
  br i1 %191, label %192, label %199

192:                                              ; preds = %189
  %193 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  %194 = load ptr, ptr @FileData_SHARED, align 8
  %195 = icmp ne ptr %194, null
  br i1 %195, label %196, label %197

196:                                              ; preds = %192
  store ptr null, ptr @FileData_SHARED, align 8
  br label %197

197:                                              ; preds = %196, %192
  %198 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  store i32 1, ptr @allDone_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %257

199:                                              ; preds = %189
  %200 = load i32, ptr %8, align 4
  %201 = load i32, ptr %6, align 4
  %202 = icmp ne i32 %200, %201
  br i1 %202, label %203, label %210

203:                                              ; preds = %199
  %204 = call i32 @pthread_mutex_lock(ptr noundef @MemMutex)
  %205 = load ptr, ptr @FileData_SHARED, align 8
  %206 = icmp ne ptr %205, null
  br i1 %206, label %207, label %208

207:                                              ; preds = %203
  store ptr null, ptr @FileData_SHARED, align 8
  br label %208

208:                                              ; preds = %207, %203
  %209 = call i32 @pthread_mutex_unlock(ptr noundef @MemMutex)
  store i32 1, ptr @allDone_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %257

210:                                              ; preds = %199
  br label %211

211:                                              ; preds = %210
  br label %212

212:                                              ; preds = %211
  %213 = call i32 @pthread_mutex_lock(ptr noundef @OutMutex)
  %214 = load i32, ptr @OutputBuffer_SHARED, align 4
  %215 = add nsw i32 %214, 1
  store i32 %215, ptr @OutputBuffer_SHARED, align 4
  %216 = call i32 @pthread_mutex_unlock(ptr noundef @OutMutex)
  %217 = call i32 @pthread_mutex_lock(ptr noundef @queue_mut)
  br label %218

218:                                              ; preds = %221, %212
  %219 = load i32, ptr @queue_full_SHARED, align 4
  %220 = icmp ne i32 %219, 0
  br i1 %220, label %221, label %223

221:                                              ; preds = %218
  %222 = call i32 @"\01_pthread_cond_wait"(ptr noundef @queue_notFull, ptr noundef @queue_mut)
  br label %218, !llvm.loop !17

223:                                              ; preds = %218
  %224 = load ptr, ptr @FileData_SHARED, align 8
  %225 = load ptr, ptr @queue_buf_SHARED, align 8
  %226 = load i64, ptr @queue_tail_SHARED, align 8
  %227 = getelementptr inbounds ptr, ptr %225, i64 %226
  store ptr %224, ptr %227, align 8
  %228 = load i32, ptr %6, align 4
  %229 = load ptr, ptr @queue_bufSize_SHARED, align 8
  %230 = load i64, ptr @queue_tail_SHARED, align 8
  %231 = getelementptr inbounds i32, ptr %229, i64 %230
  store i32 %228, ptr %231, align 4
  %232 = load i32, ptr %14, align 4
  %233 = load ptr, ptr @queue_blockNum_SHARED, align 8
  %234 = load i64, ptr @queue_tail_SHARED, align 8
  %235 = getelementptr inbounds i32, ptr %233, i64 %234
  store i32 %232, ptr %235, align 4
  %236 = load i64, ptr @queue_tail_SHARED, align 8
  %237 = add nsw i64 %236, 1
  store i64 %237, ptr @queue_tail_SHARED, align 8
  %238 = load i64, ptr @queue_tail_SHARED, align 8
  %239 = load i32, ptr @QUEUESIZE_SHARED, align 4
  %240 = sext i32 %239 to i64
  %241 = icmp eq i64 %238, %240
  br i1 %241, label %242, label %243

242:                                              ; preds = %223
  store i64 0, ptr @queue_tail_SHARED, align 8
  br label %243

243:                                              ; preds = %242, %223
  %244 = load i64, ptr @queue_tail_SHARED, align 8
  %245 = load i64, ptr @queue_head_SHARED, align 8
  %246 = icmp eq i64 %244, %245
  br i1 %246, label %247, label %248

247:                                              ; preds = %243
  store i32 1, ptr @queue_full_SHARED, align 4
  br label %248

248:                                              ; preds = %247, %243
  store i32 0, ptr @queue_empty_SHARED, align 4
  %249 = call i32 @pthread_mutex_unlock(ptr noundef @queue_mut)
  %250 = call i32 @pthread_cond_signal(ptr noundef @queue_notEmpty)
  %251 = load i32, ptr %14, align 4
  %252 = add nsw i32 %251, 1
  store i32 %252, ptr %14, align 4
  br label %253

253:                                              ; preds = %248
  %254 = load i32, ptr %12, align 4
  %255 = add nsw i32 %254, 1
  store i32 %255, ptr %12, align 4
  br label %151, !llvm.loop !18

256:                                              ; preds = %151
  store i32 1, ptr @allDone_SHARED, align 4
  store ptr null, ptr %2, align 8
  br label %257

257:                                              ; preds = %256, %208, %197, %187, %176, %160, %61, %32
  %258 = load ptr, ptr %2, align 8
  ret ptr %258
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 2, ptr %10, align 4
  store i32 0, ptr %11, align 4
  store ptr null, ptr %12, align 8
  store i32 0, ptr %13, align 4
  store i32 1, ptr %14, align 4
  store i32 0, ptr %16, align 4
  store i32 0, ptr %17, align 4
  store i32 900000, ptr %18, align 4
  store i32 0, ptr %19, align 4
  %21 = load i32, ptr %10, align 4
  store i32 %21, ptr @QUEUESIZE_SHARED, align 4
  store ptr null, ptr @queue_buf_SHARED, align 8
  store ptr null, ptr @queue_bufSize_SHARED, align 8
  store ptr null, ptr @queue_blockNum_SHARED, align 8
  store i32 0, ptr @queue_empty_SHARED, align 4
  store i32 0, ptr @queue_full_SHARED, align 4
  store i64 0, ptr @queue_head_SHARED, align 8
  store i64 0, ptr @queue_tail_SHARED, align 8
  %22 = call i32 @pthread_mutex_init(ptr noundef @queue_mut, ptr noundef null)
  %23 = call i32 @"\01_pthread_cond_init"(ptr noundef @queue_notFull, ptr noundef null)
  %24 = call i32 @"\01_pthread_cond_init"(ptr noundef @queue_notEmpty, ptr noundef null)
  %25 = load i32, ptr %11, align 4
  %26 = icmp eq i32 %25, 1
  br i1 %26, label %27, label %28

27:                                               ; preds = %0
  store i32 0, ptr %13, align 4
  br label %35

28:                                               ; preds = %0
  %29 = load i32, ptr %17, align 4
  %30 = load i32, ptr %18, align 4
  %31 = add nsw i32 %29, %30
  %32 = sub nsw i32 %31, 1
  %33 = load i32, ptr %18, align 4
  %34 = sdiv i32 %32, %33
  store i32 %34, ptr %13, align 4
  br label %35

35:                                               ; preds = %28, %27
  %36 = load i32, ptr %13, align 4
  store i32 %36, ptr @NumBlocks_SHARED, align 4
  store i32 0, ptr %15, align 4
  br label %37

37:                                               ; preds = %42, %35
  %38 = load i32, ptr %15, align 4
  %39 = load i32, ptr %13, align 4
  %40 = icmp slt i32 %38, %39
  br i1 %40, label %41, label %45

41:                                               ; preds = %37
  store i32 1, ptr @OutputBuffer_SHARED, align 4
  store i32 2, ptr @OutputBuffer_SHARED, align 4
  br label %42

42:                                               ; preds = %41
  %43 = load i32, ptr %15, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %15, align 4
  br label %37, !llvm.loop !19

45:                                               ; preds = %37
  %46 = load i32, ptr %11, align 4
  %47 = icmp eq i32 %46, 1
  br i1 %47, label %48, label %60

48:                                               ; preds = %45
  %49 = load i32, ptr @QuietMode_SHARED, align 4
  %50 = icmp ne i32 %49, 1
  br i1 %50, label %51, label %53

51:                                               ; preds = %48
  %52 = call i32 (ptr, ...) @printf(ptr noundef @.str.10)
  br label %53

53:                                               ; preds = %51, %48
  %54 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @consumer_decompress1, ptr noundef null)
  %55 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @consumer_decompress2, ptr noundef null)
  %56 = call i32 @pthread_create(ptr noundef %6, ptr noundef null, ptr noundef @fileWriter1, ptr noundef null)
  %57 = call i32 @pthread_create(ptr noundef %8, ptr noundef null, ptr noundef @producer_decompress, ptr noundef null)
  %58 = load ptr, ptr %6, align 8
  %59 = call i32 @"\01_pthread_join"(ptr noundef %58, ptr noundef null)
  br label %72

60:                                               ; preds = %45
  %61 = load i32, ptr @QuietMode_SHARED, align 4
  %62 = icmp ne i32 %61, 1
  br i1 %62, label %63, label %65

63:                                               ; preds = %60
  %64 = call i32 (ptr, ...) @printf(ptr noundef @.str.11)
  br label %65

65:                                               ; preds = %63, %60
  %66 = call i32 @pthread_create(ptr noundef %4, ptr noundef null, ptr noundef @consumer1, ptr noundef null)
  %67 = call i32 @pthread_create(ptr noundef %5, ptr noundef null, ptr noundef @consumer2, ptr noundef null)
  %68 = call i32 @pthread_create(ptr noundef %7, ptr noundef null, ptr noundef @fileWriter2, ptr noundef null)
  %69 = call i32 @pthread_create(ptr noundef %9, ptr noundef null, ptr noundef @producer, ptr noundef null)
  %70 = load ptr, ptr %7, align 8
  %71 = call i32 @"\01_pthread_join"(ptr noundef %70, ptr noundef null)
  br label %72

72:                                               ; preds = %65, %53
  store ptr null, ptr @sigInFilename_SHARED, align 8
  store ptr null, ptr @sigOutFilename_SHARED, align 8
  %73 = load i32, ptr %14, align 4
  %74 = icmp ne i32 %73, 1
  br i1 %74, label %75, label %81

75:                                               ; preds = %72
  %76 = load i32, ptr @OutputStdOut_SHARED, align 4
  %77 = icmp eq i32 %76, 0
  br i1 %77, label %78, label %79

78:                                               ; preds = %75
  br label %80

79:                                               ; preds = %75
  br label %80

80:                                               ; preds = %79, %78
  br label %81

81:                                               ; preds = %80, %72
  store i32 0, ptr @OutputBuffer_SHARED, align 4
  store i32 1, ptr @queue_empty_SHARED, align 4
  store i32 0, ptr @queue_full_SHARED, align 4
  store i64 0, ptr @queue_head_SHARED, align 8
  store i64 0, ptr @queue_tail_SHARED, align 8
  %82 = load i32, ptr @QuietMode_SHARED, align 4
  %83 = icmp ne i32 %82, 1
  br i1 %83, label %84, label %86

84:                                               ; preds = %81
  %85 = call i32 (ptr, ...) @printf(ptr noundef @.str.12)
  br label %86

86:                                               ; preds = %84, %81
  store i32 1, ptr @patchVar_SHARED, align 4
  %87 = load ptr, ptr %2, align 8
  call void @nop1(ptr noundef %87)
  %88 = load ptr, ptr %3, align 8
  call void @nop1(ptr noundef %88)
  %89 = load ptr, ptr %4, align 8
  call void @nop1(ptr noundef %89)
  %90 = load ptr, ptr %5, align 8
  call void @nop1(ptr noundef %90)
  %91 = call i32 @pthread_mutex_destroy(ptr noundef @queue_mut)
  %92 = load i32, ptr %20, align 4
  store i32 %92, ptr @queue_mut_SHARED, align 4
  %93 = call i32 @pthread_cond_destroy(ptr noundef @queue_notFull)
  %94 = call i32 @pthread_cond_destroy(ptr noundef @queue_notEmpty)
  %95 = load i32, ptr @QuietMode_SHARED, align 4
  %96 = icmp ne i32 %95, 1
  br i1 %96, label %97, label %99

97:                                               ; preds = %86
  %98 = call i32 (ptr, ...) @printf(ptr noundef @.str.13)
  br label %99

99:                                               ; preds = %97, %86
  %100 = load i32, ptr %16, align 4
  ret i32 %100
}

declare i32 @pthread_mutex_init(ptr noundef, ptr noundef) #1

declare i32 @"\01_pthread_cond_init"(ptr noundef, ptr noundef) #1

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

declare i32 @"\01_pthread_join"(ptr noundef, ptr noundef) #1

declare i32 @pthread_mutex_destroy(ptr noundef) #1

declare i32 @pthread_cond_destroy(ptr noundef) #1

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

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
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
