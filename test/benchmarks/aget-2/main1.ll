; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }
%struct._opaque_pthread_cond_t = type { i64, [40 x i8] }

@.str = private unnamed_addr constant [35 x i8] c"^C caught, saving download job...\0A\00", align 1
@nthreads_SHARED = common global i32 0, align 4
@wthread1_status_SHARED = common global i8 0, align 1
@wthread2_status_SHARED = common global i8 0, align 1
@wthread3_status_SHARED = common global i8 0, align 1
@wthread4_status_SHARED = common global i8 0, align 1
@req_lfile_SHARED = common global [512 x i8] zeroinitializer, align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"aget-%s.log\00", align 1
@req_file_SHARED = common global [512 x i8] zeroinitializer, align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@__stderrp = external global ptr, align 8
@.str.3 = private unnamed_addr constant [41 x i8] c"cannot open log file %s for writing: %s\0A\00", align 1
@errno_SHARED = common global i32 0, align 4
@bwritten_SHARED = common global i32 0, align 4
@patchVar_SHARED = common global i32 0, align 4
@.str.4 = private unnamed_addr constant [59 x i8] c"--> Logfile is: %s, so far %d bytes have been transferred\0A\00", align 1
@.str.5 = private unnamed_addr constant [19 x i8] c"Signal Alarm came\0A\00", align 1
@req_clength_SHARED = common global i32 0, align 4
@signal_waiter.prev = internal global float -1.000000e+00, align 4
@.str.6 = private unnamed_addr constant [18 x i8] c"[%d%% completed]\0A\00", align 1
@wthread1_getstr_SHARED = common global ptr null, align 8
@wthread1_soffset_SHARED = common global i64 0, align 8
@wthread1_offset_SHARED = common global i64 0, align 8
@wthread1_clength_SHARED = common global i64 0, align 8
@wthread1_fd_SHARED = common global i32 0, align 4
@.str.7 = private unnamed_addr constant [5 x i8] c"test\00", align 1
@.str.8 = private unnamed_addr constant [41 x i8] c"<THREAD #%ld> socket creation failed: %s\00", align 1
@wthread1_tid = common global ptr null, align 8
@.str.9 = private unnamed_addr constant [30 x i8] c"<THREAD #%ld> send failed: %s\00", align 1
@.str.10 = private unnamed_addr constant [30 x i8] c"<THREAD #%ld> recv failed: %s\00", align 1
@.str.11 = private unnamed_addr constant [13 x i8] c"HTTP/1.1 416\00", align 1
@.str.12 = private unnamed_addr constant [64 x i8] c"Server returned HTTP/1.1 416 - Requested Range Not Satisfiable\0A\00", align 1
@.str.13 = private unnamed_addr constant [13 x i8] c"HTTP/1.1 403\00", align 1
@.str.14 = private unnamed_addr constant [51 x i8] c"<Server returned HTTP/1.1 403 - Permission Denied\0A\00", align 1
@.str.15 = private unnamed_addr constant [13 x i8] c"HTTP/1.1 404\00", align 1
@.str.16 = private unnamed_addr constant [48 x i8] c"<Server returned HTTP/1.1 404 - File Not Found\0A\00", align 1
@.str.17 = private unnamed_addr constant [13 x i8] c"HTTP/1.1 206\00", align 1
@.str.18 = private unnamed_addr constant [48 x i8] c"Something unhandled happened, shutting down...\0A\00", align 1
@bwritten_mutex = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@http_get1.prev = internal global float -1.000000e+00, align 4
@wthread2_getstr_SHARED = common global ptr null, align 8
@wthread2_soffset_SHARED = common global i64 0, align 8
@wthread2_offset_SHARED = common global i64 0, align 8
@wthread2_clength_SHARED = common global i64 0, align 8
@wthread2_fd_SHARED = common global i32 0, align 4
@wthread2_tid = common global ptr null, align 8
@http_get2.prev = internal global float -1.000000e+00, align 4
@wthread3_getstr_SHARED = common global ptr null, align 8
@wthread3_soffset_SHARED = common global i64 0, align 8
@wthread3_offset_SHARED = common global i64 0, align 8
@wthread3_clength_SHARED = common global i64 0, align 8
@wthread3_fd_SHARED = common global i32 0, align 4
@wthread3_tid = common global ptr null, align 8
@http_get3.prev = internal global float -1.000000e+00, align 4
@wthread4_getstr_SHARED = common global ptr null, align 8
@wthread4_soffset_SHARED = common global i64 0, align 8
@wthread4_offset_SHARED = common global i64 0, align 8
@wthread4_clength_SHARED = common global i64 0, align 8
@wthread4_fd_SHARED = common global i32 0, align 4
@wthread4_tid = common global ptr null, align 8
@http_get4.prev = internal global float -1.000000e+00, align 4
@hthread = common global ptr null, align 8
@.str.19 = private unnamed_addr constant [10 x i8] c"p:l:n:hfv\00", align 1
@optarg = external global ptr, align 8
@req_port_SHARED = common global i32 0, align 4
@fsuggested_SHARED = common global i32 0, align 4
@.str.20 = private unnamed_addr constant [43 x i8] c"Error: Maximum # of threads allowed is %d\0A\00", align 1
@.str.21 = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.str.22 = private unnamed_addr constant [20 x i8] c"EnderUNIX Aget v0.4\00", align 1
@.str.23 = private unnamed_addr constant [43 x i8] c"%s\0Aby Murat BALABAN <murat@enderunix.org>\0A\00", align 1
@.str.24 = private unnamed_addr constant [57 x i8] c"\0AERROR: -f and -n should be used together!, exiting...\0A\0A\00", align 1
@fullurl_SHARED = common global ptr null, align 8
@optind = external global i32, align 4
@hist_data_nthreads_SHARED = common global i32 0, align 4
@.str.25 = private unnamed_addr constant [4 x i8] c"000\00", align 1
@req_url_SHARED = common global [1024 x i8] zeroinitializer, align 1
@req_host_SHARED = common global [1024 x i8] zeroinitializer, align 1
@req_ip_SHARED = common global [16 x i8] zeroinitializer, align 1
@.str.26 = private unnamed_addr constant [42 x i8] c"get: cannot open file %s for writing: %s\0A\00", align 1
@t_start_SHARED = common global i64 0, align 8
@.str.27 = private unnamed_addr constant [84 x i8] c"GET %s HTTP/1.1\0D\0AHost: %s\0D\0AUser-Agent: %s\0D\0ARange: bytes=%ld-\0D\0AConnection: close\0D\0A\0D\0A\00", align 1
@t_finish_SHARED = common global i64 0, align 8
@.str.28 = private unnamed_addr constant [61 x i8] c"Download completed, job completed in %d seconds. (%d Kb/sec)\00", align 1
@hist_data_bwritten_SHARED = common global i32 0, align 4
@.str.29 = private unnamed_addr constant [17 x i8] c"Shutting down...\00", align 1
@.str.30 = private unnamed_addr constant [69 x i8] c"Downloading %s (%d bytes) from site %s(%s:%d). Number of Threads: %d\00", align 1
@.str.31 = private unnamed_addr constant [26 x i8] c"get: couldn't lseek:  %s\0A\00", align 1
@.str.32 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.33 = private unnamed_addr constant [52 x i8] c"get: couldn't allocate space for download file: %s\0A\00", align 1
@wthread3_foffset_SHARED = common global i64 0, align 8
@wthread4_foffset_SHARED = common global i64 0, align 8
@patchLock = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@patchCond = common global %struct._opaque_pthread_cond_t zeroinitializer, align 8
@hist_data_host_SHARED = common global [1024 x i8] zeroinitializer, align 1
@hist_data_url_SHARED = common global [1024 x i8] zeroinitializer, align 1
@hist_data_file_SHARED = common global [512 x i8] zeroinitializer, align 1
@hist_data_lfile_SHARED = common global [512 x i8] zeroinitializer, align 1
@hist_data_ip_SHARED = common global [16 x i8] zeroinitializer, align 1
@hist_data_username_SHARED = common global [512 x i8] zeroinitializer, align 1
@hist_data_password_SHARED = common global [512 x i8] zeroinitializer, align 1
@hist_data_port_SHARED = common global i32 0, align 4
@hist_data_clength_SHARED = common global i32 0, align 4
@hist_data_proto_SHARED = common global i8 0, align 1
@hist_data_wthread1_getstr_SHARED = common global [256 x i8] zeroinitializer, align 1
@hist_data_wthread1_soffset_SHARED = common global i64 0, align 8
@hist_data_wthread1_foffset_SHARED = common global i64 0, align 8
@hist_data_wthread1_offset_SHARED = common global i64 0, align 8
@hist_data_wthread1_clength_SHARED = common global i64 0, align 8
@hist_data_wthread1_fd_SHARED = common global i32 0, align 4
@hist_data_wthread1_tid = common global ptr null, align 8
@hist_data_wthread1_status_SHARED = common global i8 0, align 1
@hist_data_wthread2_getstr_SHARED = common global [256 x i8] zeroinitializer, align 1
@hist_data_wthread2_soffset_SHARED = common global i64 0, align 8
@hist_data_wthread2_foffset_SHARED = common global i64 0, align 8
@hist_data_wthread2_offset_SHARED = common global i64 0, align 8
@hist_data_wthread2_clength_SHARED = common global i64 0, align 8
@hist_data_wthread2_fd_SHARED = common global i32 0, align 4
@hist_data_wthread2_tid = common global ptr null, align 8
@hist_data_wthread2_status_SHARED = common global i8 0, align 1
@signal_set = common global i32 0, align 4
@wthread1_foffset_SHARED = common global i64 0, align 8
@wthread2_foffset_SHARED = common global i64 0, align 8
@req_username_SHARED = common global [512 x i8] zeroinitializer, align 1
@req_password_SHARED = common global [512 x i8] zeroinitializer, align 1
@req_proto_SHARED = common global i8 0, align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @signal_waiter(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca float, align 4
  %10 = alloca float, align 4
  %11 = alloca float, align 4
  %12 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store ptr null, ptr %2, align 8
  %13 = load i32, ptr %3, align 4
  switch i32 %13, label %140 [
    i32 2, label %14
    i32 14, label %92
  ]

14:                                               ; preds = %1
  %15 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  store i32 0, ptr %4, align 4
  %16 = load i32, ptr %4, align 4
  %17 = load i32, ptr @nthreads_SHARED, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %24

19:                                               ; preds = %14
  %20 = load i8, ptr @wthread1_status_SHARED, align 1
  %21 = zext i8 %20 to i32
  %22 = and i32 %21, 15
  %23 = trunc i32 %22 to i8
  store i8 %23, ptr @wthread1_status_SHARED, align 1
  br label %24

24:                                               ; preds = %19, %14
  %25 = load i32, ptr %4, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %4, align 4
  %27 = load i32, ptr %4, align 4
  %28 = load i32, ptr @nthreads_SHARED, align 4
  %29 = icmp slt i32 %27, %28
  br i1 %29, label %30, label %35

30:                                               ; preds = %24
  %31 = load i8, ptr @wthread2_status_SHARED, align 1
  %32 = zext i8 %31 to i32
  %33 = and i32 %32, 15
  %34 = trunc i32 %33 to i8
  store i8 %34, ptr @wthread2_status_SHARED, align 1
  br label %35

35:                                               ; preds = %30, %24
  %36 = load i32, ptr %4, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %4, align 4
  %38 = load i32, ptr %4, align 4
  %39 = load i32, ptr @nthreads_SHARED, align 4
  %40 = icmp slt i32 %38, %39
  br i1 %40, label %41, label %46

41:                                               ; preds = %35
  %42 = load i8, ptr @wthread3_status_SHARED, align 1
  %43 = zext i8 %42 to i32
  %44 = and i32 %43, 15
  %45 = trunc i32 %44 to i8
  store i8 %45, ptr @wthread3_status_SHARED, align 1
  br label %46

46:                                               ; preds = %41, %35
  %47 = load i32, ptr %4, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %4, align 4
  %49 = load i32, ptr %4, align 4
  %50 = load i32, ptr @nthreads_SHARED, align 4
  %51 = icmp slt i32 %49, %50
  br i1 %51, label %52, label %57

52:                                               ; preds = %46
  %53 = load i8, ptr @wthread4_status_SHARED, align 1
  %54 = zext i8 %53 to i32
  %55 = and i32 %54, 15
  %56 = trunc i32 %55 to i8
  store i8 %56, ptr @wthread4_status_SHARED, align 1
  br label %57

57:                                               ; preds = %52, %46
  %58 = load i32, ptr %4, align 4
  %59 = add nsw i32 %58, 1
  store i32 %59, ptr %4, align 4
  %60 = call i64 @strlen(ptr noundef @req_lfile_SHARED) #5
  %61 = icmp eq i64 %60, 0
  br i1 %61, label %62, label %67

62:                                               ; preds = %57
  %63 = load ptr, ptr %5, align 8
  %64 = load ptr, ptr %5, align 8
  %65 = call i64 @llvm.objectsize.i64.p0(ptr %64, i1 false, i1 true, i1 false)
  %66 = call i32 (ptr, i64, i32, i64, ptr, ...) @__snprintf_chk(ptr noundef %63, i64 noundef 255, i32 noundef 0, i64 noundef %65, ptr noundef @.str.1, ptr noundef @req_file_SHARED)
  br label %72

67:                                               ; preds = %57
  %68 = load ptr, ptr %5, align 8
  %69 = load ptr, ptr %5, align 8
  %70 = call i64 @llvm.objectsize.i64.p0(ptr %69, i1 false, i1 true, i1 false)
  %71 = call i32 (ptr, i64, i32, i64, ptr, ...) @__snprintf_chk(ptr noundef %68, i64 noundef 255, i32 noundef 0, i64 noundef %70, ptr noundef @.str.1, ptr noundef @req_lfile_SHARED)
  br label %72

72:                                               ; preds = %67, %62
  %73 = load ptr, ptr %5, align 8
  %74 = call ptr @"\01_fopen"(ptr noundef %73, ptr noundef @.str.2)
  store ptr %74, ptr %6, align 8
  %75 = icmp eq ptr %74, null
  br i1 %75, label %76, label %82

76:                                               ; preds = %72
  %77 = load ptr, ptr @__stderrp, align 8
  %78 = load ptr, ptr %5, align 8
  %79 = load i32, ptr @errno_SHARED, align 4
  %80 = call ptr @"\01_strerror"(i32 noundef %79)
  %81 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %77, ptr noundef @.str.3, ptr noundef %78, ptr noundef %80) #5
  br label %91

82:                                               ; preds = %72
  %83 = load i32, ptr @nthreads_SHARED, align 4
  store i32 %83, ptr %7, align 4
  %84 = load i32, ptr @bwritten_SHARED, align 4
  store i32 %84, ptr %8, align 4
  call void @nop1()
  store i32 1, ptr @patchVar_SHARED, align 4
  call void @nop1()
  call void @nop1()
  %85 = load ptr, ptr %5, align 8
  %86 = load i32, ptr %8, align 4
  %87 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, ptr noundef %85, i32 noundef %86)
  %88 = load ptr, ptr %6, align 8
  %89 = call i32 @fclose(ptr noundef %88)
  %90 = load ptr, ptr %5, align 8
  call void @free(ptr noundef %90)
  br label %91

