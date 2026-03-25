; ModuleID = 'main2.c'
source_filename = "main2.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }

@str_is_shared_SHARED = common global i8 0, align 1
@str_lock = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@ref_count_SHARED = common global i8 0, align 1
@mutex0 = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@destroyed_SHARED = common global i8 0, align 1
@__func__.t3_main = private unnamed_addr constant [8 x i8] c"t3_main\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"main2.c\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@str_data_SHARED = common global i8 0, align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @t1_main(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load i8, ptr @str_is_shared_SHARED, align 1
  %4 = trunc i8 %3 to i1
  br i1 %4, label %5, label %10

5:                                                ; preds = %1
  %6 = call i32 @pthread_mutex_lock(ptr noundef @str_lock)
  %7 = load i8, ptr @ref_count_SHARED, align 1
  %8 = add i8 %7, 1
  store i8 %8, ptr @ref_count_SHARED, align 1
  %9 = call i32 @pthread_mutex_unlock(ptr noundef @str_lock)
  br label %10

10:                                               ; preds = %5, %1
  %11 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  %12 = call i32 @pthread_mutex_lock(ptr noundef @str_lock)
  %13 = load i8, ptr @ref_count_SHARED, align 1
  %14 = sext i8 %13 to i32
  %15 = icmp slt i32 %14, 0
  br i1 %15, label %16, label %19

16:                                               ; preds = %10
  %17 = call i32 @pthread_mutex_unlock(ptr noundef @str_lock)
  store i8 1, ptr @destroyed_SHARED, align 1
  %18 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  br label %21

19:                                               ; preds = %10
  %20 = call i32 @pthread_mutex_unlock(ptr noundef @str_lock)
  br label %21

21:                                               ; preds = %19, %16
  ret ptr null
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @t2_main(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load i8, ptr @str_is_shared_SHARED, align 1
  %4 = trunc i8 %3 to i1
  br i1 %4, label %5, label %10

5:                                                ; preds = %1
  %6 = call i32 @pthread_mutex_lock(ptr noundef @str_lock)
  %7 = load i8, ptr @ref_count_SHARED, align 1
  %8 = add i8 %7, 1
  store i8 %8, ptr @ref_count_SHARED, align 1
  %9 = call i32 @pthread_mutex_unlock(ptr noundef @str_lock)
  br label %10

10:                                               ; preds = %5, %1
  %11 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  %12 = call i32 @pthread_mutex_lock(ptr noundef @str_lock)
  %13 = load i8, ptr @ref_count_SHARED, align 1
  %14 = sext i8 %13 to i32
  %15 = icmp slt i32 %14, 0
  br i1 %15, label %16, label %19

16:                                               ; preds = %10
  %17 = call i32 @pthread_mutex_unlock(ptr noundef @str_lock)
  store i8 1, ptr @destroyed_SHARED, align 1
  %18 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  br label %21

19:                                               ; preds = %10
  %20 = call i32 @pthread_mutex_unlock(ptr noundef @str_lock)
  br label %21

21:                                               ; preds = %19, %16
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @t3_main(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load i8, ptr @str_is_shared_SHARED, align 1
  %4 = trunc i8 %3 to i1
  br i1 %4, label %8, label %5

5:                                                ; preds = %1
  %6 = call i32 @pthread_mutex_lock(ptr noundef @str_lock)
  store i8 -1, ptr @ref_count_SHARED, align 1
  %7 = call i32 @pthread_mutex_unlock(ptr noundef @str_lock)
  br label %8

8:                                                ; preds = %5, %1
  %9 = call i32 @pthread_mutex_lock(ptr noundef @mutex0)
  %10 = load i8, ptr @destroyed_SHARED, align 1
  %11 = trunc i8 %10 to i1
  br i1 %11, label %12, label %13

12:                                               ; preds = %8
  call void @__assert_rtn(ptr noundef @__func__.t3_main, ptr noundef @.str, i32 noundef 106, ptr noundef @.str.1) #3
  unreachable

13:                                               ; preds = %8
  %14 = call i32 @pthread_mutex_unlock(ptr noundef @mutex0)
  store i8 97, ptr @str_data_SHARED, align 1
  ret ptr null
}

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  store i8 0, ptr @str_is_shared_SHARED, align 1
  store i8 120, ptr @str_data_SHARED, align 1
  store i8 0, ptr @ref_count_SHARED, align 1
  store i8 0, ptr @destroyed_SHARED, align 1
  %5 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @t1_main, ptr noundef null)
  %6 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @t2_main, ptr noundef null)
  %7 = call i32 @pthread_create(ptr noundef %4, ptr noundef null, ptr noundef @t3_main, ptr noundef null)
  %8 = load ptr, ptr %2, align 8
  %9 = call i32 @"\01_pthread_join"(ptr noundef %8, ptr noundef null)
  %10 = load ptr, ptr %3, align 8
  %11 = call i32 @"\01_pthread_join"(ptr noundef %10, ptr noundef null)
  %12 = load ptr, ptr %4, align 8
  %13 = call i32 @"\01_pthread_join"(ptr noundef %12, ptr noundef null)
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
