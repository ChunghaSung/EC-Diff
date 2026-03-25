; ModuleID = 'main1.c'
source_filename = "main1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }
%struct._opaque_pthread_cond_t = type { i64, [40 x i8] }
%struct.stat = type { i32, i16, i16, i64, i32, i32, i32, %struct.timespec, %struct.timespec, %struct.timespec, %struct.timespec, i64, i64, i32, i32, i32, i32, [2 x i64] }
%struct.timespec = type { i64, i64 }
%struct.rlimit = type { i64, i64 }

@.str = private unnamed_addr constant [7 x i8] c"pfscan\00", align 1
@argv0_SHARED = global ptr @.str, align 8
@max_depth_SHARED = global i32 64, align 4
@rstr_SHARED = global ptr null, align 8
@rlen_SHARED = global i32 0, align 4
@debug_SHARED = global i32 0, align 4
@verbose_SHARED = global i32 0, align 4
@nworkers_SHARED = global i32 0, align 4
@aworkers_SHARED = global i32 0, align 4
@line_f_SHARED = global i32 0, align 4
@maxlen_SHARED = global i32 64, align 4
@ignore_case_SHARED = global i32 0, align 4
@n_matches_SHARED = global i32 0, align 4
@n_files_SHARED = global i32 0, align 4
@n_bytes_SHARED = global i64 0, align 8
@version_SHARED = global [4 x i8] c"1.0\00", align 1
@q_mtx = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@q_occupied_SHARED = common global i32 0, align 4
@q_closed_SHARED = common global i32 0, align 4
@q_more = common global %struct._opaque_pthread_cond_t zeroinitializer, align 8
@q_buf_SHARED = common global ptr null, align 8
@q_nextout_SHARED = common global i32 0, align 4
@q_qsize_SHARED = common global i32 0, align 4
@q_less = common global %struct._opaque_pthread_cond_t zeroinitializer, align 8
@print_lock = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@__stderrp = external global ptr, align 8
@.str.1 = private unnamed_addr constant [30 x i8] c"%s : ERR : open() failed: %s\0A\00", align 1
@.str.2 = private unnamed_addr constant [31 x i8] c"%s : ERR : fstat() failed: %s\0A\00", align 1
@.str.3 = private unnamed_addr constant [34 x i8] c"*** Scanning file %s (%u Mbytes)\0A\00", align 1
@.str.4 = private unnamed_addr constant [30 x i8] c"%s : ERR : mmap() failed: %s\0A\00", align 1
@.str.5 = private unnamed_addr constant [10 x i8] c"%s : 0 : \00", align 1
@.str.6 = private unnamed_addr constant [5 x i8] c"NULL\00", align 1
@.str.7 = private unnamed_addr constant [7 x i8] c"TXT : \00", align 1
@.str.8 = private unnamed_addr constant [3 x i8] c"\\0\00", align 1
@.str.9 = private unnamed_addr constant [3 x i8] c"\\n\00", align 1
@.str.10 = private unnamed_addr constant [3 x i8] c"\\r\00", align 1
@.str.11 = private unnamed_addr constant [3 x i8] c"\\t\00", align 1
@.str.12 = private unnamed_addr constant [7 x i8] c"\\x%02x\00", align 1
@.str.13 = private unnamed_addr constant [6 x i8] c"HEX :\00", align 1
@.str.14 = private unnamed_addr constant [6 x i8] c" %02x\00", align 1
@__stdoutp = external global ptr, align 8
@happen_SHARED = common global i32 0, align 4
@aworker_lock = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@aworker_cv = common global %struct._opaque_pthread_cond_t zeroinitializer, align 8
@.str.15 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@matches_lock = common global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@.str.16 = private unnamed_addr constant [30 x i8] c"[PFScan, version %s - %s %s]\0A\00", align 1
@.str.17 = private unnamed_addr constant [12 x i8] c"Mar 24 2026\00", align 1
@.str.18 = private unnamed_addr constant [9 x i8] c"22:26:50\00", align 1
@.str.19 = private unnamed_addr constant [69 x i8] c"Usage: %s [<options>] <search-string> <pathname> [... <pathname-N>]\0A\00", align 1
@.str.20 = private unnamed_addr constant [352 x i8] c"\0A                                        This program implements a multithreaded file scanner.\0A                                        More information may be found at:\0A                                        \09http://www.lysator.liu.se/~pen/pfscan\0A                                        \0A                                        Command line options:\0A\00", align 1
@.str.21 = private unnamed_addr constant [43 x i8] c"\09-h             Display this information.\0A\00", align 1
@.str.22 = private unnamed_addr constant [32 x i8] c"\09-V             Print version.\0A\00", align 1
@.str.23 = private unnamed_addr constant [29 x i8] c"\09-v             Be verbose.\0A\00", align 1
@.str.24 = private unnamed_addr constant [39 x i8] c"\09-d             Print debugging info.\0A\00", align 1
@.str.25 = private unnamed_addr constant [44 x i8] c"\09-i             Ignore case when scanning.\0A\00", align 1
@.str.26 = private unnamed_addr constant [39 x i8] c"\09-l             Line oriented output.\0A\00", align 1
@.str.27 = private unnamed_addr constant [50 x i8] c"\09-n<workers>    Concurrent worker threads limit.\0A\00", align 1
@.str.28 = private unnamed_addr constant [47 x i8] c"\09-L<length>     Max length of bytes to print.\0A\00", align 1
@.str.29 = private unnamed_addr constant [3 x i8] c"%u\00", align 1
@.str.30 = private unnamed_addr constant [38 x i8] c"%s: Invalid length specification: %s\0A\00", align 1
@.str.31 = private unnamed_addr constant [7 x i8] c"<null>\00", align 1
@.str.32 = private unnamed_addr constant [39 x i8] c"%s: Invalid workers specification: %s\0A\00", align 1
@.str.33 = private unnamed_addr constant [38 x i8] c"%s: unknown command line switch: -%c\0A\00", align 1
@bmb_icase_SHARED = common global i32 0, align 4
@bmb_bmGs_SHARED = common global ptr null, align 8
@bmb_saved_m_SHARED = common global i32 0, align 4
@bmb_saved_x_SHARED = common global ptr null, align 8
@main.preBmGs_ret = internal global i32 0, align 4
@bmb_bmBc_SHARED = common global [256 x i32] zeroinitializer, align 4
@.str.34 = private unnamed_addr constant [36 x i8] c"%s: Failed search string setup: %s\0A\00", align 1
@.str.35 = private unnamed_addr constant [31 x i8] c"max_depth = %d, nworkers = %d\0A\00", align 1
@q_nextin_SHARED = common global i32 0, align 4
@.str.36 = private unnamed_addr constant [34 x i8] c"Waiting for workers to finish...\0A\00", align 1
@.str.37 = private unnamed_addr constant [61 x i8] c"n_files = %d, n_matches = %d, n_workers = %d, n_Mbytes = %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @nop1() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @worker1(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  %9 = alloca %struct.stat, align 8
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca i32, align 4
  %15 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %4, align 4
  %16 = call i32 @pthread_mutex_lock(ptr noundef @q_mtx)
  %17 = load i32, ptr @q_occupied_SHARED, align 4
  %18 = icmp sle i32 %17, 0
  br i1 %18, label %19, label %24

19:                                               ; preds = %1
  %20 = load i32, ptr @q_closed_SHARED, align 4
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %24, label %22

22:                                               ; preds = %19
  %23 = call i32 @"\01_pthread_cond_wait"(ptr noundef @q_more, ptr noundef @q_mtx)
  br label %24

24:                                               ; preds = %22, %19, %1
  %25 = load i32, ptr @q_occupied_SHARED, align 4
  %26 = icmp sgt i32 %25, 0
  br i1 %26, label %27, label %41

27:                                               ; preds = %24
  %28 = load ptr, ptr @q_buf_SHARED, align 8
  %29 = load i32, ptr @q_nextout_SHARED, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr @q_nextout_SHARED, align 4
  %31 = sext i32 %29 to i64
  %32 = getelementptr inbounds ptr, ptr %28, i64 %31
  %33 = load ptr, ptr %32, align 8
  store ptr %33, ptr %3, align 8
  %34 = load i32, ptr @q_qsize_SHARED, align 4
  %35 = load i32, ptr @q_nextout_SHARED, align 4
  %36 = srem i32 %35, %34
  store i32 %36, ptr @q_nextout_SHARED, align 4
  %37 = load i32, ptr @q_occupied_SHARED, align 4
  %38 = add nsw i32 %37, -1
  store i32 %38, ptr @q_occupied_SHARED, align 4
  store i32 1, ptr %4, align 4
  %39 = call i32 @pthread_mutex_unlock(ptr noundef @q_mtx)
  %40 = call i32 @pthread_cond_signal(ptr noundef @q_less)
  br label %43

41:                                               ; preds = %24
  %42 = call i32 @pthread_mutex_unlock(ptr noundef @q_mtx)
  br label %43

43:                                               ; preds = %41, %27
  %44 = load i32, ptr %4, align 4
  %45 = icmp eq i32 %44, 1
  br i1 %45, label %46, label %270

46:                                               ; preds = %43
  %47 = load ptr, ptr %3, align 8
  store ptr %47, ptr %5, align 8
  %48 = load ptr, ptr %5, align 8
  %49 = call i32 (ptr, i32, ...) @"\01_open"(ptr noundef %48, i32 noundef 0)
  store i32 %49, ptr %6, align 4
  %50 = load i32, ptr %6, align 4
  %51 = icmp slt i32 %50, 0
  br i1 %51, label %52, label %65

52:                                               ; preds = %46
  %53 = load i32, ptr @verbose_SHARED, align 4
  %54 = icmp ne i32 %53, 0
  br i1 %54, label %55, label %64

55:                                               ; preds = %52
  %56 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %57 = load ptr, ptr @__stderrp, align 8
  %58 = load ptr, ptr %5, align 8
  %59 = call ptr @__error()
  %60 = load i32, ptr %59, align 4
  %61 = call ptr @"\01_strerror"(i32 noundef %60)
  %62 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %57, ptr noundef @.str.1, ptr noundef %58, ptr noundef %61) #8
  %63 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %64

64:                                               ; preds = %55, %52
  br label %268

65:                                               ; preds = %46
  %66 = load i32, ptr %6, align 4
  %67 = call i32 @"\01_fstat"(i32 noundef %66, ptr noundef %9)
  %68 = icmp slt i32 %67, 0
  br i1 %68, label %69, label %84

69:                                               ; preds = %65
  %70 = load i32, ptr @verbose_SHARED, align 4
  %71 = icmp ne i32 %70, 0
  br i1 %71, label %72, label %81

72:                                               ; preds = %69
  %73 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %74 = load ptr, ptr @__stderrp, align 8
  %75 = load ptr, ptr %5, align 8
  %76 = call ptr @__error()
  %77 = load i32, ptr %76, align 4
  %78 = call ptr @"\01_strerror"(i32 noundef %77)
  %79 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %74, ptr noundef @.str.2, ptr noundef %75, ptr noundef %78) #8
  %80 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %81

81:                                               ; preds = %72, %69
  %82 = load i32, ptr %6, align 4
  %83 = call i32 @"\01_close"(i32 noundef %82)
  br label %267

84:                                               ; preds = %65
  %85 = getelementptr inbounds %struct.stat, ptr %9, i32 0, i32 11
  %86 = load i64, ptr %85, align 8
  store i64 %86, ptr %7, align 8
  %87 = load i32, ptr @debug_SHARED, align 4
  %88 = icmp sgt i32 %87, 1
  br i1 %88, label %89, label %96

89:                                               ; preds = %84
  %90 = load ptr, ptr @__stderrp, align 8
  %91 = load ptr, ptr %5, align 8
  %92 = load i64, ptr %7, align 8
  %93 = udiv i64 %92, 1000000
  %94 = trunc i64 %93 to i32
  %95 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %90, ptr noundef @.str.3, ptr noundef %91, i32 noundef %94) #8
  br label %96

96:                                               ; preds = %89, %84
  %97 = load i64, ptr %7, align 8
  %98 = load i32, ptr %6, align 4
  %99 = call ptr @"\01_mmap"(ptr noundef null, i64 noundef %97, i32 noundef 1, i32 noundef 66, i32 noundef %98, i64 noundef 0)
  store ptr %99, ptr %8, align 8
  %100 = load ptr, ptr %8, align 8
  %101 = icmp eq ptr %100, inttoptr (i64 -1 to ptr)
  br i1 %101, label %102, label %117

102:                                              ; preds = %96
  %103 = load i32, ptr @verbose_SHARED, align 4
  %104 = icmp ne i32 %103, 0
  br i1 %104, label %105, label %114

105:                                              ; preds = %102
  %106 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %107 = load ptr, ptr @__stderrp, align 8
  %108 = load ptr, ptr %5, align 8
  %109 = call ptr @__error()
  %110 = load i32, ptr %109, align 4
  %111 = call ptr @"\01_strerror"(i32 noundef %110)
  %112 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %107, ptr noundef @.str.4, ptr noundef %108, ptr noundef %111) #8
  %113 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %114

114:                                              ; preds = %105, %102
  %115 = load i32, ptr %6, align 4
  %116 = call i32 @"\01_close"(i32 noundef %115)
  br label %266

117:                                              ; preds = %96
  %118 = load ptr, ptr @rstr_SHARED, align 8
  %119 = icmp ne ptr %118, null
  br i1 %119, label %120, label %121

120:                                              ; preds = %117
  store i32 0, ptr %10, align 4
  br label %260

121:                                              ; preds = %117
  %122 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %123 = load ptr, ptr %5, align 8
  %124 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, ptr noundef %123)
  %125 = load ptr, ptr %8, align 8
  store ptr %125, ptr %11, align 8
  %126 = load i64, ptr %7, align 8
  store i64 %126, ptr %12, align 8
  store i64 0, ptr %13, align 8
  %127 = load ptr, ptr %11, align 8
  %128 = icmp eq ptr %127, null
  br i1 %128, label %129, label %131

129:                                              ; preds = %121
  %130 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  br label %257

131:                                              ; preds = %121
  %132 = load ptr, ptr %11, align 8
  store ptr %132, ptr %15, align 8
  br label %133

133:                                              ; preds = %166, %131
  %134 = load i64, ptr %12, align 8
  %135 = icmp ugt i64 %134, 0
  br i1 %135, label %136, label %164

136:                                              ; preds = %133
  %137 = load ptr, ptr %15, align 8
  %138 = load i8, ptr %137, align 1
  %139 = zext i8 %138 to i32
  %140 = call i32 @isprint(i32 noundef %139) #9
  %141 = icmp ne i32 %140, 0
  br i1 %141, label %162, label %142

142:                                              ; preds = %136
  %143 = load ptr, ptr %15, align 8
  %144 = load i8, ptr %143, align 1
  %145 = zext i8 %144 to i32
  %146 = icmp eq i32 %145, 0
  br i1 %146, label %162, label %147

147:                                              ; preds = %142
  %148 = load ptr, ptr %15, align 8
  %149 = load i8, ptr %148, align 1
  %150 = zext i8 %149 to i32
  %151 = icmp eq i32 %150, 9
  br i1 %151, label %162, label %152

152:                                              ; preds = %147
  %153 = load ptr, ptr %15, align 8
  %154 = load i8, ptr %153, align 1
  %155 = zext i8 %154 to i32
  %156 = icmp eq i32 %155, 10
  br i1 %156, label %162, label %157

157:                                              ; preds = %152
  %158 = load ptr, ptr %15, align 8
  %159 = load i8, ptr %158, align 1
  %160 = zext i8 %159 to i32
  %161 = icmp eq i32 %160, 13
  br label %162

162:                                              ; preds = %157, %152, %147, %142, %136
  %163 = phi i1 [ true, %152 ], [ true, %147 ], [ true, %142 ], [ true, %136 ], [ %161, %157 ]
  br label %164

164:                                              ; preds = %162, %133
  %165 = phi i1 [ false, %133 ], [ %163, %162 ]
  br i1 %165, label %166, label %171

166:                                              ; preds = %164
  %167 = load i64, ptr %12, align 8
  %168 = add i64 %167, -1
  store i64 %168, ptr %12, align 8
  %169 = load ptr, ptr %15, align 8
  %170 = getelementptr inbounds i8, ptr %169, i32 1
  store ptr %170, ptr %15, align 8
  br label %133, !llvm.loop !6

171:                                              ; preds = %164
  %172 = load i64, ptr %12, align 8
  %173 = icmp eq i64 %172, 0
  %174 = zext i1 %173 to i32
  store i32 %174, ptr %14, align 4
  %175 = load i32, ptr %14, align 4
  %176 = icmp ne i32 %175, 0
  br i1 %176, label %177, label %233

177:                                              ; preds = %171
  %178 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  br label %179

179:                                              ; preds = %227, %177
  %180 = load i64, ptr %7, align 8
  %181 = load i64, ptr %12, align 8
  %182 = icmp ult i64 %180, %181
  br i1 %182, label %183, label %188

183:                                              ; preds = %179
  %184 = load i64, ptr %7, align 8
  %185 = load i32, ptr @maxlen_SHARED, align 4
  %186 = sext i32 %185 to i64
  %187 = icmp ult i64 %184, %186
  br label %188

188:                                              ; preds = %183, %179
  %189 = phi i1 [ false, %179 ], [ %187, %183 ]
  br i1 %189, label %190, label %232

190:                                              ; preds = %188
  %191 = load ptr, ptr %11, align 8
  %192 = load i8, ptr %191, align 1
  %193 = zext i8 %192 to i32
  %194 = call i32 @isprint(i32 noundef %193) #9
  %195 = icmp ne i32 %194, 0
  br i1 %195, label %196, label %201