91:                                               ; preds = %82, %76
  br label %140

92:                                               ; preds = %1
  %93 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  %94 = load i32, ptr @bwritten_SHARED, align 4
  %95 = sitofp i32 %94 to float
  store float %95, ptr %9, align 4
  %96 = load i32, ptr @req_clength_SHARED, align 4
  %97 = sitofp i32 %96 to float
  store float %97, ptr %10, align 4
  %98 = load float, ptr %9, align 4
  %99 = load float, ptr %10, align 4
  %100 = fdiv float %98, %99
  store float %100, ptr %11, align 4
  %101 = load float, ptr %11, align 4
  %102 = fmul float %101, 1.000000e+02
  %103 = fptosi float %102 to i32
  store i32 %103, ptr %12, align 4
  %104 = load i32, ptr %12, align 4
  %105 = sitofp i32 %104 to float
  %106 = load float, ptr @signal_waiter.prev, align 4
  %107 = fadd float %106, 5.000000e+00
  %108 = fcmp olt float %105, %107
  br i1 %108, label %109, label %112

109:                                              ; preds = %92
  %110 = load i32, ptr %12, align 4
  %111 = icmp ne i32 %110, 100
  br i1 %111, label %139, label %112

112:                                              ; preds = %109, %92
  store i32 0, ptr %4, align 4
  br label %113

113:                                              ; preds = %119, %112
  %114 = load i32, ptr %4, align 4
  %115 = load i32, ptr %12, align 4
  %116 = icmp slt i32 %114, %115
  br i1 %116, label %117, label %122

117:                                              ; preds = %113
  %118 = call i32 @putchar(i32 noundef 46)
  br label %119

119:                                              ; preds = %117
  %120 = load i32, ptr %4, align 4
  %121 = add nsw i32 %120, 2
  store i32 %121, ptr %4, align 4
  br label %113, !llvm.loop !6

122:                                              ; preds = %113
  %123 = load i32, ptr %12, align 4
  %124 = sub nsw i32 %123, 1
  store i32 %124, ptr %4, align 4
  br label %125

125:                                              ; preds = %130, %122
  %126 = load i32, ptr %4, align 4
  %127 = icmp slt i32 %126, 100
  br i1 %127, label %128, label %133

128:                                              ; preds = %125
  %129 = call i32 @putchar(i32 noundef 32)
  br label %130

130:                                              ; preds = %128
  %131 = load i32, ptr %4, align 4
  %132 = add nsw i32 %131, 2
  store i32 %132, ptr %4, align 4
  br label %125, !llvm.loop !8

133:                                              ; preds = %125
  %134 = load i32, ptr %12, align 4
  %135 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %134)
  %136 = load i32, ptr %12, align 4
  %137 = sitofp i32 %136 to float
  store float %137, ptr @signal_waiter.prev, align 4
  %138 = call i32 @alarm(i32 noundef 1)
  br label %139

139:                                              ; preds = %133, %109
  br label %140

140:                                              ; preds = %1, %139, %91
  ret ptr null
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: nounwind
declare i64 @strlen(ptr noundef) #2

declare i32 @__snprintf_chk(ptr noundef, i64 noundef, i32 noundef, i64 noundef, ptr noundef, ...) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.objectsize.i64.p0(ptr, i1 immarg, i1 immarg, i1 immarg) #3

declare ptr @"\01_fopen"(ptr noundef, ptr noundef) #1

; Function Attrs: nounwind
declare i32 @fprintf(ptr noundef, ptr noundef, ...) #2

declare ptr @"\01_strerror"(i32 noundef) #1

declare i32 @fclose(ptr noundef) #1

declare void @free(ptr noundef) #1

declare i32 @putchar(i32 noundef) #1

declare i32 @alarm(i32 noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @http_get1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i32, align 4
  %9 = alloca i8, align 1
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i64, align 8
  %17 = alloca float, align 4
  %18 = alloca float, align 4
  %19 = alloca float, align 4
  %20 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %21 = load ptr, ptr @wthread1_getstr_SHARED, align 8
  store ptr %21, ptr %3, align 8
  %22 = load i64, ptr @wthread1_soffset_SHARED, align 8
  store i64 %22, ptr %4, align 8
  %23 = load i64, ptr @wthread1_offset_SHARED, align 8
  store i64 %23, ptr %6, align 8
  %24 = load i64, ptr @wthread1_clength_SHARED, align 8
  store i64 %24, ptr %7, align 8
  %25 = load i32, ptr @wthread1_fd_SHARED, align 4
  store i32 %25, ptr %8, align 4
  %26 = load i8, ptr @wthread1_status_SHARED, align 1
  store i8 %26, ptr %9, align 1
  %27 = load i64, ptr %5, align 8
  store i64 %27, ptr %16, align 8
  store ptr @.str.7, ptr %11, align 8
  %28 = call i32 @socket(i32 noundef 2, i32 noundef 1, i32 noundef 0)
  store i32 %28, ptr %10, align 4
  %29 = icmp eq i32 %28, -1
  br i1 %29, label %30, label %35

30:                                               ; preds = %1
  %31 = load ptr, ptr @wthread1_tid, align 8
  %32 = load i32, ptr @errno_SHARED, align 4
  %33 = call ptr @"\01_strerror"(i32 noundef %32)
  %34 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, ptr noundef %31, ptr noundef %33)
  call void @pthread_exit(ptr noundef inttoptr (i64 1 to ptr)) #6
  unreachable

35:                                               ; preds = %1
  %36 = load i32, ptr %10, align 4
  %37 = load ptr, ptr %3, align 8
  %38 = load ptr, ptr %3, align 8
  %39 = call i64 @strlen(ptr noundef %38) #5
  %40 = call i64 @"\01_send"(i32 noundef %36, ptr noundef %37, i64 noundef %39, i32 noundef 0)
  %41 = icmp eq i64 %40, -1
  br i1 %41, label %42, label %47

42:                                               ; preds = %35
  %43 = load ptr, ptr @wthread1_tid, align 8
  %44 = load i32, ptr @errno_SHARED, align 4
  %45 = call ptr @"\01_strerror"(i32 noundef %44)
  %46 = call i32 (ptr, ...) @printf(ptr noundef @.str.9, ptr noundef %43, ptr noundef %45)
  call void @pthread_exit(ptr noundef inttoptr (i64 1 to ptr)) #6
  unreachable

47:                                               ; preds = %35
  %48 = load i32, ptr %10, align 4
  %49 = load ptr, ptr %11, align 8
  %50 = call i64 @"\01_recv"(i32 noundef %48, ptr noundef %49, i64 noundef 512, i32 noundef 0)
  %51 = trunc i64 %50 to i32
  store i32 %51, ptr %13, align 4
  %52 = icmp eq i32 %51, -1
  br i1 %52, label %53, label %58

53:                                               ; preds = %47
  %54 = load ptr, ptr @wthread1_tid, align 8
  %55 = load i32, ptr @errno_SHARED, align 4
  %56 = call ptr @"\01_strerror"(i32 noundef %55)
  %57 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, ptr noundef %54, ptr noundef %56)
  call void @pthread_exit(ptr noundef inttoptr (i64 1 to ptr)) #6
  unreachable

58:                                               ; preds = %47
  %59 = load ptr, ptr %11, align 8
  %60 = call ptr @strstr(ptr noundef %59, ptr noundef @.str.11) #5
  %61 = icmp ne ptr %60, null
  br i1 %61, label %62, label %64

62:                                               ; preds = %58
  %63 = call i32 (ptr, ...) @printf(ptr noundef @.str.12)
  call void @exit(i32 noundef 1) #6
  unreachable

64:                                               ; preds = %58
  %65 = load ptr, ptr %11, align 8
  %66 = call ptr @strstr(ptr noundef %65, ptr noundef @.str.13) #5
  %67 = icmp ne ptr %66, null
  br i1 %67, label %68, label %70

68:                                               ; preds = %64
  %69 = call i32 (ptr, ...) @printf(ptr noundef @.str.14)
  call void @exit(i32 noundef 1) #6
  unreachable

70:                                               ; preds = %64
  %71 = load ptr, ptr %11, align 8
  %72 = call ptr @strstr(ptr noundef %71, ptr noundef @.str.15) #5
  %73 = icmp ne ptr %72, null
  br i1 %73, label %74, label %76

74:                                               ; preds = %70
  %75 = call i32 (ptr, ...) @printf(ptr noundef @.str.16)
  call void @exit(i32 noundef 1) #6
  unreachable

76:                                               ; preds = %70
  br label %77

77:                                               ; preds = %76
  br label %78

78:                                               ; preds = %77
  %79 = load ptr, ptr %11, align 8
  %80 = call ptr @strstr(ptr noundef %79, ptr noundef @.str.17) #5
  %81 = icmp eq ptr %80, null
  br i1 %81, label %82, label %84

82:                                               ; preds = %78
  %83 = call i32 (ptr, ...) @printf(ptr noundef @.str.18)
  call void @exit(i32 noundef 1) #6
  unreachable

84:                                               ; preds = %78
  %85 = load ptr, ptr %11, align 8
  store ptr %85, ptr %12, align 8
  store i32 0, ptr %15, align 4
  br label %86

86:                                               ; preds = %84, %114
  %87 = load ptr, ptr %12, align 8
  %88 = load i8, ptr %87, align 1
  %89 = sext i8 %88 to i32
  %90 = icmp eq i32 %89, 10
  br i1 %90, label %91, label %114

91:                                               ; preds = %86
  %92 = load ptr, ptr %12, align 8
  %93 = getelementptr inbounds i8, ptr %92, i64 -1
  %94 = load i8, ptr %93, align 1
  %95 = sext i8 %94 to i32
  %96 = icmp eq i32 %95, 13
  br i1 %96, label %97, label %114

97:                                               ; preds = %91
  %98 = load ptr, ptr %12, align 8
  %99 = getelementptr inbounds i8, ptr %98, i64 -2
  %100 = load i8, ptr %99, align 1
  %101 = sext i8 %100 to i32
  %102 = icmp eq i32 %101, 10
  br i1 %102, label %103, label %114

103:                                              ; preds = %97
  %104 = load ptr, ptr %12, align 8
  %105 = getelementptr inbounds i8, ptr %104, i64 -3
  %106 = load i8, ptr %105, align 1
  %107 = sext i8 %106 to i32
  %108 = icmp eq i32 %107, 13
  br i1 %108, label %109, label %114

109:                                              ; preds = %103
  %110 = load ptr, ptr %12, align 8
  %111 = getelementptr inbounds i8, ptr %110, i32 1
  store ptr %111, ptr %12, align 8
  %112 = load i32, ptr %15, align 4
  %113 = add nsw i32 %112, 1
  store i32 %113, ptr %15, align 4
  br label %119

114:                                              ; preds = %103, %97, %91, %86
  %115 = load ptr, ptr %12, align 8
  %116 = getelementptr inbounds i8, ptr %115, i32 1
  store ptr %116, ptr %12, align 8
  %117 = load i32, ptr %15, align 4
  %118 = add nsw i32 %117, 1
  store i32 %118, ptr %15, align 4
  br label %86

119:                                              ; preds = %109
  %120 = load i64, ptr %4, align 8
  store i64 %120, ptr %6, align 8
  %121 = load i32, ptr %13, align 4
  %122 = load i32, ptr %15, align 4
  %123 = sub nsw i32 %121, %122
  %124 = sext i32 %123 to i64
  %125 = load i64, ptr %16, align 8
  %126 = icmp sgt i64 %124, %125
  br i1 %126, label %127, label %137

127:                                              ; preds = %119
  %128 = load i32, ptr %8, align 4
  %129 = load ptr, ptr %12, align 8
  %130 = load i64, ptr %16, align 8
  %131 = load i32, ptr %15, align 4
  %132 = sext i32 %131 to i64
  %133 = sub nsw i64 %130, %132
  %134 = load i64, ptr %4, align 8
  %135 = call i64 @"\01_pwrite"(i32 noundef %128, ptr noundef %129, i64 noundef %133, i64 noundef %134)
  %136 = trunc i64 %135 to i32
  store i32 %136, ptr %14, align 4
  br label %147

137:                                              ; preds = %119
  %138 = load i32, ptr %8, align 4
  %139 = load ptr, ptr %12, align 8
  %140 = load i32, ptr %13, align 4
  %141 = load i32, ptr %15, align 4
  %142 = sub nsw i32 %140, %141
  %143 = sext i32 %142 to i64
  %144 = load i64, ptr %4, align 8
  %145 = call i64 @"\01_pwrite"(i32 noundef %138, ptr noundef %139, i64 noundef %143, i64 noundef %144)
  %146 = trunc i64 %145 to i32
  store i32 %146, ptr %14, align 4
  br label %147

147:                                              ; preds = %137, %127
  %148 = load i64, ptr %4, align 8
  %149 = load i32, ptr %14, align 4
  %150 = sext i32 %149 to i64
  %151 = add nsw i64 %148, %150
  store i64 %151, ptr %6, align 8
  call void @nop1()
  br label %152

152:                                              ; preds = %156, %147
  %153 = load i32, ptr @patchVar_SHARED, align 4
  %154 = icmp ne i32 %153, 0
  %155 = xor i1 %154, true
  br i1 %155, label %156, label %157

156:                                              ; preds = %152
  call void @nop1()
  br label %152, !llvm.loop !9

157:                                              ; preds = %152
  call void @nop1()
  %158 = call i32 @pthread_mutex_lock(ptr noundef @bwritten_mutex)
  %159 = load i32, ptr %14, align 4
  %160 = load i32, ptr @bwritten_SHARED, align 4
  %161 = add nsw i32 %160, %159
  store i32 %161, ptr @bwritten_SHARED, align 4
  %162 = call i32 @pthread_mutex_unlock(ptr noundef @bwritten_mutex)
  br label %163

163:                                              ; preds = %253, %157
  %164 = load i64, ptr %6, align 8
  %165 = load i64, ptr %16, align 8
  %166 = icmp slt i64 %164, %165
  br i1 %166, label %167, label %254

167:                                              ; preds = %163
  %168 = load ptr, ptr %11, align 8
  %169 = load ptr, ptr %11, align 8
  %170 = call i64 @llvm.objectsize.i64.p0(ptr %169, i1 false, i1 true, i1 false)
  %171 = call ptr @__memset_chk(ptr noundef %168, i32 noundef 512, i64 noundef 0, i64 noundef %170) #5
  %172 = load i32, ptr %10, align 4
  %173 = load ptr, ptr %11, align 8
  %174 = call i64 @"\01_recv"(i32 noundef %172, ptr noundef %173, i64 noundef 512, i32 noundef 0)
  %175 = trunc i64 %174 to i32
  store i32 %175, ptr %13, align 4
  %176 = load i64, ptr %6, align 8
  %177 = load i32, ptr %13, align 4
  %178 = sext i32 %177 to i64
  %179 = add nsw i64 %176, %178
  %180 = load i64, ptr %16, align 8
  %181 = icmp sgt i64 %179, %180
  br i1 %181, label %182, label %191

