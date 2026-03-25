; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@mutex0 = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@used_SHARED = common global i8 0, align 1
@buffer_SHARED = common global [2 x i8] zeroinitializer, align 1
@__func__.main = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main1.c\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @insLog_t1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  %4 = load i8, ptr @used_SHARED, align 1
  %5 = add i8 %4, 1
  store i8 %5, ptr @used_SHARED, align 1
  %6 = load i8, ptr @used_SHARED, align 1
  %7 = zext i8 %6 to i64
  %8 = getelementptr inbounds [2 x i8], ptr @buffer_SHARED, i64 0, i64 %7
  store i8 97, ptr %8, align 1
  %9 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  ret ptr null
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @insLog_t2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  %4 = load i8, ptr @used_SHARED, align 1
  %5 = add i8 %4, 1
  store i8 %5, ptr @used_SHARED, align 1
  %6 = load i8, ptr @used_SHARED, align 1
  %7 = zext i8 %6 to i64
  %8 = getelementptr inbounds [2 x i8], ptr @buffer_SHARED, i64 0, i64 %7
  store i8 97, ptr %8, align 1
  %9 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  store i8 -1, ptr @used_SHARED, align 1
  store i8 120, ptr @buffer_SHARED, align 1
  store i8 120, ptr getelementptr inbounds ([2 x i8], ptr @buffer_SHARED, i64 0, i64 1), align 1
  %4 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @insLog_t1, ptr noundef null)
  %5 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @insLog_t2, ptr noundef null)
  %6 = load ptr, ptr %2, align 8
  %7 = call i32 @"\01_pthread_join"(ptr noundef %6, ptr noundef null)
  %8 = load ptr, ptr %3, align 8
  %9 = call i32 @"\01_pthread_join"(ptr noundef %8, ptr noundef null)
  %10 = load i8, ptr getelementptr inbounds ([2 x i8], ptr @buffer_SHARED, i64 0, i64 1), align 1
  %11 = sext i8 %10 to i32
  %12 = icmp eq i32 %11, 120
  br i1 %12, label %13, label %14

13:                                               ; preds = %0
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str, i32 noundef 146, ptr noundef @.str.1) #3
  unreachable

14:                                               ; preds = %0
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