196:                                              ; preds = %190
  %197 = load ptr, ptr %11, align 8
  %198 = load i8, ptr %197, align 1
  %199 = zext i8 %198 to i32
  %200 = call i32 @putchar(i32 noundef %199)
  br label %227

201:                                              ; preds = %190
  %202 = load ptr, ptr %11, align 8
  %203 = load i8, ptr %202, align 1
  %204 = zext i8 %203 to i32
  switch i32 %204, label %221 [
    i32 0, label %205
    i32 10, label %207
    i32 13, label %213
    i32 9, label %219
  ]

205:                                              ; preds = %201
  %206 = call i32 (ptr, ...) @printf(ptr noundef @.str.8)
  br label %226

207:                                              ; preds = %201
  %208 = load i32, ptr @line_f_SHARED, align 4
  %209 = icmp ne i32 %208, 0
  br i1 %209, label %212, label %210

210:                                              ; preds = %207
  %211 = call i32 (ptr, ...) @printf(ptr noundef @.str.9)
  br label %226

212:                                              ; preds = %207
  br label %213

213:                                              ; preds = %201, %212
  %214 = load i32, ptr @line_f_SHARED, align 4
  %215 = icmp ne i32 %214, 0
  br i1 %215, label %218, label %216

216:                                              ; preds = %213
  %217 = call i32 (ptr, ...) @printf(ptr noundef @.str.10)
  br label %226

218:                                              ; preds = %213
  br label %219

219:                                              ; preds = %201, %218
  %220 = call i32 (ptr, ...) @printf(ptr noundef @.str.11)
  br label %226

221:                                              ; preds = %201
  %222 = load ptr, ptr %11, align 8
  %223 = load i8, ptr %222, align 1
  %224 = zext i8 %223 to i32
  %225 = call i32 (ptr, ...) @printf(ptr noundef @.str.12, i32 noundef %224)
  br label %226

226:                                              ; preds = %221, %219, %216, %210, %205
  br label %227

227:                                              ; preds = %226, %196
  %228 = load i64, ptr %7, align 8
  %229 = add i64 %228, 1
  store i64 %229, ptr %7, align 8
  %230 = load ptr, ptr %11, align 8
  %231 = getelementptr inbounds i8, ptr %230, i32 1
  store ptr %231, ptr %11, align 8
  br label %179, !llvm.loop !8

232:                                              ; preds = %188
  br label %256

233:                                              ; preds = %171
  %234 = call i32 (ptr, ...) @printf(ptr noundef @.str.13)
  br label %235

235:                                              ; preds = %246, %233
  %236 = load i64, ptr %7, align 8
  %237 = load i64, ptr %12, align 8
  %238 = icmp ult i64 %236, %237
  br i1 %238, label %239, label %244

239:                                              ; preds = %235
  %240 = load i64, ptr %7, align 8
  %241 = load i32, ptr @maxlen_SHARED, align 4
  %242 = sext i32 %241 to i64
  %243 = icmp ult i64 %240, %242
  br label %244

244:                                              ; preds = %239, %235
  %245 = phi i1 [ false, %235 ], [ %243, %239 ]
  br i1 %245, label %246, label %255

246:                                              ; preds = %244
  %247 = load ptr, ptr %11, align 8
  %248 = load i8, ptr %247, align 1
  %249 = zext i8 %248 to i32
  %250 = call i32 (ptr, ...) @printf(ptr noundef @.str.14, i32 noundef %249)
  %251 = load i64, ptr %7, align 8
  %252 = add i64 %251, 1
  store i64 %252, ptr %7, align 8
  %253 = load ptr, ptr %11, align 8
  %254 = getelementptr inbounds i8, ptr %253, i32 1
  store ptr %254, ptr %11, align 8
  br label %235, !llvm.loop !9

255:                                              ; preds = %244
  br label %256

256:                                              ; preds = %255, %232
  br label %257

257:                                              ; preds = %256, %129
  %258 = call i32 @putchar(i32 noundef 10)
  %259 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %260

260:                                              ; preds = %257, %120
  %261 = load ptr, ptr %8, align 8
  %262 = load i64, ptr %7, align 8
  %263 = call i32 @"\01_munmap"(ptr noundef %261, i64 noundef %262)
  %264 = load i32, ptr %6, align 4
  %265 = call i32 @"\01_close"(i32 noundef %264)
  br label %266

266:                                              ; preds = %260, %114
  br label %267

267:                                              ; preds = %266, %81
  br label %268

268:                                              ; preds = %267, %64
  %269 = load ptr, ptr %3, align 8
  call void @free(ptr noundef %269)
  br label %270

270:                                              ; preds = %268, %43
  %271 = load ptr, ptr @__stdoutp, align 8
  %272 = call i32 @fflush(ptr noundef %271)
  store i32 1, ptr @happen_SHARED, align 4
  %273 = call i32 @pthread_mutex_lock(ptr noundef @aworker_lock)
  %274 = load i32, ptr @aworkers_SHARED, align 4
  %275 = add nsw i32 %274, -1
  store i32 %275, ptr @aworkers_SHARED, align 4
  %276 = call i32 @pthread_cond_signal(ptr noundef @aworker_cv)
  %277 = call i32 @pthread_mutex_unlock(ptr noundef @aworker_lock)
  ret ptr null
}

declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @"\01_pthread_cond_wait"(ptr noundef, ptr noundef) #1

declare i32 @pthread_mutex_unlock(ptr noundef) #1

declare i32 @pthread_cond_signal(ptr noundef) #1

declare i32 @"\01_open"(ptr noundef, i32 noundef, ...) #1

; Function Attrs: nounwind
declare i32 @fprintf(ptr noundef, ptr noundef, ...) #2

declare ptr @"\01_strerror"(i32 noundef) #1

declare ptr @__error() #1

declare i32 @"\01_fstat"(i32 noundef, ptr noundef) #1

declare i32 @"\01_close"(i32 noundef) #1

declare ptr @"\01_mmap"(ptr noundef, i64 noundef, i32 noundef, i32 noundef, i32 noundef, i64 noundef) #1

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: nounwind willreturn memory(read)
declare i32 @isprint(i32 noundef) #3

declare i32 @putchar(i32 noundef) #1

declare i32 @"\01_munmap"(ptr noundef, i64 noundef) #1

declare void @free(ptr noundef) #1

declare i32 @fflush(ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @worker2(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  %9 = alloca %struct.stat, align 8
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca i32, align 4
  %15 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %4, align 4
  %16 = call i32 @pthread_mutex_lock(ptr noundef @q_mtx)
  %17 = load i32, ptr @q_occupied_SHARED, align 4
  %18 = icmp sle i32 %17, 0
  br i1 %18, label %19, label %24

19:                                               ; preds = %1
  %20 = load i32, ptr @q_closed_SHARED, align 4
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %24, label %22

22:                                               ; preds = %19
  %23 = call i32 @"\01_pthread_cond_wait"(ptr noundef @q_more, ptr noundef @q_mtx)
  br label %24

24:                                               ; preds = %22, %19, %1
  %25 = load i32, ptr @q_occupied_SHARED, align 4
  %26 = icmp sgt i32 %25, 0
  br i1 %26, label %27, label %41

27:                                               ; preds = %24
  %28 = load ptr, ptr @q_buf_SHARED, align 8
  %29 = load i32, ptr @q_nextout_SHARED, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr @q_nextout_SHARED, align 4
  %31 = sext i32 %29 to i64
  %32 = getelementptr inbounds ptr, ptr %28, i64 %31
  %33 = load ptr, ptr %32, align 8
  store ptr %33, ptr %3, align 8
  %34 = load i32, ptr @q_qsize_SHARED, align 4
  %35 = load i32, ptr @q_nextout_SHARED, align 4
  %36 = srem i32 %35, %34
  store i32 %36, ptr @q_nextout_SHARED, align 4
  %37 = load i32, ptr @q_occupied_SHARED, align 4
  %38 = add nsw i32 %37, -1
  store i32 %38, ptr @q_occupied_SHARED, align 4
  store i32 1, ptr %4, align 4
  %39 = call i32 @pthread_mutex_unlock(ptr noundef @q_mtx)
  %40 = call i32 @pthread_cond_signal(ptr noundef @q_less)
  br label %43

41:                                               ; preds = %24
  %42 = call i32 @pthread_mutex_unlock(ptr noundef @q_mtx)
  br label %43

43:                                               ; preds = %41, %27
  %44 = load i32, ptr %4, align 4
  %45 = icmp eq i32 %44, 1
  br i1 %45, label %46, label %270

46:                                               ; preds = %43
  %47 = load ptr, ptr %3, align 8
  store ptr %47, ptr %5, align 8
  %48 = load ptr, ptr %5, align 8
  %49 = call i32 (ptr, i32, ...) @"\01_open"(ptr noundef %48, i32 noundef 0)
  store i32 %49, ptr %6, align 4
  %50 = load i32, ptr %6, align 4
  %51 = icmp slt i32 %50, 0
  br i1 %51, label %52, label %65

52:                                               ; preds = %46
  %53 = load i32, ptr @verbose_SHARED, align 4
  %54 = icmp ne i32 %53, 0
  br i1 %54, label %55, label %64

55:                                               ; preds = %52
  %56 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %57 = load ptr, ptr @__stderrp, align 8
  %58 = load ptr, ptr %5, align 8
  %59 = call ptr @__error()
  %60 = load i32, ptr %59, align 4
  %61 = call ptr @"\01_strerror"(i32 noundef %60)
  %62 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %57, ptr noundef @.str.1, ptr noundef %58, ptr noundef %61) #8
  %63 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %64

64:                                               ; preds = %55, %52
  br label %268

65:                                               ; preds = %46
  %66 = load i32, ptr %6, align 4
  %67 = call i32 @"\01_fstat"(i32 noundef %66, ptr noundef %9)
  %68 = icmp slt i32 %67, 0
  br i1 %68, label %69, label %84

69:                                               ; preds = %65
  %70 = load i32, ptr @verbose_SHARED, align 4
  %71 = icmp ne i32 %70, 0
  br i1 %71, label %72, label %81

72:                                               ; preds = %69
  %73 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %74 = load ptr, ptr @__stderrp, align 8
  %75 = load ptr, ptr %5, align 8
  %76 = call ptr @__error()
  %77 = load i32, ptr %76, align 4
  %78 = call ptr @"\01_strerror"(i32 noundef %77)
  %79 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %74, ptr noundef @.str.2, ptr noundef %75, ptr noundef %78) #8
  %80 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %81

81:                                               ; preds = %72, %69
  %82 = load i32, ptr %6, align 4
  %83 = call i32 @"\01_close"(i32 noundef %82)
  br label %267

84:                                               ; preds = %65
  %85 = getelementptr inbounds %struct.stat, ptr %9, i32 0, i32 11
  %86 = load i64, ptr %85, align 8
  store i64 %86, ptr %7, align 8
  %87 = load i32, ptr @debug_SHARED, align 4
  %88 = icmp sgt i32 %87, 1
  br i1 %88, label %89, label %96

89:                                               ; preds = %84
  %90 = load ptr, ptr @__stderrp, align 8
  %91 = load ptr, ptr %5, align 8
  %92 = load i64, ptr %7, align 8
  %93 = udiv i64 %92, 1000000
  %94 = trunc i64 %93 to i32
  %95 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %90, ptr noundef @.str.3, ptr noundef %91, i32 noundef %94) #8
  br label %96

96:                                               ; preds = %89, %84
  %97 = load i64, ptr %7, align 8
  %98 = load i32, ptr %6, align 4
  %99 = call ptr @"\01_mmap"(ptr noundef null, i64 noundef %97, i32 noundef 1, i32 noundef 66, i32 noundef %98, i64 noundef 0)
  store ptr %99, ptr %8, align 8
  %100 = load ptr, ptr %8, align 8
  %101 = icmp eq ptr %100, inttoptr (i64 -1 to ptr)
  br i1 %101, label %102, label %117

102:                                              ; preds = %96
  %103 = load i32, ptr @verbose_SHARED, align 4
  %104 = icmp ne i32 %103, 0
  br i1 %104, label %105, label %114

105:                                              ; preds = %102
  %106 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %107 = load ptr, ptr @__stderrp, align 8
  %108 = load ptr, ptr %5, align 8
  %109 = call ptr @__error()
  %110 = load i32, ptr %109, align 4
  %111 = call ptr @"\01_strerror"(i32 noundef %110)
  %112 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %107, ptr noundef @.str.4, ptr noundef %108, ptr noundef %111) #8
  %113 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %114

114:                                              ; preds = %105, %102
  %115 = load i32, ptr %6, align 4
  %116 = call i32 @"\01_close"(i32 noundef %115)
  br label %266

117:                                              ; preds = %96
  %118 = load ptr, ptr @rstr_SHARED, align 8
  %119 = icmp ne ptr %118, null
  br i1 %119, label %120, label %121

120:                                              ; preds = %117
  store i32 0, ptr %10, align 4
  br label %260

121:                                              ; preds = %117
  %122 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %123 = load ptr, ptr %5, align 8
  %124 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, ptr noundef %123)
  %125 = load ptr, ptr %8, align 8
  store ptr %125, ptr %11, align 8
  %126 = load i64, ptr %7, align 8
  store i64 %126, ptr %12, align 8
  store i64 0, ptr %13, align 8
  %127 = load ptr, ptr %11, align 8
  %128 = icmp eq ptr %127, null
  br i1 %128, label %129, label %131

129:                                              ; preds = %121
  %130 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  br label %257

131:                                              ; preds = %121
  %132 = load ptr, ptr %11, align 8
  store ptr %132, ptr %15, align 8
  br label %133

133:                                              ; preds = %166, %131
  %134 = load i64, ptr %12, align 8
  %135 = icmp ugt i64 %134, 0
  br i1 %135, label %136, label %164

136:                                              ; preds = %133
  %137 = load ptr, ptr %15, align 8
  %138 = load i8, ptr %137, align 1
  %139 = zext i8 %138 to i32
  %140 = call i32 @isprint(i32 noundef %139) #9
  %141 = icmp ne i32 %140, 0
  br i1 %141, label %162, label %142

142:                                              ; preds = %136
  %143 = load ptr, ptr %15, align 8
  %144 = load i8, ptr %143, align 1
  %145 = zext i8 %144 to i32
  %146 = icmp eq i32 %145, 0
  br i1 %146, label %162, label %147

147:                                              ; preds = %142
  %148 = load ptr, ptr %15, align 8
  %149 = load i8, ptr %148, align 1
  %150 = zext i8 %149 to i32
  %151 = icmp eq i32 %150, 9
  br i1 %151, label %162, label %152

152:                                              ; preds = %147
  %153 = load ptr, ptr %15, align 8
  %154 = load i8, ptr %153, align 1
  %155 = zext i8 %154 to i32
  %156 = icmp eq i32 %155, 10
  br i1 %156, label %162, label %157

157:                                              ; preds = %152
  %158 = load ptr, ptr %15, align 8
  %159 = load i8, ptr %158, align 1
  %160 = zext i8 %159 to i32
  %161 = icmp eq i32 %160, 13
  br label %162

162:                                              ; preds = %157, %152, %147, %142, %136
  %163 = phi i1 [ true, %152 ], [ true, %147 ], [ true, %142 ], [ true, %136 ], [ %161, %157 ]
  br label %164

164:                                              ; preds = %162, %133
  %165 = phi i1 [ false, %133 ], [ %163, %162 ]
  br i1 %165, label %166, label %171

166:                                              ; preds = %164
  %167 = load i64, ptr %12, align 8
  %168 = add i64 %167, -1
  store i64 %168, ptr %12, align 8
  %169 = load ptr, ptr %15, align 8
  %170 = getelementptr inbounds i8, ptr %169, i32 1
  store ptr %170, ptr %15, align 8
  br label %133, !llvm.loop !10

171:                                              ; preds = %164
  %172 = load i64, ptr %12, align 8
  %173 = icmp eq i64 %172, 0
  %174 = zext i1 %173 to i32
  store i32 %174, ptr %14, align 4
  %175 = load i32, ptr %14, align 4
  %176 = icmp ne i32 %175, 0
  br i1 %176, label %177, label %233

177:                                              ; preds = %171
  %178 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  br label %179

179:                                              ; preds = %227, %177
  %180 = load i64, ptr %7, align 8
  %181 = load i64, ptr %12, align 8
  %182 = icmp ult i64 %180, %181
  br i1 %182, label %183, label %188

183:                                              ; preds = %179
  %184 = load i64, ptr %7, align 8
  %185 = load i32, ptr @maxlen_SHARED, align 4
  %186 = sext i32 %185 to i64
  %187 = icmp ult i64 %184, %186
  br label %188

188:                                              ; preds = %183, %179
  %189 = phi i1 [ false, %179 ], [ %187, %183 ]
  br i1 %189, label %190, label %232

190:                                              ; preds = %188
  %191 = load ptr, ptr %11, align 8
  %192 = load i8, ptr %191, align 1
  %193 = zext i8 %192 to i32
  %194 = call i32 @isprint(i32 noundef %193) #9
  %195 = icmp ne i32 %194, 0
  br i1 %195, label %196, label %201

196:                                              ; preds = %190
  %197 = load ptr, ptr %11, align 8
  %198 = load i8, ptr %197, align 1
  %199 = zext i8 %198 to i32
  %200 = call i32 @putchar(i32 noundef %199)
  br label %227

201:                                              ; preds = %190
  %202 = load ptr, ptr %11, align 8
  %203 = load i8, ptr %202, align 1
  %204 = zext i8 %203 to i32
  switch i32 %204, label %221 [
    i32 0, label %205
    i32 10, label %207
    i32 13, label %213
    i32 9, label %219
  ]

205:                                              ; preds = %201
  %206 = call i32 (ptr, ...) @printf(ptr noundef @.str.8)
  br label %226