182:                                              ; preds = %167
  %183 = load i32, ptr %8, align 4
  %184 = load ptr, ptr %11, align 8
  %185 = load i64, ptr %16, align 8
  %186 = load i64, ptr %6, align 8
  %187 = sub nsw i64 %185, %186
  %188 = load i64, ptr %6, align 8
  %189 = call i64 @"\01_pwrite"(i32 noundef %183, ptr noundef %184, i64 noundef %187, i64 noundef %188)
  %190 = trunc i64 %189 to i32
  store i32 %190, ptr %14, align 4
  br label %199

191:                                              ; preds = %167
  %192 = load i32, ptr %8, align 4
  %193 = load ptr, ptr %11, align 8
  %194 = load i32, ptr %13, align 4
  %195 = sext i32 %194 to i64
  %196 = load i64, ptr %6, align 8
  %197 = call i64 @"\01_pwrite"(i32 noundef %192, ptr noundef %193, i64 noundef %195, i64 noundef %196)
  %198 = trunc i64 %197 to i32
  store i32 %198, ptr %14, align 4
  br label %199

199:                                              ; preds = %191, %182
  %200 = load i32, ptr %14, align 4
  %201 = sext i32 %200 to i64
  %202 = load i64, ptr %6, align 8
  %203 = add nsw i64 %202, %201
  store i64 %203, ptr %6, align 8
  %204 = call i32 @pthread_mutex_lock(ptr noundef @bwritten_mutex)
  %205 = load i32, ptr %14, align 4
  %206 = load i32, ptr @bwritten_SHARED, align 4
  %207 = add nsw i32 %206, %205
  store i32 %207, ptr @bwritten_SHARED, align 4
  %208 = call i32 @pthread_mutex_unlock(ptr noundef @bwritten_mutex)
  %209 = load i32, ptr @bwritten_SHARED, align 4
  %210 = sitofp i32 %209 to float
  store float %210, ptr %17, align 4
  %211 = load i64, ptr %7, align 8
  %212 = sitofp i64 %211 to float
  store float %212, ptr %18, align 4
  %213 = load float, ptr %17, align 4
  %214 = load float, ptr %18, align 4
  %215 = fdiv float %213, %214
  store float %215, ptr %19, align 4
  %216 = load float, ptr %19, align 4
  %217 = fmul float %216, 1.000000e+02
  %218 = fptosi float %217 to i32
  store i32 %218, ptr %20, align 4
  %219 = load i32, ptr %20, align 4
  %220 = sitofp i32 %219 to float
  %221 = load float, ptr @http_get1.prev, align 4
  %222 = fadd float %221, 5.000000e+00
  %223 = fcmp olt float %220, %222
  br i1 %223, label %224, label %227

224:                                              ; preds = %199
  %225 = load i32, ptr %20, align 4
  %226 = icmp ne i32 %225, 100
  br i1 %226, label %253, label %227

227:                                              ; preds = %224, %199
  store i32 0, ptr %15, align 4
  br label %228

228:                                              ; preds = %234, %227
  %229 = load i32, ptr %15, align 4
  %230 = load i32, ptr %20, align 4
  %231 = icmp slt i32 %229, %230
  br i1 %231, label %232, label %237

232:                                              ; preds = %228
  %233 = call i32 @putchar(i32 noundef 46)
  br label %234

234:                                              ; preds = %232
  %235 = load i32, ptr %15, align 4
  %236 = add nsw i32 %235, 2
  store i32 %236, ptr %15, align 4
  br label %228, !llvm.loop !10

237:                                              ; preds = %228
  %238 = load i32, ptr %20, align 4
  %239 = sub nsw i32 %238, 1
  store i32 %239, ptr %15, align 4
  br label %240

240:                                              ; preds = %245, %237
  %241 = load i32, ptr %15, align 4
  %242 = icmp slt i32 %241, 100
  br i1 %242, label %243, label %248

243:                                              ; preds = %240
  %244 = call i32 @putchar(i32 noundef 32)
  br label %245

245:                                              ; preds = %243
  %246 = load i32, ptr %15, align 4
  %247 = add nsw i32 %246, 2
  store i32 %247, ptr %15, align 4
  br label %240, !llvm.loop !11

248:                                              ; preds = %240
  %249 = load i32, ptr %20, align 4
  %250 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %249)
  %251 = load i32, ptr %20, align 4
  %252 = sitofp i32 %251 to float
  store float %252, ptr @http_get1.prev, align 4
  br label %253

253:                                              ; preds = %248, %224
  br label %163, !llvm.loop !12

254:                                              ; preds = %163
  %255 = load i64, ptr %6, align 8
  %256 = load i64, ptr %5, align 8
  %257 = icmp eq i64 %255, %256
  br i1 %257, label %258, label %259

258:                                              ; preds = %254
  store i8 -1, ptr %9, align 1
  br label %259

259:                                              ; preds = %258, %254
  %260 = load i32, ptr %10, align 4
  %261 = call i32 @"\01_close"(i32 noundef %260)
  ret ptr null
}

declare i32 @socket(i32 noundef, i32 noundef, i32 noundef) #1

; Function Attrs: noreturn
declare void @pthread_exit(ptr noundef) #4

declare i64 @"\01_send"(i32 noundef, ptr noundef, i64 noundef, i32 noundef) #1

declare i64 @"\01_recv"(i32 noundef, ptr noundef, i64 noundef, i32 noundef) #1

; Function Attrs: nounwind
declare ptr @strstr(ptr noundef, ptr noundef) #2

; Function Attrs: noreturn
declare void @exit(i32 noundef) #4

declare i64 @"\01_pwrite"(i32 noundef, ptr noundef, i64 noundef, i64 noundef) #1

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: nounwind
declare ptr @__memset_chk(ptr noundef, i32 noundef, i64 noundef, i64 noundef) #2

declare i32 @"\01_close"(i32 noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @http_get2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i32, align 4
  %9 = alloca i8, align 1
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i64, align 8
  %17 = alloca ptr, align 8
  %18 = alloca float, align 4
  %19 = alloca float, align 4
  %20 = alloca float, align 4
  %21 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %22 = load ptr, ptr @wthread2_getstr_SHARED, align 8
  store ptr %22, ptr %3, align 8
  %23 = load i64, ptr @wthread2_soffset_SHARED, align 8
  store i64 %23, ptr %4, align 8
  %24 = load i64, ptr @wthread2_offset_SHARED, align 8
  store i64 %24, ptr %6, align 8
  %25 = load i64, ptr @wthread2_clength_SHARED, align 8
  store i64 %25, ptr %7, align 8
  %26 = load i32, ptr @wthread2_fd_SHARED, align 4
  store i32 %26, ptr %8, align 4
  %27 = load i8, ptr @wthread2_status_SHARED, align 1
  store i8 %27, ptr %9, align 1
  %28 = load i64, ptr %5, align 8
  store i64 %28, ptr %16, align 8
  store ptr @.str.7, ptr %11, align 8
  %29 = call i32 @socket(i32 noundef 2, i32 noundef 1, i32 noundef 0)
  store i32 %29, ptr %10, align 4
  %30 = icmp eq i32 %29, -1
  br i1 %30, label %31, label %36

31:                                               ; preds = %1
  %32 = load ptr, ptr @wthread2_tid, align 8
  %33 = load i32, ptr @errno_SHARED, align 4
  %34 = call ptr @"\01_strerror"(i32 noundef %33)
  %35 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, ptr noundef %32, ptr noundef %34)
  call void @pthread_exit(ptr noundef inttoptr (i64 1 to ptr)) #6
  unreachable

36:                                               ; preds = %1
  %37 = load i32, ptr %10, align 4
  %38 = load ptr, ptr %3, align 8
  %39 = load ptr, ptr %3, align 8
  %40 = call i64 @strlen(ptr noundef %39) #5
  %41 = call i64 @"\01_send"(i32 noundef %37, ptr noundef %38, i64 noundef %40, i32 noundef 0)
  %42 = icmp eq i64 %41, -1
  br i1 %42, label %43, label %48

43:                                               ; preds = %36
  %44 = load ptr, ptr @wthread2_tid, align 8
  %45 = load i32, ptr @errno_SHARED, align 4
  %46 = call ptr @"\01_strerror"(i32 noundef %45)
  %47 = call i32 (ptr, ...) @printf(ptr noundef @.str.9, ptr noundef %44, ptr noundef %46)
  call void @pthread_exit(ptr noundef inttoptr (i64 1 to ptr)) #6
  unreachable

48:                                               ; preds = %36
  %49 = load i32, ptr %10, align 4
  %50 = load ptr, ptr %11, align 8
  %51 = call i64 @"\01_recv"(i32 noundef %49, ptr noundef %50, i64 noundef 512, i32 noundef 0)
  %52 = trunc i64 %51 to i32
  store i32 %52, ptr %13, align 4
  %53 = icmp eq i32 %52, -1
  br i1 %53, label %54, label %59

54:                                               ; preds = %48
  %55 = load ptr, ptr @wthread2_tid, align 8
  %56 = load i32, ptr @errno_SHARED, align 4
  %57 = call ptr @"\01_strerror"(i32 noundef %56)
  %58 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, ptr noundef %55, ptr noundef %57)
  call void @pthread_exit(ptr noundef inttoptr (i64 1 to ptr)) #6
  unreachable

59:                                               ; preds = %48
  %60 = load ptr, ptr %11, align 8
  %61 = call ptr @strstr(ptr noundef %60, ptr noundef @.str.11) #5
  %62 = icmp ne ptr %61, null
  br i1 %62, label %63, label %65

63:                                               ; preds = %59
  %64 = call i32 (ptr, ...) @printf(ptr noundef @.str.12)
  call void @exit(i32 noundef 1) #6
  unreachable

65:                                               ; preds = %59
  %66 = load ptr, ptr %11, align 8
  %67 = call ptr @strstr(ptr noundef %66, ptr noundef @.str.13) #5
  %68 = icmp ne ptr %67, null
  br i1 %68, label %69, label %71

69:                                               ; preds = %65
  %70 = call i32 (ptr, ...) @printf(ptr noundef @.str.14)
  call void @exit(i32 noundef 1) #6
  unreachable

71:                                               ; preds = %65
  %72 = load ptr, ptr %11, align 8
  %73 = call ptr @strstr(ptr noundef %72, ptr noundef @.str.15) #5
  %74 = icmp ne ptr %73, null
  br i1 %74, label %75, label %77

75:                                               ; preds = %71
  %76 = call i32 (ptr, ...) @printf(ptr noundef @.str.16)
  call void @exit(i32 noundef 1) #6
  unreachable

77:                                               ; preds = %71
  br label %78

78:                                               ; preds = %77
  br label %79

79:                                               ; preds = %78
  %80 = load ptr, ptr %11, align 8
  %81 = call ptr @strstr(ptr noundef %80, ptr noundef @.str.17) #5
  %82 = icmp eq ptr %81, null
  br i1 %82, label %83, label %85

83:                                               ; preds = %79
  %84 = call i32 (ptr, ...) @printf(ptr noundef @.str.18)
  call void @exit(i32 noundef 1) #6
  unreachable

85:                                               ; preds = %79
  %86 = load ptr, ptr %11, align 8
  store ptr %86, ptr %12, align 8
  store i32 0, ptr %15, align 4
  br label %87

87:                                               ; preds = %85, %115
  %88 = load ptr, ptr %12, align 8
  %89 = load i8, ptr %88, align 1
  %90 = sext i8 %89 to i32
  %91 = icmp eq i32 %90, 10
  br i1 %91, label %92, label %115

92:                                               ; preds = %87
  %93 = load ptr, ptr %12, align 8
  %94 = getelementptr inbounds i8, ptr %93, i64 -1
  %95 = load i8, ptr %94, align 1
  %96 = sext i8 %95 to i32
  %97 = icmp eq i32 %96, 13
  br i1 %97, label %98, label %115

98:                                               ; preds = %92
  %99 = load ptr, ptr %12, align 8
  %100 = getelementptr inbounds i8, ptr %99, i64 -2
  %101 = load i8, ptr %100, align 1
  %102 = sext i8 %101 to i32
  %103 = icmp eq i32 %102, 10
  br i1 %103, label %104, label %115

104:                                              ; preds = %98
  %105 = load ptr, ptr %12, align 8
  %106 = getelementptr inbounds i8, ptr %105, i64 -3
  %107 = load i8, ptr %106, align 1
  %108 = sext i8 %107 to i32
  %109 = icmp eq i32 %108, 13
  br i1 %109, label %110, label %115

110:                                              ; preds = %104
  %111 = load ptr, ptr %12, align 8
  %112 = getelementptr inbounds i8, ptr %111, i32 1
  store ptr %112, ptr %12, align 8
  %113 = load i32, ptr %15, align 4
  %114 = add nsw i32 %113, 1
  store i32 %114, ptr %15, align 4
  br label %120

115:                                              ; preds = %104, %98, %92, %87
  %116 = load ptr, ptr %12, align 8
  %117 = getelementptr inbounds i8, ptr %116, i32 1
  store ptr %117, ptr %12, align 8
  %118 = load i32, ptr %15, align 4
  %119 = add nsw i32 %118, 1
  store i32 %119, ptr %15, align 4
  br label %87

120:                                              ; preds = %110
  %121 = load i64, ptr %4, align 8
  store i64 %121, ptr %6, align 8
  %122 = load i32, ptr %13, align 4
  %123 = load i32, ptr %15, align 4
  %124 = sub nsw i32 %122, %123
  %125 = sext i32 %124 to i64
  %126 = load i64, ptr %16, align 8
  %127 = icmp sgt i64 %125, %126
  br i1 %127, label %128, label %138

128:                                              ; preds = %120
  %129 = load i32, ptr %8, align 4
  %130 = load ptr, ptr %12, align 8
  %131 = load i64, ptr %16, align 8
  %132 = load i32, ptr %15, align 4
  %133 = sext i32 %132 to i64
  %134 = sub nsw i64 %131, %133
  %135 = load i64, ptr %4, align 8
  %136 = call i64 @"\01_pwrite"(i32 noundef %129, ptr noundef %130, i64 noundef %134, i64 noundef %135)
  %137 = trunc i64 %136 to i32
  store i32 %137, ptr %14, align 4
  br label %148

138:                                              ; preds = %120
  %139 = load i32, ptr %8, align 4
  %140 = load ptr, ptr %12, align 8
  %141 = load i32, ptr %13, align 4
  %142 = load i32, ptr %15, align 4
  %143 = sub nsw i32 %141, %142
  %144 = sext i32 %143 to i64
  %145 = load i64, ptr %4, align 8
  %146 = call i64 @"\01_pwrite"(i32 noundef %139, ptr noundef %140, i64 noundef %144, i64 noundef %145)
  %147 = trunc i64 %146 to i32
  store i32 %147, ptr %14, align 4
  br label %148

