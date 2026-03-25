; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@vec1_SHARED = common global i32 0, align 4
@res_SHARED = common global i32 0, align 4
@vec2_SHARED = common global i32 0, align 4
@__func__.main = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main1.c\00", align 1
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
  store i32 0, ptr %4, align 4
  store i32 0, ptr %3, align 4
  %5 = load i32, ptr @vec1_SHARED, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %9

7:                                                ; preds = %1
  %8 = load i32, ptr @vec1_SHARED, align 4
  store i32 %8, ptr %3, align 4
  br label %9

9:                                                ; preds = %7, %1
  store i32 0, ptr @vec1_SHARED, align 4
  %10 = load i32, ptr @res_SHARED, align 4
  store i32 %10, ptr %4, align 4
  %11 = load i32, ptr %3, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %90

13:                                               ; preds = %9
  %14 = load i32, ptr %3, align 4
  %15 = icmp eq i32 %14, 2
  br i1 %15, label %85, label %16

16:                                               ; preds = %13
  %17 = load i32, ptr %3, align 4
  %18 = icmp eq i32 %17, 3
  br i1 %18, label %85, label %19

19:                                               ; preds = %16
  %20 = load i32, ptr %3, align 4
  %21 = icmp eq i32 %20, 5
  br i1 %21, label %85, label %22

22:                                               ; preds = %19
  %23 = load i32, ptr %3, align 4
  %24 = icmp eq i32 %23, 7
  br i1 %24, label %85, label %25

25:                                               ; preds = %22
  %26 = load i32, ptr %3, align 4
  %27 = icmp eq i32 %26, 11
  br i1 %27, label %85, label %28

28:                                               ; preds = %25
  %29 = load i32, ptr %3, align 4
  %30 = icmp eq i32 %29, 13
  br i1 %30, label %85, label %31

31:                                               ; preds = %28
  %32 = load i32, ptr %3, align 4
  %33 = icmp eq i32 %32, 17
  br i1 %33, label %85, label %34

34:                                               ; preds = %31
  %35 = load i32, ptr %3, align 4
  %36 = icmp eq i32 %35, 19
  br i1 %36, label %85, label %37

37:                                               ; preds = %34
  %38 = load i32, ptr %3, align 4
  %39 = icmp eq i32 %38, 23
  br i1 %39, label %85, label %40

40:                                               ; preds = %37
  %41 = load i32, ptr %3, align 4
  %42 = icmp eq i32 %41, 29
  br i1 %42, label %85, label %43

43:                                               ; preds = %40
  %44 = load i32, ptr %3, align 4
  %45 = icmp eq i32 %44, 31
  br i1 %45, label %85, label %46

46:                                               ; preds = %43
  %47 = load i32, ptr %3, align 4
  %48 = icmp eq i32 %47, 37
  br i1 %48, label %85, label %49

49:                                               ; preds = %46
  %50 = load i32, ptr %3, align 4
  %51 = icmp eq i32 %50, 41
  br i1 %51, label %85, label %52

52:                                               ; preds = %49
  %53 = load i32, ptr %3, align 4
  %54 = icmp eq i32 %53, 43
  br i1 %54, label %85, label %55

55:                                               ; preds = %52
  %56 = load i32, ptr %3, align 4
  %57 = icmp eq i32 %56, 47
  br i1 %57, label %85, label %58

58:                                               ; preds = %55
  %59 = load i32, ptr %3, align 4
  %60 = icmp eq i32 %59, 53
  br i1 %60, label %85, label %61

61:                                               ; preds = %58
  %62 = load i32, ptr %3, align 4
  %63 = icmp eq i32 %62, 59
  br i1 %63, label %85, label %64

64:                                               ; preds = %61
  %65 = load i32, ptr %3, align 4
  %66 = icmp eq i32 %65, 61
  br i1 %66, label %85, label %67

67:                                               ; preds = %64
  %68 = load i32, ptr %3, align 4
  %69 = icmp eq i32 %68, 67
  br i1 %69, label %85, label %70

70:                                               ; preds = %67
  %71 = load i32, ptr %3, align 4
  %72 = icmp eq i32 %71, 71
  br i1 %72, label %85, label %73

73:                                               ; preds = %70
  %74 = load i32, ptr %3, align 4
  %75 = icmp eq i32 %74, 73
  br i1 %75, label %85, label %76

76:                                               ; preds = %73
  %77 = load i32, ptr %3, align 4
  %78 = icmp eq i32 %77, 79
  br i1 %78, label %85, label %79

79:                                               ; preds = %76
  %80 = load i32, ptr %3, align 4
  %81 = icmp eq i32 %80, 83
  br i1 %81, label %85, label %82

82:                                               ; preds = %79
  %83 = load i32, ptr %3, align 4
  %84 = icmp eq i32 %83, 89
  br i1 %84, label %85, label %86

85:                                               ; preds = %82, %79, %76, %73, %70, %67, %64, %61, %58, %55, %52, %49, %46, %43, %40, %37, %34, %31, %28, %25, %22, %19, %16, %13
  call void @nop1()
  br label %86

86:                                               ; preds = %85, %82
  %87 = load i32, ptr @res_SHARED, align 4
  %88 = add nsw i32 %87, 1
  store i32 %88, ptr %4, align 4
  %89 = load i32, ptr %4, align 4
  store i32 %89, ptr @res_SHARED, align 4
  call void @nop1()
  br label %90

90:                                               ; preds = %86, %9
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @thread2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  store i32 0, ptr %3, align 4
  %5 = load i32, ptr @vec2_SHARED, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %9

7:                                                ; preds = %1
  %8 = load i32, ptr @vec2_SHARED, align 4
  store i32 %8, ptr %3, align 4
  br label %9