207:                                              ; preds = %201
  %208 = load i32, ptr @line_f_SHARED, align 4
  %209 = icmp ne i32 %208, 0
  br i1 %209, label %212, label %210

210:                                              ; preds = %207
  %211 = call i32 (ptr, ...) @printf(ptr noundef @.str.9)
  br label %226

212:                                              ; preds = %207
  br label %213

213:                                              ; preds = %201, %212
  %214 = load i32, ptr @line_f_SHARED, align 4
  %215 = icmp ne i32 %214, 0
  br i1 %215, label %218, label %216

216:                                              ; preds = %213
  %217 = call i32 (ptr, ...) @printf(ptr noundef @.str.10)
  br label %226

218:                                              ; preds = %213
  br label %219

219:                                              ; preds = %201, %218
  %220 = call i32 (ptr, ...) @printf(ptr noundef @.str.11)
  br label %226

221:                                              ; preds = %201
  %222 = load ptr, ptr %11, align 8
  %223 = load i8, ptr %222, align 1
  %224 = zext i8 %223 to i32
  %225 = call i32 (ptr, ...) @printf(ptr noundef @.str.12, i32 noundef %224)
  br label %226

226:                                              ; preds = %221, %219, %216, %210, %205
  br label %227

227:                                              ; preds = %226, %196
  %228 = load i64, ptr %7, align 8
  %229 = add i64 %228, 1
  store i64 %229, ptr %7, align 8
  %230 = load ptr, ptr %11, align 8
  %231 = getelementptr inbounds i8, ptr %230, i32 1
  store ptr %231, ptr %11, align 8
  br label %179, !llvm.loop !11

232:                                              ; preds = %188
  br label %256

233:                                              ; preds = %171
  %234 = call i32 (ptr, ...) @printf(ptr noundef @.str.13)
  br label %235

235:                                              ; preds = %246, %233
  %236 = load i64, ptr %7, align 8
  %237 = load i64, ptr %12, align 8
  %238 = icmp ult i64 %236, %237
  br i1 %238, label %239, label %244

239:                                              ; preds = %235
  %240 = load i64, ptr %7, align 8
  %241 = load i32, ptr @maxlen_SHARED, align 4
  %242 = sext i32 %241 to i64
  %243 = icmp ult i64 %240, %242
  br label %244

244:                                              ; preds = %239, %235
  %245 = phi i1 [ false, %235 ], [ %243, %239 ]
  br i1 %245, label %246, label %255

246:                                              ; preds = %244
  %247 = load ptr, ptr %11, align 8
  %248 = load i8, ptr %247, align 1
  %249 = zext i8 %248 to i32
  %250 = call i32 (ptr, ...) @printf(ptr noundef @.str.14, i32 noundef %249)
  %251 = load i64, ptr %7, align 8
  %252 = add i64 %251, 1
  store i64 %252, ptr %7, align 8
  %253 = load ptr, ptr %11, align 8
  %254 = getelementptr inbounds i8, ptr %253, i32 1
  store ptr %254, ptr %11, align 8
  br label %235, !llvm.loop !12

255:                                              ; preds = %244
  br label %256

256:                                              ; preds = %255, %232
  br label %257

257:                                              ; preds = %256, %129
  %258 = call i32 @putchar(i32 noundef 10)
  %259 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %260

260:                                              ; preds = %257, %120
  %261 = load ptr, ptr %8, align 8
  %262 = load i64, ptr %7, align 8
  %263 = call i32 @"\01_munmap"(ptr noundef %261, i64 noundef %262)
  %264 = load i32, ptr %6, align 4
  %265 = call i32 @"\01_close"(i32 noundef %264)
  br label %266

266:                                              ; preds = %260, %114
  br label %267

267:                                              ; preds = %266, %81
  br label %268

268:                                              ; preds = %267, %64
  %269 = load ptr, ptr %3, align 8
  call void @free(ptr noundef %269)
  br label %270

270:                                              ; preds = %268, %43
  %271 = load ptr, ptr @__stdoutp, align 8
  %272 = call i32 @fflush(ptr noundef %271)
  store i32 1, ptr @happen_SHARED, align 4
  %273 = call i32 @pthread_mutex_lock(ptr noundef @aworker_lock)
  %274 = load i32, ptr @aworkers_SHARED, align 4
  %275 = add nsw i32 %274, -1
  store i32 %275, ptr @aworkers_SHARED, align 4
  %276 = call i32 @pthread_cond_signal(ptr noundef @aworker_cv)
  %277 = call i32 @pthread_mutex_unlock(ptr noundef @aworker_lock)
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @worker3(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  %9 = alloca %struct.stat, align 8
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca i32, align 4
  %15 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %4, align 4
  %16 = call i32 @pthread_mutex_lock(ptr noundef @q_mtx)
  %17 = load i32, ptr @q_occupied_SHARED, align 4
  %18 = icmp sle i32 %17, 0
  br i1 %18, label %19, label %24

19:                                               ; preds = %1
  %20 = load i32, ptr @q_closed_SHARED, align 4
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %24, label %22

22:                                               ; preds = %19
  %23 = call i32 @"\01_pthread_cond_wait"(ptr noundef @q_more, ptr noundef @q_mtx)
  br label %24

24:                                               ; preds = %22, %19, %1
  %25 = load i32, ptr @q_occupied_SHARED, align 4
  %26 = icmp sgt i32 %25, 0
  br i1 %26, label %27, label %41

27:                                               ; preds = %24
  %28 = load ptr, ptr @q_buf_SHARED, align 8
  %29 = load i32, ptr @q_nextout_SHARED, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr @q_nextout_SHARED, align 4
  %31 = sext i32 %29 to i64
  %32 = getelementptr inbounds ptr, ptr %28, i64 %31
  %33 = load ptr, ptr %32, align 8
  store ptr %33, ptr %3, align 8
  %34 = load i32, ptr @q_qsize_SHARED, align 4
  %35 = load i32, ptr @q_nextout_SHARED, align 4
  %36 = srem i32 %35, %34
  store i32 %36, ptr @q_nextout_SHARED, align 4
  %37 = load i32, ptr @q_occupied_SHARED, align 4
  %38 = add nsw i32 %37, -1
  store i32 %38, ptr @q_occupied_SHARED, align 4
  store i32 1, ptr %4, align 4
  %39 = call i32 @pthread_mutex_unlock(ptr noundef @q_mtx)
  %40 = call i32 @pthread_cond_signal(ptr noundef @q_less)
  br label %43

41:                                               ; preds = %24
  %42 = call i32 @pthread_mutex_unlock(ptr noundef @q_mtx)
  br label %43

43:                                               ; preds = %41, %27
  %44 = load i32, ptr %4, align 4
  %45 = icmp eq i32 %44, 1
  br i1 %45, label %46, label %270

46:                                               ; preds = %43
  %47 = load ptr, ptr %3, align 8
  store ptr %47, ptr %5, align 8
  %48 = load ptr, ptr %5, align 8
  %49 = call i32 (ptr, i32, ...) @"\01_open"(ptr noundef %48, i32 noundef 0)
  store i32 %49, ptr %6, align 4
  %50 = load i32, ptr %6, align 4
  %51 = icmp slt i32 %50, 0
  br i1 %51, label %52, label %65

52:                                               ; preds = %46
  %53 = load i32, ptr @verbose_SHARED, align 4
  %54 = icmp ne i32 %53, 0
  br i1 %54, label %55, label %64

55:                                               ; preds = %52
  %56 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %57 = load ptr, ptr @__stderrp, align 8
  %58 = load ptr, ptr %5, align 8
  %59 = call ptr @__error()
  %60 = load i32, ptr %59, align 4
  %61 = call ptr @"\01_strerror"(i32 noundef %60)
  %62 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %57, ptr noundef @.str.1, ptr noundef %58, ptr noundef %61) #8
  %63 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %64

64:                                               ; preds = %55, %52
  br label %268

65:                                               ; preds = %46
  %66 = load i32, ptr %6, align 4
  %67 = call i32 @"\01_fstat"(i32 noundef %66, ptr noundef %9)
  %68 = icmp slt i32 %67, 0
  br i1 %68, label %69, label %84

69:                                               ; preds = %65
  %70 = load i32, ptr @verbose_SHARED, align 4
  %71 = icmp ne i32 %70, 0
  br i1 %71, label %72, label %81

72:                                               ; preds = %69
  %73 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %74 = load ptr, ptr @__stderrp, align 8
  %75 = load ptr, ptr %5, align 8
  %76 = call ptr @__error()
  %77 = load i32, ptr %76, align 4
  %78 = call ptr @"\01_strerror"(i32 noundef %77)
  %79 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %74, ptr noundef @.str.2, ptr noundef %75, ptr noundef %78) #8
  %80 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %81

81:                                               ; preds = %72, %69
  %82 = load i32, ptr %6, align 4
  %83 = call i32 @"\01_close"(i32 noundef %82)
  br label %267

84:                                               ; preds = %65
  %85 = getelementptr inbounds %struct.stat, ptr %9, i32 0, i32 11
  %86 = load i64, ptr %85, align 8
  store i64 %86, ptr %7, align 8
  %87 = load i32, ptr @debug_SHARED, align 4
  %88 = icmp sgt i32 %87, 1
  br i1 %88, label %89, label %96

89:                                               ; preds = %84
  %90 = load ptr, ptr @__stderrp, align 8
  %91 = load ptr, ptr %5, align 8
  %92 = load i64, ptr %7, align 8
  %93 = udiv i64 %92, 1000000
  %94 = trunc i64 %93 to i32
  %95 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %90, ptr noundef @.str.3, ptr noundef %91, i32 noundef %94) #8
  br label %96

96:                                               ; preds = %89, %84
  %97 = load i64, ptr %7, align 8
  %98 = load i32, ptr %6, align 4
  %99 = call ptr @"\01_mmap"(ptr noundef null, i64 noundef %97, i32 noundef 1, i32 noundef 66, i32 noundef %98, i64 noundef 0)
  store ptr %99, ptr %8, align 8
  %100 = load ptr, ptr %8, align 8
  %101 = icmp eq ptr %100, inttoptr (i64 -1 to ptr)
  br i1 %101, label %102, label %117

102:                                              ; preds = %96
  %103 = load i32, ptr @verbose_SHARED, align 4
  %104 = icmp ne i32 %103, 0
  br i1 %104, label %105, label %114

105:                                              ; preds = %102
  %106 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %107 = load ptr, ptr @__stderrp, align 8
  %108 = load ptr, ptr %5, align 8
  %109 = call ptr @__error()
  %110 = load i32, ptr %109, align 4
  %111 = call ptr @"\01_strerror"(i32 noundef %110)
  %112 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %107, ptr noundef @.str.4, ptr noundef %108, ptr noundef %111) #8
  %113 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %114

114:                                              ; preds = %105, %102
  %115 = load i32, ptr %6, align 4
  %116 = call i32 @"\01_close"(i32 noundef %115)
  br label %266

117:                                              ; preds = %96
  %118 = load ptr, ptr @rstr_SHARED, align 8
  %119 = icmp ne ptr %118, null
  br i1 %119, label %120, label %121

120:                                              ; preds = %117
  store i32 0, ptr %10, align 4
  br label %260

121:                                              ; preds = %117
  %122 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %123 = load ptr, ptr %5, align 8
  %124 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, ptr noundef %123)
  %125 = load ptr, ptr %8, align 8
  store ptr %125, ptr %11, align 8
  %126 = load i64, ptr %7, align 8
  store i64 %126, ptr %12, align 8
  store i64 0, ptr %13, align 8
  %127 = load ptr, ptr %11, align 8
  %128 = icmp eq ptr %127, null
  br i1 %128, label %129, label %131

129:                                              ; preds = %121
  %130 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  br label %257

131:                                              ; preds = %121
  %132 = load ptr, ptr %11, align 8
  store ptr %132, ptr %15, align 8
  br label %133

133:                                              ; preds = %166, %131
  %134 = load i64, ptr %12, align 8
  %135 = icmp ugt i64 %134, 0
  br i1 %135, label %136, label %164

136:                                              ; preds = %133
  %137 = load ptr, ptr %15, align 8
  %138 = load i8, ptr %137, align 1
  %139 = zext i8 %138 to i32
  %140 = call i32 @isprint(i32 noundef %139) #9
  %141 = icmp ne i32 %140, 0
  br i1 %141, label %162, label %142

142:                                              ; preds = %136
  %143 = load ptr, ptr %15, align 8
  %144 = load i8, ptr %143, align 1
  %145 = zext i8 %144 to i32
  %146 = icmp eq i32 %145, 0
  br i1 %146, label %162, label %147

147:                                              ; preds = %142
  %148 = load ptr, ptr %15, align 8
  %149 = load i8, ptr %148, align 1
  %150 = zext i8 %149 to i32
  %151 = icmp eq i32 %150, 9
  br i1 %151, label %162, label %152

152:                                              ; preds = %147
  %153 = load ptr, ptr %15, align 8
  %154 = load i8, ptr %153, align 1
  %155 = zext i8 %154 to i32
  %156 = icmp eq i32 %155, 10
  br i1 %156, label %162, label %157

157:                                              ; preds = %152
  %158 = load ptr, ptr %15, align 8
  %159 = load i8, ptr %158, align 1
  %160 = zext i8 %159 to i32
  %161 = icmp eq i32 %160, 13
  br label %162

162:                                              ; preds = %157, %152, %147, %142, %136
  %163 = phi i1 [ true, %152 ], [ true, %147 ], [ true, %142 ], [ true, %136 ], [ %161, %157 ]
  br label %164

164:                                              ; preds = %162, %133
  %165 = phi i1 [ false, %133 ], [ %163, %162 ]
  br i1 %165, label %166, label %171

166:                                              ; preds = %164
  %167 = load i64, ptr %12, align 8
  %168 = add i64 %167, -1
  store i64 %168, ptr %12, align 8
  %169 = load ptr, ptr %15, align 8
  %170 = getelementptr inbounds i8, ptr %169, i32 1
  store ptr %170, ptr %15, align 8
  br label %133, !llvm.loop !13

171:                                              ; preds = %164
  %172 = load i64, ptr %12, align 8
  %173 = icmp eq i64 %172, 0
  %174 = zext i1 %173 to i32
  store i32 %174, ptr %14, align 4
  %175 = load i32, ptr %14, align 4
  %176 = icmp ne i32 %175, 0
  br i1 %176, label %177, label %233

177:                                              ; preds = %171
  %178 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  br label %179

179:                                              ; preds = %227, %177
  %180 = load i64, ptr %7, align 8
  %181 = load i64, ptr %12, align 8
  %182 = icmp ult i64 %180, %181
  br i1 %182, label %183, label %188

183:                                              ; preds = %179
  %184 = load i64, ptr %7, align 8
  %185 = load i32, ptr @maxlen_SHARED, align 4
  %186 = sext i32 %185 to i64
  %187 = icmp ult i64 %184, %186
  br label %188

188:                                              ; preds = %183, %179
  %189 = phi i1 [ false, %179 ], [ %187, %183 ]
  br i1 %189, label %190, label %232

190:                                              ; preds = %188
  %191 = load ptr, ptr %11, align 8
  %192 = load i8, ptr %191, align 1
  %193 = zext i8 %192 to i32
  %194 = call i32 @isprint(i32 noundef %193) #9
  %195 = icmp ne i32 %194, 0
  br i1 %195, label %196, label %201

196:                                              ; preds = %190
  %197 = load ptr, ptr %11, align 8
  %198 = load i8, ptr %197, align 1
  %199 = zext i8 %198 to i32
  %200 = call i32 @putchar(i32 noundef %199)
  br label %227

201:                                              ; preds = %190
  %202 = load ptr, ptr %11, align 8
  %203 = load i8, ptr %202, align 1
  %204 = zext i8 %203 to i32
  switch i32 %204, label %221 [
    i32 0, label %205
    i32 10, label %207
    i32 13, label %213
    i32 9, label %219
  ]

205:                                              ; preds = %201
  %206 = call i32 (ptr, ...) @printf(ptr noundef @.str.8)
  br label %226

207:                                              ; preds = %201
  %208 = load i32, ptr @line_f_SHARED, align 4
  %209 = icmp ne i32 %208, 0
  br i1 %209, label %212, label %210

210:                                              ; preds = %207
  %211 = call i32 (ptr, ...) @printf(ptr noundef @.str.9)
  br label %226

212:                                              ; preds = %207
  br label %213

213:                                              ; preds = %201, %212
  %214 = load i32, ptr @line_f_SHARED, align 4
  %215 = icmp ne i32 %214, 0
  br i1 %215, label %218, label %216

216:                                              ; preds = %213
  %217 = call i32 (ptr, ...) @printf(ptr noundef @.str.10)
  br label %226

218:                                              ; preds = %213
  br label %219

219:                                              ; preds = %201, %218
  %220 = call i32 (ptr, ...) @printf(ptr noundef @.str.11)
  br label %226

221:                                              ; preds = %201
  %222 = load ptr, ptr %11, align 8
  %223 = load i8, ptr %222, align 1
  %224 = zext i8 %223 to i32
  %225 = call i32 (ptr, ...) @printf(ptr noundef @.str.12, i32 noundef %224)
  br label %226

226:                                              ; preds = %221, %219, %216, %210, %205
  br label %227

227:                                              ; preds = %226, %196
  %228 = load i64, ptr %7, align 8
  %229 = add i64 %228, 1
  store i64 %229, ptr %7, align 8
  %230 = load ptr, ptr %11, align 8
  %231 = getelementptr inbounds i8, ptr %230, i32 1
  store ptr %231, ptr %11, align 8
  br label %179, !llvm.loop !14

232:                                              ; preds = %188
  br label %256