148:                                              ; preds = %138, %128
  %149 = load i64, ptr %4, align 8
  %150 = load i32, ptr %14, align 4
  %151 = sext i32 %150 to i64
  %152 = add nsw i64 %149, %151
  store i64 %152, ptr %6, align 8
  call void @nop1()
  br label %153

153:                                              ; preds = %157, %148
  %154 = load i32, ptr @patchVar_SHARED, align 4
  %155 = icmp ne i32 %154, 0
  %156 = xor i1 %155, true
  br i1 %156, label %157, label %158

157:                                              ; preds = %153
  call void @nop1()
  br label %153, !llvm.loop !13

158:                                              ; preds = %153
  call void @nop1()
  %159 = call i32 @pthread_mutex_lock(ptr noundef @bwritten_mutex)
  %160 = load i32, ptr %14, align 4
  %161 = load i32, ptr @bwritten_SHARED, align 4
  %162 = add nsw i32 %161, %160
  store i32 %162, ptr @bwritten_SHARED, align 4
  %163 = call i32 @pthread_mutex_unlock(ptr noundef @bwritten_mutex)
  br label %164

164:                                              ; preds = %254, %158
  %165 = load i64, ptr %6, align 8
  %166 = load i64, ptr %16, align 8
  %167 = icmp slt i64 %165, %166
  br i1 %167, label %168, label %255

168:                                              ; preds = %164
  %169 = load ptr, ptr %11, align 8
  %170 = load ptr, ptr %11, align 8
  %171 = call i64 @llvm.objectsize.i64.p0(ptr %170, i1 false, i1 true, i1 false)
  %172 = call ptr @__memset_chk(ptr noundef %169, i32 noundef 512, i64 noundef 0, i64 noundef %171) #5
  %173 = load i32, ptr %10, align 4
  %174 = load ptr, ptr %11, align 8
  %175 = call i64 @"\01_recv"(i32 noundef %173, ptr noundef %174, i64 noundef 512, i32 noundef 0)
  %176 = trunc i64 %175 to i32
  store i32 %176, ptr %13, align 4
  %177 = load i64, ptr %6, align 8
  %178 = load i32, ptr %13, align 4
  %179 = sext i32 %178 to i64
  %180 = add nsw i64 %177, %179
  %181 = load i64, ptr %16, align 8
  %182 = icmp sgt i64 %180, %181
  br i1 %182, label %183, label %192

183:                                              ; preds = %168
  %184 = load i32, ptr %8, align 4
  %185 = load ptr, ptr %11, align 8
  %186 = load i64, ptr %16, align 8
  %187 = load i64, ptr %6, align 8
  %188 = sub nsw i64 %186, %187
  %189 = load i64, ptr %6, align 8
  %190 = call i64 @"\01_pwrite"(i32 noundef %184, ptr noundef %185, i64 noundef %188, i64 noundef %189)
  %191 = trunc i64 %190 to i32
  store i32 %191, ptr %14, align 4
  br label %200

192:                                              ; preds = %168
  %193 = load i32, ptr %8, align 4
  %194 = load ptr, ptr %11, align 8
  %195 = load i32, ptr %13, align 4
  %196 = sext i32 %195 to i64
  %197 = load i64, ptr %6, align 8
  %198 = call i64 @"\01_pwrite"(i32 noundef %193, ptr noundef %194, i64 noundef %196, i64 noundef %197)
  %199 = trunc i64 %198 to i32
  store i32 %199, ptr %14, align 4
  br label %200

200:                                              ; preds = %192, %183
  %201 = load i32, ptr %14, align 4
  %202 = sext i32 %201 to i64
  %203 = load i64, ptr %6, align 8
  %204 = add nsw i64 %203, %202
  store i64 %204, ptr %6, align 8
  %205 = call i32 @pthread_mutex_lock(ptr noundef @bwritten_mutex)
  %206 = load i32, ptr %14, align 4
  %207 = load i32, ptr @bwritten_SHARED, align 4
  %208 = add nsw i32 %207, %206
  store i32 %208, ptr @bwritten_SHARED, align 4
  %209 = call i32 @pthread_mutex_unlock(ptr noundef @bwritten_mutex)
  %210 = load i32, ptr @bwritten_SHARED, align 4
  %211 = sitofp i32 %210 to float
  store float %211, ptr %18, align 4
  %212 = load i64, ptr %7, align 8
  %213 = sitofp i64 %212 to float
  store float %213, ptr %19, align 4
  %214 = load float, ptr %18, align 4
  %215 = load float, ptr %19, align 4
  %216 = fdiv float %214, %215
  store float %216, ptr %20, align 4
  %217 = load float, ptr %20, align 4
  %218 = fmul float %217, 1.000000e+02
  %219 = fptosi float %218 to i32
  store i32 %219, ptr %21, align 4
  %220 = load i32, ptr %21, align 4
  %221 = sitofp i32 %220 to float
  %222 = load float, ptr @http_get2.prev, align 4
  %223 = fadd float %222, 5.000000e+00
  %224 = fcmp olt float %221, %223
  br i1 %224, label %225, label %228

225:                                              ; preds = %200
  %226 = load i32, ptr %21, align 4
  %227 = icmp ne i32 %226, 100
  br i1 %227, label %254, label %228

228:                                              ; preds = %225, %200
  store i32 0, ptr %15, align 4
  br label %229

229:                                              ; preds = %235, %228
  %230 = load i32, ptr %15, align 4
  %231 = load i32, ptr %21, align 4
  %232 = icmp slt i32 %230, %231
  br i1 %232, label %233, label %238

233:                                              ; preds = %229
  %234 = call i32 @putchar(i32 noundef 46)
  br label %235

235:                                              ; preds = %233
  %236 = load i32, ptr %15, align 4
  %237 = add nsw i32 %236, 2
  store i32 %237, ptr %15, align 4
  br label %229, !llvm.loop !14

238:                                              ; preds = %229
  %239 = load i32, ptr %21, align 4
  %240 = sub nsw i32 %239, 1
  store i32 %240, ptr %15, align 4
  br label %241

241:                                              ; preds = %246, %238
  %242 = load i32, ptr %15, align 4
  %243 = icmp slt i32 %242, 100
  br i1 %243, label %244, label %249

244:                                              ; preds = %241
  %245 = call i32 @putchar(i32 noundef 32)
  br label %246

246:                                              ; preds = %244
  %247 = load i32, ptr %15, align 4
  %248 = add nsw i32 %247, 2
  store i32 %248, ptr %15, align 4
  br label %241, !llvm.loop !15

249:                                              ; preds = %241
  %250 = load i32, ptr %21, align 4
  %251 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %250)
  %252 = load i32, ptr %21, align 4
  %253 = sitofp i32 %252 to float
  store float %253, ptr @http_get2.prev, align 4
  br label %254

254:                                              ; preds = %249, %225
  br label %164, !llvm.loop !16

255:                                              ; preds = %164
  %256 = load i64, ptr %6, align 8
  %257 = load i64, ptr %5, align 8
  %258 = icmp eq i64 %256, %257
  br i1 %258, label %259, label %260

259:                                              ; preds = %255
  store i8 -1, ptr %9, align 1
  br label %260

260:                                              ; preds = %259, %255
  %261 = load i32, ptr %10, align 4
  %262 = call i32 @"\01_close"(i32 noundef %261)
  call void @pthread_exit(ptr noundef null) #6
  unreachable
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @http_get3(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i32, align 4
  %9 = alloca i8, align 1
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i64, align 8
  %17 = alloca ptr, align 8
  %18 = alloca float, align 4
  %19 = alloca float, align 4
  %20 = alloca float, align 4
  %21 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %22 = load ptr, ptr @wthread3_getstr_SHARED, align 8
  store ptr %22, ptr %3, align 8
  %23 = load i64, ptr @wthread3_soffset_SHARED, align 8
  store i64 %23, ptr %4, align 8
  %24 = load i64, ptr @wthread3_offset_SHARED, align 8
  store i64 %24, ptr %6, align 8
  %25 = load i64, ptr @wthread3_clength_SHARED, align 8
  store i64 %25, ptr %7, align 8
  %26 = load i32, ptr @wthread3_fd_SHARED, align 4
  store i32 %26, ptr %8, align 4
  %27 = load i8, ptr @wthread3_status_SHARED, align 1
  store i8 %27, ptr %9, align 1
  %28 = load i64, ptr %5, align 8
  store i64 %28, ptr %16, align 8
  store ptr @.str.7, ptr %11, align 8
  %29 = call i32 @socket(i32 noundef 2, i32 noundef 1, i32 noundef 0)
  store i32 %29, ptr %10, align 4
  %30 = icmp eq i32 %29, -1
  br i1 %30, label %31, label %36

31:                                               ; preds = %1
  %32 = load ptr, ptr @wthread3_tid, align 8
  %33 = load i32, ptr @errno_SHARED, align 4
  %34 = call ptr @"\01_strerror"(i32 noundef %33)
  %35 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, ptr noundef %32, ptr noundef %34)
  call void @pthread_exit(ptr noundef inttoptr (i64 1 to ptr)) #6
  unreachable

36:                                               ; preds = %1
  %37 = load i32, ptr %10, align 4
  %38 = load ptr, ptr %3, align 8
  %39 = load ptr, ptr %3, align 8
  %40 = call i64 @strlen(ptr noundef %39) #5
  %41 = call i64 @"\01_send"(i32 noundef %37, ptr noundef %38, i64 noundef %40, i32 noundef 0)
  %42 = icmp eq i64 %41, -1
  br i1 %42, label %43, label %48

43:                                               ; preds = %36
  %44 = load ptr, ptr @wthread3_tid, align 8
  %45 = load i32, ptr @errno_SHARED, align 4
  %46 = call ptr @"\01_strerror"(i32 noundef %45)
  %47 = call i32 (ptr, ...) @printf(ptr noundef @.str.9, ptr noundef %44, ptr noundef %46)
  call void @pthread_exit(ptr noundef inttoptr (i64 1 to ptr)) #6
  unreachable

48:                                               ; preds = %36
  %49 = load i32, ptr %10, align 4
  %50 = load ptr, ptr %11, align 8
  %51 = call i64 @"\01_recv"(i32 noundef %49, ptr noundef %50, i64 noundef 512, i32 noundef 0)
  %52 = trunc i64 %51 to i32
  store i32 %52, ptr %13, align 4
  %53 = icmp eq i32 %52, -1
  br i1 %53, label %54, label %59

54:                                               ; preds = %48
  %55 = load ptr, ptr @wthread3_tid, align 8
  %56 = load i32, ptr @errno_SHARED, align 4
  %57 = call ptr @"\01_strerror"(i32 noundef %56)
  %58 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, ptr noundef %55, ptr noundef %57)
  call void @pthread_exit(ptr noundef inttoptr (i64 1 to ptr)) #6
  unreachable

59:                                               ; preds = %48
  %60 = load ptr, ptr %11, align 8
  %61 = call ptr @strstr(ptr noundef %60, ptr noundef @.str.11) #5
  %62 = icmp ne ptr %61, null
  br i1 %62, label %63, label %65

63:                                               ; preds = %59
  %64 = call i32 (ptr, ...) @printf(ptr noundef @.str.12)
  call void @exit(i32 noundef 1) #6
  unreachable

65:                                               ; preds = %59
  %66 = load ptr, ptr %11, align 8
  %67 = call ptr @strstr(ptr noundef %66, ptr noundef @.str.13) #5
  %68 = icmp ne ptr %67, null
  br i1 %68, label %69, label %71

69:                                               ; preds = %65
  %70 = call i32 (ptr, ...) @printf(ptr noundef @.str.14)
  call void @exit(i32 noundef 1) #6
  unreachable

71:                                               ; preds = %65
  %72 = load ptr, ptr %11, align 8
  %73 = call ptr @strstr(ptr noundef %72, ptr noundef @.str.15) #5
  %74 = icmp ne ptr %73, null
  br i1 %74, label %75, label %77

75:                                               ; preds = %71
  %76 = call i32 (ptr, ...) @printf(ptr noundef @.str.16)
  call void @exit(i32 noundef 1) #6
  unreachable

77:                                               ; preds = %71
  br label %78

78:                                               ; preds = %77
  br label %79

79:                                               ; preds = %78
  %80 = load ptr, ptr %11, align 8
  %81 = call ptr @strstr(ptr noundef %80, ptr noundef @.str.17) #5
  %82 = icmp eq ptr %81, null
  br i1 %82, label %83, label %85

83:                                               ; preds = %79
  %84 = call i32 (ptr, ...) @printf(ptr noundef @.str.18)
  call void @exit(i32 noundef 1) #6
  unreachable

85:                                               ; preds = %79
  %86 = load ptr, ptr %11, align 8
  store ptr %86, ptr %12, align 8
  store i32 0, ptr %15, align 4
  br label %87

87:                                               ; preds = %85, %115
  %88 = load ptr, ptr %12, align 8
  %89 = load i8, ptr %88, align 1
  %90 = sext i8 %89 to i32
  %91 = icmp eq i32 %90, 10
  br i1 %91, label %92, label %115

92:                                               ; preds = %87
  %93 = load ptr, ptr %12, align 8
  %94 = getelementptr inbounds i8, ptr %93, i64 -1
  %95 = load i8, ptr %94, align 1
  %96 = sext i8 %95 to i32
  %97 = icmp eq i32 %96, 13
  br i1 %97, label %98, label %115

98:                                               ; preds = %92
  %99 = load ptr, ptr %12, align 8
  %100 = getelementptr inbounds i8, ptr %99, i64 -2
  %101 = load i8, ptr %100, align 1
  %102 = sext i8 %101 to i32
  %103 = icmp eq i32 %102, 10
  br i1 %103, label %104, label %115

104:                                              ; preds = %98
  %105 = load ptr, ptr %12, align 8
  %106 = getelementptr inbounds i8, ptr %105, i64 -3
  %107 = load i8, ptr %106, align 1
  %108 = sext i8 %107 to i32
  %109 = icmp eq i32 %108, 13
  br i1 %109, label %110, label %115

110:                                              ; preds = %104
  %111 = load ptr, ptr %12, align 8
  %112 = getelementptr inbounds i8, ptr %111, i32 1
  store ptr %112, ptr %12, align 8
  %113 = load i32, ptr %15, align 4
  %114 = add nsw i32 %113, 1
  store i32 %114, ptr %15, align 4
  br label %120

115:                                              ; preds = %104, %98, %92, %87
  %116 = load ptr, ptr %12, align 8
  %117 = getelementptr inbounds i8, ptr %116, i32 1
  store ptr %117, ptr %12, align 8
  %118 = load i32, ptr %15, align 4
  %119 = add nsw i32 %118, 1
  store i32 %119, ptr %15, align 4
  br label %87