9:                                                ; preds = %7, %1
  store i32 0, ptr @vec2_SHARED, align 4
  %10 = load i32, ptr @res_SHARED, align 4
  store i32 %10, ptr %4, align 4
  %11 = load i32, ptr %3, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %90

13:                                               ; preds = %9
  %14 = load i32, ptr %3, align 4
  %15 = icmp eq i32 %14, 2
  br i1 %15, label %85, label %16

16:                                               ; preds = %13
  %17 = load i32, ptr %3, align 4
  %18 = icmp eq i32 %17, 3
  br i1 %18, label %85, label %19

19:                                               ; preds = %16
  %20 = load i32, ptr %3, align 4
  %21 = icmp eq i32 %20, 5
  br i1 %21, label %85, label %22

22:                                               ; preds = %19
  %23 = load i32, ptr %3, align 4
  %24 = icmp eq i32 %23, 7
  br i1 %24, label %85, label %25

25:                                               ; preds = %22
  %26 = load i32, ptr %3, align 4
  %27 = icmp eq i32 %26, 11
  br i1 %27, label %85, label %28

28:                                               ; preds = %25
  %29 = load i32, ptr %3, align 4
  %30 = icmp eq i32 %29, 13
  br i1 %30, label %85, label %31

31:                                               ; preds = %28
  %32 = load i32, ptr %3, align 4
  %33 = icmp eq i32 %32, 17
  br i1 %33, label %85, label %34

34:                                               ; preds = %31
  %35 = load i32, ptr %3, align 4
  %36 = icmp eq i32 %35, 19
  br i1 %36, label %85, label %37

37:                                               ; preds = %34
  %38 = load i32, ptr %3, align 4
  %39 = icmp eq i32 %38, 23
  br i1 %39, label %85, label %40

40:                                               ; preds = %37
  %41 = load i32, ptr %3, align 4
  %42 = icmp eq i32 %41, 29
  br i1 %42, label %85, label %43

43:                                               ; preds = %40
  %44 = load i32, ptr %3, align 4
  %45 = icmp eq i32 %44, 31
  br i1 %45, label %85, label %46

46:                                               ; preds = %43
  %47 = load i32, ptr %3, align 4
  %48 = icmp eq i32 %47, 37
  br i1 %48, label %85, label %49

49:                                               ; preds = %46
  %50 = load i32, ptr %3, align 4
  %51 = icmp eq i32 %50, 41
  br i1 %51, label %85, label %52

52:                                               ; preds = %49
  %53 = load i32, ptr %3, align 4
  %54 = icmp eq i32 %53, 43
  br i1 %54, label %85, label %55

55:                                               ; preds = %52
  %56 = load i32, ptr %3, align 4
  %57 = icmp eq i32 %56, 47
  br i1 %57, label %85, label %58

58:                                               ; preds = %55
  %59 = load i32, ptr %3, align 4
  %60 = icmp eq i32 %59, 53
  br i1 %60, label %85, label %61

61:                                               ; preds = %58
  %62 = load i32, ptr %3, align 4
  %63 = icmp eq i32 %62, 59
  br i1 %63, label %85, label %64

64:                                               ; preds = %61
  %65 = load i32, ptr %3, align 4
  %66 = icmp eq i32 %65, 61
  br i1 %66, label %85, label %67

67:                                               ; preds = %64
  %68 = load i32, ptr %3, align 4
  %69 = icmp eq i32 %68, 67
  br i1 %69, label %85, label %70

70:                                               ; preds = %67
  %71 = load i32, ptr %3, align 4
  %72 = icmp eq i32 %71, 71
  br i1 %72, label %85, label %73

73:                                               ; preds = %70
  %74 = load i32, ptr %3, align 4
  %75 = icmp eq i32 %74, 73
  br i1 %75, label %85, label %76

76:                                               ; preds = %73
  %77 = load i32, ptr %3, align 4
  %78 = icmp eq i32 %77, 79
  br i1 %78, label %85, label %79

79:                                               ; preds = %76
  %80 = load i32, ptr %3, align 4
  %81 = icmp eq i32 %80, 83
  br i1 %81, label %85, label %82

82:                                               ; preds = %79
  %83 = load i32, ptr %3, align 4
  %84 = icmp eq i32 %83, 89
  br i1 %84, label %85, label %86

85:                                               ; preds = %82, %79, %76, %73, %70, %67, %64, %61, %58, %55, %52, %49, %46, %43, %40, %37, %34, %31, %28, %25, %22, %19, %16, %13
  call void @nop1()
  br label %86

86:                                               ; preds = %85, %82
  %87 = load i32, ptr @res_SHARED, align 4
  %88 = add nsw i32 %87, 1
  store i32 %88, ptr %4, align 4
  %89 = load i32, ptr %4, align 4
  store i32 %89, ptr @res_SHARED, align 4
  call void @nop1()
  br label %90

90:                                               ; preds = %86, %9
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  store i32 0, ptr @res_SHARED, align 4
  store i32 11, ptr @vec1_SHARED, align 4
  store i32 23, ptr @vec2_SHARED, align 4
  %4 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @thread1, ptr noundef null)
  %5 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @thread2, ptr noundef null)
  %6 = load ptr, ptr %2, align 8
  %7 = call i32 @"\01_pthread_join"(ptr noundef %6, ptr noundef null)
  %8 = load ptr, ptr %3, align 8
  %9 = call i32 @"\01_pthread_join"(ptr noundef %8, ptr noundef null)
  %10 = load i32, ptr @res_SHARED, align 4
  %11 = icmp ne i32 %10, 2
  br i1 %11, label %12, label %13

12:                                               ; preds = %0
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str, i32 noundef 123, ptr noundef @.str.1) #3
  unreachable

13:                                               ; preds = %0
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