233:                                              ; preds = %171
  %234 = call i32 (ptr, ...) @printf(ptr noundef @.str.13)
  br label %235

235:                                              ; preds = %246, %233
  %236 = load i64, ptr %7, align 8
  %237 = load i64, ptr %12, align 8
  %238 = icmp ult i64 %236, %237
  br i1 %238, label %239, label %244

239:                                              ; preds = %235
  %240 = load i64, ptr %7, align 8
  %241 = load i32, ptr @maxlen_SHARED, align 4
  %242 = sext i32 %241 to i64
  %243 = icmp ult i64 %240, %242
  br label %244

244:                                              ; preds = %239, %235
  %245 = phi i1 [ false, %235 ], [ %243, %239 ]
  br i1 %245, label %246, label %255

246:                                              ; preds = %244
  %247 = load ptr, ptr %11, align 8
  %248 = load i8, ptr %247, align 1
  %249 = zext i8 %248 to i32
  %250 = call i32 (ptr, ...) @printf(ptr noundef @.str.14, i32 noundef %249)
  %251 = load i64, ptr %7, align 8
  %252 = add i64 %251, 1
  store i64 %252, ptr %7, align 8
  %253 = load ptr, ptr %11, align 8
  %254 = getelementptr inbounds i8, ptr %253, i32 1
  store ptr %254, ptr %11, align 8
  br label %235, !llvm.loop !15

255:                                              ; preds = %244
  br label %256

256:                                              ; preds = %255, %232
  br label %257

257:                                              ; preds = %256, %129
  %258 = call i32 @putchar(i32 noundef 10)
  %259 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %260

260:                                              ; preds = %257, %120
  %261 = load ptr, ptr %8, align 8
  %262 = load i64, ptr %7, align 8
  %263 = call i32 @"\01_munmap"(ptr noundef %261, i64 noundef %262)
  %264 = load i32, ptr %6, align 4
  %265 = call i32 @"\01_close"(i32 noundef %264)
  br label %266

266:                                              ; preds = %260, %114
  br label %267

267:                                              ; preds = %266, %81
  br label %268

268:                                              ; preds = %267, %64
  %269 = load ptr, ptr %3, align 8
  call void @free(ptr noundef %269)
  br label %270

270:                                              ; preds = %268, %43
  %271 = load ptr, ptr @__stdoutp, align 8
  %272 = call i32 @fflush(ptr noundef %271)
  store i32 1, ptr @happen_SHARED, align 4
  %273 = call i32 @pthread_mutex_lock(ptr noundef @aworker_lock)
  %274 = load i32, ptr @aworkers_SHARED, align 4
  %275 = add nsw i32 %274, -1
  store i32 %275, ptr @aworkers_SHARED, align 4
  %276 = call i32 @pthread_cond_signal(ptr noundef @aworker_cv)
  %277 = call i32 @pthread_mutex_unlock(ptr noundef @aworker_lock)
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @worker4(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  %9 = alloca %struct.stat, align 8
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca i32, align 4
  %15 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %4, align 4
  %16 = call i32 @pthread_mutex_lock(ptr noundef @q_mtx)
  %17 = load i32, ptr @q_occupied_SHARED, align 4
  %18 = icmp sle i32 %17, 0
  br i1 %18, label %19, label %24

19:                                               ; preds = %1
  %20 = load i32, ptr @q_closed_SHARED, align 4
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %24, label %22

22:                                               ; preds = %19
  %23 = call i32 @"\01_pthread_cond_wait"(ptr noundef @q_more, ptr noundef @q_mtx)
  br label %24

24:                                               ; preds = %22, %19, %1
  %25 = load i32, ptr @q_occupied_SHARED, align 4
  %26 = icmp sgt i32 %25, 0
  br i1 %26, label %27, label %41

27:                                               ; preds = %24
  %28 = load ptr, ptr @q_buf_SHARED, align 8
  %29 = load i32, ptr @q_nextout_SHARED, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr @q_nextout_SHARED, align 4
  %31 = sext i32 %29 to i64
  %32 = getelementptr inbounds ptr, ptr %28, i64 %31
  %33 = load ptr, ptr %32, align 8
  store ptr %33, ptr %3, align 8
  %34 = load i32, ptr @q_qsize_SHARED, align 4
  %35 = load i32, ptr @q_nextout_SHARED, align 4
  %36 = srem i32 %35, %34
  store i32 %36, ptr @q_nextout_SHARED, align 4
  %37 = load i32, ptr @q_occupied_SHARED, align 4
  %38 = add nsw i32 %37, -1
  store i32 %38, ptr @q_occupied_SHARED, align 4
  store i32 1, ptr %4, align 4
  %39 = call i32 @pthread_mutex_unlock(ptr noundef @q_mtx)
  %40 = call i32 @pthread_cond_signal(ptr noundef @q_less)
  br label %43

41:                                               ; preds = %24
  %42 = call i32 @pthread_mutex_unlock(ptr noundef @q_mtx)
  br label %43

43:                                               ; preds = %41, %27
  %44 = load i32, ptr %4, align 4
  %45 = icmp eq i32 %44, 1
  br i1 %45, label %46, label %270

46:                                               ; preds = %43
  %47 = load ptr, ptr %3, align 8
  store ptr %47, ptr %5, align 8
  %48 = load ptr, ptr %5, align 8
  %49 = call i32 (ptr, i32, ...) @"\01_open"(ptr noundef %48, i32 noundef 0)
  store i32 %49, ptr %6, align 4
  %50 = load i32, ptr %6, align 4
  %51 = icmp slt i32 %50, 0
  br i1 %51, label %52, label %65

52:                                               ; preds = %46
  %53 = load i32, ptr @verbose_SHARED, align 4
  %54 = icmp ne i32 %53, 0
  br i1 %54, label %55, label %64

55:                                               ; preds = %52
  %56 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %57 = load ptr, ptr @__stderrp, align 8
  %58 = load ptr, ptr %5, align 8
  %59 = call ptr @__error()
  %60 = load i32, ptr %59, align 4
  %61 = call ptr @"\01_strerror"(i32 noundef %60)
  %62 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %57, ptr noundef @.str.1, ptr noundef %58, ptr noundef %61) #8
  %63 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %64

64:                                               ; preds = %55, %52
  br label %268

65:                                               ; preds = %46
  %66 = load i32, ptr %6, align 4
  %67 = call i32 @"\01_fstat"(i32 noundef %66, ptr noundef %9)
  %68 = icmp slt i32 %67, 0
  br i1 %68, label %69, label %84

69:                                               ; preds = %65
  %70 = load i32, ptr @verbose_SHARED, align 4
  %71 = icmp ne i32 %70, 0
  br i1 %71, label %72, label %81

72:                                               ; preds = %69
  %73 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %74 = load ptr, ptr @__stderrp, align 8
  %75 = load ptr, ptr %5, align 8
  %76 = call ptr @__error()
  %77 = load i32, ptr %76, align 4
  %78 = call ptr @"\01_strerror"(i32 noundef %77)
  %79 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %74, ptr noundef @.str.2, ptr noundef %75, ptr noundef %78) #8
  %80 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %81

81:                                               ; preds = %72, %69
  %82 = load i32, ptr %6, align 4
  %83 = call i32 @"\01_close"(i32 noundef %82)
  br label %267

84:                                               ; preds = %65
  %85 = getelementptr inbounds %struct.stat, ptr %9, i32 0, i32 11
  %86 = load i64, ptr %85, align 8
  store i64 %86, ptr %7, align 8
  %87 = load i32, ptr @debug_SHARED, align 4
  %88 = icmp sgt i32 %87, 1
  br i1 %88, label %89, label %96

89:                                               ; preds = %84
  %90 = load ptr, ptr @__stderrp, align 8
  %91 = load ptr, ptr %5, align 8
  %92 = load i64, ptr %7, align 8
  %93 = udiv i64 %92, 1000000
  %94 = trunc i64 %93 to i32
  %95 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %90, ptr noundef @.str.3, ptr noundef %91, i32 noundef %94) #8
  br label %96

96:                                               ; preds = %89, %84
  %97 = load i64, ptr %7, align 8
  %98 = load i32, ptr %6, align 4
  %99 = call ptr @"\01_mmap"(ptr noundef null, i64 noundef %97, i32 noundef 1, i32 noundef 66, i32 noundef %98, i64 noundef 0)
  store ptr %99, ptr %8, align 8
  %100 = load ptr, ptr %8, align 8
  %101 = icmp eq ptr %100, inttoptr (i64 -1 to ptr)
  br i1 %101, label %102, label %117

102:                                              ; preds = %96
  %103 = load i32, ptr @verbose_SHARED, align 4
  %104 = icmp ne i32 %103, 0
  br i1 %104, label %105, label %114

105:                                              ; preds = %102
  %106 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %107 = load ptr, ptr @__stderrp, align 8
  %108 = load ptr, ptr %5, align 8
  %109 = call ptr @__error()
  %110 = load i32, ptr %109, align 4
  %111 = call ptr @"\01_strerror"(i32 noundef %110)
  %112 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %107, ptr noundef @.str.4, ptr noundef %108, ptr noundef %111) #8
  %113 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %114

114:                                              ; preds = %105, %102
  %115 = load i32, ptr %6, align 4
  %116 = call i32 @"\01_close"(i32 noundef %115)
  br label %266

117:                                              ; preds = %96
  %118 = load ptr, ptr @rstr_SHARED, align 8
  %119 = icmp ne ptr %118, null
  br i1 %119, label %120, label %121

120:                                              ; preds = %117
  store i32 0, ptr %10, align 4
  br label %260

121:                                              ; preds = %117
  %122 = call i32 @pthread_mutex_lock(ptr noundef @print_lock)
  %123 = load ptr, ptr %5, align 8
  %124 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, ptr noundef %123)
  %125 = load ptr, ptr %8, align 8
  store ptr %125, ptr %11, align 8
  %126 = load i64, ptr %7, align 8
  store i64 %126, ptr %12, align 8
  store i64 0, ptr %13, align 8
  %127 = load ptr, ptr %11, align 8
  %128 = icmp eq ptr %127, null
  br i1 %128, label %129, label %131

129:                                              ; preds = %121
  %130 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  br label %257

131:                                              ; preds = %121
  %132 = load ptr, ptr %11, align 8
  store ptr %132, ptr %15, align 8
  br label %133

133:                                              ; preds = %166, %131
  %134 = load i64, ptr %12, align 8
  %135 = icmp ugt i64 %134, 0
  br i1 %135, label %136, label %164

136:                                              ; preds = %133
  %137 = load ptr, ptr %15, align 8
  %138 = load i8, ptr %137, align 1
  %139 = zext i8 %138 to i32
  %140 = call i32 @isprint(i32 noundef %139) #9
  %141 = icmp ne i32 %140, 0
  br i1 %141, label %162, label %142

142:                                              ; preds = %136
  %143 = load ptr, ptr %15, align 8
  %144 = load i8, ptr %143, align 1
  %145 = zext i8 %144 to i32
  %146 = icmp eq i32 %145, 0
  br i1 %146, label %162, label %147

147:                                              ; preds = %142
  %148 = load ptr, ptr %15, align 8
  %149 = load i8, ptr %148, align 1
  %150 = zext i8 %149 to i32
  %151 = icmp eq i32 %150, 9
  br i1 %151, label %162, label %152

152:                                              ; preds = %147
  %153 = load ptr, ptr %15, align 8
  %154 = load i8, ptr %153, align 1
  %155 = zext i8 %154 to i32
  %156 = icmp eq i32 %155, 10
  br i1 %156, label %162, label %157

157:                                              ; preds = %152
  %158 = load ptr, ptr %15, align 8
  %159 = load i8, ptr %158, align 1
  %160 = zext i8 %159 to i32
  %161 = icmp eq i32 %160, 13
  br label %162

162:                                              ; preds = %157, %152, %147, %142, %136
  %163 = phi i1 [ true, %152 ], [ true, %147 ], [ true, %142 ], [ true, %136 ], [ %161, %157 ]
  br label %164

164:                                              ; preds = %162, %133
  %165 = phi i1 [ false, %133 ], [ %163, %162 ]
  br i1 %165, label %166, label %171

166:                                              ; preds = %164
  %167 = load i64, ptr %12, align 8
  %168 = add i64 %167, -1
  store i64 %168, ptr %12, align 8
  %169 = load ptr, ptr %15, align 8
  %170 = getelementptr inbounds i8, ptr %169, i32 1
  store ptr %170, ptr %15, align 8
  br label %133, !llvm.loop !16

171:                                              ; preds = %164
  %172 = load i64, ptr %12, align 8
  %173 = icmp eq i64 %172, 0
  %174 = zext i1 %173 to i32
  store i32 %174, ptr %14, align 4
  %175 = load i32, ptr %14, align 4
  %176 = icmp ne i32 %175, 0
  br i1 %176, label %177, label %233

177:                                              ; preds = %171
  %178 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  br label %179

179:                                              ; preds = %227, %177
  %180 = load i64, ptr %7, align 8
  %181 = load i64, ptr %12, align 8
  %182 = icmp ult i64 %180, %181
  br i1 %182, label %183, label %188

183:                                              ; preds = %179
  %184 = load i64, ptr %7, align 8
  %185 = load i32, ptr @maxlen_SHARED, align 4
  %186 = sext i32 %185 to i64
  %187 = icmp ult i64 %184, %186
  br label %188

188:                                              ; preds = %183, %179
  %189 = phi i1 [ false, %179 ], [ %187, %183 ]
  br i1 %189, label %190, label %232

190:                                              ; preds = %188
  %191 = load ptr, ptr %11, align 8
  %192 = load i8, ptr %191, align 1
  %193 = zext i8 %192 to i32
  %194 = call i32 @isprint(i32 noundef %193) #9
  %195 = icmp ne i32 %194, 0
  br i1 %195, label %196, label %201

196:                                              ; preds = %190
  %197 = load ptr, ptr %11, align 8
  %198 = load i8, ptr %197, align 1
  %199 = zext i8 %198 to i32
  %200 = call i32 @putchar(i32 noundef %199)
  br label %227

201:                                              ; preds = %190
  %202 = load ptr, ptr %11, align 8
  %203 = load i8, ptr %202, align 1
  %204 = zext i8 %203 to i32
  switch i32 %204, label %221 [
    i32 0, label %205
    i32 10, label %207
    i32 13, label %213
    i32 9, label %219
  ]

205:                                              ; preds = %201
  %206 = call i32 (ptr, ...) @printf(ptr noundef @.str.8)
  br label %226

207:                                              ; preds = %201
  %208 = load i32, ptr @line_f_SHARED, align 4
  %209 = icmp ne i32 %208, 0
  br i1 %209, label %212, label %210

210:                                              ; preds = %207
  %211 = call i32 (ptr, ...) @printf(ptr noundef @.str.9)
  br label %226

212:                                              ; preds = %207
  br label %213

213:                                              ; preds = %201, %212
  %214 = load i32, ptr @line_f_SHARED, align 4
  %215 = icmp ne i32 %214, 0
  br i1 %215, label %218, label %216

216:                                              ; preds = %213
  %217 = call i32 (ptr, ...) @printf(ptr noundef @.str.10)
  br label %226

218:                                              ; preds = %213
  br label %219

219:                                              ; preds = %201, %218
  %220 = call i32 (ptr, ...) @printf(ptr noundef @.str.11)
  br label %226

221:                                              ; preds = %201
  %222 = load ptr, ptr %11, align 8
  %223 = load i8, ptr %222, align 1
  %224 = zext i8 %223 to i32
  %225 = call i32 (ptr, ...) @printf(ptr noundef @.str.12, i32 noundef %224)
  br label %226

226:                                              ; preds = %221, %219, %216, %210, %205
  br label %227

227:                                              ; preds = %226, %196
  %228 = load i64, ptr %7, align 8
  %229 = add i64 %228, 1
  store i64 %229, ptr %7, align 8
  %230 = load ptr, ptr %11, align 8
  %231 = getelementptr inbounds i8, ptr %230, i32 1
  store ptr %231, ptr %11, align 8
  br label %179, !llvm.loop !17

232:                                              ; preds = %188
  br label %256

233:                                              ; preds = %171
  %234 = call i32 (ptr, ...) @printf(ptr noundef @.str.13)
  br label %235

235:                                              ; preds = %246, %233
  %236 = load i64, ptr %7, align 8
  %237 = load i64, ptr %12, align 8
  %238 = icmp ult i64 %236, %237
  br i1 %238, label %239, label %244

239:                                              ; preds = %235
  %240 = load i64, ptr %7, align 8
  %241 = load i32, ptr @maxlen_SHARED, align 4
  %242 = sext i32 %241 to i64
  %243 = icmp ult i64 %240, %242
  br label %244

244:                                              ; preds = %239, %235
  %245 = phi i1 [ false, %235 ], [ %243, %239 ]
  br i1 %245, label %246, label %255

246:                                              ; preds = %244
  %247 = load ptr, ptr %11, align 8
  %248 = load i8, ptr %247, align 1
  %249 = zext i8 %248 to i32
  %250 = call i32 (ptr, ...) @printf(ptr noundef @.str.14, i32 noundef %249)
  %251 = load i64, ptr %7, align 8
  %252 = add i64 %251, 1
  store i64 %252, ptr %7, align 8
  %253 = load ptr, ptr %11, align 8
  %254 = getelementptr inbounds i8, ptr %253, i32 1
  store ptr %254, ptr %11, align 8
  br label %235, !llvm.loop !18

255:                                              ; preds = %244
  br label %256

256:                                              ; preds = %255, %232
  br label %257

257:                                              ; preds = %256, %129
  %258 = call i32 @putchar(i32 noundef 10)
  %259 = call i32 @pthread_mutex_unlock(ptr noundef @print_lock)
  br label %260