120:                                              ; preds = %110
  %121 = load i64, ptr %4, align 8
  store i64 %121, ptr %6, align 8
  %122 = load i32, ptr %13, align 4
  %123 = load i32, ptr %15, align 4
  %124 = sub nsw i32 %122, %123
  %125 = sext i32 %124 to i64
  %126 = load i64, ptr %16, align 8
  %127 = icmp sgt i64 %125, %126
  br i1 %127, label %128, label %138

128:                                              ; preds = %120
  %129 = load i32, ptr %8, align 4
  %130 = load ptr, ptr %12, align 8
  %131 = load i64, ptr %16, align 8
  %132 = load i32, ptr %15, align 4
  %133 = sext i32 %132 to i64
  %134 = sub nsw i64 %131, %133
  %135 = load i64, ptr %4, align 8
  %136 = call i64 @"\01_pwrite"(i32 noundef %129, ptr noundef %130, i64 noundef %134, i64 noundef %135)
  %137 = trunc i64 %136 to i32
  store i32 %137, ptr %14, align 4
  br label %148

138:                                              ; preds = %120
  %139 = load i32, ptr %8, align 4
  %140 = load ptr, ptr %12, align 8
  %141 = load i32, ptr %13, align 4
  %142 = load i32, ptr %15, align 4
  %143 = sub nsw i32 %141, %142
  %144 = sext i32 %143 to i64
  %145 = load i64, ptr %4, align 8
  %146 = call i64 @"\01_pwrite"(i32 noundef %139, ptr noundef %140, i64 noundef %144, i64 noundef %145)
  %147 = trunc i64 %146 to i32
  store i32 %147, ptr %14, align 4
  br label %148

148:                                              ; preds = %138, %128
  %149 = load i64, ptr %4, align 8
  %150 = load i32, ptr %14, align 4
  %151 = sext i32 %150 to i64
  %152 = add nsw i64 %149, %151
  store i64 %152, ptr %6, align 8
  call void @nop1()
  br label %153

153:                                              ; preds = %157, %148
  %154 = load i32, ptr @patchVar_SHARED, align 4
  %155 = icmp ne i32 %154, 0
  %156 = xor i1 %155, true
  br i1 %156, label %157, label %158

157:                                              ; preds = %153
  call void @nop1()
  br label %153, !llvm.loop !17

158:                                              ; preds = %153
  call void @nop1()
  %159 = call i32 @pthread_mutex_lock(ptr noundef @bwritten_mutex)
  %160 = load i32, ptr %14, align 4
  %161 = load i32, ptr @bwritten_SHARED, align 4
  %162 = add nsw i32 %161, %160
  store i32 %162, ptr @bwritten_SHARED, align 4
  %163 = call i32 @pthread_mutex_unlock(ptr noundef @bwritten_mutex)
  br label %164

164:                                              ; preds = %254, %158
  %165 = load i64, ptr %6, align 8
  %166 = load i64, ptr %16, align 8
  %167 = icmp slt i64 %165, %166
  br i1 %167, label %168, label %255

168:                                              ; preds = %164
  %169 = load ptr, ptr %11, align 8
  %170 = load ptr, ptr %11, align 8
  %171 = call i64 @llvm.objectsize.i64.p0(ptr %170, i1 false, i1 true, i1 false)
  %172 = call ptr @__memset_chk(ptr noundef %169, i32 noundef 512, i64 noundef 0, i64 noundef %171) #5
  %173 = load i32, ptr %10, align 4
  %174 = load ptr, ptr %11, align 8
  %175 = call i64 @"\01_recv"(i32 noundef %173, ptr noundef %174, i64 noundef 512, i32 noundef 0)
  %176 = trunc i64 %175 to i32
  store i32 %176, ptr %13, align 4
  %177 = load i64, ptr %6, align 8
  %178 = load i32, ptr %13, align 4
  %179 = sext i32 %178 to i64
  %180 = add nsw i64 %177, %179
  %181 = load i64, ptr %16, align 8
  %182 = icmp sgt i64 %180, %181
  br i1 %182, label %183, label %192

183:                                              ; preds = %168
  %184 = load i32, ptr %8, align 4
  %185 = load ptr, ptr %11, align 8
  %186 = load i64, ptr %16, align 8
  %187 = load i64, ptr %6, align 8
  %188 = sub nsw i64 %186, %187
  %189 = load i64, ptr %6, align 8
  %190 = call i64 @"\01_pwrite"(i32 noundef %184, ptr noundef %185, i64 noundef %188, i64 noundef %189)
  %191 = trunc i64 %190 to i32
  store i32 %191, ptr %14, align 4
  br label %200

192:                                              ; preds = %168
  %193 = load i32, ptr %8, align 4
  %194 = load ptr, ptr %11, align 8
  %195 = load i32, ptr %13, align 4
  %196 = sext i32 %195 to i64
  %197 = load i64, ptr %6, align 8
  %198 = call i64 @"\01_pwrite"(i32 noundef %193, ptr noundef %194, i64 noundef %196, i64 noundef %197)
  %199 = trunc i64 %198 to i32
  store i32 %199, ptr %14, align 4
  br label %200

200:                                              ; preds = %192, %183
  %201 = load i32, ptr %14, align 4
  %202 = sext i32 %201 to i64
  %203 = load i64, ptr %6, align 8
  %204 = add nsw i64 %203, %202
  store i64 %204, ptr %6, align 8
  %205 = call i32 @pthread_mutex_lock(ptr noundef @bwritten_mutex)
  %206 = load i32, ptr %14, align 4
  %207 = load i32, ptr @bwritten_SHARED, align 4
  %208 = add nsw i32 %207, %206
  store i32 %208, ptr @bwritten_SHARED, align 4
  %209 = call i32 @pthread_mutex_unlock(ptr noundef @bwritten_mutex)
  %210 = load i32, ptr @bwritten_SHARED, align 4
  %211 = sitofp i32 %210 to float
  store float %211, ptr %18, align 4
  %212 = load i64, ptr %7, align 8
  %213 = sitofp i64 %212 to float
  store float %213, ptr %19, align 4
  %214 = load float, ptr %18, align 4
  %215 = load float, ptr %19, align 4
  %216 = fdiv float %214, %215
  store float %216, ptr %20, align 4
  %217 = load float, ptr %20, align 4
  %218 = fmul float %217, 1.000000e+02
  %219 = fptosi float %218 to i32
  store i32 %219, ptr %21, align 4
  %220 = load i32, ptr %21, align 4
  %221 = sitofp i32 %220 to float
  %222 = load float, ptr @http_get3.prev, align 4
  %223 = fadd float %222, 5.000000e+00
  %224 = fcmp olt float %221, %223
  br i1 %224, label %225, label %228

225:                                              ; preds = %200
  %226 = load i32, ptr %21, align 4
  %227 = icmp ne i32 %226, 100
  br i1 %227, label %254, label %228

228:                                              ; preds = %225, %200
  store i32 0, ptr %15, align 4
  br label %229

229:                                              ; preds = %235, %228
  %230 = load i32, ptr %15, align 4
  %231 = load i32, ptr %21, align 4
  %232 = icmp slt i32 %230, %231
  br i1 %232, label %233, label %238

233:                                              ; preds = %229
  %234 = call i32 @putchar(i32 noundef 46)
  br label %235

235:                                              ; preds = %233
  %236 = load i32, ptr %15, align 4
  %237 = add nsw i32 %236, 2
  store i32 %237, ptr %15, align 4
  br label %229, !llvm.loop !18

238:                                              ; preds = %229
  %239 = load i32, ptr %21, align 4
  %240 = sub nsw i32 %239, 1
  store i32 %240, ptr %15, align 4
  br label %241

241:                                              ; preds = %246, %238
  %242 = load i32, ptr %15, align 4
  %243 = icmp slt i32 %242, 100
  br i1 %243, label %244, label %249

244:                                              ; preds = %241
  %245 = call i32 @putchar(i32 noundef 32)
  br label %246

246:                                              ; preds = %244
  %247 = load i32, ptr %15, align 4
  %248 = add nsw i32 %247, 2
  store i32 %248, ptr %15, align 4
  br label %241, !llvm.loop !19

249:                                              ; preds = %241
  %250 = load i32, ptr %21, align 4
  %251 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %250)
  %252 = load i32, ptr %21, align 4
  %253 = sitofp i32 %252 to float
  store float %253, ptr @http_get3.prev, align 4
  br label %254

254:                                              ; preds = %249, %225
  br label %164, !llvm.loop !20

255:                                              ; preds = %164
  %256 = load i64, ptr %6, align 8
  %257 = load i64, ptr %5, align 8
  %258 = icmp eq i64 %256, %257
  br i1 %258, label %259, label %260

259:                                              ; preds = %255
  store i8 -1, ptr %9, align 1
  br label %260

260:                                              ; preds = %259, %255
  %261 = load i32, ptr %10, align 4
  %262 = call i32 @"\01_close"(i32 noundef %261)
  call void @pthread_exit(ptr noundef null) #6
  unreachable
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @http_get4(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i32, align 4
  %9 = alloca i8, align 1
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i64, align 8
  %17 = alloca ptr, align 8
  %18 = alloca float, align 4
  %19 = alloca float, align 4
  %20 = alloca float, align 4
  %21 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %22 = load ptr, ptr @wthread4_getstr_SHARED, align 8
  store ptr %22, ptr %3, align 8
  %23 = load i64, ptr @wthread4_soffset_SHARED, align 8
  store i64 %23, ptr %4, align 8
  %24 = load i64, ptr @wthread4_offset_SHARED, align 8
  store i64 %24, ptr %6, align 8
  %25 = load i64, ptr @wthread4_clength_SHARED, align 8
  store i64 %25, ptr %7, align 8
  %26 = load i32, ptr @wthread4_fd_SHARED, align 4
  store i32 %26, ptr %8, align 4
  %27 = load i8, ptr @wthread4_status_SHARED, align 1
  store i8 %27, ptr %9, align 1
  %28 = load i64, ptr %5, align 8
  store i64 %28, ptr %16, align 8
  store ptr @.str.7, ptr %11, align 8
  %29 = call i32 @socket(i32 noundef 2, i32 noundef 1, i32 noundef 0)
  store i32 %29, ptr %10, align 4
  %30 = icmp eq i32 %29, -1
  br i1 %30, label %31, label %36

31:                                               ; preds = %1
  %32 = load ptr, ptr @wthread4_tid, align 8
  %33 = load i32, ptr @errno_SHARED, align 4
  %34 = call ptr @"\01_strerror"(i32 noundef %33)
  %35 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, ptr noundef %32, ptr noundef %34)
  call void @pthread_exit(ptr noundef inttoptr (i64 1 to ptr)) #6
  unreachable

36:                                               ; preds = %1
  %37 = load i32, ptr %10, align 4
  %38 = load ptr, ptr %3, align 8
  %39 = load ptr, ptr %3, align 8
  %40 = call i64 @strlen(ptr noundef %39) #5
  %41 = call i64 @"\01_send"(i32 noundef %37, ptr noundef %38, i64 noundef %40, i32 noundef 0)
  %42 = icmp eq i64 %41, -1
  br i1 %42, label %43, label %48

43:                                               ; preds = %36
  %44 = load ptr, ptr @wthread4_tid, align 8
  %45 = load i32, ptr @errno_SHARED, align 4
  %46 = call ptr @"\01_strerror"(i32 noundef %45)
  %47 = call i32 (ptr, ...) @printf(ptr noundef @.str.9, ptr noundef %44, ptr noundef %46)
  call void @pthread_exit(ptr noundef inttoptr (i64 1 to ptr)) #6
  unreachable

48:                                               ; preds = %36
  %49 = load i32, ptr %10, align 4
  %50 = load ptr, ptr %11, align 8
  %51 = call i64 @"\01_recv"(i32 noundef %49, ptr noundef %50, i64 noundef 512, i32 noundef 0)
  %52 = trunc i64 %51 to i32
  store i32 %52, ptr %13, align 4
  %53 = icmp eq i32 %52, -1
  br i1 %53, label %54, label %59

54:                                               ; preds = %48
  %55 = load ptr, ptr @wthread4_tid, align 8
  %56 = load i32, ptr @errno_SHARED, align 4
  %57 = call ptr @"\01_strerror"(i32 noundef %56)
  %58 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, ptr noundef %55, ptr noundef %57)
  call void @pthread_exit(ptr noundef inttoptr (i64 1 to ptr)) #6
  unreachable

59:                                               ; preds = %48
  %60 = load ptr, ptr %11, align 8
  %61 = call ptr @strstr(ptr noundef %60, ptr noundef @.str.11) #5
  %62 = icmp ne ptr %61, null
  br i1 %62, label %63, label %65

63:                                               ; preds = %59
  %64 = call i32 (ptr, ...) @printf(ptr noundef @.str.12)
  call void @exit(i32 noundef 1) #6
  unreachable

65:                                               ; preds = %59
  %66 = load ptr, ptr %11, align 8
  %67 = call ptr @strstr(ptr noundef %66, ptr noundef @.str.13) #5
  %68 = icmp ne ptr %67, null
  br i1 %68, label %69, label %71

69:                                               ; preds = %65
  %70 = call i32 (ptr, ...) @printf(ptr noundef @.str.14)
  call void @exit(i32 noundef 1) #6
  unreachable

71:                                               ; preds = %65
  %72 = load ptr, ptr %11, align 8
  %73 = call ptr @strstr(ptr noundef %72, ptr noundef @.str.15) #5
  %74 = icmp ne ptr %73, null
  br i1 %74, label %75, label %77

75:                                               ; preds = %71
  %76 = call i32 (ptr, ...) @printf(ptr noundef @.str.16)
  call void @exit(i32 noundef 1) #6
  unreachable

77:                                               ; preds = %71
  br label %78

78:                                               ; preds = %77
  br label %79

79:                                               ; preds = %78
  %80 = load ptr, ptr %11, align 8
  %81 = call ptr @strstr(ptr noundef %80, ptr noundef @.str.17) #5
  %82 = icmp eq ptr %81, null
  br i1 %82, label %83, label %85

83:                                               ; preds = %79
  %84 = call i32 (ptr, ...) @printf(ptr noundef @.str.18)
  call void @exit(i32 noundef 1) #6
  unreachable

85:                                               ; preds = %79
  %86 = load ptr, ptr %11, align 8
  store ptr %86, ptr %12, align 8
  store i32 0, ptr %15, align 4
  br label %87

87:                                               ; preds = %85, %115
  %88 = load ptr, ptr %12, align 8
  %89 = load i8, ptr %88, align 1
  %90 = sext i8 %89 to i32
  %91 = icmp eq i32 %90, 10
  br i1 %91, label %92, label %115

92:                                               ; preds = %87
  %93 = load ptr, ptr %12, align 8
  %94 = getelementptr inbounds i8, ptr %93, i64 -1
  %95 = load i8, ptr %94, align 1
  %96 = sext i8 %95 to i32
  %97 = icmp eq i32 %96, 13
  br i1 %97, label %98, label %115

