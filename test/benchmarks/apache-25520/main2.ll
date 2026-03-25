; ModuleID = 'main2.c'
source_filename = "main2.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }
%struct.timespec = type { i64, i64 }

@.str = private unnamed_addr constant [16 x i8] c"Copying string\0A\00", align 1
@.str.1 = private unnamed_addr constant [24 x i8] c"Updating outcnt_SHARED\0A\00", align 1
@mutex0 = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@outcnt_SHARED = common global i32 0, align 4
@b1_SHARED = common global i8 0, align 1
@b2_SHARED = common global i8 0, align 1
@.str.2 = private unnamed_addr constant [45 x i8] c"The quick brown fox jumps over the lazy dog.\00", align 1
@.str.3 = private unnamed_addr constant [40 x i8] c"Vamp fox held quartz duck just by wing.\00", align 1
@.str.4 = private unnamed_addr constant [23 x i8] c"Spawning first thread\0A\00", align 1
@.str.5 = private unnamed_addr constant [24 x i8] c"Spawning second thread\0A\00", align 1
@__func__.main = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str.6 = private unnamed_addr constant [8 x i8] c"main2.c\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"0\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @writeSentence_t1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca %struct.timespec, align 8
  store ptr %0, ptr %2, align 8
  %4 = getelementptr inbounds %struct.timespec, ptr %3, i32 0, i32 0
  store i64 0, ptr %4, align 8
  %5 = getelementptr inbounds %struct.timespec, ptr %3, i32 0, i32 1
  store i64 1000, ptr %5, align 8
  %6 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  %7 = call i32 @"\01_nanosleep"(ptr noundef %3, ptr noundef %3)
  %8 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  %9 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  %10 = load i32, ptr @outcnt_SHARED, align 4
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %12, label %13

12:                                               ; preds = %1
  store i8 97, ptr @b1_SHARED, align 1
  br label %14

13:                                               ; preds = %1
  store i8 97, ptr @b2_SHARED, align 1
  br label %14

14:                                               ; preds = %13, %12
  %15 = load i32, ptr @outcnt_SHARED, align 4
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr @outcnt_SHARED, align 4
  %17 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  ret ptr null
}

declare i32 @printf(ptr noundef, ...) #1

declare i32 @"\01_nanosleep"(ptr noundef, ptr noundef) #1

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @writeSentence_t2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca %struct.timespec, align 8
  store ptr %0, ptr %2, align 8
  %4 = getelementptr inbounds %struct.timespec, ptr %3, i32 0, i32 0
  store i64 0, ptr %4, align 8
  %5 = getelementptr inbounds %struct.timespec, ptr %3, i32 0, i32 1
  store i64 1000, ptr %5, align 8
  %6 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  %7 = call i32 @"\01_nanosleep"(ptr noundef %3, ptr noundef %3)
  %8 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  %9 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  %10 = load i32, ptr @outcnt_SHARED, align 4
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %12, label %13

12:                                               ; preds = %1
  store i8 98, ptr @b1_SHARED, align 1
  br label %14

13:                                               ; preds = %1
  store i8 98, ptr @b2_SHARED, align 1
  br label %14

14:                                               ; preds = %13, %12
  %15 = load i32, ptr @outcnt_SHARED, align 4
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr @outcnt_SHARED, align 4
  %17 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
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
  store ptr @.str.2, ptr %4, align 8
  store ptr @.str.3, ptr %5, align 8
  %6 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  store i8 120, ptr @b1_SHARED, align 1
  store i8 120, ptr @b2_SHARED, align 1
  store i32 0, ptr @outcnt_SHARED, align 4
  %8 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @writeSentence_t1, ptr noundef null)
  %9 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @writeSentence_t2, ptr noundef null)
  %10 = load ptr, ptr %2, align 8
  %11 = call i32 @"\01_pthread_join"(ptr noundef %10, ptr noundef null)
  %12 = load ptr, ptr %3, align 8
  %13 = call i32 @"\01_pthread_join"(ptr noundef %12, ptr noundef null)
  %14 = load i8, ptr @b2_SHARED, align 1
  %15 = sext i8 %14 to i32
  %16 = icmp eq i32 %15, 120
  br i1 %16, label %17, label %18

17:                                               ; preds = %0
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str.6, i32 noundef 171, ptr noundef @.str.7) #3
  unreachable

18:                                               ; preds = %0
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