260:                                              ; preds = %257, %120
  %261 = load ptr, ptr %8, align 8
  %262 = load i64, ptr %7, align 8
  %263 = call i32 @"\01_munmap"(ptr noundef %261, i64 noundef %262)
  %264 = load i32, ptr %6, align 4
  %265 = call i32 @"\01_close"(i32 noundef %264)
  br label %266

266:                                              ; preds = %260, %114
  br label %267

267:                                              ; preds = %266, %81
  br label %268

268:                                              ; preds = %267, %64
  %269 = load ptr, ptr %3, align 8
  call void @free(ptr noundef %269)
  br label %270

270:                                              ; preds = %268, %43
  %271 = load ptr, ptr @__stdoutp, align 8
  %272 = call i32 @fflush(ptr noundef %271)
  store i32 1, ptr @happen_SHARED, align 4
  %273 = call i32 @pthread_mutex_lock(ptr noundef @aworker_lock)
  %274 = load i32, ptr @aworkers_SHARED, align 4
  %275 = add nsw i32 %274, -1
  store i32 %275, ptr @aworkers_SHARED, align 4
  %276 = call i32 @pthread_cond_signal(ptr noundef @aworker_cv)
  %277 = call i32 @pthread_mutex_unlock(ptr noundef @aworker_lock)
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca %struct.rlimit, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  %16 = alloca ptr, align 8
  %17 = alloca ptr, align 8
  %18 = alloca ptr, align 8
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca ptr, align 8
  %23 = alloca i32, align 4
  %24 = alloca ptr, align 8
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca ptr, align 8
  %28 = alloca ptr, align 8
  %29 = alloca ptr, align 8
  %30 = alloca ptr, align 8
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  %37 = alloca ptr, align 8
  %38 = alloca ptr, align 8
  %39 = alloca i32, align 4
  %40 = alloca i32, align 4
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  %41 = load ptr, ptr %5, align 8
  %42 = getelementptr inbounds ptr, ptr %41, i64 0
  %43 = load ptr, ptr %42, align 8
  store ptr %43, ptr @argv0_SHARED, align 8
  %44 = call ptr @setlocale(i32 noundef 2, ptr noundef @.str.15)
  %45 = call i32 @"\01_getrlimit"(i32 noundef 8, ptr noundef %8)
  %46 = getelementptr inbounds %struct.rlimit, ptr %8, i32 0, i32 1
  %47 = load i64, ptr %46, align 8
  %48 = getelementptr inbounds %struct.rlimit, ptr %8, i32 0, i32 0
  store i64 %47, ptr %48, align 8
  %49 = call i32 @"\01_setrlimit"(i32 noundef 8, ptr noundef %8)
  %50 = call ptr @signal(i32 noundef 13, ptr noundef inttoptr (i64 1 to ptr))
  store i32 2, ptr @nworkers_SHARED, align 4
  %51 = call i32 @pthread_mutex_init(ptr noundef @print_lock, ptr noundef null)
  %52 = call i32 @pthread_mutex_init(ptr noundef @aworker_lock, ptr noundef null)
  %53 = call i32 @pthread_mutex_init(ptr noundef @matches_lock, ptr noundef null)
  %54 = call i32 @"\01_pthread_cond_init"(ptr noundef @aworker_cv, ptr noundef null)
  store i32 1, ptr %6, align 4
  br label %55

55:                                               ; preds = %247, %2
  %56 = load i32, ptr %6, align 4
  %57 = load i32, ptr %4, align 4
  %58 = icmp slt i32 %56, %57
  br i1 %58, label %59, label %69

59:                                               ; preds = %55
  %60 = load ptr, ptr %5, align 8
  %61 = load i32, ptr %6, align 4
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds ptr, ptr %60, i64 %62
  %64 = load ptr, ptr %63, align 8
  %65 = getelementptr inbounds i8, ptr %64, i64 0
  %66 = load i8, ptr %65, align 1
  %67 = sext i8 %66 to i32
  %68 = icmp eq i32 %67, 45
  br label %69

69:                                               ; preds = %59, %55
  %70 = phi i1 [ false, %55 ], [ %68, %59 ]
  br i1 %70, label %71, label %250

71:                                               ; preds = %69
  store i32 1, ptr %7, align 4
  br label %72

72:                                               ; preds = %243, %71
  %73 = load i32, ptr %7, align 4
  %74 = icmp sgt i32 %73, 0
  br i1 %74, label %75, label %87

75:                                               ; preds = %72
  %76 = load ptr, ptr %5, align 8
  %77 = load i32, ptr %6, align 4
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds ptr, ptr %76, i64 %78
  %80 = load ptr, ptr %79, align 8
  %81 = load i32, ptr %7, align 4
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds i8, ptr %80, i64 %82
  %84 = load i8, ptr %83, align 1
  %85 = sext i8 %84 to i32
  %86 = icmp ne i32 %85, 0
  br label %87

87:                                               ; preds = %75, %72
  %88 = phi i1 [ false, %72 ], [ %86, %75 ]
  br i1 %88, label %89, label %246

89:                                               ; preds = %87
  %90 = load ptr, ptr %5, align 8
  %91 = load i32, ptr %6, align 4
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds ptr, ptr %90, i64 %92
  %94 = load ptr, ptr %93, align 8
  %95 = load i32, ptr %7, align 4
  %96 = sext i32 %95 to i64
  %97 = getelementptr inbounds i8, ptr %94, i64 %96
  %98 = load i8, ptr %97, align 1
  %99 = sext i8 %98 to i32
  switch i32 %99, label %226 [
    i32 45, label %100
    i32 86, label %103
    i32 100, label %106
    i32 105, label %109
    i32 118, label %110
    i32 104, label %113
    i32 108, label %135
    i32 76, label %138
    i32 110, label %182
  ]

100:                                              ; preds = %89
  %101 = load i32, ptr %6, align 4
  %102 = add nsw i32 %101, 1
  store i32 %102, ptr %6, align 4
  br label %251

103:                                              ; preds = %89
  %104 = load ptr, ptr @__stdoutp, align 8
  %105 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %104, ptr noundef @.str.16, ptr noundef @version_SHARED, ptr noundef @.str.17, ptr noundef @.str.18) #8
  br label %242

106:                                              ; preds = %89
  %107 = load i32, ptr @debug_SHARED, align 4
  %108 = add nsw i32 %107, 1
  store i32 %108, ptr @debug_SHARED, align 4
  br label %242

109:                                              ; preds = %89
  store i32 1, ptr @ignore_case_SHARED, align 4
  br label %242

110:                                              ; preds = %89
  %111 = load i32, ptr @verbose_SHARED, align 4
  %112 = add nsw i32 %111, 1
  store i32 %112, ptr @verbose_SHARED, align 4
  br label %242

113:                                              ; preds = %89
  %114 = load ptr, ptr @__stdoutp, align 8
  %115 = load ptr, ptr @argv0_SHARED, align 8
  %116 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %114, ptr noundef @.str.19, ptr noundef %115) #8
  %117 = load ptr, ptr @__stdoutp, align 8
  %118 = call i32 @"\01_fputs"(ptr noundef @.str.20, ptr noundef %117)
  %119 = load ptr, ptr @__stdoutp, align 8
  %120 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %119, ptr noundef @.str.21) #8
  %121 = load ptr, ptr @__stdoutp, align 8
  %122 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %121, ptr noundef @.str.22) #8
  %123 = load ptr, ptr @__stdoutp, align 8
  %124 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %123, ptr noundef @.str.23) #8
  %125 = load ptr, ptr @__stdoutp, align 8
  %126 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %125, ptr noundef @.str.24) #8
  %127 = load ptr, ptr @__stdoutp, align 8
  %128 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %127, ptr noundef @.str.25) #8
  %129 = load ptr, ptr @__stdoutp, align 8
  %130 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %129, ptr noundef @.str.26) #8
  %131 = load ptr, ptr @__stdoutp, align 8
  %132 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %131, ptr noundef @.str.27) #8
  %133 = load ptr, ptr @__stdoutp, align 8
  %134 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %133, ptr noundef @.str.28) #8
  call void @exit(i32 noundef 0) #10
  unreachable

135:                                              ; preds = %89
  %136 = load i32, ptr @line_f_SHARED, align 4
  %137 = add nsw i32 %136, 1
  store i32 %137, ptr @line_f_SHARED, align 4
  br label %242

138:                                              ; preds = %89
  %139 = load ptr, ptr %5, align 8
  %140 = load i32, ptr %6, align 4
  %141 = sext i32 %140 to i64
  %142 = getelementptr inbounds ptr, ptr %139, i64 %141
  %143 = load ptr, ptr %142, align 8
  %144 = getelementptr inbounds i8, ptr %143, i64 2
  %145 = load i8, ptr %144, align 1
  %146 = icmp ne i8 %145, 0
  br i1 %146, label %147, label %154

147:                                              ; preds = %138
  %148 = load ptr, ptr %5, align 8
  %149 = load i32, ptr %6, align 4
  %150 = sext i32 %149 to i64
  %151 = getelementptr inbounds ptr, ptr %148, i64 %150
  %152 = load ptr, ptr %151, align 8
  %153 = getelementptr inbounds i8, ptr %152, i64 2
  store ptr %153, ptr %9, align 8
  br label %161

154:                                              ; preds = %138
  %155 = load ptr, ptr %5, align 8
  %156 = load i32, ptr %6, align 4
  %157 = add nsw i32 %156, 1
  store i32 %157, ptr %6, align 4
  %158 = sext i32 %157 to i64
  %159 = getelementptr inbounds ptr, ptr %155, i64 %158
  %160 = load ptr, ptr %159, align 8
  store ptr %160, ptr %9, align 8
  br label %161

161:                                              ; preds = %154, %147
  %162 = load ptr, ptr %9, align 8
  %163 = icmp ne ptr %162, null
  br i1 %163, label %164, label %168

164:                                              ; preds = %161
  %165 = load ptr, ptr %9, align 8
  %166 = call i32 (ptr, ptr, ...) @sscanf(ptr noundef %165, ptr noundef @.str.29, ptr noundef @maxlen_SHARED)
  %167 = icmp ne i32 %166, 1
  br i1 %167, label %168, label %181

168:                                              ; preds = %164, %161
  %169 = load ptr, ptr @__stderrp, align 8
  %170 = load ptr, ptr %5, align 8
  %171 = getelementptr inbounds ptr, ptr %170, i64 0
  %172 = load ptr, ptr %171, align 8
  %173 = load ptr, ptr %9, align 8
  %174 = icmp ne ptr %173, null
  br i1 %174, label %175, label %177

175:                                              ; preds = %168
  %176 = load ptr, ptr %9, align 8
  br label %178

177:                                              ; preds = %168
  br label %178

178:                                              ; preds = %177, %175
  %179 = phi ptr [ %176, %175 ], [ @.str.31, %177 ]
  %180 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %169, ptr noundef @.str.30, ptr noundef %172, ptr noundef %179) #8
  call void @exit(i32 noundef 1) #10
  unreachable

181:                                              ; preds = %164
  store i32 -2, ptr %7, align 4
  br label %242

182:                                              ; preds = %89
  %183 = load ptr, ptr %5, align 8
  %184 = load i32, ptr %6, align 4
  %185 = sext i32 %184 to i64
  %186 = getelementptr inbounds ptr, ptr %183, i64 %185
  %187 = load ptr, ptr %186, align 8
  %188 = getelementptr inbounds i8, ptr %187, i64 2
  %189 = load i8, ptr %188, align 1
  %190 = icmp ne i8 %189, 0
  br i1 %190, label %191, label %198

191:                                              ; preds = %182
  %192 = load ptr, ptr %5, align 8
  %193 = load i32, ptr %6, align 4
  %194 = sext i32 %193 to i64
  %195 = getelementptr inbounds ptr, ptr %192, i64 %194
  %196 = load ptr, ptr %195, align 8
  %197 = getelementptr inbounds i8, ptr %196, i64 2
  store ptr %197, ptr %9, align 8
  br label %205

198:                                              ; preds = %182
  %199 = load ptr, ptr %5, align 8
  %200 = load i32, ptr %6, align 4
  %201 = add nsw i32 %200, 1
  store i32 %201, ptr %6, align 4
  %202 = sext i32 %201 to i64
  %203 = getelementptr inbounds ptr, ptr %199, i64 %202
  %204 = load ptr, ptr %203, align 8
  store ptr %204, ptr %9, align 8
  br label %205

205:                                              ; preds = %198, %191
  %206 = load ptr, ptr %9, align 8
  %207 = icmp ne ptr %206, null
  br i1 %207, label %208, label %212

208:                                              ; preds = %205
  %209 = load ptr, ptr %9, align 8
  %210 = call i32 (ptr, ptr, ...) @sscanf(ptr noundef %209, ptr noundef @.str.29, ptr noundef @nworkers_SHARED)
  %211 = icmp ne i32 %210, 1
  br i1 %211, label %212, label %225

212:                                              ; preds = %208, %205
  %213 = load ptr, ptr @__stderrp, align 8
  %214 = load ptr, ptr %5, align 8
  %215 = getelementptr inbounds ptr, ptr %214, i64 0
  %216 = load ptr, ptr %215, align 8
  %217 = load ptr, ptr %9, align 8
  %218 = icmp ne ptr %217, null
  br i1 %218, label %219, label %221

219:                                              ; preds = %212
  %220 = load ptr, ptr %9, align 8
  br label %222

221:                                              ; preds = %212
  br label %222

222:                                              ; preds = %221, %219
  %223 = phi ptr [ %220, %219 ], [ @.str.31, %221 ]
  %224 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %213, ptr noundef @.str.32, ptr noundef %216, ptr noundef %223) #8
  call void @exit(i32 noundef 1) #10
  unreachable

225:                                              ; preds = %208
  store i32 -2, ptr %7, align 4
  br label %242

226:                                              ; preds = %89
  %227 = load ptr, ptr @__stderrp, align 8
  %228 = load ptr, ptr %5, align 8
  %229 = getelementptr inbounds ptr, ptr %228, i64 0
  %230 = load ptr, ptr %229, align 8
  %231 = load ptr, ptr %5, align 8
  %232 = load i32, ptr %6, align 4
  %233 = sext i32 %232 to i64
  %234 = getelementptr inbounds ptr, ptr %231, i64 %233
  %235 = load ptr, ptr %234, align 8
  %236 = load i32, ptr %7, align 4
  %237 = sext i32 %236 to i64
  %238 = getelementptr inbounds i8, ptr %235, i64 %237
  %239 = load i8, ptr %238, align 1
  %240 = sext i8 %239 to i32
  %241 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %227, ptr noundef @.str.33, ptr noundef %230, i32 noundef %240) #8
  call void @exit(i32 noundef 1) #10
  unreachable

242:                                              ; preds = %225, %181, %135, %110, %109, %106, %103
  br label %243

243:                                              ; preds = %242
  %244 = load i32, ptr %7, align 4
  %245 = add nsw i32 %244, 1
  store i32 %245, ptr %7, align 4
  br label %72, !llvm.loop !19

246:                                              ; preds = %87
  br label %247

247:                                              ; preds = %246
  %248 = load i32, ptr %6, align 4
  %249 = add nsw i32 %248, 1
  store i32 %249, ptr %6, align 4
  br label %55, !llvm.loop !20

250:                                              ; preds = %69
  br label %251

251:                                              ; preds = %250, %100
  %252 = load ptr, ptr %5, align 8
  %253 = load i32, ptr %6, align 4
  %254 = sext i32 %253 to i64
  %255 = getelementptr inbounds ptr, ptr %252, i64 %254
  %256 = load ptr, ptr %255, align 8
  %257 = call i64 @strlen(ptr noundef %256) #8
  %258 = add i64 %257, 1
  %259 = trunc i64 %258 to i32
  store i32 %259, ptr %15, align 4
  %260 = load i32, ptr %15, align 4
  %261 = sext i32 %260 to i64
  %262 = mul i64 %261, 1
  %263 = call ptr @malloc(i64 noundef %262) #11
  store ptr %263, ptr @rstr_SHARED, align 8
  %264 = load ptr, ptr @rstr_SHARED, align 8
  %265 = load ptr, ptr %5, align 8
  %266 = load i32, ptr %6, align 4
  %267 = sext i32 %266 to i64
  %268 = getelementptr inbounds ptr, ptr %265, i64 %267
  %269 = load ptr, ptr %268, align 8
  %270 = load ptr, ptr @rstr_SHARED, align 8
  %271 = call i64 @llvm.objectsize.i64.p0(ptr %270, i1 false, i1 true, i1 false)
  %272 = call ptr @__strcpy_chk(ptr noundef %264, ptr noundef %269, i64 noundef %271) #8
  %273 = load i32, ptr %6, align 4
  %274 = add nsw i32 %273, 1
  store i32 %274, ptr %6, align 4
  %275 = load ptr, ptr @rstr_SHARED, align 8
  store ptr %275, ptr %16, align 8
  %276 = load ptr, ptr %16, align 8
  store ptr %276, ptr %17, align 8
  store ptr %276, ptr %18, align 8
  br label %277

277:                                              ; preds = %710, %251
  %278 = load ptr, ptr %18, align 8
  %279 = load i8, ptr %278, align 1
  %280 = icmp ne i8 %279, 0
  br i1 %280, label %281, label %711

281:                                              ; preds = %277
  %282 = load ptr, ptr %18, align 8
  %283 = load i8, ptr %282, align 1
  %284 = zext i8 %283 to i32
  %285 = icmp ne i32 %284, 92
  br i1 %285, label %286, label %292

286:                                              ; preds = %281
  %287 = load ptr, ptr %18, align 8
  %288 = getelementptr inbounds i8, ptr %287, i32 1
  store ptr %288, ptr %18, align 8
  %289 = load i8, ptr %287, align 1
  %290 = load ptr, ptr %17, align 8
  %291 = getelementptr inbounds i8, ptr %290, i32 1
  store ptr %291, ptr %17, align 8
  store i8 %289, ptr %290, align 1
  br label %710