98:                                               ; preds = %92
  %99 = load ptr, ptr %12, align 8
  %100 = getelementptr inbounds i8, ptr %99, i64 -2
  %101 = load i8, ptr %100, align 1
  %102 = sext i8 %101 to i32
  %103 = icmp eq i32 %102, 10
  br i1 %103, label %104, label %115

104:                                              ; preds = %98
  %105 = load ptr, ptr %12, align 8
  %106 = getelementptr inbounds i8, ptr %105, i64 -3
  %107 = load i8, ptr %106, align 1
  %108 = sext i8 %107 to i32
  %109 = icmp eq i32 %108, 13
  br i1 %109, label %110, label %115

110:                                              ; preds = %104
  %111 = load ptr, ptr %12, align 8
  %112 = getelementptr inbounds i8, ptr %111, i32 1
  store ptr %112, ptr %12, align 8
  %113 = load i32, ptr %15, align 4
  %114 = add nsw i32 %113, 1
  store i32 %114, ptr %15, align 4
  br label %120

115:                                              ; preds = %104, %98, %92, %87
  %116 = load ptr, ptr %12, align 8
  %117 = getelementptr inbounds i8, ptr %116, i32 1
  store ptr %117, ptr %12, align 8
  %118 = load i32, ptr %15, align 4
  %119 = add nsw i32 %118, 1
  store i32 %119, ptr %15, align 4
  br label %87

120:                                              ; preds = %110
  %121 = load i64, ptr %4, align 8
  store i64 %121, ptr %6, align 8
  %122 = load i32, ptr %13, align 4
  %123 = load i32, ptr %15, align 4
  %124 = sub nsw i32 %122, %123
  %125 = sext i32 %124 to i64
  %126 = load i64, ptr %16, align 8
  %127 = icmp sgt i64 %125, %126
  br i1 %127, label %128, label %138

128:                                              ; preds = %120
  %129 = load i32, ptr %8, align 4
  %130 = load ptr, ptr %12, align 8
  %131 = load i64, ptr %16, align 8
  %132 = load i32, ptr %15, align 4
  %133 = sext i32 %132 to i64
  %134 = sub nsw i64 %131, %133
  %135 = load i64, ptr %4, align 8
  %136 = call i64 @"\01_pwrite"(i32 noundef %129, ptr noundef %130, i64 noundef %134, i64 noundef %135)
  %137 = trunc i64 %136 to i32
  store i32 %137, ptr %14, align 4
  br label %148

138:                                              ; preds = %120
  %139 = load i32, ptr %8, align 4
  %140 = load ptr, ptr %12, align 8
  %141 = load i32, ptr %13, align 4
  %142 = load i32, ptr %15, align 4
  %143 = sub nsw i32 %141, %142
  %144 = sext i32 %143 to i64
  %145 = load i64, ptr %4, align 8
  %146 = call i64 @"\01_pwrite"(i32 noundef %139, ptr noundef %140, i64 noundef %144, i64 noundef %145)
  %147 = trunc i64 %146 to i32
  store i32 %147, ptr %14, align 4
  br label %148

148:                                              ; preds = %138, %128
  %149 = load i64, ptr %4, align 8
  %150 = load i32, ptr %14, align 4
  %151 = sext i32 %150 to i64
  %152 = add nsw i64 %149, %151
  store i64 %152, ptr %6, align 8
  call void @nop1()
  br label %153

153:                                              ; preds = %157, %148
  %154 = load i32, ptr @patchVar_SHARED, align 4
  %155 = icmp ne i32 %154, 0
  %156 = xor i1 %155, true
  br i1 %156, label %157, label %158

157:                                              ; preds = %153
  call void @nop1()
  br label %153, !llvm.loop !21

158:                                              ; preds = %153
  call void @nop1()
  %159 = call i32 @pthread_mutex_lock(ptr noundef @bwritten_mutex)
  %160 = load i32, ptr %14, align 4
  %161 = load i32, ptr @bwritten_SHARED, align 4
  %162 = add nsw i32 %161, %160
  store i32 %162, ptr @bwritten_SHARED, align 4
  %163 = call i32 @pthread_mutex_unlock(ptr noundef @bwritten_mutex)
  br label %164

164:                                              ; preds = %254, %158
  %165 = load i64, ptr %6, align 8
  %166 = load i64, ptr %16, align 8
  %167 = icmp slt i64 %165, %166
  br i1 %167, label %168, label %255

168:                                              ; preds = %164
  %169 = load ptr, ptr %11, align 8
  %170 = load ptr, ptr %11, align 8
  %171 = call i64 @llvm.objectsize.i64.p0(ptr %170, i1 false, i1 true, i1 false)
  %172 = call ptr @__memset_chk(ptr noundef %169, i32 noundef 512, i64 noundef 0, i64 noundef %171) #5
  %173 = load i32, ptr %10, align 4
  %174 = load ptr, ptr %11, align 8
  %175 = call i64 @"\01_recv"(i32 noundef %173, ptr noundef %174, i64 noundef 512, i32 noundef 0)
  %176 = trunc i64 %175 to i32
  store i32 %176, ptr %13, align 4
  %177 = load i64, ptr %6, align 8
  %178 = load i32, ptr %13, align 4
  %179 = sext i32 %178 to i64
  %180 = add nsw i64 %177, %179
  %181 = load i64, ptr %16, align 8
  %182 = icmp sgt i64 %180, %181
  br i1 %182, label %183, label %192

183:                                              ; preds = %168
  %184 = load i32, ptr %8, align 4
  %185 = load ptr, ptr %11, align 8
  %186 = load i64, ptr %16, align 8
  %187 = load i64, ptr %6, align 8
  %188 = sub nsw i64 %186, %187
  %189 = load i64, ptr %6, align 8
  %190 = call i64 @"\01_pwrite"(i32 noundef %184, ptr noundef %185, i64 noundef %188, i64 noundef %189)
  %191 = trunc i64 %190 to i32
  store i32 %191, ptr %14, align 4
  br label %200

192:                                              ; preds = %168
  %193 = load i32, ptr %8, align 4
  %194 = load ptr, ptr %11, align 8
  %195 = load i32, ptr %13, align 4
  %196 = sext i32 %195 to i64
  %197 = load i64, ptr %6, align 8
  %198 = call i64 @"\01_pwrite"(i32 noundef %193, ptr noundef %194, i64 noundef %196, i64 noundef %197)
  %199 = trunc i64 %198 to i32
  store i32 %199, ptr %14, align 4
  br label %200

200:                                              ; preds = %192, %183
  %201 = load i32, ptr %14, align 4
  %202 = sext i32 %201 to i64
  %203 = load i64, ptr %6, align 8
  %204 = add nsw i64 %203, %202
  store i64 %204, ptr %6, align 8
  %205 = call i32 @pthread_mutex_lock(ptr noundef @bwritten_mutex)
  %206 = load i32, ptr %14, align 4
  %207 = load i32, ptr @bwritten_SHARED, align 4
  %208 = add nsw i32 %207, %206
  store i32 %208, ptr @bwritten_SHARED, align 4
  %209 = call i32 @pthread_mutex_unlock(ptr noundef @bwritten_mutex)
  %210 = load i32, ptr @bwritten_SHARED, align 4
  %211 = sitofp i32 %210 to float
  store float %211, ptr %18, align 4
  %212 = load i64, ptr %7, align 8
  %213 = sitofp i64 %212 to float
  store float %213, ptr %19, align 4
  %214 = load float, ptr %18, align 4
  %215 = load float, ptr %19, align 4
  %216 = fdiv float %214, %215
  store float %216, ptr %20, align 4
  %217 = load float, ptr %20, align 4
  %218 = fmul float %217, 1.000000e+02
  %219 = fptosi float %218 to i32
  store i32 %219, ptr %21, align 4
  %220 = load i32, ptr %21, align 4
  %221 = sitofp i32 %220 to float
  %222 = load float, ptr @http_get4.prev, align 4
  %223 = fadd float %222, 5.000000e+00
  %224 = fcmp olt float %221, %223
  br i1 %224, label %225, label %228

225:                                              ; preds = %200
  %226 = load i32, ptr %21, align 4
  %227 = icmp ne i32 %226, 100
  br i1 %227, label %254, label %228

228:                                              ; preds = %225, %200
  store i32 0, ptr %15, align 4
  br label %229

229:                                              ; preds = %235, %228
  %230 = load i32, ptr %15, align 4
  %231 = load i32, ptr %21, align 4
  %232 = icmp slt i32 %230, %231
  br i1 %232, label %233, label %238

233:                                              ; preds = %229
  %234 = call i32 @putchar(i32 noundef 46)
  br label %235

235:                                              ; preds = %233
  %236 = load i32, ptr %15, align 4
  %237 = add nsw i32 %236, 2
  store i32 %237, ptr %15, align 4
  br label %229, !llvm.loop !22

238:                                              ; preds = %229
  %239 = load i32, ptr %21, align 4
  %240 = sub nsw i32 %239, 1
  store i32 %240, ptr %15, align 4
  br label %241

241:                                              ; preds = %246, %238
  %242 = load i32, ptr %15, align 4
  %243 = icmp slt i32 %242, 100
  br i1 %243, label %244, label %249

244:                                              ; preds = %241
  %245 = call i32 @putchar(i32 noundef 32)
  br label %246

246:                                              ; preds = %244
  %247 = load i32, ptr %15, align 4
  %248 = add nsw i32 %247, 2
  store i32 %248, ptr %15, align 4
  br label %241, !llvm.loop !23

249:                                              ; preds = %241
  %250 = load i32, ptr %21, align 4
  %251 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %250)
  %252 = load i32, ptr %21, align 4
  %253 = sitofp i32 %252 to float
  store float %253, ptr @http_get4.prev, align 4
  br label %254

254:                                              ; preds = %249, %225
  br label %164, !llvm.loop !24

255:                                              ; preds = %164
  %256 = load i64, ptr %6, align 8
  %257 = load i64, ptr %5, align 8
  %258 = icmp eq i64 %256, %257
  br i1 %258, label %259, label %260

259:                                              ; preds = %255
  store i8 -1, ptr %9, align 1
  br label %260

260:                                              ; preds = %259, %255
  %261 = load i32, ptr %10, align 4
  %262 = call i32 @"\01_close"(i32 noundef %261)
  call void @pthread_exit(ptr noundef null) #6
  unreachable
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca ptr, align 8
  %15 = alloca ptr, align 8
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i64, align 8
  %23 = alloca i64, align 8
  %24 = alloca ptr, align 8
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 0, ptr %7, align 4
  %31 = call i32 @pthread_mutex_init(ptr noundef @bwritten_mutex, ptr noundef null)
  %32 = call i32 @pthread_create(ptr noundef @hthread, ptr noundef null, ptr noundef @signal_waiter, ptr noundef null)
  br label %33

33:                                               ; preds = %64, %2
  %34 = load i32, ptr %7, align 4
  %35 = icmp ne i32 %34, 0
  br i1 %35, label %41, label %36

36:                                               ; preds = %33
  %37 = load i32, ptr %4, align 4
  %38 = load ptr, ptr %5, align 8
  %39 = call i32 @"\01_getopt"(i32 noundef %37, ptr noundef %38, ptr noundef @.str.19)
  store i32 %39, ptr %6, align 4
  %40 = icmp ne i32 %39, -1
  br label %41

41:                                               ; preds = %36, %33
  %42 = phi i1 [ false, %33 ], [ %40, %36 ]
  br i1 %42, label %43, label %65

43:                                               ; preds = %41
  %44 = load i32, ptr %6, align 4
  switch i32 %44, label %63 [
    i32 112, label %45
    i32 102, label %48
    i32 108, label %49
    i32 110, label %52
    i32 104, label %59
    i32 118, label %61
  ]

45:                                               ; preds = %43
  %46 = load ptr, ptr @optarg, align 8
  %47 = call i32 @atoi(ptr noundef %46)
  store i32 %47, ptr @req_port_SHARED, align 4
  br label %64

48:                                               ; preds = %43
  store i32 1, ptr @fsuggested_SHARED, align 4
  br label %64

49:                                               ; preds = %43
  %50 = load ptr, ptr @optarg, align 8
  %51 = call ptr @__strncpy_chk(ptr noundef @req_lfile_SHARED, ptr noundef %50, i64 noundef 512, i64 noundef 512) #5
  br label %64

52:                                               ; preds = %43
  %53 = load ptr, ptr @optarg, align 8
  %54 = call i32 @atoi(ptr noundef %53)
  store i32 %54, ptr @nthreads_SHARED, align 4
  %55 = icmp sgt i32 %54, 25
  br i1 %55, label %56, label %58

56:                                               ; preds = %52
  %57 = call i32 (ptr, ...) @printf(ptr noundef @.str.20, i32 noundef 25)
  store i32 0, ptr @nthreads_SHARED, align 4
  br label %58

58:                                               ; preds = %56, %52
  br label %64

59:                                               ; preds = %43
  %60 = call i32 (ptr, ...) @printf(ptr noundef @.str.21, ptr noundef @.str.22)
  call void @exit(i32 noundef 0) #6
  unreachable

61:                                               ; preds = %43
  %62 = call i32 (ptr, ...) @printf(ptr noundef @.str.23, ptr noundef @.str.22)
  call void @exit(i32 noundef 0) #6
  unreachable

63:                                               ; preds = %43
  store i32 1, ptr %7, align 4
  call void @exit(i32 noundef 1) #6
  unreachable

64:                                               ; preds = %58, %49, %48, %45
  br label %33, !llvm.loop !25

65:                                               ; preds = %41
  %66 = load i32, ptr %7, align 4
  %67 = icmp ne i32 %66, 0
  br i1 %67, label %68, label %69

68:                                               ; preds = %65
  call void @exit(i32 noundef 1) #6
  unreachable

69:                                               ; preds = %65
  %70 = load i32, ptr @fsuggested_SHARED, align 4
  %71 = icmp eq i32 %70, 1
  br i1 %71, label %72, label %78

72:                                               ; preds = %69
  %73 = load i32, ptr @nthreads_SHARED, align 4
  %74 = icmp eq i32 %73, 0
  br i1 %74, label %75, label %78

75:                                               ; preds = %72
  %76 = load ptr, ptr @__stderrp, align 8
  %77 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %76, ptr noundef @.str.24) #5
  call void @exit(i32 noundef 1) #6
  unreachable

78:                                               ; preds = %72, %69
  %79 = load i32, ptr %4, align 4
  %80 = icmp eq i32 %79, 2
  br i1 %80, label %81, label %86

81:                                               ; preds = %78
  %82 = load ptr, ptr %5, align 8
  %83 = getelementptr inbounds ptr, ptr %82, i64 1
  %84 = load ptr, ptr %83, align 8
  %85 = call ptr @strdup(ptr noundef %84) #5
  store ptr %85, ptr @fullurl_SHARED, align 8
  br label %109

86:                                               ; preds = %78
  %87 = load i32, ptr @optind, align 4
  %88 = load i32, ptr %4, align 4
  %89 = icmp slt i32 %87, %88
  br i1 %89, label %90, label %102

90:                                               ; preds = %86
  %91 = load i32, ptr %4, align 4
  %92 = icmp sgt i32 %91, 2
  br i1 %92, label %93, label %100

93:                                               ; preds = %90
  %94 = load ptr, ptr %5, align 8
  %95 = load i32, ptr @optind, align 4
  %96 = sext i32 %95 to i64
  %97 = getelementptr inbounds ptr, ptr %94, i64 %96
  %98 = load ptr, ptr %97, align 8
  %99 = call ptr @strdup(ptr noundef %98) #5
  store ptr %99, ptr @fullurl_SHARED, align 8
  br label %101

100:                                              ; preds = %90
  call void @exit(i32 noundef 1) #6
  unreachable

101:                                              ; preds = %93
  br label %108

102:                                              ; preds = %86
  %103 = load i32, ptr @optind, align 4
  %104 = load i32, ptr %4, align 4
  %105 = icmp eq i32 %103, %104
  br i1 %105, label %106, label %107

106:                                              ; preds = %102
  call void @exit(i32 noundef 1) #6
  unreachable

107:                                              ; preds = %102
  br label %108

108:                                              ; preds = %107, %101
  br label %109

109:                                              ; preds = %108, %81
  %110 = load i32, ptr %9, align 4
  %111 = icmp ne i32 %110, -1
  br i1 %111, label %112, label %256

112:                                              ; preds = %109
  store i32 0, ptr %13, align 4
  %113 = load i32, ptr @hist_data_nthreads_SHARED, align 4
  store i32 %113, ptr @nthreads_SHARED, align 4
  store ptr @.str.25, ptr %14, align 8
  store ptr @req_url_SHARED, ptr %15, align 8
  %114 = load i32, ptr @req_clength_SHARED, align 4
  store i32 %114, ptr %16, align 4
  store ptr @req_host_SHARED, ptr %15, align 8
  store ptr @req_ip_SHARED, ptr %15, align 8
  %115 = load i32, ptr @req_port_SHARED, align 4
  store i32 %115, ptr %16, align 4
  %116 = load i32, ptr @nthreads_SHARED, align 4
  store i32 %116, ptr %16, align 4
  %117 = call i64 @strlen(ptr noundef @req_lfile_SHARED) #5
  %118 = icmp ne i64 %117, 0
  br i1 %118, label %119, label %128

119:                                              ; preds = %112
  %120 = call i32 (ptr, i32, ...) @"\01_open"(ptr noundef @req_lfile_SHARED, i32 noundef 2, i32 noundef 448)
  store i32 %120, ptr %11, align 4
  %121 = icmp eq i32 %120, -1
  br i1 %121, label %122, label %127

122:                                              ; preds = %119
  %123 = load ptr, ptr @__stderrp, align 8
  %124 = load i32, ptr @errno_SHARED, align 4
  %125 = call ptr @"\01_strerror"(i32 noundef %124)
  %126 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %123, ptr noundef @.str.26, ptr noundef @req_lfile_SHARED, ptr noundef %125) #5
  call void @exit(i32 noundef 1) #6
  unreachable

127:                                              ; preds = %119
  br label %137

128:                                              ; preds = %112
  %129 = call i32 (ptr, i32, ...) @"\01_open"(ptr noundef @req_file_SHARED, i32 noundef 2, i32 noundef 448)
  store i32 %129, ptr %11, align 4
  %130 = icmp eq i32 %129, -1
  br i1 %130, label %131, label %136

131:                                              ; preds = %128
  %132 = load ptr, ptr @__stderrp, align 8
  %133 = load i32, ptr @errno_SHARED, align 4
  %134 = call ptr @"\01_strerror"(i32 noundef %133)
  %135 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %132, ptr noundef @.str.26, ptr noundef @req_lfile_SHARED, ptr noundef %134) #5
  call void @exit(i32 noundef 1) #6
  unreachable

136:                                              ; preds = %128
  br label %137

137:                                              ; preds = %136, %127
  %138 = call i64 @time(ptr noundef @t_start_SHARED)
  store i32 0, ptr %10, align 4
  %139 = load i32, ptr %10, align 4
  %140 = load i32, ptr @nthreads_SHARED, align 4
  %141 = icmp slt i32 %139, %140
  br i1 %141, label %142, label %156

142:                                              ; preds = %137
  %143 = load i64, ptr @wthread1_offset_SHARED, align 8
  store i64 %143, ptr @wthread1_soffset_SHARED, align 8
  %144 = load i32, ptr %11, align 4
  store i32 %144, ptr @wthread1_fd_SHARED, align 4
  %145 = load ptr, ptr %14, align 8
  %146 = load ptr, ptr %14, align 8
  %147 = call i64 @llvm.objectsize.i64.p0(ptr %146, i1 false, i1 true, i1 false)
  %148 = load i64, ptr @wthread1_offset_SHARED, align 8
  %149 = call i32 (ptr, i64, i32, i64, ptr, ...) @__snprintf_chk(ptr noundef %145, i64 noundef 256, i32 noundef 0, i64 noundef %147, ptr noundef @.str.27, ptr noundef @req_url_SHARED, ptr noundef @req_host_SHARED, ptr noundef @.str.22, i64 noundef %148)
  %150 = load ptr, ptr @wthread1_getstr_SHARED, align 8
  %151 = load ptr, ptr %14, align 8
  %152 = load ptr, ptr @wthread1_getstr_SHARED, align 8
  %153 = call i64 @llvm.objectsize.i64.p0(ptr %152, i1 false, i1 true, i1 false)
  %154 = call ptr @__strncpy_chk(ptr noundef %150, ptr noundef %151, i64 noundef 256, i64 noundef %153) #5
  %155 = call i32 @pthread_create(ptr noundef @wthread1_tid, ptr noundef null, ptr noundef @http_get1, ptr noundef null)
  br label %156

156:                                              ; preds = %142, %137
  %157 = load i32, ptr %10, align 4
  %158 = add nsw i32 %157, 1
  store i32 %158, ptr %10, align 4
  %159 = load i32, ptr %10, align 4
  %160 = load i32, ptr @nthreads_SHARED, align 4
  %161 = icmp slt i32 %159, %160
  br i1 %161, label %162, label %176

162:                                              ; preds = %156
  %163 = load i64, ptr @wthread2_offset_SHARED, align 8
  store i64 %163, ptr @wthread2_soffset_SHARED, align 8
  %164 = load i32, ptr %11, align 4
  store i32 %164, ptr @wthread2_fd_SHARED, align 4
  %165 = load ptr, ptr %14, align 8
  %166 = load ptr, ptr %14, align 8
  %167 = call i64 @llvm.objectsize.i64.p0(ptr %166, i1 false, i1 true, i1 false)
  %168 = load i64, ptr @wthread2_offset_SHARED, align 8
  %169 = call i32 (ptr, i64, i32, i64, ptr, ...) @__snprintf_chk(ptr noundef %165, i64 noundef 256, i32 noundef 0, i64 noundef %167, ptr noundef @.str.27, ptr noundef @req_url_SHARED, ptr noundef @req_host_SHARED, ptr noundef @.str.22, i64 noundef %168)
  %170 = load ptr, ptr @wthread2_getstr_SHARED, align 8
  %171 = load ptr, ptr %14, align 8
  %172 = load ptr, ptr @wthread2_getstr_SHARED, align 8
  %173 = call i64 @llvm.objectsize.i64.p0(ptr %172, i1 false, i1 true, i1 false)
  %174 = call ptr @__strncpy_chk(ptr noundef %170, ptr noundef %171, i64 noundef 256, i64 noundef %173) #5
  %175 = call i32 @pthread_create(ptr noundef @wthread2_tid, ptr noundef null, ptr noundef @http_get2, ptr noundef null)
  br label %176

176:                                              ; preds = %162, %156
  %177 = load i32, ptr %10, align 4
  %178 = add nsw i32 %177, 1
  store i32 %178, ptr %10, align 4
  store i32 0, ptr %10, align 4
  %179 = load i32, ptr %10, align 4
  %180 = load i32, ptr @nthreads_SHARED, align 4
  %181 = icmp slt i32 %179, %180
  br i1 %181, label %182, label %185

182:                                              ; preds = %176
  %183 = load ptr, ptr @wthread1_tid, align 8
  %184 = call i32 @"\01_pthread_join"(ptr noundef %183, ptr noundef null)
  br label %185

185:                                              ; preds = %182, %176
  %186 = load i32, ptr %10, align 4
  %187 = add nsw i32 %186, 1
  store i32 %187, ptr %10, align 4
  %188 = load i32, ptr %10, align 4
  %189 = load i32, ptr @nthreads_SHARED, align 4
  %190 = icmp slt i32 %188, %189
  br i1 %190, label %191, label %194

191:                                              ; preds = %185
  %192 = load ptr, ptr @wthread2_tid, align 8
  %193 = call i32 @"\01_pthread_join"(ptr noundef %192, ptr noundef null)
  br label %194

194:                                              ; preds = %191, %185
  %195 = load i32, ptr %10, align 4
  %196 = add nsw i32 %195, 1
  store i32 %196, ptr %10, align 4
  store i32 0, ptr %10, align 4
  %197 = load i32, ptr %10, align 4
  %198 = load i32, ptr @nthreads_SHARED, align 4
  %199 = icmp slt i32 %197, %198
  br i1 %199, label %200, label %210

200:                                              ; preds = %194
  %201 = load ptr, ptr @wthread1_tid, align 8
  %202 = call i32 @"\01_pthread_join"(ptr noundef %201, ptr noundef null)
  %203 = load i8, ptr @wthread1_status_SHARED, align 1
  %204 = zext i8 %203 to i32
  %205 = icmp eq i32 %204, 255
  br i1 %205, label %206, label %209

206:                                              ; preds = %200
  %207 = load i32, ptr %13, align 4
  %208 = add nsw i32 %207, 1
  store i32 %208, ptr %13, align 4
  br label %209

209:                                              ; preds = %206, %200
  br label %210

210:                                              ; preds = %209, %194
  %211 = load i32, ptr %10, align 4
  %212 = add nsw i32 %211, 1
  store i32 %212, ptr %10, align 4
  %213 = load i32, ptr %10, align 4
  %214 = load i32, ptr @nthreads_SHARED, align 4
  %215 = icmp slt i32 %213, %214
  br i1 %215, label %216, label %226

216:                                              ; preds = %210
  %217 = load ptr, ptr @wthread2_tid, align 8
  %218 = call i32 @"\01_pthread_join"(ptr noundef %217, ptr noundef null)
  %219 = load i8, ptr @wthread2_status_SHARED, align 1
  %220 = zext i8 %219 to i32
  %221 = icmp eq i32 %220, 255
  br i1 %221, label %222, label %225

222:                                              ; preds = %216
  %223 = load i32, ptr %13, align 4
  %224 = add nsw i32 %223, 1
  store i32 %224, ptr %13, align 4
  br label %225

225:                                              ; preds = %222, %216
  br label %226

226:                                              ; preds = %225, %210
  %227 = load i32, ptr %13, align 4
  %228 = load i32, ptr @nthreads_SHARED, align 4
  %229 = icmp eq i32 %227, %228
  br i1 %229, label %230, label %233

230:                                              ; preds = %226
  %231 = load ptr, ptr @hthread, align 8
  %232 = call i32 @"\01_pthread_cancel"(ptr noundef %231)
  br label %236

233:                                              ; preds = %226
  %234 = load ptr, ptr @hthread, align 8
  %235 = call i32 @"\01_pthread_join"(ptr noundef %234, ptr noundef null)
  br label %236

236:                                              ; preds = %233, %230
  %237 = call i64 @time(ptr noundef @t_finish_SHARED)
  %238 = load i64, ptr @t_finish_SHARED, align 8
  %239 = load i64, ptr @t_start_SHARED, align 8
  %240 = sub nsw i64 %238, %239
  %241 = trunc i64 %240 to i32
  store i32 %241, ptr %12, align 4
  %242 = icmp eq i32 %241, 0
  br i1 %242, label %243, label %244

243:                                              ; preds = %236
  store i32 1, ptr %12, align 4
  br label %244

244:                                              ; preds = %243, %236
  %245 = load i32, ptr %12, align 4
  %246 = load i32, ptr @req_clength_SHARED, align 4
  %247 = load i32, ptr @hist_data_bwritten_SHARED, align 4
  %248 = sub nsw i32 %246, %247
  %249 = load i32, ptr %12, align 4
  %250 = sdiv i32 %248, %249
  %251 = sdiv i32 %250, 1024
  %252 = call i32 (ptr, ...) @printf(ptr noundef @.str.28, i32 noundef %245, i32 noundef %251)
  %253 = call i32 (ptr, ...) @printf(ptr noundef @.str.29)
  %254 = load i32, ptr %11, align 4
  %255 = call i32 @"\01_close"(i32 noundef %254)
  br label %468

256:                                              ; preds = %109
  store i32 0, ptr %21, align 4
  %257 = load i32, ptr @fsuggested_SHARED, align 4
  %258 = icmp eq i32 %257, 0
  br i1 %258, label %259, label %266

259:                                              ; preds = %256
  %260 = load i32, ptr %18, align 4
  %261 = icmp eq i32 %260, 0
  br i1 %261, label %262, label %263

262:                                              ; preds = %259
  store i32 1, ptr @nthreads_SHARED, align 4
  br label %265

263:                                              ; preds = %259
  %264 = load i32, ptr %18, align 4
  store i32 %264, ptr @nthreads_SHARED, align 4
  br label %265

265:                                              ; preds = %263, %262
  br label %266

266:                                              ; preds = %265, %256
  %267 = load i32, ptr @req_clength_SHARED, align 4
  %268 = load i32, ptr @req_port_SHARED, align 4
  %269 = load i32, ptr @nthreads_SHARED, align 4
  %270 = call i32 (ptr, ...) @printf(ptr noundef @.str.30, ptr noundef @req_url_SHARED, i32 noundef %267, ptr noundef @req_host_SHARED, ptr noundef @req_ip_SHARED, i32 noundef %268, i32 noundef %269)
  %271 = call i64 @strlen(ptr noundef @req_lfile_SHARED) #5
  %272 = icmp ne i64 %271, 0
  br i1 %272, label %273, label %282

273:                                              ; preds = %266
  %274 = call i32 (ptr, i32, ...) @"\01_open"(ptr noundef @req_lfile_SHARED, i32 noundef 514, i32 noundef 448)
  store i32 %274, ptr %19, align 4
  %275 = icmp eq i32 %274, -1
  br i1 %275, label %276, label %281

276:                                              ; preds = %273
  %277 = load ptr, ptr @__stderrp, align 8
  %278 = load i32, ptr @errno_SHARED, align 4
  %279 = call ptr @"\01_strerror"(i32 noundef %278)
  %280 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %277, ptr noundef @.str.26, ptr noundef @req_lfile_SHARED, ptr noundef %279) #5
  call void @exit(i32 noundef 1) #6
  unreachable

281:                                              ; preds = %273
  br label %291