292:                                              ; preds = %281
  %293 = load ptr, ptr %18, align 8
  %294 = getelementptr inbounds i8, ptr %293, i32 1
  store ptr %294, ptr %18, align 8
  %295 = load i8, ptr %294, align 1
  %296 = zext i8 %295 to i32
  switch i32 %296, label %703 [
    i32 110, label %297
    i32 114, label %302
    i32 116, label %307
    i32 98, label %312
    i32 120, label %317
    i32 48, label %447
    i32 49, label %575
    i32 50, label %575
    i32 51, label %575
    i32 52, label %575
    i32 53, label %575
    i32 54, label %575
    i32 55, label %575
    i32 56, label %575
    i32 57, label %575
  ]

297:                                              ; preds = %292
  %298 = load ptr, ptr %17, align 8
  %299 = getelementptr inbounds i8, ptr %298, i32 1
  store ptr %299, ptr %17, align 8
  store i8 10, ptr %298, align 1
  %300 = load ptr, ptr %18, align 8
  %301 = getelementptr inbounds i8, ptr %300, i32 1
  store ptr %301, ptr %18, align 8
  br label %709

302:                                              ; preds = %292
  %303 = load ptr, ptr %17, align 8
  %304 = getelementptr inbounds i8, ptr %303, i32 1
  store ptr %304, ptr %17, align 8
  store i8 13, ptr %303, align 1
  %305 = load ptr, ptr %18, align 8
  %306 = getelementptr inbounds i8, ptr %305, i32 1
  store ptr %306, ptr %18, align 8
  br label %709

307:                                              ; preds = %292
  %308 = load ptr, ptr %17, align 8
  %309 = getelementptr inbounds i8, ptr %308, i32 1
  store ptr %309, ptr %17, align 8
  store i8 9, ptr %308, align 1
  %310 = load ptr, ptr %18, align 8
  %311 = getelementptr inbounds i8, ptr %310, i32 1
  store ptr %311, ptr %18, align 8
  br label %709

312:                                              ; preds = %292
  %313 = load ptr, ptr %17, align 8
  %314 = getelementptr inbounds i8, ptr %313, i32 1
  store ptr %314, ptr %17, align 8
  store i8 8, ptr %313, align 1
  %315 = load ptr, ptr %18, align 8
  %316 = getelementptr inbounds i8, ptr %315, i32 1
  store ptr %316, ptr %18, align 8
  br label %709

317:                                              ; preds = %292
  %318 = load ptr, ptr %18, align 8
  %319 = getelementptr inbounds i8, ptr %318, i32 1
  store ptr %319, ptr %18, align 8
  store i32 0, ptr %19, align 4
  store i32 0, ptr %20, align 4
  store i32 16, ptr %21, align 4
  store ptr %18, ptr %22, align 8
  br label %320

320:                                              ; preds = %435, %317
  %321 = load i32, ptr %20, align 4
  %322 = load i32, ptr %21, align 4
  %323 = icmp eq i32 %322, 16
  %324 = zext i1 %323 to i64
  %325 = select i1 %323, i32 2, i32 3
  %326 = icmp slt i32 %321, %325
  br i1 %326, label %327, label %371

327:                                              ; preds = %320
  %328 = load ptr, ptr %22, align 8
  %329 = load ptr, ptr %328, align 8
  %330 = load i8, ptr %329, align 1
  %331 = zext i8 %330 to i32
  %332 = icmp sge i32 %331, 48
  br i1 %332, label %333, label %347

333:                                              ; preds = %327
  %334 = load ptr, ptr %22, align 8
  %335 = load ptr, ptr %334, align 8
  %336 = load i8, ptr %335, align 1
  %337 = zext i8 %336 to i32
  %338 = load i32, ptr %21, align 4
  %339 = icmp sgt i32 %338, 10
  br i1 %339, label %340, label %341

340:                                              ; preds = %333
  br label %343

341:                                              ; preds = %333
  %342 = load i32, ptr %21, align 4
  br label %343

343:                                              ; preds = %341, %340
  %344 = phi i32 [ 10, %340 ], [ %342, %341 ]
  %345 = add nsw i32 48, %344
  %346 = icmp slt i32 %337, %345
  br i1 %346, label %369, label %347

347:                                              ; preds = %343, %327
  %348 = load i32, ptr %21, align 4
  %349 = icmp sge i32 %348, 10
  br i1 %349, label %350, label %367

350:                                              ; preds = %347
  %351 = load ptr, ptr %22, align 8
  %352 = load ptr, ptr %351, align 8
  %353 = load i8, ptr %352, align 1
  %354 = zext i8 %353 to i32
  %355 = call i32 @toupper(i32 noundef %354) #9
  %356 = icmp sge i32 %355, 65
  br i1 %356, label %357, label %367

357:                                              ; preds = %350
  %358 = load ptr, ptr %22, align 8
  %359 = load ptr, ptr %358, align 8
  %360 = load i8, ptr %359, align 1
  %361 = zext i8 %360 to i32
  %362 = call i32 @toupper(i32 noundef %361) #9
  %363 = load i32, ptr %21, align 4
  %364 = add nsw i32 65, %363
  %365 = sub nsw i32 %364, 10
  %366 = icmp slt i32 %362, %365
  br label %367

367:                                              ; preds = %357, %350, %347
  %368 = phi i1 [ false, %350 ], [ false, %347 ], [ %366, %357 ]
  br label %369

369:                                              ; preds = %367, %343
  %370 = phi i1 [ true, %343 ], [ %368, %367 ]
  br label %371

371:                                              ; preds = %369, %320
  %372 = phi i1 [ false, %320 ], [ %370, %369 ]
  br i1 %372, label %373, label %441

373:                                              ; preds = %371
  %374 = load i32, ptr %21, align 4
  %375 = load i32, ptr %19, align 4
  %376 = mul nsw i32 %375, %374
  store i32 %376, ptr %19, align 4
  %377 = load ptr, ptr %22, align 8
  %378 = load ptr, ptr %377, align 8
  %379 = load i8, ptr %378, align 1
  %380 = zext i8 %379 to i32
  %381 = icmp sge i32 %380, 48
  br i1 %381, label %382, label %404

382:                                              ; preds = %373
  %383 = load ptr, ptr %22, align 8
  %384 = load ptr, ptr %383, align 8
  %385 = load i8, ptr %384, align 1
  %386 = zext i8 %385 to i32
  %387 = load i32, ptr %21, align 4
  %388 = icmp sgt i32 %387, 10
  br i1 %388, label %389, label %390

389:                                              ; preds = %382
  br label %392

390:                                              ; preds = %382
  %391 = load i32, ptr %21, align 4
  br label %392

392:                                              ; preds = %390, %389
  %393 = phi i32 [ 10, %389 ], [ %391, %390 ]
  %394 = add nsw i32 48, %393
  %395 = icmp slt i32 %386, %394
  br i1 %395, label %396, label %404

396:                                              ; preds = %392
  %397 = load ptr, ptr %22, align 8
  %398 = load ptr, ptr %397, align 8
  %399 = load i8, ptr %398, align 1
  %400 = zext i8 %399 to i32
  %401 = sub nsw i32 %400, 48
  %402 = load i32, ptr %19, align 4
  %403 = add nsw i32 %402, %401
  store i32 %403, ptr %19, align 4
  br label %435

404:                                              ; preds = %392, %373
  %405 = load i32, ptr %21, align 4
  %406 = icmp sge i32 %405, 10
  br i1 %406, label %407, label %434

407:                                              ; preds = %404
  %408 = load ptr, ptr %22, align 8
  %409 = load ptr, ptr %408, align 8
  %410 = load i8, ptr %409, align 1
  %411 = zext i8 %410 to i32
  %412 = call i32 @toupper(i32 noundef %411) #9
  %413 = icmp sge i32 %412, 65
  br i1 %413, label %414, label %434

414:                                              ; preds = %407
  %415 = load ptr, ptr %22, align 8
  %416 = load ptr, ptr %415, align 8
  %417 = load i8, ptr %416, align 1
  %418 = zext i8 %417 to i32
  %419 = call i32 @toupper(i32 noundef %418) #9
  %420 = load i32, ptr %21, align 4
  %421 = add nsw i32 65, %420
  %422 = sub nsw i32 %421, 10
  %423 = icmp slt i32 %419, %422
  br i1 %423, label %424, label %434

424:                                              ; preds = %414
  %425 = load ptr, ptr %22, align 8
  %426 = load ptr, ptr %425, align 8
  %427 = load i8, ptr %426, align 1
  %428 = zext i8 %427 to i32
  %429 = call i32 @toupper(i32 noundef %428) #9
  %430 = sub nsw i32 %429, 65
  %431 = add nsw i32 %430, 10
  %432 = load i32, ptr %19, align 4
  %433 = add nsw i32 %432, %431
  store i32 %433, ptr %19, align 4
  br label %434

434:                                              ; preds = %424, %414, %407, %404
  br label %435

435:                                              ; preds = %434, %396
  %436 = load ptr, ptr %22, align 8
  %437 = load ptr, ptr %436, align 8
  %438 = getelementptr inbounds i8, ptr %437, i32 1
  store ptr %438, ptr %436, align 8
  %439 = load i32, ptr %20, align 4
  %440 = add nsw i32 %439, 1
  store i32 %440, ptr %20, align 4
  br label %320, !llvm.loop !21

441:                                              ; preds = %371
  %442 = load i32, ptr %19, align 4
  %443 = and i32 %442, 255
  %444 = trunc i32 %443 to i8
  %445 = load ptr, ptr %17, align 8
  %446 = getelementptr inbounds i8, ptr %445, i32 1
  store ptr %446, ptr %17, align 8
  store i8 %444, ptr %445, align 1
  br label %709

447:                                              ; preds = %292
  store i32 0, ptr %19, align 4
  store i32 0, ptr %20, align 4
  store i32 8, ptr %21, align 4
  store ptr %18, ptr %22, align 8
  br label %448

448:                                              ; preds = %563, %447
  %449 = load i32, ptr %20, align 4
  %450 = load i32, ptr %21, align 4
  %451 = icmp eq i32 %450, 16
  %452 = zext i1 %451 to i64
  %453 = select i1 %451, i32 2, i32 3
  %454 = icmp slt i32 %449, %453
  br i1 %454, label %455, label %499

455:                                              ; preds = %448
  %456 = load ptr, ptr %22, align 8
  %457 = load ptr, ptr %456, align 8
  %458 = load i8, ptr %457, align 1
  %459 = zext i8 %458 to i32
  %460 = icmp sge i32 %459, 48
  br i1 %460, label %461, label %475

461:                                              ; preds = %455
  %462 = load ptr, ptr %22, align 8
  %463 = load ptr, ptr %462, align 8
  %464 = load i8, ptr %463, align 1
  %465 = zext i8 %464 to i32
  %466 = load i32, ptr %21, align 4
  %467 = icmp sgt i32 %466, 10
  br i1 %467, label %468, label %469

468:                                              ; preds = %461
  br label %471

469:                                              ; preds = %461
  %470 = load i32, ptr %21, align 4
  br label %471

471:                                              ; preds = %469, %468
  %472 = phi i32 [ 10, %468 ], [ %470, %469 ]
  %473 = add nsw i32 48, %472
  %474 = icmp slt i32 %465, %473
  br i1 %474, label %497, label %475

475:                                              ; preds = %471, %455
  %476 = load i32, ptr %21, align 4
  %477 = icmp sge i32 %476, 10
  br i1 %477, label %478, label %495

478:                                              ; preds = %475
  %479 = load ptr, ptr %22, align 8
  %480 = load ptr, ptr %479, align 8
  %481 = load i8, ptr %480, align 1
  %482 = zext i8 %481 to i32
  %483 = call i32 @toupper(i32 noundef %482) #9
  %484 = icmp sge i32 %483, 65
  br i1 %484, label %485, label %495

485:                                              ; preds = %478
  %486 = load ptr, ptr %22, align 8
  %487 = load ptr, ptr %486, align 8
  %488 = load i8, ptr %487, align 1
  %489 = zext i8 %488 to i32
  %490 = call i32 @toupper(i32 noundef %489) #9
  %491 = load i32, ptr %21, align 4
  %492 = add nsw i32 65, %491
  %493 = sub nsw i32 %492, 10
  %494 = icmp slt i32 %490, %493
  br label %495

495:                                              ; preds = %485, %478, %475
  %496 = phi i1 [ false, %478 ], [ false, %475 ], [ %494, %485 ]
  br label %497

497:                                              ; preds = %495, %471
  %498 = phi i1 [ true, %471 ], [ %496, %495 ]
  br label %499

499:                                              ; preds = %497, %448
  %500 = phi i1 [ false, %448 ], [ %498, %497 ]
  br i1 %500, label %501, label %569

501:                                              ; preds = %499
  %502 = load i32, ptr %21, align 4
  %503 = load i32, ptr %19, align 4
  %504 = mul nsw i32 %503, %502
  store i32 %504, ptr %19, align 4
  %505 = load ptr, ptr %22, align 8
  %506 = load ptr, ptr %505, align 8
  %507 = load i8, ptr %506, align 1
  %508 = zext i8 %507 to i32
  %509 = icmp sge i32 %508, 48
  br i1 %509, label %510, label %532

510:                                              ; preds = %501
  %511 = load ptr, ptr %22, align 8
  %512 = load ptr, ptr %511, align 8
  %513 = load i8, ptr %512, align 1
  %514 = zext i8 %513 to i32
  %515 = load i32, ptr %21, align 4
  %516 = icmp sgt i32 %515, 10
  br i1 %516, label %517, label %518

517:                                              ; preds = %510
  br label %520

518:                                              ; preds = %510
  %519 = load i32, ptr %21, align 4
  br label %520

520:                                              ; preds = %518, %517
  %521 = phi i32 [ 10, %517 ], [ %519, %518 ]
  %522 = add nsw i32 48, %521
  %523 = icmp slt i32 %514, %522
  br i1 %523, label %524, label %532

524:                                              ; preds = %520
  %525 = load ptr, ptr %22, align 8
  %526 = load ptr, ptr %525, align 8
  %527 = load i8, ptr %526, align 1
  %528 = zext i8 %527 to i32
  %529 = sub nsw i32 %528, 48
  %530 = load i32, ptr %19, align 4
  %531 = add nsw i32 %530, %529
  store i32 %531, ptr %19, align 4
  br label %563

532:                                              ; preds = %520, %501
  %533 = load i32, ptr %21, align 4
  %534 = icmp sge i32 %533, 10
  br i1 %534, label %535, label %562

535:                                              ; preds = %532
  %536 = load ptr, ptr %22, align 8
  %537 = load ptr, ptr %536, align 8
  %538 = load i8, ptr %537, align 1
  %539 = zext i8 %538 to i32
  %540 = call i32 @toupper(i32 noundef %539) #9
  %541 = icmp sge i32 %540, 65
  br i1 %541, label %542, label %562

542:                                              ; preds = %535
  %543 = load ptr, ptr %22, align 8
  %544 = load ptr, ptr %543, align 8
  %545 = load i8, ptr %544, align 1
  %546 = zext i8 %545 to i32
  %547 = call i32 @toupper(i32 noundef %546) #9
  %548 = load i32, ptr %21, align 4
  %549 = add nsw i32 65, %548
  %550 = sub nsw i32 %549, 10
  %551 = icmp slt i32 %547, %550
  br i1 %551, label %552, label %562

552:                                              ; preds = %542
  %553 = load ptr, ptr %22, align 8
  %554 = load ptr, ptr %553, align 8
  %555 = load i8, ptr %554, align 1
  %556 = zext i8 %555 to i32
  %557 = call i32 @toupper(i32 noundef %556) #9
  %558 = sub nsw i32 %557, 65
  %559 = add nsw i32 %558, 10
  %560 = load i32, ptr %19, align 4
  %561 = add nsw i32 %560, %559
  store i32 %561, ptr %19, align 4
  br label %562

562:                                              ; preds = %552, %542, %535, %532
  br label %563

563:                                              ; preds = %562, %524
  %564 = load ptr, ptr %22, align 8
  %565 = load ptr, ptr %564, align 8
  %566 = getelementptr inbounds i8, ptr %565, i32 1
  store ptr %566, ptr %564, align 8
  %567 = load i32, ptr %20, align 4
  %568 = add nsw i32 %567, 1
  store i32 %568, ptr %20, align 4
  br label %448, !llvm.loop !22

569:                                              ; preds = %499
  %570 = load i32, ptr %19, align 4
  %571 = and i32 %570, 255
  %572 = trunc i32 %571 to i8
  %573 = load ptr, ptr %17, align 8
  %574 = getelementptr inbounds i8, ptr %573, i32 1
  store ptr %574, ptr %17, align 8
  store i8 %572, ptr %573, align 1
  br label %709

575:                                              ; preds = %292, %292, %292, %292, %292, %292, %292, %292, %292
  store i32 0, ptr %19, align 4
  store i32 0, ptr %20, align 4
  store i32 10, ptr %21, align 4
  store ptr %18, ptr %22, align 8
  br label %576

576:                                              ; preds = %691, %575
  %577 = load i32, ptr %20, align 4
  %578 = load i32, ptr %21, align 4
  %579 = icmp eq i32 %578, 16
  %580 = zext i1 %579 to i64
  %581 = select i1 %579, i32 2, i32 3
  %582 = icmp slt i32 %577, %581
  br i1 %582, label %583, label %627