282:                                              ; preds = %266
  %283 = call i32 (ptr, i32, ...) @"\01_open"(ptr noundef @req_file_SHARED, i32 noundef 514, i32 noundef 448)
  store i32 %283, ptr %19, align 4
  %284 = icmp eq i32 %283, -1
  br i1 %284, label %285, label %290

285:                                              ; preds = %282
  %286 = load ptr, ptr @__stderrp, align 8
  %287 = load i32, ptr @errno_SHARED, align 4
  %288 = call ptr @"\01_strerror"(i32 noundef %287)
  %289 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %286, ptr noundef @.str.26, ptr noundef @req_lfile_SHARED, ptr noundef %288) #5
  call void @exit(i32 noundef 1) #6
  unreachable

290:                                              ; preds = %282
  br label %291

291:                                              ; preds = %290, %281
  %292 = load i32, ptr %19, align 4
  %293 = load i32, ptr @req_clength_SHARED, align 4
  %294 = sub nsw i32 %293, 1
  %295 = sext i32 %294 to i64
  %296 = call i64 @lseek(i32 noundef %292, i64 noundef %295, i32 noundef 0)
  %297 = icmp eq i64 %296, -1
  br i1 %297, label %298, label %303

298:                                              ; preds = %291
  %299 = load ptr, ptr @__stderrp, align 8
  %300 = load i32, ptr @errno_SHARED, align 4
  %301 = call ptr @"\01_strerror"(i32 noundef %300)
  %302 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %299, ptr noundef @.str.31, ptr noundef %301) #5
  call void @exit(i32 noundef 1) #6
  unreachable

303:                                              ; preds = %291
  %304 = load i32, ptr %19, align 4
  %305 = call i64 @"\01_write"(i32 noundef %304, ptr noundef @.str.32, i64 noundef 1)
  %306 = icmp eq i64 %305, -1
  br i1 %306, label %307, label %312

307:                                              ; preds = %303
  %308 = load ptr, ptr @__stderrp, align 8
  %309 = load i32, ptr @errno_SHARED, align 4
  %310 = call ptr @"\01_strerror"(i32 noundef %309)
  %311 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %308, ptr noundef @.str.33, ptr noundef %310) #5
  call void @exit(i32 noundef 1) #6
  unreachable

312:                                              ; preds = %303
  store ptr @.str.7, ptr %24, align 8
  %313 = call i64 @time(ptr noundef @t_start_SHARED)
  store i32 0, ptr %17, align 4
  %314 = load i32, ptr %17, align 4
  %315 = load i32, ptr @nthreads_SHARED, align 4
  %316 = icmp slt i32 %314, %315
  br i1 %316, label %317, label %363

317:                                              ; preds = %312
  %318 = load i32, ptr @req_clength_SHARED, align 4
  store i32 %318, ptr %25, align 4
  %319 = load i32, ptr %17, align 4
  store i32 %319, ptr %26, align 4
  %320 = load i32, ptr @nthreads_SHARED, align 4
  store i32 %320, ptr %27, align 4
  %321 = load i32, ptr %26, align 4
  %322 = load i32, ptr %25, align 4
  %323 = load i32, ptr %27, align 4
  %324 = sdiv i32 %322, %323
  %325 = mul nsw i32 %321, %324
  %326 = sext i32 %325 to i64
  store i64 %326, ptr %22, align 8
  %327 = load i32, ptr @req_clength_SHARED, align 4
  store i32 %327, ptr %25, align 4
  %328 = load i32, ptr %17, align 4
  store i32 %328, ptr %26, align 4
  %329 = load i32, ptr @nthreads_SHARED, align 4
  store i32 %329, ptr %27, align 4
  %330 = load i32, ptr %26, align 4
  %331 = load i32, ptr %25, align 4
  %332 = load i32, ptr %27, align 4
  %333 = sdiv i32 %331, %332
  %334 = mul nsw i32 %330, %333
  %335 = sext i32 %334 to i64
  store i64 %335, ptr %23, align 8
  %336 = load i64, ptr %22, align 8
  store i64 %336, ptr @wthread3_soffset_SHARED, align 8
  %337 = load i32, ptr %17, align 4
  %338 = load i32, ptr @nthreads_SHARED, align 4
  %339 = sub nsw i32 %338, 1
  %340 = icmp eq i32 %337, %339
  br i1 %340, label %341, label %344

341:                                              ; preds = %317
  %342 = load i32, ptr @req_clength_SHARED, align 4
  %343 = sext i32 %342 to i64
  br label %346

344:                                              ; preds = %317
  %345 = load i64, ptr %23, align 8
  br label %346

346:                                              ; preds = %344, %341
  %347 = phi i64 [ %343, %341 ], [ %345, %344 ]
  store i64 %347, ptr @wthread3_foffset_SHARED, align 8
  %348 = load i32, ptr %19, align 4
  %349 = call i32 @dup(i32 noundef %348)
  store i32 %349, ptr @wthread3_fd_SHARED, align 4
  %350 = load i32, ptr @req_clength_SHARED, align 4
  %351 = sext i32 %350 to i64
  store i64 %351, ptr @wthread3_clength_SHARED, align 8
  %352 = load ptr, ptr %24, align 8
  %353 = load ptr, ptr %24, align 8
  %354 = call i64 @llvm.objectsize.i64.p0(ptr %353, i1 false, i1 true, i1 false)
  %355 = load i64, ptr %22, align 8
  %356 = call i32 (ptr, i64, i32, i64, ptr, ...) @__snprintf_chk(ptr noundef %352, i64 noundef 256, i32 noundef 0, i64 noundef %354, ptr noundef @.str.27, ptr noundef @req_url_SHARED, ptr noundef @req_host_SHARED, ptr noundef @.str.22, i64 noundef %355)
  %357 = load ptr, ptr @wthread3_getstr_SHARED, align 8
  %358 = load ptr, ptr %24, align 8
  %359 = load ptr, ptr @wthread3_getstr_SHARED, align 8
  %360 = call i64 @llvm.objectsize.i64.p0(ptr %359, i1 false, i1 true, i1 false)
  %361 = call ptr @__strncpy_chk(ptr noundef %357, ptr noundef %358, i64 noundef 256, i64 noundef %360) #5
  %362 = call i32 @pthread_create(ptr noundef @wthread3_tid, ptr noundef null, ptr noundef @http_get3, ptr noundef null)
  br label %363

363:                                              ; preds = %346, %312
  %364 = load i32, ptr %17, align 4
  %365 = add nsw i32 %364, 1
  store i32 %365, ptr %17, align 4
  %366 = load i32, ptr %17, align 4
  %367 = load i32, ptr @nthreads_SHARED, align 4
  %368 = icmp slt i32 %366, %367
  br i1 %368, label %369, label %415

369:                                              ; preds = %363
  %370 = load i32, ptr @req_clength_SHARED, align 4
  store i32 %370, ptr %28, align 4
  %371 = load i32, ptr %17, align 4
  store i32 %371, ptr %29, align 4
  %372 = load i32, ptr @nthreads_SHARED, align 4
  store i32 %372, ptr %30, align 4
  %373 = load i32, ptr %29, align 4
  %374 = load i32, ptr %28, align 4
  %375 = load i32, ptr %30, align 4
  %376 = sdiv i32 %374, %375
  %377 = mul nsw i32 %373, %376
  %378 = sext i32 %377 to i64
  store i64 %378, ptr %22, align 8
  %379 = load i32, ptr @req_clength_SHARED, align 4
  store i32 %379, ptr %28, align 4
  %380 = load i32, ptr %17, align 4
  store i32 %380, ptr %29, align 4
  %381 = load i32, ptr @nthreads_SHARED, align 4
  store i32 %381, ptr %30, align 4
  %382 = load i32, ptr %29, align 4
  %383 = load i32, ptr %28, align 4
  %384 = load i32, ptr %30, align 4
  %385 = sdiv i32 %383, %384
  %386 = mul nsw i32 %382, %385
  %387 = sext i32 %386 to i64
  store i64 %387, ptr %23, align 8
  %388 = load i64, ptr %22, align 8
  store i64 %388, ptr @wthread4_soffset_SHARED, align 8
  %389 = load i32, ptr %17, align 4
  %390 = load i32, ptr @nthreads_SHARED, align 4
  %391 = sub nsw i32 %390, 1
  %392 = icmp eq i32 %389, %391
  br i1 %392, label %393, label %396

393:                                              ; preds = %369
  %394 = load i32, ptr @req_clength_SHARED, align 4
  %395 = sext i32 %394 to i64
  br label %398

396:                                              ; preds = %369
  %397 = load i64, ptr %23, align 8
  br label %398

398:                                              ; preds = %396, %393
  %399 = phi i64 [ %395, %393 ], [ %397, %396 ]
  store i64 %399, ptr @wthread4_foffset_SHARED, align 8
  %400 = load i32, ptr %19, align 4
  %401 = call i32 @dup(i32 noundef %400)
  store i32 %401, ptr @wthread4_fd_SHARED, align 4
  %402 = load i32, ptr @req_clength_SHARED, align 4
  %403 = sext i32 %402 to i64
  store i64 %403, ptr @wthread4_clength_SHARED, align 8
  %404 = load ptr, ptr %24, align 8
  %405 = load ptr, ptr %24, align 8
  %406 = call i64 @llvm.objectsize.i64.p0(ptr %405, i1 false, i1 true, i1 false)
  %407 = load i64, ptr %22, align 8
  %408 = call i32 (ptr, i64, i32, i64, ptr, ...) @__snprintf_chk(ptr noundef %404, i64 noundef 256, i32 noundef 0, i64 noundef %406, ptr noundef @.str.27, ptr noundef @req_url_SHARED, ptr noundef @req_host_SHARED, ptr noundef @.str.22, i64 noundef %407)
  %409 = load ptr, ptr @wthread4_getstr_SHARED, align 8
  %410 = load ptr, ptr %24, align 8
  %411 = load ptr, ptr @wthread4_getstr_SHARED, align 8
  %412 = call i64 @llvm.objectsize.i64.p0(ptr %411, i1 false, i1 true, i1 false)
  %413 = call ptr @__strncpy_chk(ptr noundef %409, ptr noundef %410, i64 noundef 256, i64 noundef %412) #5
  %414 = call i32 @pthread_create(ptr noundef @wthread4_tid, ptr noundef null, ptr noundef @http_get4, ptr noundef null)
  br label %415

415:                                              ; preds = %398, %363
  %416 = load i32, ptr %17, align 4
  %417 = add nsw i32 %416, 1
  store i32 %417, ptr %17, align 4
  %418 = load ptr, ptr %24, align 8
  call void @free(ptr noundef %418)
  store i32 0, ptr %17, align 4
  %419 = load i32, ptr %17, align 4
  %420 = load i32, ptr @nthreads_SHARED, align 4
  %421 = icmp slt i32 %419, %420
  br i1 %421, label %422, label %432

422:                                              ; preds = %415
  %423 = load ptr, ptr @wthread3_tid, align 8
  %424 = call i32 @"\01_pthread_join"(ptr noundef %423, ptr noundef null)
  %425 = load i8, ptr @wthread3_status_SHARED, align 1
  %426 = zext i8 %425 to i32
  %427 = icmp eq i32 %426, 255
  br i1 %427, label %428, label %431

428:                                              ; preds = %422
  %429 = load i32, ptr %21, align 4
  %430 = add nsw i32 %429, 1
  store i32 %430, ptr %21, align 4
  br label %431

431:                                              ; preds = %428, %422
  br label %432

432:                                              ; preds = %431, %415
  %433 = load i32, ptr %17, align 4
  %434 = add nsw i32 %433, 1
  store i32 %434, ptr %17, align 4
  %435 = load i32, ptr %17, align 4
  %436 = load i32, ptr @nthreads_SHARED, align 4
  %437 = icmp slt i32 %435, %436
  br i1 %437, label %438, label %448

438:                                              ; preds = %432
  %439 = load ptr, ptr @wthread4_tid, align 8
  %440 = call i32 @"\01_pthread_join"(ptr noundef %439, ptr noundef null)
  %441 = load i8, ptr @wthread4_status_SHARED, align 1
  %442 = zext i8 %441 to i32
  %443 = icmp eq i32 %442, 255
  br i1 %443, label %444, label %447

444:                                              ; preds = %438
  %445 = load i32, ptr %21, align 4
  %446 = add nsw i32 %445, 1
  store i32 %446, ptr %21, align 4
  br label %447

447:                                              ; preds = %444, %438
  br label %448

448:                                              ; preds = %447, %432
  %449 = load i32, ptr %17, align 4
  %450 = add nsw i32 %449, 1
  store i32 %450, ptr %17, align 4
  %451 = call i64 @time(ptr noundef @t_finish_SHARED)
  %452 = load i64, ptr @t_finish_SHARED, align 8
  %453 = load i64, ptr @t_start_SHARED, align 8
  %454 = sub nsw i64 %452, %453
  %455 = trunc i64 %454 to i32
  store i32 %455, ptr %20, align 4
  %456 = icmp eq i32 %455, 0
  br i1 %456, label %457, label %458

457:                                              ; preds = %448
  store i32 1, ptr %20, align 4
  br label %458

458:                                              ; preds = %457, %448
  %459 = load i32, ptr %20, align 4
  %460 = load i32, ptr @req_clength_SHARED, align 4
  %461 = load i32, ptr %20, align 4
  %462 = sdiv i32 %460, %461
  %463 = sdiv i32 %462, 1024
  %464 = call i32 (ptr, ...) @printf(ptr noundef @.str.28, i32 noundef %459, i32 noundef %463)
  %465 = call i32 (ptr, ...) @printf(ptr noundef @.str.29)
  %466 = load i32, ptr %19, align 4
  %467 = call i32 @"\01_close"(i32 noundef %466)
  br label %468

468:                                              ; preds = %458, %244
  ret i32 0
}

declare i32 @pthread_mutex_init(ptr noundef, ptr noundef) #1

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

declare i32 @"\01_getopt"(i32 noundef, ptr noundef, ptr noundef) #1

declare i32 @atoi(ptr noundef) #1

; Function Attrs: nounwind
declare ptr @__strncpy_chk(ptr noundef, ptr noundef, i64 noundef, i64 noundef) #2

; Function Attrs: nounwind
declare ptr @strdup(ptr noundef) #2

declare i32 @"\01_open"(ptr noundef, i32 noundef, ...) #1

declare i64 @time(ptr noundef) #1

declare i32 @"\01_pthread_join"(ptr noundef, ptr noundef) #1

declare i32 @"\01_pthread_cancel"(ptr noundef) #1

declare i64 @lseek(i32 noundef, i64 noundef, i32 noundef) #1

declare i64 @"\01_write"(i32 noundef, ptr noundef, i64 noundef) #1

declare i32 @dup(i32 noundef) #1

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #2 = { nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { noreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #5 = { nounwind }
attributes #6 = { noreturn }

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
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}
!23 = distinct !{!23, !7}
!24 = distinct !{!24, !7}
!25 = distinct !{!25, !7}