583:                                              ; preds = %576
  %584 = load ptr, ptr %22, align 8
  %585 = load ptr, ptr %584, align 8
  %586 = load i8, ptr %585, align 1
  %587 = zext i8 %586 to i32
  %588 = icmp sge i32 %587, 48
  br i1 %588, label %589, label %603

589:                                              ; preds = %583
  %590 = load ptr, ptr %22, align 8
  %591 = load ptr, ptr %590, align 8
  %592 = load i8, ptr %591, align 1
  %593 = zext i8 %592 to i32
  %594 = load i32, ptr %21, align 4
  %595 = icmp sgt i32 %594, 10
  br i1 %595, label %596, label %597

596:                                              ; preds = %589
  br label %599

597:                                              ; preds = %589
  %598 = load i32, ptr %21, align 4
  br label %599

599:                                              ; preds = %597, %596
  %600 = phi i32 [ 10, %596 ], [ %598, %597 ]
  %601 = add nsw i32 48, %600
  %602 = icmp slt i32 %593, %601
  br i1 %602, label %625, label %603

603:                                              ; preds = %599, %583
  %604 = load i32, ptr %21, align 4
  %605 = icmp sge i32 %604, 10
  br i1 %605, label %606, label %623

606:                                              ; preds = %603
  %607 = load ptr, ptr %22, align 8
  %608 = load ptr, ptr %607, align 8
  %609 = load i8, ptr %608, align 1
  %610 = zext i8 %609 to i32
  %611 = call i32 @toupper(i32 noundef %610) #9
  %612 = icmp sge i32 %611, 65
  br i1 %612, label %613, label %623

613:                                              ; preds = %606
  %614 = load ptr, ptr %22, align 8
  %615 = load ptr, ptr %614, align 8
  %616 = load i8, ptr %615, align 1
  %617 = zext i8 %616 to i32
  %618 = call i32 @toupper(i32 noundef %617) #9
  %619 = load i32, ptr %21, align 4
  %620 = add nsw i32 65, %619
  %621 = sub nsw i32 %620, 10
  %622 = icmp slt i32 %618, %621
  br label %623

623:                                              ; preds = %613, %606, %603
  %624 = phi i1 [ false, %606 ], [ false, %603 ], [ %622, %613 ]
  br label %625

625:                                              ; preds = %623, %599
  %626 = phi i1 [ true, %599 ], [ %624, %623 ]
  br label %627

627:                                              ; preds = %625, %576
  %628 = phi i1 [ false, %576 ], [ %626, %625 ]
  br i1 %628, label %629, label %697

629:                                              ; preds = %627
  %630 = load i32, ptr %21, align 4
  %631 = load i32, ptr %19, align 4
  %632 = mul nsw i32 %631, %630
  store i32 %632, ptr %19, align 4
  %633 = load ptr, ptr %22, align 8
  %634 = load ptr, ptr %633, align 8
  %635 = load i8, ptr %634, align 1
  %636 = zext i8 %635 to i32
  %637 = icmp sge i32 %636, 48
  br i1 %637, label %638, label %660

638:                                              ; preds = %629
  %639 = load ptr, ptr %22, align 8
  %640 = load ptr, ptr %639, align 8
  %641 = load i8, ptr %640, align 1
  %642 = zext i8 %641 to i32
  %643 = load i32, ptr %21, align 4
  %644 = icmp sgt i32 %643, 10
  br i1 %644, label %645, label %646

645:                                              ; preds = %638
  br label %648

646:                                              ; preds = %638
  %647 = load i32, ptr %21, align 4
  br label %648

648:                                              ; preds = %646, %645
  %649 = phi i32 [ 10, %645 ], [ %647, %646 ]
  %650 = add nsw i32 48, %649
  %651 = icmp slt i32 %642, %650
  br i1 %651, label %652, label %660

652:                                              ; preds = %648
  %653 = load ptr, ptr %22, align 8
  %654 = load ptr, ptr %653, align 8
  %655 = load i8, ptr %654, align 1
  %656 = zext i8 %655 to i32
  %657 = sub nsw i32 %656, 48
  %658 = load i32, ptr %19, align 4
  %659 = add nsw i32 %658, %657
  store i32 %659, ptr %19, align 4
  br label %691

660:                                              ; preds = %648, %629
  %661 = load i32, ptr %21, align 4
  %662 = icmp sge i32 %661, 10
  br i1 %662, label %663, label %690

663:                                              ; preds = %660
  %664 = load ptr, ptr %22, align 8
  %665 = load ptr, ptr %664, align 8
  %666 = load i8, ptr %665, align 1
  %667 = zext i8 %666 to i32
  %668 = call i32 @toupper(i32 noundef %667) #9
  %669 = icmp sge i32 %668, 65
  br i1 %669, label %670, label %690

670:                                              ; preds = %663
  %671 = load ptr, ptr %22, align 8
  %672 = load ptr, ptr %671, align 8
  %673 = load i8, ptr %672, align 1
  %674 = zext i8 %673 to i32
  %675 = call i32 @toupper(i32 noundef %674) #9
  %676 = load i32, ptr %21, align 4
  %677 = add nsw i32 65, %676
  %678 = sub nsw i32 %677, 10
  %679 = icmp slt i32 %675, %678
  br i1 %679, label %680, label %690

680:                                              ; preds = %670
  %681 = load ptr, ptr %22, align 8
  %682 = load ptr, ptr %681, align 8
  %683 = load i8, ptr %682, align 1
  %684 = zext i8 %683 to i32
  %685 = call i32 @toupper(i32 noundef %684) #9
  %686 = sub nsw i32 %685, 65
  %687 = add nsw i32 %686, 10
  %688 = load i32, ptr %19, align 4
  %689 = add nsw i32 %688, %687
  store i32 %689, ptr %19, align 4
  br label %690

690:                                              ; preds = %680, %670, %663, %660
  br label %691

691:                                              ; preds = %690, %652
  %692 = load ptr, ptr %22, align 8
  %693 = load ptr, ptr %692, align 8
  %694 = getelementptr inbounds i8, ptr %693, i32 1
  store ptr %694, ptr %692, align 8
  %695 = load i32, ptr %20, align 4
  %696 = add nsw i32 %695, 1
  store i32 %696, ptr %20, align 4
  br label %576, !llvm.loop !23

697:                                              ; preds = %627
  %698 = load i32, ptr %19, align 4
  %699 = and i32 %698, 255
  %700 = trunc i32 %699 to i8
  %701 = load ptr, ptr %17, align 8
  %702 = getelementptr inbounds i8, ptr %701, i32 1
  store ptr %702, ptr %17, align 8
  store i8 %700, ptr %701, align 1
  br label %709

703:                                              ; preds = %292
  %704 = load ptr, ptr %18, align 8
  %705 = getelementptr inbounds i8, ptr %704, i32 1
  store ptr %705, ptr %18, align 8
  %706 = load i8, ptr %704, align 1
  %707 = load ptr, ptr %17, align 8
  %708 = getelementptr inbounds i8, ptr %707, i32 1
  store ptr %708, ptr %17, align 8
  store i8 %706, ptr %707, align 1
  br label %709

709:                                              ; preds = %703, %697, %569, %441, %312, %307, %302, %297
  br label %710

710:                                              ; preds = %709, %286
  br label %277, !llvm.loop !24

711:                                              ; preds = %277
  %712 = load ptr, ptr %17, align 8
  store i8 0, ptr %712, align 1
  %713 = load ptr, ptr %17, align 8
  %714 = load ptr, ptr %16, align 8
  %715 = ptrtoint ptr %713 to i64
  %716 = ptrtoint ptr %714 to i64
  %717 = sub i64 %715, %716
  %718 = trunc i64 %717 to i32
  store i32 %718, ptr @rlen_SHARED, align 4
  %719 = load ptr, ptr @rstr_SHARED, align 8
  store ptr %719, ptr %24, align 8
  %720 = load i32, ptr @rlen_SHARED, align 4
  store i32 %720, ptr %25, align 4
  %721 = load i32, ptr @ignore_case_SHARED, align 4
  store i32 %721, ptr %26, align 4
  store ptr @bmb_icase_SHARED, ptr %27, align 8
  %722 = load i32, ptr %26, align 4
  store i32 %722, ptr @bmb_icase_SHARED, align 4
  %723 = load i32, ptr %25, align 4
  %724 = sext i32 %723 to i64
  %725 = call ptr @calloc(i64 noundef 4, i64 noundef %724) #12
  store ptr %725, ptr @bmb_bmGs_SHARED, align 8
  %726 = load ptr, ptr @bmb_bmGs_SHARED, align 8
  %727 = icmp eq ptr %726, null
  br i1 %727, label %728, label %729

728:                                              ; preds = %711
  store i32 -1, ptr %23, align 4
  br label %1010

729:                                              ; preds = %711
  %730 = load i32, ptr %25, align 4
  store i32 %730, ptr @bmb_saved_m_SHARED, align 4
  %731 = load i32, ptr %25, align 4
  %732 = sext i32 %731 to i64
  %733 = call ptr @malloc(i64 noundef %732) #11
  store ptr %733, ptr @bmb_saved_x_SHARED, align 8
  %734 = load ptr, ptr @bmb_saved_x_SHARED, align 8
  %735 = icmp eq ptr %734, null
  br i1 %735, label %736, label %737

736:                                              ; preds = %729
  store i32 -2, ptr %23, align 4
  br label %1009

737:                                              ; preds = %729
  store i32 0, ptr %6, align 4
  br label %738

738:                                              ; preds = %767, %737
  %739 = load i32, ptr %6, align 4
  %740 = load i32, ptr %25, align 4
  %741 = icmp slt i32 %739, %740
  br i1 %741, label %742, label %770

742:                                              ; preds = %738
  %743 = load i32, ptr %26, align 4
  %744 = icmp ne i32 %743, 0
  br i1 %744, label %745, label %753

745:                                              ; preds = %742
  %746 = load ptr, ptr %24, align 8
  %747 = load i32, ptr %6, align 4
  %748 = sext i32 %747 to i64
  %749 = getelementptr inbounds i8, ptr %746, i64 %748
  %750 = load i8, ptr %749, align 1
  %751 = zext i8 %750 to i32
  %752 = call i32 @tolower(i32 noundef %751) #9
  br label %760

753:                                              ; preds = %742
  %754 = load ptr, ptr %24, align 8
  %755 = load i32, ptr %6, align 4
  %756 = sext i32 %755 to i64
  %757 = getelementptr inbounds i8, ptr %754, i64 %756
  %758 = load i8, ptr %757, align 1
  %759 = zext i8 %758 to i32
  br label %760

760:                                              ; preds = %753, %745
  %761 = phi i32 [ %752, %745 ], [ %759, %753 ]
  %762 = trunc i32 %761 to i8
  %763 = load ptr, ptr @bmb_saved_x_SHARED, align 8
  %764 = load i32, ptr %6, align 4
  %765 = sext i32 %764 to i64
  %766 = getelementptr inbounds i8, ptr %763, i64 %765
  store i8 %762, ptr %766, align 1
  br label %767

767:                                              ; preds = %760
  %768 = load i32, ptr %6, align 4
  %769 = add nsw i32 %768, 1
  store i32 %769, ptr %6, align 4
  br label %738, !llvm.loop !25

770:                                              ; preds = %738
  %771 = load ptr, ptr @bmb_saved_x_SHARED, align 8
  store ptr %771, ptr %28, align 8
  %772 = load ptr, ptr @bmb_bmGs_SHARED, align 8
  store ptr %772, ptr %29, align 8
  %773 = load i32, ptr %25, align 4
  %774 = sext i32 %773 to i64
  %775 = call ptr @calloc(i64 noundef 4, i64 noundef %774) #12
  store ptr %775, ptr %30, align 8
  %776 = load ptr, ptr %30, align 8
  %777 = icmp eq ptr %776, null
  br i1 %777, label %778, label %779

778:                                              ; preds = %770
  store i32 -1, ptr @main.preBmGs_ret, align 4
  br label %967

779:                                              ; preds = %770
  store i32 0, ptr %33, align 4
  %780 = load i32, ptr %25, align 4
  %781 = load ptr, ptr %30, align 8
  %782 = load i32, ptr %25, align 4
  %783 = sub nsw i32 %782, 1
  %784 = sext i32 %783 to i64
  %785 = getelementptr inbounds i32, ptr %781, i64 %784
  store i32 %780, ptr %785, align 4
  %786 = load i32, ptr %25, align 4
  %787 = sub nsw i32 %786, 1
  store i32 %787, ptr %34, align 4
  %788 = load i32, ptr %25, align 4
  %789 = sub nsw i32 %788, 2
  store i32 %789, ptr %35, align 4
  br label %790

790:                                              ; preds = %871, %779
  %791 = load i32, ptr %35, align 4
  %792 = icmp sge i32 %791, 0
  br i1 %792, label %793, label %874

793:                                              ; preds = %790
  %794 = load i32, ptr %35, align 4
  %795 = load i32, ptr %34, align 4
  %796 = icmp sgt i32 %794, %795
  br i1 %796, label %797, label %827

797:                                              ; preds = %793
  %798 = load ptr, ptr %30, align 8
  %799 = load i32, ptr %35, align 4
  %800 = load i32, ptr %25, align 4
  %801 = add nsw i32 %799, %800
  %802 = sub nsw i32 %801, 1
  %803 = load i32, ptr %33, align 4
  %804 = sub nsw i32 %802, %803
  %805 = sext i32 %804 to i64
  %806 = getelementptr inbounds i32, ptr %798, i64 %805
  %807 = load i32, ptr %806, align 4
  %808 = load i32, ptr %35, align 4
  %809 = load i32, ptr %34, align 4
  %810 = sub nsw i32 %808, %809
  %811 = icmp slt i32 %807, %810
  br i1 %811, label %812, label %827

812:                                              ; preds = %797
  %813 = load ptr, ptr %30, align 8
  %814 = load i32, ptr %35, align 4
  %815 = load i32, ptr %25, align 4
  %816 = add nsw i32 %814, %815
  %817 = sub nsw i32 %816, 1
  %818 = load i32, ptr %33, align 4
  %819 = sub nsw i32 %817, %818
  %820 = sext i32 %819 to i64
  %821 = getelementptr inbounds i32, ptr %813, i64 %820
  %822 = load i32, ptr %821, align 4
  %823 = load ptr, ptr %30, align 8
  %824 = load i32, ptr %35, align 4
  %825 = sext i32 %824 to i64
  %826 = getelementptr inbounds i32, ptr %823, i64 %825
  store i32 %822, ptr %826, align 4
  br label %870

827:                                              ; preds = %797, %793
  %828 = load i32, ptr %35, align 4
  %829 = load i32, ptr %34, align 4
  %830 = icmp slt i32 %828, %829
  br i1 %830, label %831, label %833

831:                                              ; preds = %827
  %832 = load i32, ptr %35, align 4
  store i32 %832, ptr %34, align 4
  br label %833

833:                                              ; preds = %831, %827
  %834 = load i32, ptr %35, align 4
  store i32 %834, ptr %33, align 4
  br label %835

835:                                              ; preds = %859, %833
  %836 = load i32, ptr %34, align 4
  %837 = icmp sge i32 %836, 0
  br i1 %837, label %838, label %857

838:                                              ; preds = %835
  %839 = load ptr, ptr %28, align 8
  %840 = load i32, ptr %34, align 4
  %841 = sext i32 %840 to i64
  %842 = getelementptr inbounds i8, ptr %839, i64 %841
  %843 = load i8, ptr %842, align 1
  %844 = zext i8 %843 to i32
  %845 = load ptr, ptr %28, align 8
  %846 = load i32, ptr %34, align 4
  %847 = load i32, ptr %25, align 4
  %848 = add nsw i32 %846, %847
  %849 = sub nsw i32 %848, 1
  %850 = load i32, ptr %33, align 4
  %851 = sub nsw i32 %849, %850
  %852 = sext i32 %851 to i64
  %853 = getelementptr inbounds i8, ptr %845, i64 %852
  %854 = load i8, ptr %853, align 1
  %855 = zext i8 %854 to i32
  %856 = icmp eq i32 %844, %855
  br label %857

857:                                              ; preds = %838, %835
  %858 = phi i1 [ false, %835 ], [ %856, %838 ]
  br i1 %858, label %859, label %862

859:                                              ; preds = %857
  %860 = load i32, ptr %34, align 4
  %861 = add nsw i32 %860, -1
  store i32 %861, ptr %34, align 4
  br label %835, !llvm.loop !26

862:                                              ; preds = %857
  %863 = load i32, ptr %33, align 4
  %864 = load i32, ptr %34, align 4
  %865 = sub nsw i32 %863, %864
  %866 = load ptr, ptr %30, align 8
  %867 = load i32, ptr %35, align 4
  %868 = sext i32 %867 to i64
  %869 = getelementptr inbounds i32, ptr %866, i64 %868
  store i32 %865, ptr %869, align 4
  br label %870

870:                                              ; preds = %862, %812
  br label %871

871:                                              ; preds = %870
  %872 = load i32, ptr %35, align 4
  %873 = add nsw i32 %872, -1
  store i32 %873, ptr %35, align 4
  br label %790, !llvm.loop !27

874:                                              ; preds = %790
  store i32 0, ptr %35, align 4
  br label %875

875:                                              ; preds = %885, %874
  %876 = load i32, ptr %35, align 4
  %877 = load i32, ptr %25, align 4
  %878 = icmp slt i32 %876, %877
  br i1 %878, label %879, label %888

879:                                              ; preds = %875
  %880 = load i32, ptr %25, align 4
  %881 = load ptr, ptr %29, align 8
  %882 = load i32, ptr %35, align 4
  %883 = sext i32 %882 to i64
  %884 = getelementptr inbounds i32, ptr %881, i64 %883
  store i32 %880, ptr %884, align 4
  br label %885

885:                                              ; preds = %879
  %886 = load i32, ptr %35, align 4
  %887 = add nsw i32 %886, 1
  store i32 %887, ptr %35, align 4
  br label %875, !llvm.loop !28

888:                                              ; preds = %875
  store i32 0, ptr %32, align 4
  %889 = load i32, ptr %25, align 4
  %890 = sub nsw i32 %889, 1
  store i32 %890, ptr %35, align 4
  br label %891

891:                                              ; preds = %937, %888
  %892 = load i32, ptr %35, align 4
  %893 = icmp sge i32 %892, -1
  br i1 %893, label %894, label %940

894:                                              ; preds = %891
  %895 = load i32, ptr %35, align 4
  %896 = icmp eq i32 %895, -1
  br i1 %896, label %906, label %897

897:                                              ; preds = %894
  %898 = load ptr, ptr %30, align 8
  %899 = load i32, ptr %35, align 4
  %900 = sext i32 %899 to i64
  %901 = getelementptr inbounds i32, ptr %898, i64 %900
  %902 = load i32, ptr %901, align 4
  %903 = load i32, ptr %35, align 4
  %904 = add nsw i32 %903, 1
  %905 = icmp eq i32 %902, %904
  br i1 %905, label %906, label %936

906:                                              ; preds = %897, %894
  br label %907

907:                                              ; preds = %932, %906
  %908 = load i32, ptr %32, align 4
  %909 = load i32, ptr %25, align 4
  %910 = sub nsw i32 %909, 1
  %911 = load i32, ptr %35, align 4
  %912 = sub nsw i32 %910, %911
  %913 = icmp slt i32 %908, %912
  br i1 %913, label %914, label %935

914:                                              ; preds = %907
  %915 = load ptr, ptr %29, align 8
  %916 = load i32, ptr %32, align 4
  %917 = sext i32 %916 to i64
  %918 = getelementptr inbounds i32, ptr %915, i64 %917
  %919 = load i32, ptr %918, align 4
  %920 = load i32, ptr %25, align 4
  %921 = icmp eq i32 %919, %920
  br i1 %921, label %922, label %931

922:                                              ; preds = %914
  %923 = load i32, ptr %25, align 4
  %924 = sub nsw i32 %923, 1
  %925 = load i32, ptr %35, align 4
  %926 = sub nsw i32 %924, %925
  %927 = load ptr, ptr %29, align 8
  %928 = load i32, ptr %32, align 4
  %929 = sext i32 %928 to i64
  %930 = getelementptr inbounds i32, ptr %927, i64 %929
  store i32 %926, ptr %930, align 4
  br label %931

931:                                              ; preds = %922, %914
  br label %932

932:                                              ; preds = %931
  %933 = load i32, ptr %32, align 4
  %934 = add nsw i32 %933, 1
  store i32 %934, ptr %32, align 4
  br label %907, !llvm.loop !29

935:                                              ; preds = %907
  br label %936

936:                                              ; preds = %935, %897
  br label %937

937:                                              ; preds = %936
  %938 = load i32, ptr %35, align 4
  %939 = add nsw i32 %938, -1
  store i32 %939, ptr %35, align 4
  br label %891, !llvm.loop !30

940:                                              ; preds = %891
  store i32 0, ptr %35, align 4
  br label %941

941:                                              ; preds = %962, %940
  %942 = load i32, ptr %35, align 4
  %943 = load i32, ptr %25, align 4
  %944 = sub nsw i32 %943, 2
  %945 = icmp sle i32 %942, %944
  br i1 %945, label %946, label %965

946:                                              ; preds = %941
  %947 = load i32, ptr %25, align 4
  %948 = sub nsw i32 %947, 1
  %949 = load i32, ptr %35, align 4
  %950 = sub nsw i32 %948, %949
  %951 = load ptr, ptr %29, align 8
  %952 = load i32, ptr %25, align 4
  %953 = sub nsw i32 %952, 1
  %954 = load ptr, ptr %30, align 8
  %955 = load i32, ptr %35, align 4
  %956 = sext i32 %955 to i64
  %957 = getelementptr inbounds i32, ptr %954, i64 %956
  %958 = load i32, ptr %957, align 4
  %959 = sub nsw i32 %953, %958
  %960 = sext i32 %959 to i64
  %961 = getelementptr inbounds i32, ptr %951, i64 %960
  store i32 %950, ptr %961, align 4
  br label %962

962:                                              ; preds = %946
  %963 = load i32, ptr %35, align 4
  %964 = add nsw i32 %963, 1
  store i32 %964, ptr %35, align 4
  br label %941, !llvm.loop !31

965:                                              ; preds = %941
  %966 = load ptr, ptr %30, align 8
  call void @free(ptr noundef %966)
  store i32 0, ptr @main.preBmGs_ret, align 4
  br label %967

967:                                              ; preds = %965, %778
  %968 = load i32, ptr @main.preBmGs_ret, align 4
  %969 = icmp slt i32 %968, 0
  br i1 %969, label %970, label %971

970:                                              ; preds = %967
  store i32 -3, ptr %23, align 4
  br label %1008

971:                                              ; preds = %967
  %972 = load ptr, ptr @bmb_saved_x_SHARED, align 8
  store ptr %972, ptr %37, align 8
  store ptr @bmb_bmBc_SHARED, ptr %38, align 8
  store i32 0, ptr %36, align 4
  br label %973

973:                                              ; preds = %982, %971
  %974 = load i32, ptr %36, align 4
  %975 = icmp slt i32 %974, 256
  br i1 %975, label %976, label %985

976:                                              ; preds = %973
  %977 = load i32, ptr %25, align 4
  %978 = load ptr, ptr %38, align 8
  %979 = load i32, ptr %36, align 4
  %980 = sext i32 %979 to i64
  %981 = getelementptr inbounds i32, ptr %978, i64 %980
  store i32 %977, ptr %981, align 4
  br label %982

982:                                              ; preds = %976
  %983 = load i32, ptr %36, align 4
  %984 = add nsw i32 %983, 1
  store i32 %984, ptr %36, align 4
  br label %973, !llvm.loop !32

985:                                              ; preds = %973
  store i32 0, ptr %36, align 4
  br label %986

986:                                              ; preds = %1004, %985
  %987 = load i32, ptr %36, align 4
  %988 = load i32, ptr %25, align 4
  %989 = sub nsw i32 %988, 1
  %990 = icmp slt i32 %987, %989
  br i1 %990, label %991, label %1007

991:                                              ; preds = %986
  %992 = load i32, ptr %25, align 4
  %993 = load i32, ptr %36, align 4
  %994 = sub nsw i32 %992, %993
  %995 = sub nsw i32 %994, 1
  %996 = load ptr, ptr %38, align 8
  %997 = load ptr, ptr %37, align 8
  %998 = load i32, ptr %36, align 4
  %999 = sext i32 %998 to i64
  %1000 = getelementptr inbounds i8, ptr %997, i64 %999
  %1001 = load i8, ptr %1000, align 1
  %1002 = zext i8 %1001 to i64
  %1003 = getelementptr inbounds i32, ptr %996, i64 %1002
  store i32 %995, ptr %1003, align 4
  br label %1004

1004:                                             ; preds = %991
  %1005 = load i32, ptr %36, align 4
  %1006 = add nsw i32 %1005, 1
  store i32 %1006, ptr %36, align 4
  br label %986, !llvm.loop !33

1007:                                             ; preds = %986
  br label %1008

1008:                                             ; preds = %1007, %970
  br label %1009

1009:                                             ; preds = %1008, %736
  br label %1010

1010:                                             ; preds = %1009, %728
  %1011 = load i32, ptr %23, align 4
  %1012 = icmp slt i32 %1011, 0
  br i1 %1012, label %1013, label %1020

1013:                                             ; preds = %1010
  %1014 = load ptr, ptr @__stderrp, align 8
  %1015 = load ptr, ptr %5, align 8
  %1016 = getelementptr inbounds ptr, ptr %1015, i64 0
  %1017 = load ptr, ptr %1016, align 8
  %1018 = load ptr, ptr @rstr_SHARED, align 8
  %1019 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %1014, ptr noundef @.str.34, ptr noundef %1017, ptr noundef %1018) #8
  call void @exit(i32 noundef 1) #10
  unreachable

1020:                                             ; preds = %1010
  %1021 = getelementptr inbounds %struct.rlimit, ptr %8, i32 0, i32 1
  %1022 = load i64, ptr %1021, align 8
  %1023 = load i32, ptr @nworkers_SHARED, align 4
  %1024 = sext i32 %1023 to i64
  %1025 = sub i64 %1022, %1024
  %1026 = sub i64 %1025, 16
  %1027 = trunc i64 %1026 to i32
  store i32 %1027, ptr @max_depth_SHARED, align 4
  %1028 = load i32, ptr @debug_SHARED, align 4
  %1029 = icmp ne i32 %1028, 0
  br i1 %1029, label %1030, label %1035

1030:                                             ; preds = %1020
  %1031 = load ptr, ptr @__stderrp, align 8
  %1032 = load i32, ptr @max_depth_SHARED, align 4
  %1033 = load i32, ptr @nworkers_SHARED, align 4
  %1034 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %1031, ptr noundef @.str.35, i32 noundef %1032, i32 noundef %1033) #8
  br label %1035

1035:                                             ; preds = %1030, %1020
  %1036 = load i32, ptr @nworkers_SHARED, align 4
  %1037 = add nsw i32 %1036, 8
  store i32 %1037, ptr %39, align 4
  %1038 = load i32, ptr %39, align 4
  %1039 = sext i32 %1038 to i64
  %1040 = call ptr @calloc(i64 noundef 8, i64 noundef %1039) #12
  store ptr %1040, ptr @q_buf_SHARED, align 8
  %1041 = load ptr, ptr @q_buf_SHARED, align 8
  %1042 = icmp ne ptr %1041, null
  br i1 %1042, label %1043, label %1048

1043:                                             ; preds = %1035
  %1044 = load i32, ptr %39, align 4
  store i32 %1044, ptr @q_qsize_SHARED, align 4
  store i32 0, ptr @q_occupied_SHARED, align 4
  store i32 0, ptr @q_nextin_SHARED, align 4
  store i32 0, ptr @q_nextout_SHARED, align 4
  store i32 0, ptr @q_closed_SHARED, align 4
  %1045 = call i32 @pthread_mutex_init(ptr noundef @q_mtx, ptr noundef null)
  %1046 = call i32 @"\01_pthread_cond_init"(ptr noundef @q_more, ptr noundef null)
  %1047 = call i32 @"\01_pthread_cond_init"(ptr noundef @q_less, ptr noundef null)
  br label %1049

1048:                                             ; preds = %1035
  ret i32 0

1049:                                             ; preds = %1043
  %1050 = load i32, ptr @nworkers_SHARED, align 4
  store i32 %1050, ptr @aworkers_SHARED, align 4
  store i32 0, ptr %7, align 4
  %1051 = load i32, ptr %7, align 4
  %1052 = load i32, ptr @nworkers_SHARED, align 4
  %1053 = icmp slt i32 %1051, %1052
  br i1 %1053, label %1054, label %1056

1054:                                             ; preds = %1049
  %1055 = call i32 @pthread_create(ptr noundef %11, ptr noundef null, ptr noundef @worker1, ptr noundef null)
  br label %1056

1056:                                             ; preds = %1054, %1049
  %1057 = load i32, ptr %7, align 4
  %1058 = add nsw i32 %1057, 1
  store i32 %1058, ptr %7, align 4
  %1059 = load i32, ptr %7, align 4
  %1060 = load i32, ptr @nworkers_SHARED, align 4
  %1061 = icmp slt i32 %1059, %1060
  br i1 %1061, label %1062, label %1064

1062:                                             ; preds = %1056
  %1063 = call i32 @pthread_create(ptr noundef %12, ptr noundef null, ptr noundef @worker2, ptr noundef null)
  br label %1064

1064:                                             ; preds = %1062, %1056
  %1065 = load i32, ptr %7, align 4
  %1066 = add nsw i32 %1065, 1
  store i32 %1066, ptr %7, align 4
  %1067 = load i32, ptr %7, align 4
  %1068 = load i32, ptr @nworkers_SHARED, align 4
  %1069 = icmp slt i32 %1067, %1068
  br i1 %1069, label %1070, label %1072

1070:                                             ; preds = %1064
  %1071 = call i32 @pthread_create(ptr noundef %13, ptr noundef null, ptr noundef @worker3, ptr noundef null)
  br label %1072

1072:                                             ; preds = %1070, %1064
  %1073 = load i32, ptr %7, align 4
  %1074 = add nsw i32 %1073, 1
  store i32 %1074, ptr %7, align 4
  %1075 = load i32, ptr %7, align 4
  %1076 = load i32, ptr @nworkers_SHARED, align 4
  %1077 = icmp slt i32 %1075, %1076
  br i1 %1077, label %1078, label %1080

1078:                                             ; preds = %1072
  %1079 = call i32 @pthread_create(ptr noundef %14, ptr noundef null, ptr noundef @worker4, ptr noundef null)
  br label %1080

1080:                                             ; preds = %1078, %1072
  %1081 = load i32, ptr %7, align 4
  %1082 = add nsw i32 %1081, 1
  store i32 %1082, ptr %7, align 4
  %1083 = call i32 @pthread_mutex_lock(ptr noundef @q_mtx)
  store i32 1, ptr @q_closed_SHARED, align 4
  %1084 = call i32 @pthread_cond_signal(ptr noundef @q_more)
  %1085 = call i32 @pthread_mutex_unlock(ptr noundef @q_mtx)
  %1086 = load i32, ptr @debug_SHARED, align 4
  %1087 = icmp ne i32 %1086, 0
  br i1 %1087, label %1088, label %1091

1088:                                             ; preds = %1080
  %1089 = load ptr, ptr @__stderrp, align 8
  %1090 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %1089, ptr noundef @.str.36) #8
  br label %1091

1091:                                             ; preds = %1088, %1080
  %1092 = call i32 @pthread_mutex_lock(ptr noundef @aworker_lock)
  br label %1093

1093:                                             ; preds = %1096, %1091
  %1094 = load i32, ptr @aworkers_SHARED, align 4
  %1095 = icmp sgt i32 %1094, 0
  br i1 %1095, label %1096, label %1098

1096:                                             ; preds = %1093
  %1097 = call i32 @"\01_pthread_cond_wait"(ptr noundef @aworker_cv, ptr noundef @aworker_lock)
  br label %1093, !llvm.loop !34

1098:                                             ; preds = %1093
  %1099 = call i32 @pthread_mutex_unlock(ptr noundef @aworker_lock)
  %1100 = load i32, ptr @happen_SHARED, align 4
  store i32 %1100, ptr %40, align 4
  %1101 = load i32, ptr @debug_SHARED, align 4
  %1102 = icmp ne i32 %1101, 0
  br i1 %1102, label %1103, label %1112

1103:                                             ; preds = %1098
  %1104 = load ptr, ptr @__stderrp, align 8
  %1105 = load i32, ptr @n_files_SHARED, align 4
  %1106 = load i32, ptr @n_matches_SHARED, align 4
  %1107 = load i32, ptr @nworkers_SHARED, align 4
  %1108 = load i64, ptr @n_bytes_SHARED, align 8
  %1109 = udiv i64 %1108, 1000000
  %1110 = trunc i64 %1109 to i32
  %1111 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %1104, ptr noundef @.str.37, i32 noundef %1105, i32 noundef %1106, i32 noundef %1107, i32 noundef %1110) #8
  br label %1112

1112:                                             ; preds = %1103, %1098
  call void @pthread_exit(ptr noundef null) #10
  unreachable
}

declare ptr @setlocale(i32 noundef, ptr noundef) #1

declare i32 @"\01_getrlimit"(i32 noundef, ptr noundef) #1

declare i32 @"\01_setrlimit"(i32 noundef, ptr noundef) #1

declare ptr @signal(i32 noundef, ptr noundef) #1

declare i32 @pthread_mutex_init(ptr noundef, ptr noundef) #1

declare i32 @"\01_pthread_cond_init"(ptr noundef, ptr noundef) #1

declare i32 @"\01_fputs"(ptr noundef, ptr noundef) #1

; Function Attrs: noreturn
declare void @exit(i32 noundef) #4

declare i32 @sscanf(ptr noundef, ptr noundef, ...) #1

; Function Attrs: nounwind
declare i64 @strlen(ptr noundef) #2

; Function Attrs: allocsize(0)
declare ptr @malloc(i64 noundef) #5

; Function Attrs: nounwind
declare ptr @__strcpy_chk(ptr noundef, ptr noundef, i64 noundef) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.objectsize.i64.p0(ptr, i1 immarg, i1 immarg, i1 immarg) #6

; Function Attrs: nounwind willreturn memory(read)
declare i32 @toupper(i32 noundef) #3

; Function Attrs: allocsize(0,1)
declare ptr @calloc(i64 noundef, i64 noundef) #7

; Function Attrs: nounwind willreturn memory(read)
declare i32 @tolower(i32 noundef) #3

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

; Function Attrs: noreturn
declare void @pthread_exit(ptr noundef) #4

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #2 = { nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #3 = { nounwind willreturn memory(read) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #4 = { noreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #5 = { allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { allocsize(0,1) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+bti,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #8 = { nounwind }
attributes #9 = { nounwind willreturn memory(read) }
attributes #10 = { noreturn }
attributes #11 = { allocsize(0) }
attributes #12 = { allocsize(0,1) }

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
!26 = distinct !{!26, !7}
!27 = distinct !{!27, !7}
!28 = distinct !{!28, !7}
!29 = distinct !{!29, !7}
!30 = distinct !{!30, !7}
!31 = distinct !{!31, !7}
!32 = distinct !{!32, !7}
!33 = distinct !{!33, !7}
!34 = distinct !{!34, !7}
