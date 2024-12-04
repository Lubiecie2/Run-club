; ModuleID = 'marshal_methods.x86.ll'
source_filename = "marshal_methods.x86.ll"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i686-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [357 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [708 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 68
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 67
	i32 15721112, ; 2: System.Runtime.Intrinsics.dll => 0xefe298 => 108
	i32 32687329, ; 3: Xamarin.AndroidX.Lifecycle.Runtime => 0x1f2c4e1 => 276
	i32 34715100, ; 4: Xamarin.Google.Guava.ListenableFuture.dll => 0x211b5dc => 311
	i32 34839235, ; 5: System.IO.FileSystem.DriveInfo => 0x2139ac3 => 48
	i32 39109920, ; 6: Newtonsoft.Json.dll => 0x254c520 => 219
	i32 39485524, ; 7: System.Net.WebSockets.dll => 0x25a8054 => 80
	i32 42639949, ; 8: System.Threading.Thread => 0x28aa24d => 145
	i32 66541672, ; 9: System.Diagnostics.StackTrace => 0x3f75868 => 30
	i32 67008169, ; 10: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 352
	i32 68219467, ; 11: System.Security.Cryptography.Primitives => 0x410f24b => 124
	i32 72070932, ; 12: Microsoft.Maui.Graphics.dll => 0x44bb714 => 215
	i32 82292897, ; 13: System.Runtime.CompilerServices.VisualC.dll => 0x4e7b0a1 => 102
	i32 101534019, ; 14: Xamarin.AndroidX.SlidingPaneLayout => 0x60d4943 => 294
	i32 117431740, ; 15: System.Runtime.InteropServices => 0x6ffddbc => 107
	i32 120558881, ; 16: Xamarin.AndroidX.SlidingPaneLayout.dll => 0x72f9521 => 294
	i32 122350210, ; 17: System.Threading.Channels.dll => 0x74aea82 => 139
	i32 134690465, ; 18: Xamarin.Kotlin.StdLib.Jdk7.dll => 0x80736a1 => 315
	i32 142721839, ; 19: System.Net.WebHeaderCollection => 0x881c32f => 77
	i32 149764678, ; 20: Svg.Skia.dll => 0x8ed3a46 => 229
	i32 149972175, ; 21: System.Security.Cryptography.Primitives.dll => 0x8f064cf => 124
	i32 159306688, ; 22: System.ComponentModel.Annotations => 0x97ed3c0 => 13
	i32 165246403, ; 23: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 250
	i32 176265551, ; 24: System.ServiceProcess => 0xa81994f => 132
	i32 182336117, ; 25: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 296
	i32 184328833, ; 26: System.ValueTuple.dll => 0xafca281 => 151
	i32 195452805, ; 27: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 349
	i32 199333315, ; 28: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 350
	i32 205061960, ; 29: System.ComponentModel => 0xc38ff48 => 18
	i32 209399409, ; 30: Xamarin.AndroidX.Browser.dll => 0xc7b2e71 => 248
	i32 220171995, ; 31: System.Diagnostics.Debug => 0xd1f8edb => 26
	i32 230216969, ; 32: Xamarin.AndroidX.Legacy.Support.Core.Utils.dll => 0xdb8d509 => 270
	i32 230752869, ; 33: Microsoft.CSharp.dll => 0xdc10265 => 1
	i32 231409092, ; 34: System.Linq.Parallel => 0xdcb05c4 => 59
	i32 231814094, ; 35: System.Globalization => 0xdd133ce => 42
	i32 246610117, ; 36: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 91
	i32 261689757, ; 37: Xamarin.AndroidX.ConstraintLayout.dll => 0xf99119d => 253
	i32 276479776, ; 38: System.Threading.Timer.dll => 0x107abf20 => 147
	i32 278686392, ; 39: Xamarin.AndroidX.Lifecycle.LiveData.dll => 0x109c6ab8 => 272
	i32 280482487, ; 40: Xamarin.AndroidX.Interpolator => 0x10b7d2b7 => 269
	i32 280992041, ; 41: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 321
	i32 291076382, ; 42: System.IO.Pipes.AccessControl.dll => 0x1159791e => 54
	i32 292822316, ; 43: Mapsui.UI.Maui => 0x11741d2c => 196
	i32 298918909, ; 44: System.Net.Ping.dll => 0x11d123fd => 69
	i32 317674968, ; 45: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 349
	i32 318968648, ; 46: Xamarin.AndroidX.Activity.dll => 0x13031348 => 239
	i32 321597661, ; 47: System.Numerics => 0x132b30dd => 83
	i32 336156722, ; 48: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 334
	i32 342366114, ; 49: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 271
	i32 356389973, ; 50: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 333
	i32 360082299, ; 51: System.ServiceModel.Web => 0x15766b7b => 131
	i32 364956269, ; 52: Grpc.Net.Common => 0x15c0ca6d => 192
	i32 367780167, ; 53: System.IO.Pipes => 0x15ebe147 => 55
	i32 371306672, ; 54: Grpc.Core.Api.dll => 0x1621b0b0 => 190
	i32 374914964, ; 55: System.Transactions.Local => 0x1658bf94 => 149
	i32 375677976, ; 56: System.Net.ServicePoint.dll => 0x16646418 => 74
	i32 379916513, ; 57: System.Threading.Thread.dll => 0x16a510e1 => 145
	i32 385762202, ; 58: System.Memory.dll => 0x16fe439a => 62
	i32 391886110, ; 59: Grpc.Net.Client.dll => 0x175bb51e => 191
	i32 392610295, ; 60: System.Threading.ThreadPool.dll => 0x1766c1f7 => 146
	i32 393699800, ; 61: Firebase => 0x177761d8 => 176
	i32 395744057, ; 62: _Microsoft.Android.Resource.Designer => 0x17969339 => 353
	i32 403441872, ; 63: WindowsBase => 0x180c08d0 => 165
	i32 435591531, ; 64: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 345
	i32 441335492, ; 65: Xamarin.AndroidX.ConstraintLayout.Core => 0x1a4e3ec4 => 254
	i32 442521989, ; 66: Xamarin.Essentials => 0x1a605985 => 306
	i32 442565967, ; 67: System.Collections => 0x1a61054f => 12
	i32 450948140, ; 68: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 267
	i32 451504562, ; 69: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 125
	i32 456227837, ; 70: System.Web.HttpUtility.dll => 0x1b317bfd => 152
	i32 459347974, ; 71: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 113
	i32 465658307, ; 72: ExCSS => 0x1bc161c3 => 174
	i32 465846621, ; 73: mscorlib => 0x1bc4415d => 166
	i32 469710990, ; 74: System.dll => 0x1bff388e => 164
	i32 469965489, ; 75: Svg.Model => 0x1c031ab1 => 228
	i32 476646585, ; 76: Xamarin.AndroidX.Interpolator.dll => 0x1c690cb9 => 269
	i32 486930444, ; 77: Xamarin.AndroidX.LocalBroadcastManager.dll => 0x1d05f80c => 282
	i32 498788369, ; 78: System.ObjectModel => 0x1dbae811 => 84
	i32 500358224, ; 79: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 332
	i32 503918385, ; 80: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 326
	i32 513247710, ; 81: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 209
	i32 525008092, ; 82: SkiaSharp.dll => 0x1f4afcdc => 221
	i32 526420162, ; 83: System.Transactions.dll => 0x1f6088c2 => 150
	i32 527452488, ; 84: Xamarin.Kotlin.StdLib.Jdk7 => 0x1f704948 => 315
	i32 530272170, ; 85: System.Linq.Queryable => 0x1f9b4faa => 60
	i32 539058512, ; 86: Microsoft.Extensions.Logging => 0x20216150 => 205
	i32 540030774, ; 87: System.IO.FileSystem.dll => 0x20303736 => 51
	i32 545304856, ; 88: System.Runtime.Extensions => 0x2080b118 => 103
	i32 546455878, ; 89: System.Runtime.Serialization.Xml => 0x20924146 => 114
	i32 548916678, ; 90: Microsoft.Bcl.AsyncInterfaces => 0x20b7cdc6 => 200
	i32 549171840, ; 91: System.Globalization.Calendars => 0x20bbb280 => 40
	i32 557405415, ; 92: Jsr305Binding => 0x213954e7 => 308
	i32 569601784, ; 93: Xamarin.AndroidX.Window.Extensions.Core.Core => 0x21f36ef8 => 305
	i32 577335427, ; 94: System.Security.Cryptography.Cng => 0x22697083 => 120
	i32 592146354, ; 95: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 340
	i32 601371474, ; 96: System.IO.IsolatedStorage.dll => 0x23d83352 => 52
	i32 605376203, ; 97: System.IO.Compression.FileSystem => 0x24154ecb => 44
	i32 610194910, ; 98: System.Reactive.dll => 0x245ed5de => 233
	i32 613668793, ; 99: System.Security.Cryptography.Algorithms => 0x2493d7b9 => 119
	i32 627609679, ; 100: Xamarin.AndroidX.CustomView => 0x2568904f => 259
	i32 627931235, ; 101: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 338
	i32 639843206, ; 102: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 0x26233b86 => 265
	i32 643868501, ; 103: System.Net => 0x2660a755 => 81
	i32 646990296, ; 104: Google.Cloud.Firestore.V1.dll => 0x269049d8 => 184
	i32 662205335, ; 105: System.Text.Encodings.Web.dll => 0x27787397 => 136
	i32 663517072, ; 106: Xamarin.AndroidX.VersionedParcelable => 0x278c7790 => 301
	i32 666292255, ; 107: Xamarin.AndroidX.Arch.Core.Common.dll => 0x27b6d01f => 246
	i32 672442732, ; 108: System.Collections.Concurrent => 0x2814a96c => 8
	i32 680049820, ; 109: Mapsui.Rendering.Skia.dll => 0x2888bc9c => 198
	i32 683518922, ; 110: System.Net.Security => 0x28bdabca => 73
	i32 688181140, ; 111: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 320
	i32 690569205, ; 112: System.Xml.Linq.dll => 0x29293ff5 => 155
	i32 691348768, ; 113: Xamarin.KotlinX.Coroutines.Android.dll => 0x29352520 => 317
	i32 693804605, ; 114: System.Windows => 0x295a9e3d => 154
	i32 699345723, ; 115: System.Reflection.Emit => 0x29af2b3b => 92
	i32 700284507, ; 116: Xamarin.Jetbrains.Annotations => 0x29bd7e5b => 312
	i32 700358131, ; 117: System.IO.Compression.ZipFile => 0x29be9df3 => 45
	i32 706645707, ; 118: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 335
	i32 707666095, ; 119: running-club => 0x2a2e20af => 0
	i32 709557578, ; 120: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 323
	i32 720511267, ; 121: Xamarin.Kotlin.StdLib.Jdk8 => 0x2af22123 => 316
	i32 722857257, ; 122: System.Runtime.Loader.dll => 0x2b15ed29 => 109
	i32 735137430, ; 123: System.Security.SecureString.dll => 0x2bd14e96 => 129
	i32 752232764, ; 124: System.Diagnostics.Contracts.dll => 0x2cd6293c => 25
	i32 755313932, ; 125: Xamarin.Android.Glide.Annotations.dll => 0x2d052d0c => 236
	i32 759454413, ; 126: System.Net.Requests => 0x2d445acd => 72
	i32 762598435, ; 127: System.IO.Pipes.dll => 0x2d745423 => 55
	i32 775507847, ; 128: System.IO.Compression => 0x2e394f87 => 46
	i32 777317022, ; 129: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 344
	i32 778756650, ; 130: SkiaSharp.HarfBuzz.dll => 0x2e6ae22a => 222
	i32 789151979, ; 131: Microsoft.Extensions.Options => 0x2f0980eb => 208
	i32 790371945, ; 132: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 0x2f1c1e69 => 260
	i32 804715423, ; 133: System.Data.Common => 0x2ff6fb9f => 22
	i32 807930345, ; 134: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 0x302809e9 => 274
	i32 823281589, ; 135: System.Private.Uri.dll => 0x311247b5 => 86
	i32 830298997, ; 136: System.IO.Compression.Brotli => 0x317d5b75 => 43
	i32 832635846, ; 137: System.Xml.XPath.dll => 0x31a103c6 => 160
	i32 834051424, ; 138: System.Net.Quic => 0x31b69d60 => 71
	i32 843511501, ; 139: Xamarin.AndroidX.Print => 0x3246f6cd => 287
	i32 873119928, ; 140: Microsoft.VisualBasic => 0x340ac0b8 => 3
	i32 877678880, ; 141: System.Globalization.dll => 0x34505120 => 42
	i32 878954865, ; 142: System.Net.Http.Json => 0x3463c971 => 63
	i32 899130691, ; 143: NetTopologySuite.dll => 0x3597a543 => 216
	i32 904024072, ; 144: System.ComponentModel.Primitives.dll => 0x35e25008 => 16
	i32 911108515, ; 145: System.IO.MemoryMappedFiles.dll => 0x364e69a3 => 53
	i32 926902833, ; 146: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 347
	i32 928116545, ; 147: Xamarin.Google.Guava.ListenableFuture => 0x3751ef41 => 311
	i32 952186615, ; 148: System.Runtime.InteropServices.JavaScript.dll => 0x38c136f7 => 105
	i32 955402788, ; 149: Newtonsoft.Json => 0x38f24a24 => 219
	i32 956575887, ; 150: Xamarin.Kotlin.StdLib.Jdk8.dll => 0x3904308f => 316
	i32 966729478, ; 151: Xamarin.Google.Crypto.Tink.Android => 0x399f1f06 => 309
	i32 967690846, ; 152: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 271
	i32 975236339, ; 153: System.Diagnostics.Tracing => 0x3a20ecf3 => 34
	i32 975874589, ; 154: System.Xml.XDocument => 0x3a2aaa1d => 158
	i32 986514023, ; 155: System.Private.DataContractSerialization.dll => 0x3acd0267 => 85
	i32 987214855, ; 156: System.Diagnostics.Tools => 0x3ad7b407 => 32
	i32 992768348, ; 157: System.Collections.dll => 0x3b2c715c => 12
	i32 994442037, ; 158: System.IO.FileSystem => 0x3b45fb35 => 51
	i32 1001831731, ; 159: System.IO.UnmanagedMemoryStream.dll => 0x3bb6bd33 => 56
	i32 1012816738, ; 160: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 291
	i32 1019214401, ; 161: System.Drawing => 0x3cbffa41 => 36
	i32 1028951442, ; 162: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 204
	i32 1029334545, ; 163: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 322
	i32 1031528504, ; 164: Xamarin.Google.ErrorProne.Annotations.dll => 0x3d7be038 => 310
	i32 1035644815, ; 165: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 244
	i32 1036536393, ; 166: System.Drawing.Primitives.dll => 0x3dc84a49 => 35
	i32 1044663988, ; 167: System.Linq.Expressions.dll => 0x3e444eb4 => 58
	i32 1049751285, ; 168: Google.Api.CommonProtos.dll => 0x3e91eef5 => 177
	i32 1052210849, ; 169: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 278
	i32 1067306892, ; 170: GoogleGson => 0x3f9dcf8c => 188
	i32 1082857460, ; 171: System.ComponentModel.TypeConverter => 0x408b17f4 => 17
	i32 1084122840, ; 172: Xamarin.Kotlin.StdLib => 0x409e66d8 => 313
	i32 1098259244, ; 173: System => 0x41761b2c => 164
	i32 1118262833, ; 174: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 335
	i32 1121599056, ; 175: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 0x42da3e50 => 277
	i32 1127624469, ; 176: Microsoft.Extensions.Logging.Debug => 0x43362f15 => 207
	i32 1145085672, ; 177: System.Linq.Async.dll => 0x44409ee8 => 231
	i32 1149092582, ; 178: Xamarin.AndroidX.Window => 0x447dc2e6 => 304
	i32 1168523401, ; 179: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 341
	i32 1170634674, ; 180: System.Web.dll => 0x45c677b2 => 153
	i32 1175144683, ; 181: Xamarin.AndroidX.VectorDrawable.Animated => 0x460b48eb => 300
	i32 1178241025, ; 182: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 285
	i32 1203173028, ; 183: Grpc.Net.Client => 0x47b6f6a4 => 191
	i32 1203215381, ; 184: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 339
	i32 1204270330, ; 185: Xamarin.AndroidX.Arch.Core.Common => 0x47c7b4fa => 246
	i32 1208641965, ; 186: System.Diagnostics.Process => 0x480a69ad => 29
	i32 1219128291, ; 187: System.IO.IsolatedStorage => 0x48aa6be3 => 52
	i32 1234928153, ; 188: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 337
	i32 1243150071, ; 189: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 0x4a18f6f7 => 305
	i32 1253011324, ; 190: Microsoft.Win32.Registry => 0x4aaf6f7c => 5
	i32 1260983243, ; 191: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 321
	i32 1264511973, ; 192: Xamarin.AndroidX.Startup.StartupRuntime.dll => 0x4b5eebe5 => 295
	i32 1267360935, ; 193: Xamarin.AndroidX.VectorDrawable => 0x4b8a64a7 => 299
	i32 1273260888, ; 194: Xamarin.AndroidX.Collection.Ktx => 0x4be46b58 => 251
	i32 1275534314, ; 195: Xamarin.KotlinX.Coroutines.Android => 0x4c071bea => 317
	i32 1278448581, ; 196: Xamarin.AndroidX.Annotation.Jvm => 0x4c3393c5 => 243
	i32 1293217323, ; 197: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 262
	i32 1309188875, ; 198: System.Private.DataContractSerialization => 0x4e08a30b => 85
	i32 1313028017, ; 199: Topten.RichTextKit => 0x4e4337b1 => 234
	i32 1322716291, ; 200: Xamarin.AndroidX.Window.dll => 0x4ed70c83 => 304
	i32 1324164729, ; 201: System.Linq => 0x4eed2679 => 61
	i32 1335329327, ; 202: System.Runtime.Serialization.Json.dll => 0x4f97822f => 112
	i32 1364015309, ; 203: System.IO => 0x514d38cd => 57
	i32 1373134921, ; 204: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 351
	i32 1376866003, ; 205: Xamarin.AndroidX.SavedState => 0x52114ed3 => 291
	i32 1379779777, ; 206: System.Resources.ResourceManager => 0x523dc4c1 => 99
	i32 1388087747, ; 207: Mapsui.dll => 0x52bc89c3 => 195
	i32 1402170036, ; 208: System.Configuration.dll => 0x53936ab4 => 19
	i32 1406073936, ; 209: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 255
	i32 1408764838, ; 210: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 111
	i32 1411638395, ; 211: System.Runtime.CompilerServices.Unsafe => 0x5423e47b => 101
	i32 1422545099, ; 212: System.Runtime.CompilerServices.VisualC => 0x54ca50cb => 102
	i32 1422967952, ; 213: Mapsui.Tiling.dll => 0x54d0c490 => 199
	i32 1430672901, ; 214: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 319
	i32 1434145427, ; 215: System.Runtime.Handles => 0x557b5293 => 104
	i32 1435222561, ; 216: Xamarin.Google.Crypto.Tink.Android.dll => 0x558bc221 => 309
	i32 1437713837, ; 217: Grpc.Auth => 0x55b1c5ad => 189
	i32 1439761251, ; 218: System.Net.Quic.dll => 0x55d10363 => 71
	i32 1443938015, ; 219: NetTopologySuite => 0x5610bedf => 216
	i32 1452070440, ; 220: System.Formats.Asn1.dll => 0x568cd628 => 38
	i32 1453312822, ; 221: System.Diagnostics.Tools.dll => 0x569fcb36 => 32
	i32 1457743152, ; 222: System.Runtime.Extensions.dll => 0x56e36530 => 103
	i32 1458022317, ; 223: System.Net.Security.dll => 0x56e7a7ad => 73
	i32 1461004990, ; 224: es\Microsoft.Maui.Controls.resources => 0x57152abe => 325
	i32 1461234159, ; 225: System.Collections.Immutable.dll => 0x5718a9ef => 9
	i32 1461719063, ; 226: System.Security.Cryptography.OpenSsl => 0x57201017 => 123
	i32 1462112819, ; 227: System.IO.Compression.dll => 0x57261233 => 46
	i32 1469204771, ; 228: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 245
	i32 1470490898, ; 229: Microsoft.Extensions.Primitives => 0x57a5e912 => 209
	i32 1479771757, ; 230: System.Collections.Immutable => 0x5833866d => 9
	i32 1480492111, ; 231: System.IO.Compression.Brotli.dll => 0x583e844f => 43
	i32 1487239319, ; 232: Microsoft.Win32.Primitives => 0x58a57897 => 4
	i32 1490025113, ; 233: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 0x58cffa99 => 292
	i32 1490249645, ; 234: running-club.dll => 0x58d367ad => 0
	i32 1493001747, ; 235: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 329
	i32 1514721132, ; 236: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 324
	i32 1536373174, ; 237: System.Diagnostics.TextWriterTraceListener => 0x5b9331b6 => 31
	i32 1543031311, ; 238: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 138
	i32 1543355203, ; 239: System.Reflection.Emit.dll => 0x5bfdbb43 => 92
	i32 1550322496, ; 240: System.Reflection.Extensions.dll => 0x5c680b40 => 93
	i32 1551623176, ; 241: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 344
	i32 1565862583, ; 242: System.IO.FileSystem.Primitives => 0x5d552ab7 => 49
	i32 1566207040, ; 243: System.Threading.Tasks.Dataflow.dll => 0x5d5a6c40 => 141
	i32 1573704789, ; 244: System.Runtime.Serialization.Json => 0x5dccd455 => 112
	i32 1580037396, ; 245: System.Threading.Overlapped => 0x5e2d7514 => 140
	i32 1582372066, ; 246: Xamarin.AndroidX.DocumentFile.dll => 0x5e5114e2 => 261
	i32 1592978981, ; 247: System.Runtime.Serialization.dll => 0x5ef2ee25 => 115
	i32 1597949149, ; 248: Xamarin.Google.ErrorProne.Annotations => 0x5f3ec4dd => 310
	i32 1600541741, ; 249: ShimSkiaSharp => 0x5f66542d => 220
	i32 1601112923, ; 250: System.Xml.Serialization => 0x5f6f0b5b => 157
	i32 1604827217, ; 251: System.Net.WebClient => 0x5fa7b851 => 76
	i32 1618516317, ; 252: System.Net.WebSockets.Client.dll => 0x6078995d => 79
	i32 1622152042, ; 253: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 281
	i32 1622358360, ; 254: System.Dynamic.Runtime => 0x60b33958 => 37
	i32 1623212457, ; 255: SkiaSharp.Views.Maui.Controls => 0x60c041a9 => 224
	i32 1624863272, ; 256: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 303
	i32 1635184631, ; 257: Xamarin.AndroidX.Emoji2.ViewsHelper => 0x6176eff7 => 265
	i32 1636350590, ; 258: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 258
	i32 1639515021, ; 259: System.Net.Http.dll => 0x61b9038d => 64
	i32 1639986890, ; 260: System.Text.RegularExpressions => 0x61c036ca => 138
	i32 1641389582, ; 261: System.ComponentModel.EventBasedAsync.dll => 0x61d59e0e => 15
	i32 1657153582, ; 262: System.Runtime => 0x62c6282e => 116
	i32 1658241508, ; 263: Xamarin.AndroidX.Tracing.Tracing.dll => 0x62d6c1e4 => 297
	i32 1658251792, ; 264: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 307
	i32 1670060433, ; 265: Xamarin.AndroidX.ConstraintLayout => 0x638b1991 => 253
	i32 1672364457, ; 266: NetTopologySuite.IO.GeoJSON4STJ.dll => 0x63ae41a9 => 218
	i32 1675553242, ; 267: System.IO.FileSystem.DriveInfo.dll => 0x63dee9da => 48
	i32 1677501392, ; 268: System.Net.Primitives.dll => 0x63fca3d0 => 70
	i32 1678508291, ; 269: System.Net.WebSockets => 0x640c0103 => 80
	i32 1679769178, ; 270: System.Security.Cryptography => 0x641f3e5a => 126
	i32 1691477237, ; 271: System.Reflection.Metadata => 0x64d1e4f5 => 94
	i32 1696967625, ; 272: System.Security.Cryptography.Csp => 0x6525abc9 => 121
	i32 1698840827, ; 273: Xamarin.Kotlin.StdLib.Common => 0x654240fb => 314
	i32 1701541528, ; 274: System.Diagnostics.Debug.dll => 0x656b7698 => 26
	i32 1720223769, ; 275: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 0x66888819 => 274
	i32 1726116996, ; 276: System.Reflection.dll => 0x66e27484 => 97
	i32 1728033016, ; 277: System.Diagnostics.FileVersionInfo.dll => 0x66ffb0f8 => 28
	i32 1729485958, ; 278: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 249
	i32 1736233607, ; 279: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 342
	i32 1743415430, ; 280: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 320
	i32 1744735666, ; 281: System.Transactions.Local.dll => 0x67fe8db2 => 149
	i32 1746316138, ; 282: Mono.Android.Export => 0x6816ab6a => 169
	i32 1750313021, ; 283: Microsoft.Win32.Primitives.dll => 0x6853a83d => 4
	i32 1758240030, ; 284: System.Resources.Reader.dll => 0x68cc9d1e => 98
	i32 1763938596, ; 285: System.Diagnostics.TraceSource.dll => 0x69239124 => 33
	i32 1765942094, ; 286: System.Reflection.Extensions => 0x6942234e => 93
	i32 1766324549, ; 287: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 296
	i32 1770582343, ; 288: Microsoft.Extensions.Logging.dll => 0x6988f147 => 205
	i32 1776026572, ; 289: System.Core.dll => 0x69dc03cc => 21
	i32 1777075843, ; 290: System.Globalization.Extensions.dll => 0x69ec0683 => 41
	i32 1780572499, ; 291: Mono.Android.Runtime.dll => 0x6a216153 => 170
	i32 1782161461, ; 292: Grpc.Core.Api => 0x6a39a035 => 190
	i32 1782862114, ; 293: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 336
	i32 1788241197, ; 294: Xamarin.AndroidX.Fragment => 0x6a96652d => 267
	i32 1793755602, ; 295: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 328
	i32 1796167890, ; 296: Microsoft.Bcl.AsyncInterfaces.dll => 0x6b0f58d2 => 200
	i32 1808609942, ; 297: Xamarin.AndroidX.Loader => 0x6bcd3296 => 281
	i32 1813058853, ; 298: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 313
	i32 1813201214, ; 299: Xamarin.Google.Android.Material => 0x6c13413e => 307
	i32 1818569960, ; 300: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 286
	i32 1818787751, ; 301: Microsoft.VisualBasic.Core => 0x6c687fa7 => 2
	i32 1824175904, ; 302: System.Text.Encoding.Extensions => 0x6cbab720 => 134
	i32 1824722060, ; 303: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 111
	i32 1828688058, ; 304: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 206
	i32 1839733746, ; 305: Mapsui.Nts.dll => 0x6da81bf2 => 197
	i32 1842015223, ; 306: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 348
	i32 1847515442, ; 307: Xamarin.Android.Glide.Annotations => 0x6e1ed932 => 236
	i32 1853025655, ; 308: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 345
	i32 1858542181, ; 309: System.Linq.Expressions => 0x6ec71a65 => 58
	i32 1867746548, ; 310: Xamarin.Essentials.dll => 0x6f538cf4 => 306
	i32 1870277092, ; 311: System.Reflection.Primitives => 0x6f7a29e4 => 95
	i32 1875935024, ; 312: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 327
	i32 1879696579, ; 313: System.Formats.Tar.dll => 0x7009e4c3 => 39
	i32 1885316902, ; 314: Xamarin.AndroidX.Arch.Core.Runtime.dll => 0x705fa726 => 247
	i32 1888955245, ; 315: System.Diagnostics.Contracts => 0x70972b6d => 25
	i32 1889954781, ; 316: System.Reflection.Metadata.dll => 0x70a66bdd => 94
	i32 1898237753, ; 317: System.Reflection.DispatchProxy => 0x7124cf39 => 89
	i32 1900519031, ; 318: Grpc.Auth.dll => 0x71479e77 => 189
	i32 1900610850, ; 319: System.Resources.ResourceManager.dll => 0x71490522 => 99
	i32 1910275211, ; 320: System.Collections.NonGeneric.dll => 0x71dc7c8b => 10
	i32 1927897671, ; 321: System.CodeDom.dll => 0x72e96247 => 230
	i32 1939592360, ; 322: System.Private.Xml.Linq => 0x739bd4a8 => 87
	i32 1956758971, ; 323: System.Resources.Writer => 0x74a1c5bb => 100
	i32 1961813231, ; 324: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x74eee4ef => 293
	i32 1968388702, ; 325: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 201
	i32 1983156543, ; 326: Xamarin.Kotlin.StdLib.Common.dll => 0x7634913f => 314
	i32 1985761444, ; 327: Xamarin.Android.Glide.GifDecoder => 0x765c50a4 => 238
	i32 2003115576, ; 328: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 324
	i32 2011961780, ; 329: System.Buffers.dll => 0x77ec19b4 => 7
	i32 2019465201, ; 330: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 278
	i32 2025202353, ; 331: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 319
	i32 2031763787, ; 332: Xamarin.Android.Glide => 0x791a414b => 235
	i32 2045470958, ; 333: System.Private.Xml => 0x79eb68ee => 88
	i32 2055257422, ; 334: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 273
	i32 2060060697, ; 335: System.Windows.dll => 0x7aca0819 => 154
	i32 2066184531, ; 336: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 323
	i32 2070888862, ; 337: System.Diagnostics.TraceSource => 0x7b6f419e => 33
	i32 2079903147, ; 338: System.Runtime.dll => 0x7bf8cdab => 116
	i32 2090596640, ; 339: System.Numerics.Vectors => 0x7c9bf920 => 82
	i32 2127167465, ; 340: System.Console => 0x7ec9ffe9 => 20
	i32 2142473426, ; 341: System.Collections.Specialized => 0x7fb38cd2 => 11
	i32 2143790110, ; 342: System.Xml.XmlSerializer.dll => 0x7fc7a41e => 162
	i32 2146852085, ; 343: Microsoft.VisualBasic.dll => 0x7ff65cf5 => 3
	i32 2159891885, ; 344: Microsoft.Maui => 0x80bd55ad => 213
	i32 2169148018, ; 345: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 331
	i32 2178612968, ; 346: System.CodeDom => 0x81dafee8 => 230
	i32 2181898931, ; 347: Microsoft.Extensions.Options.dll => 0x820d22b3 => 208
	i32 2192057212, ; 348: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 206
	i32 2193016926, ; 349: System.ObjectModel.dll => 0x82b6c85e => 84
	i32 2201107256, ; 350: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 318
	i32 2201231467, ; 351: System.Net.Http => 0x8334206b => 64
	i32 2207618523, ; 352: it\Microsoft.Maui.Controls.resources => 0x839595db => 333
	i32 2216717168, ; 353: Firebase.Auth.dll => 0x84206b70 => 175
	i32 2217644978, ; 354: Xamarin.AndroidX.VectorDrawable.Animated.dll => 0x842e93b2 => 300
	i32 2222056684, ; 355: System.Threading.Tasks.Parallel => 0x8471e4ec => 143
	i32 2244775296, ; 356: Xamarin.AndroidX.LocalBroadcastManager => 0x85cc8d80 => 282
	i32 2252106437, ; 357: System.Xml.Serialization.dll => 0x863c6ac5 => 157
	i32 2256313426, ; 358: System.Globalization.Extensions => 0x867c9c52 => 41
	i32 2265110946, ; 359: System.Security.AccessControl.dll => 0x8702d9a2 => 117
	i32 2266799131, ; 360: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 202
	i32 2267999099, ; 361: Xamarin.Android.Glide.DiskLruCache.dll => 0x872eeb7b => 237
	i32 2270573516, ; 362: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 327
	i32 2279755925, ; 363: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 289
	i32 2293034957, ; 364: System.ServiceModel.Web.dll => 0x88acefcd => 131
	i32 2295906218, ; 365: System.Net.Sockets => 0x88d8bfaa => 75
	i32 2298471582, ; 366: System.Net.Mail => 0x88ffe49e => 66
	i32 2303942373, ; 367: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 337
	i32 2305521784, ; 368: System.Private.CoreLib.dll => 0x896b7878 => 172
	i32 2315684594, ; 369: Xamarin.AndroidX.Annotation.dll => 0x8a068af2 => 241
	i32 2320631194, ; 370: System.Threading.Tasks.Parallel.dll => 0x8a52059a => 143
	i32 2327893114, ; 371: ExCSS.dll => 0x8ac0d47a => 174
	i32 2340441535, ; 372: System.Runtime.InteropServices.RuntimeInformation.dll => 0x8b804dbf => 106
	i32 2344264397, ; 373: System.ValueTuple => 0x8bbaa2cd => 151
	i32 2353062107, ; 374: System.Net.Primitives => 0x8c40e0db => 70
	i32 2364201794, ; 375: SkiaSharp.Views.Maui.Core => 0x8ceadb42 => 226
	i32 2368005991, ; 376: System.Xml.ReaderWriter.dll => 0x8d24e767 => 156
	i32 2371007202, ; 377: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 201
	i32 2378619854, ; 378: System.Security.Cryptography.Csp.dll => 0x8dc6dbce => 121
	i32 2383496789, ; 379: System.Security.Principal.Windows.dll => 0x8e114655 => 127
	i32 2395872292, ; 380: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 332
	i32 2397347608, ; 381: Google.LongRunning.dll => 0x8ee49f18 => 186
	i32 2401565422, ; 382: System.Web.HttpUtility => 0x8f24faee => 152
	i32 2403452196, ; 383: Xamarin.AndroidX.Emoji2.dll => 0x8f41c524 => 264
	i32 2421380589, ; 384: System.Threading.Tasks.Dataflow => 0x905355ed => 141
	i32 2423080555, ; 385: Xamarin.AndroidX.Collection.Ktx.dll => 0x906d466b => 251
	i32 2427813419, ; 386: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 329
	i32 2435356389, ; 387: System.Console.dll => 0x912896e5 => 20
	i32 2435904999, ; 388: System.ComponentModel.DataAnnotations.dll => 0x9130f5e7 => 14
	i32 2441199521, ; 389: Google.Cloud.Firestore => 0x9181bfa1 => 183
	i32 2454642406, ; 390: System.Text.Encoding.dll => 0x924edee6 => 135
	i32 2458678730, ; 391: System.Net.Sockets.dll => 0x928c75ca => 75
	i32 2459001652, ; 392: System.Linq.Parallel.dll => 0x92916334 => 59
	i32 2465532216, ; 393: Xamarin.AndroidX.ConstraintLayout.Core.dll => 0x92f50938 => 254
	i32 2471841756, ; 394: netstandard.dll => 0x93554fdc => 167
	i32 2475788418, ; 395: Java.Interop.dll => 0x93918882 => 168
	i32 2480646305, ; 396: Microsoft.Maui.Controls => 0x93dba8a1 => 211
	i32 2483903535, ; 397: System.ComponentModel.EventBasedAsync => 0x940d5c2f => 15
	i32 2484371297, ; 398: System.Net.ServicePoint => 0x94147f61 => 74
	i32 2486847491, ; 399: Google.Api.Gax => 0x943a4803 => 178
	i32 2490993605, ; 400: System.AppContext.dll => 0x94798bc5 => 6
	i32 2501346920, ; 401: System.Data.DataSetExtensions => 0x95178668 => 23
	i32 2505896520, ; 402: Xamarin.AndroidX.Lifecycle.Runtime.dll => 0x955cf248 => 276
	i32 2521915375, ; 403: SkiaSharp.Views.Maui.Controls.Compatibility => 0x96515fef => 225
	i32 2522472828, ; 404: Xamarin.Android.Glide.dll => 0x9659e17c => 235
	i32 2523023297, ; 405: Svg.Custom.dll => 0x966247c1 => 227
	i32 2538310050, ; 406: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 91
	i32 2550873716, ; 407: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 330
	i32 2562349572, ; 408: Microsoft.CSharp => 0x98ba5a04 => 1
	i32 2570120770, ; 409: System.Text.Encodings.Web => 0x9930ee42 => 136
	i32 2577414832, ; 410: Mapsui.Nts => 0x99a03ab0 => 197
	i32 2581783588, ; 411: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 0x99e2e424 => 277
	i32 2581819634, ; 412: Xamarin.AndroidX.VectorDrawable.dll => 0x99e370f2 => 299
	i32 2585220780, ; 413: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 134
	i32 2585805581, ; 414: System.Net.Ping => 0x9a20430d => 69
	i32 2589602615, ; 415: System.Threading.ThreadPool => 0x9a5a3337 => 146
	i32 2593496499, ; 416: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 339
	i32 2602257211, ; 417: Svg.Model.dll => 0x9b1b4b3b => 228
	i32 2605712449, ; 418: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 318
	i32 2609324236, ; 419: Svg.Custom => 0x9b8720cc => 227
	i32 2615233544, ; 420: Xamarin.AndroidX.Fragment.Ktx => 0x9be14c08 => 268
	i32 2616218305, ; 421: Microsoft.Extensions.Logging.Debug.dll => 0x9bf052c1 => 207
	i32 2617129537, ; 422: System.Private.Xml.dll => 0x9bfe3a41 => 88
	i32 2618712057, ; 423: System.Reflection.TypeExtensions.dll => 0x9c165ff9 => 96
	i32 2620871830, ; 424: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 258
	i32 2624644809, ; 425: Xamarin.AndroidX.DynamicAnimation => 0x9c70e6c9 => 263
	i32 2625339995, ; 426: SkiaSharp.Views.Maui.Core.dll => 0x9c7b825b => 226
	i32 2626831493, ; 427: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 334
	i32 2627185994, ; 428: System.Diagnostics.TextWriterTraceListener.dll => 0x9c97ad4a => 31
	i32 2629843544, ; 429: System.IO.Compression.ZipFile.dll => 0x9cc03a58 => 45
	i32 2633051222, ; 430: Xamarin.AndroidX.Lifecycle.LiveData => 0x9cf12c56 => 272
	i32 2635732976, ; 431: Google.Cloud.Firestore.dll => 0x9d1a17f0 => 183
	i32 2663391936, ; 432: Xamarin.Android.Glide.DiskLruCache => 0x9ec022c0 => 237
	i32 2663698177, ; 433: System.Runtime.Loader => 0x9ec4cf01 => 109
	i32 2664396074, ; 434: System.Xml.XDocument.dll => 0x9ecf752a => 158
	i32 2665622720, ; 435: System.Drawing.Primitives => 0x9ee22cc0 => 35
	i32 2676780864, ; 436: System.Data.Common.dll => 0x9f8c6f40 => 22
	i32 2686887180, ; 437: System.Runtime.Serialization.Xml.dll => 0xa026a50c => 114
	i32 2693849962, ; 438: System.IO.dll => 0xa090e36a => 57
	i32 2701096212, ; 439: Xamarin.AndroidX.Tracing.Tracing => 0xa0ff7514 => 297
	i32 2715334215, ; 440: System.Threading.Tasks.dll => 0xa1d8b647 => 144
	i32 2717744543, ; 441: System.Security.Claims => 0xa1fd7d9f => 118
	i32 2719963679, ; 442: System.Security.Cryptography.Cng.dll => 0xa21f5a1f => 120
	i32 2724373263, ; 443: System.Runtime.Numerics.dll => 0xa262a30f => 110
	i32 2732626843, ; 444: Xamarin.AndroidX.Activity => 0xa2e0939b => 239
	i32 2735172069, ; 445: System.Threading.Channels => 0xa30769e5 => 139
	i32 2737747696, ; 446: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 245
	i32 2740948882, ; 447: System.IO.Pipes.AccessControl => 0xa35f8f92 => 54
	i32 2744327253, ; 448: Google.Api.Gax.Grpc.dll => 0xa3931c55 => 179
	i32 2748088231, ; 449: System.Runtime.InteropServices.JavaScript => 0xa3cc7fa7 => 105
	i32 2752995522, ; 450: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 340
	i32 2756874198, ; 451: NetTopologySuite.IO.GeoJSON4STJ => 0xa4528fd6 => 218
	i32 2757554483, ; 452: Google.Api.Gax.Grpc => 0xa45cf133 => 179
	i32 2758225723, ; 453: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 212
	i32 2764765095, ; 454: Microsoft.Maui.dll => 0xa4caf7a7 => 213
	i32 2765824710, ; 455: System.Text.Encoding.CodePages.dll => 0xa4db22c6 => 133
	i32 2770495804, ; 456: Xamarin.Jetbrains.Annotations.dll => 0xa522693c => 312
	i32 2778768386, ; 457: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 302
	i32 2779977773, ; 458: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 0xa5b3182d => 290
	i32 2785988530, ; 459: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 346
	i32 2788224221, ; 460: Xamarin.AndroidX.Fragment.Ktx.dll => 0xa630ecdd => 268
	i32 2795602088, ; 461: SkiaSharp.Views.Android.dll => 0xa6a180a8 => 223
	i32 2801831435, ; 462: Microsoft.Maui.Graphics => 0xa7008e0b => 215
	i32 2803228030, ; 463: System.Xml.XPath.XDocument.dll => 0xa715dd7e => 159
	i32 2806116107, ; 464: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 325
	i32 2810250172, ; 465: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 255
	i32 2818335264, ; 466: System.Linq.Async => 0xa7fc6220 => 231
	i32 2819470561, ; 467: System.Xml.dll => 0xa80db4e1 => 163
	i32 2821205001, ; 468: System.ServiceProcess.dll => 0xa8282c09 => 132
	i32 2821294376, ; 469: Xamarin.AndroidX.ResourceInspection.Annotation => 0xa8298928 => 290
	i32 2824502124, ; 470: System.Xml.XmlDocument => 0xa85a7b6c => 161
	i32 2831556043, ; 471: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 338
	i32 2838993487, ; 472: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 0xa9379a4f => 279
	i32 2839679515, ; 473: Google.LongRunning => 0xa942121b => 186
	i32 2849599387, ; 474: System.Threading.Overlapped.dll => 0xa9d96f9b => 140
	i32 2853208004, ; 475: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 302
	i32 2855708567, ; 476: Xamarin.AndroidX.Transition => 0xaa36a797 => 298
	i32 2861098320, ; 477: Mono.Android.Export.dll => 0xaa88e550 => 169
	i32 2861189240, ; 478: Microsoft.Maui.Essentials => 0xaa8a4878 => 214
	i32 2870099610, ; 479: Xamarin.AndroidX.Activity.Ktx.dll => 0xab123e9a => 240
	i32 2875164099, ; 480: Jsr305Binding.dll => 0xab5f85c3 => 308
	i32 2875220617, ; 481: System.Globalization.Calendars.dll => 0xab606289 => 40
	i32 2884993177, ; 482: Xamarin.AndroidX.ExifInterface => 0xabf58099 => 266
	i32 2887636118, ; 483: System.Net.dll => 0xac1dd496 => 81
	i32 2893550578, ; 484: Google.Apis.Core => 0xac7813f2 => 182
	i32 2898407901, ; 485: System.Management => 0xacc231dd => 232
	i32 2899753641, ; 486: System.IO.UnmanagedMemoryStream => 0xacd6baa9 => 56
	i32 2900621748, ; 487: System.Dynamic.Runtime.dll => 0xace3f9b4 => 37
	i32 2901442782, ; 488: System.Reflection => 0xacf080de => 97
	i32 2905242038, ; 489: mscorlib.dll => 0xad2a79b6 => 166
	i32 2909740682, ; 490: System.Private.CoreLib => 0xad6f1e8a => 172
	i32 2912489636, ; 491: SkiaSharp.Views.Android => 0xad9910a4 => 223
	i32 2912646636, ; 492: Google.Api.CommonProtos => 0xad9b75ec => 177
	i32 2916838712, ; 493: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 303
	i32 2919462931, ; 494: System.Numerics.Vectors.dll => 0xae037813 => 82
	i32 2921128767, ; 495: Xamarin.AndroidX.Annotation.Experimental.dll => 0xae1ce33f => 242
	i32 2936416060, ; 496: System.Resources.Reader => 0xaf06273c => 98
	i32 2940926066, ; 497: System.Diagnostics.StackTrace.dll => 0xaf4af872 => 30
	i32 2942453041, ; 498: System.Xml.XPath.XDocument => 0xaf624531 => 159
	i32 2959614098, ; 499: System.ComponentModel.dll => 0xb0682092 => 18
	i32 2968338931, ; 500: System.Security.Principal.Windows => 0xb0ed41f3 => 127
	i32 2972252294, ; 501: System.Security.Cryptography.Algorithms.dll => 0xb128f886 => 119
	i32 2978675010, ; 502: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 262
	i32 2987532451, ; 503: Xamarin.AndroidX.Security.SecurityCrypto => 0xb21220a3 => 293
	i32 2990604888, ; 504: Google.Apis => 0xb2410258 => 180
	i32 2996846495, ; 505: Xamarin.AndroidX.Lifecycle.Process.dll => 0xb2a03f9f => 275
	i32 3016983068, ; 506: Xamarin.AndroidX.Startup.StartupRuntime => 0xb3d3821c => 295
	i32 3023353419, ; 507: WindowsBase.dll => 0xb434b64b => 165
	i32 3024354802, ; 508: Xamarin.AndroidX.Legacy.Support.Core.Utils => 0xb443fdf2 => 270
	i32 3038032645, ; 509: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 353
	i32 3056245963, ; 510: Xamarin.AndroidX.SavedState.SavedState.Ktx => 0xb62a9ccb => 292
	i32 3057625584, ; 511: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 283
	i32 3059408633, ; 512: Mono.Android.Runtime => 0xb65adef9 => 170
	i32 3059793426, ; 513: System.ComponentModel.Primitives => 0xb660be12 => 16
	i32 3075834255, ; 514: System.Threading.Tasks => 0xb755818f => 144
	i32 3077302341, ; 515: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 331
	i32 3090735792, ; 516: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 125
	i32 3099732863, ; 517: System.Security.Claims.dll => 0xb8c22b7f => 118
	i32 3103600923, ; 518: System.Formats.Asn1 => 0xb8fd311b => 38
	i32 3106263381, ; 519: Grpc.Net.Common.dll => 0xb925d155 => 192
	i32 3111772706, ; 520: System.Runtime.Serialization => 0xb979e222 => 115
	i32 3121463068, ; 521: System.IO.FileSystem.AccessControl.dll => 0xba0dbf1c => 47
	i32 3124832203, ; 522: System.Threading.Tasks.Extensions => 0xba4127cb => 142
	i32 3132293585, ; 523: System.Security.AccessControl => 0xbab301d1 => 117
	i32 3134694676, ; 524: ShimSkiaSharp.dll => 0xbad7a514 => 220
	i32 3147165239, ; 525: System.Diagnostics.Tracing.dll => 0xbb95ee37 => 34
	i32 3148237826, ; 526: GoogleGson.dll => 0xbba64c02 => 188
	i32 3159123045, ; 527: System.Reflection.Primitives.dll => 0xbc4c6465 => 95
	i32 3160747431, ; 528: System.IO.MemoryMappedFiles => 0xbc652da7 => 53
	i32 3178803400, ; 529: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 284
	i32 3192346100, ; 530: System.Security.SecureString => 0xbe4755f4 => 129
	i32 3193515020, ; 531: System.Web => 0xbe592c0c => 153
	i32 3203277885, ; 532: Google.Api.Gax.dll => 0xbeee243d => 178
	i32 3204380047, ; 533: System.Data.dll => 0xbefef58f => 24
	i32 3209718065, ; 534: System.Xml.XmlDocument.dll => 0xbf506931 => 161
	i32 3211777861, ; 535: Xamarin.AndroidX.DocumentFile => 0xbf6fd745 => 261
	i32 3220365878, ; 536: System.Threading => 0xbff2e236 => 148
	i32 3226221578, ; 537: System.Runtime.Handles.dll => 0xc04c3c0a => 104
	i32 3251039220, ; 538: System.Reflection.DispatchProxy.dll => 0xc1c6ebf4 => 89
	i32 3258312781, ; 539: Xamarin.AndroidX.CardView => 0xc235e84d => 249
	i32 3265493905, ; 540: System.Linq.Queryable.dll => 0xc2a37b91 => 60
	i32 3265893370, ; 541: System.Threading.Tasks.Extensions.dll => 0xc2a993fa => 142
	i32 3277815716, ; 542: System.Resources.Writer.dll => 0xc35f7fa4 => 100
	i32 3278552754, ; 543: Mapsui => 0xc36abeb2 => 195
	i32 3279906254, ; 544: Microsoft.Win32.Registry.dll => 0xc37f65ce => 5
	i32 3280506390, ; 545: System.ComponentModel.Annotations.dll => 0xc3888e16 => 13
	i32 3290767353, ; 546: System.Security.Cryptography.Encoding => 0xc4251ff9 => 122
	i32 3299363146, ; 547: System.Text.Encoding => 0xc4a8494a => 135
	i32 3303498502, ; 548: System.Diagnostics.FileVersionInfo => 0xc4e76306 => 28
	i32 3305363605, ; 549: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 326
	i32 3316684772, ; 550: System.Net.Requests.dll => 0xc5b097e4 => 72
	i32 3317135071, ; 551: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 259
	i32 3317144872, ; 552: System.Data => 0xc5b79d28 => 24
	i32 3322403133, ; 553: Firebase.dll => 0xc607d93d => 176
	i32 3340387945, ; 554: SkiaSharp => 0xc71a4669 => 221
	i32 3340431453, ; 555: Xamarin.AndroidX.Arch.Core.Runtime => 0xc71af05d => 247
	i32 3345895724, ; 556: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 0xc76e512c => 288
	i32 3346324047, ; 557: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 285
	i32 3357674450, ; 558: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 343
	i32 3358260929, ; 559: System.Text.Json => 0xc82afec1 => 137
	i32 3362336904, ; 560: Xamarin.AndroidX.Activity.Ktx => 0xc8693088 => 240
	i32 3362522851, ; 561: Xamarin.AndroidX.Core => 0xc86c06e3 => 256
	i32 3366347497, ; 562: Java.Interop => 0xc8a662e9 => 168
	i32 3374999561, ; 563: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 289
	i32 3381016424, ; 564: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 322
	i32 3395150330, ; 565: System.Runtime.CompilerServices.Unsafe.dll => 0xca5de1fa => 101
	i32 3403906625, ; 566: System.Security.Cryptography.OpenSsl.dll => 0xcae37e41 => 123
	i32 3405233483, ; 567: Xamarin.AndroidX.CustomView.PoolingContainer => 0xcaf7bd4b => 260
	i32 3428513518, ; 568: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 203
	i32 3429136800, ; 569: System.Xml => 0xcc6479a0 => 163
	i32 3430777524, ; 570: netstandard => 0xcc7d82b4 => 167
	i32 3441283291, ; 571: Xamarin.AndroidX.DynamicAnimation.dll => 0xcd1dd0db => 263
	i32 3445260447, ; 572: System.Formats.Tar => 0xcd5a809f => 39
	i32 3452344032, ; 573: Microsoft.Maui.Controls.Compatibility.dll => 0xcdc696e0 => 210
	i32 3453592554, ; 574: Google.Apis.Core.dll => 0xcdd9a3ea => 182
	i32 3459815001, ; 575: Mapsui.Rendering.Skia => 0xce389659 => 198
	i32 3463511458, ; 576: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 330
	i32 3466574376, ; 577: SkiaSharp.Views.Maui.Controls.Compatibility.dll => 0xce9fba28 => 225
	i32 3471940407, ; 578: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 17
	i32 3473156932, ; 579: SkiaSharp.Views.Maui.Controls.dll => 0xcf042b44 => 224
	i32 3476120550, ; 580: Mono.Android => 0xcf3163e6 => 171
	i32 3479583265, ; 581: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 343
	i32 3484440000, ; 582: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 342
	i32 3485117614, ; 583: System.Text.Json.dll => 0xcfbaacae => 137
	i32 3486566296, ; 584: System.Transactions => 0xcfd0c798 => 150
	i32 3493954962, ; 585: Xamarin.AndroidX.Concurrent.Futures.dll => 0xd0418592 => 252
	i32 3499097210, ; 586: Google.Protobuf.dll => 0xd08ffc7a => 187
	i32 3509114376, ; 587: System.Xml.Linq => 0xd128d608 => 155
	i32 3515174580, ; 588: System.Security.dll => 0xd1854eb4 => 130
	i32 3530912306, ; 589: System.Configuration => 0xd2757232 => 19
	i32 3539954161, ; 590: System.Net.HttpListener => 0xd2ff69f1 => 65
	i32 3560100363, ; 591: System.Threading.Timer => 0xd432d20b => 147
	i32 3570554715, ; 592: System.IO.FileSystem.AccessControl => 0xd4d2575b => 47
	i32 3580758918, ; 593: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 350
	i32 3596207933, ; 594: LiteDB.dll => 0xd659c73d => 194
	i32 3597029428, ; 595: Xamarin.Android.Glide.GifDecoder.dll => 0xd6665034 => 238
	i32 3598063517, ; 596: Google.Cloud.Firestore.V1 => 0xd676179d => 184
	i32 3598340787, ; 597: System.Net.WebSockets.Client => 0xd67a52b3 => 79
	i32 3608519521, ; 598: System.Linq.dll => 0xd715a361 => 61
	i32 3612435020, ; 599: System.Management.dll => 0xd751624c => 232
	i32 3624195450, ; 600: System.Runtime.InteropServices.RuntimeInformation => 0xd804d57a => 106
	i32 3627220390, ; 601: Xamarin.AndroidX.Print.dll => 0xd832fda6 => 287
	i32 3629588173, ; 602: LiteDB => 0xd8571ecd => 194
	i32 3633644679, ; 603: Xamarin.AndroidX.Annotation.Experimental => 0xd8950487 => 242
	i32 3638274909, ; 604: System.IO.FileSystem.Primitives.dll => 0xd8dbab5d => 49
	i32 3641597786, ; 605: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 273
	i32 3643446276, ; 606: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 347
	i32 3643854240, ; 607: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 284
	i32 3645089577, ; 608: System.ComponentModel.DataAnnotations => 0xd943a729 => 14
	i32 3645630983, ; 609: Google.Protobuf => 0xd94bea07 => 187
	i32 3657292374, ; 610: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 202
	i32 3660523487, ; 611: System.Net.NetworkInformation => 0xda2f27df => 68
	i32 3672681054, ; 612: Mono.Android.dll => 0xdae8aa5e => 171
	i32 3682565725, ; 613: Xamarin.AndroidX.Browser => 0xdb7f7e5d => 248
	i32 3684561358, ; 614: Xamarin.AndroidX.Concurrent.Futures => 0xdb9df1ce => 252
	i32 3697841164, ; 615: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 352
	i32 3700866549, ; 616: System.Net.WebProxy.dll => 0xdc96bdf5 => 78
	i32 3706696989, ; 617: Xamarin.AndroidX.Core.Core.Ktx.dll => 0xdcefb51d => 257
	i32 3712156464, ; 618: Mapsui.UI.Maui.dll => 0xdd430330 => 196
	i32 3716563718, ; 619: System.Runtime.Intrinsics => 0xdd864306 => 108
	i32 3718780102, ; 620: Xamarin.AndroidX.Annotation => 0xdda814c6 => 241
	i32 3724971120, ; 621: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 283
	i32 3731644420, ; 622: System.Reactive => 0xde6c6004 => 233
	i32 3732100267, ; 623: System.Net.NameResolution => 0xde7354ab => 67
	i32 3737834244, ; 624: System.Net.Http.Json.dll => 0xdecad304 => 63
	i32 3748608112, ; 625: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 27
	i32 3751444290, ; 626: System.Xml.XPath => 0xdf9a7f42 => 160
	i32 3757995660, ; 627: Google.Cloud.Location.dll => 0xdffe768c => 185
	i32 3786282454, ; 628: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 250
	i32 3792276235, ; 629: System.Collections.NonGeneric => 0xe2098b0b => 10
	i32 3792835768, ; 630: HarfBuzzSharp => 0xe21214b8 => 193
	i32 3793997468, ; 631: Google.Apis.Auth.dll => 0xe223ce9c => 181
	i32 3798102808, ; 632: BruTile => 0xe2627318 => 173
	i32 3800979733, ; 633: Microsoft.Maui.Controls.Compatibility => 0xe28e5915 => 210
	i32 3802395368, ; 634: System.Collections.Specialized.dll => 0xe2a3f2e8 => 11
	i32 3819260425, ; 635: System.Net.WebProxy => 0xe3a54a09 => 78
	i32 3823082795, ; 636: System.Security.Cryptography.dll => 0xe3df9d2b => 126
	i32 3829621856, ; 637: System.Numerics.dll => 0xe4436460 => 83
	i32 3841636137, ; 638: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 204
	i32 3844307129, ; 639: System.Net.Mail.dll => 0xe52378b9 => 66
	i32 3849253459, ; 640: System.Runtime.InteropServices.dll => 0xe56ef253 => 107
	i32 3870376305, ; 641: System.Net.HttpListener.dll => 0xe6b14171 => 65
	i32 3873536506, ; 642: System.Security.Principal => 0xe6e179fa => 128
	i32 3875112723, ; 643: System.Security.Cryptography.Encoding.dll => 0xe6f98713 => 122
	i32 3885497537, ; 644: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 77
	i32 3885922214, ; 645: Xamarin.AndroidX.Transition.dll => 0xe79e77a6 => 298
	i32 3888767677, ; 646: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 0xe7c9e2bd => 288
	i32 3889960447, ; 647: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 351
	i32 3896106733, ; 648: System.Collections.Concurrent.dll => 0xe839deed => 8
	i32 3896760992, ; 649: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 256
	i32 3901907137, ; 650: Microsoft.VisualBasic.Core.dll => 0xe89260c1 => 2
	i32 3920810846, ; 651: System.IO.Compression.FileSystem.dll => 0xe9b2d35e => 44
	i32 3921031405, ; 652: Xamarin.AndroidX.VersionedParcelable.dll => 0xe9b630ed => 301
	i32 3928044579, ; 653: System.Xml.ReaderWriter => 0xea213423 => 156
	i32 3930554604, ; 654: System.Security.Principal.dll => 0xea4780ec => 128
	i32 3931092270, ; 655: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 286
	i32 3934069706, ; 656: Topten.RichTextKit.dll => 0xea7d23ca => 234
	i32 3945713374, ; 657: System.Data.DataSetExtensions.dll => 0xeb2ecede => 23
	i32 3952289091, ; 658: NetTopologySuite.Features.dll => 0xeb932543 => 217
	i32 3953583589, ; 659: Svg.Skia => 0xeba6e5e5 => 229
	i32 3953953790, ; 660: System.Text.Encoding.CodePages => 0xebac8bfe => 133
	i32 3955647286, ; 661: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 244
	i32 3959773229, ; 662: Xamarin.AndroidX.Lifecycle.Process => 0xec05582d => 275
	i32 3980434154, ; 663: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 346
	i32 3987592930, ; 664: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 328
	i32 4003436829, ; 665: System.Diagnostics.Process.dll => 0xee9f991d => 29
	i32 4003906742, ; 666: HarfBuzzSharp.dll => 0xeea6c4b6 => 193
	i32 4013003792, ; 667: BruTile.dll => 0xef319410 => 173
	i32 4015948917, ; 668: Xamarin.AndroidX.Annotation.Jvm.dll => 0xef5e8475 => 243
	i32 4022681963, ; 669: Mapsui.Tiling => 0xefc5416b => 199
	i32 4024013275, ; 670: Firebase.Auth => 0xefd991db => 175
	i32 4025784931, ; 671: System.Memory => 0xeff49a63 => 62
	i32 4046471985, ; 672: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 212
	i32 4054681211, ; 673: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 90
	i32 4056144661, ; 674: Google.Cloud.Location => 0xf1c3db15 => 185
	i32 4059682726, ; 675: Google.Apis.dll => 0xf1f9d7a6 => 180
	i32 4066802364, ; 676: SkiaSharp.HarfBuzz => 0xf2667abc => 222
	i32 4068434129, ; 677: System.Private.Xml.Linq.dll => 0xf27f60d1 => 87
	i32 4073602200, ; 678: System.Threading.dll => 0xf2ce3c98 => 148
	i32 4082882467, ; 679: Google.Apis.Auth => 0xf35bd7a3 => 181
	i32 4094352644, ; 680: Microsoft.Maui.Essentials.dll => 0xf40add04 => 214
	i32 4099507663, ; 681: System.Drawing.dll => 0xf45985cf => 36
	i32 4100113165, ; 682: System.Private.Uri => 0xf462c30d => 86
	i32 4101593132, ; 683: Xamarin.AndroidX.Emoji2 => 0xf479582c => 264
	i32 4102112229, ; 684: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 341
	i32 4125707920, ; 685: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 336
	i32 4126470640, ; 686: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 203
	i32 4127667938, ; 687: System.IO.FileSystem.Watcher => 0xf60736e2 => 50
	i32 4130442656, ; 688: System.AppContext => 0xf6318da0 => 6
	i32 4144557198, ; 689: NetTopologySuite.Features => 0xf708ec8e => 217
	i32 4147896353, ; 690: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 90
	i32 4150914736, ; 691: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 348
	i32 4151237749, ; 692: System.Core => 0xf76edc75 => 21
	i32 4159265925, ; 693: System.Xml.XmlSerializer => 0xf7e95c85 => 162
	i32 4161255271, ; 694: System.Reflection.TypeExtensions => 0xf807b767 => 96
	i32 4164802419, ; 695: System.IO.FileSystem.Watcher.dll => 0xf83dd773 => 50
	i32 4181436372, ; 696: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 113
	i32 4182413190, ; 697: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 280
	i32 4185676441, ; 698: System.Security => 0xf97c5a99 => 130
	i32 4196529839, ; 699: System.Net.WebClient.dll => 0xfa21f6af => 76
	i32 4213026141, ; 700: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 27
	i32 4256097574, ; 701: Xamarin.AndroidX.Core.Core.Ktx => 0xfdaee526 => 257
	i32 4258378803, ; 702: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 0xfdd1b433 => 279
	i32 4260525087, ; 703: System.Buffers => 0xfdf2741f => 7
	i32 4271975918, ; 704: Microsoft.Maui.Controls.dll => 0xfea12dee => 211
	i32 4274976490, ; 705: System.Runtime.Numerics => 0xfecef6ea => 110
	i32 4292120959, ; 706: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 280
	i32 4294763496 ; 707: Xamarin.AndroidX.ExifInterface.dll => 0xfffce3e8 => 266
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [708 x i32] [
	i32 68, ; 0
	i32 67, ; 1
	i32 108, ; 2
	i32 276, ; 3
	i32 311, ; 4
	i32 48, ; 5
	i32 219, ; 6
	i32 80, ; 7
	i32 145, ; 8
	i32 30, ; 9
	i32 352, ; 10
	i32 124, ; 11
	i32 215, ; 12
	i32 102, ; 13
	i32 294, ; 14
	i32 107, ; 15
	i32 294, ; 16
	i32 139, ; 17
	i32 315, ; 18
	i32 77, ; 19
	i32 229, ; 20
	i32 124, ; 21
	i32 13, ; 22
	i32 250, ; 23
	i32 132, ; 24
	i32 296, ; 25
	i32 151, ; 26
	i32 349, ; 27
	i32 350, ; 28
	i32 18, ; 29
	i32 248, ; 30
	i32 26, ; 31
	i32 270, ; 32
	i32 1, ; 33
	i32 59, ; 34
	i32 42, ; 35
	i32 91, ; 36
	i32 253, ; 37
	i32 147, ; 38
	i32 272, ; 39
	i32 269, ; 40
	i32 321, ; 41
	i32 54, ; 42
	i32 196, ; 43
	i32 69, ; 44
	i32 349, ; 45
	i32 239, ; 46
	i32 83, ; 47
	i32 334, ; 48
	i32 271, ; 49
	i32 333, ; 50
	i32 131, ; 51
	i32 192, ; 52
	i32 55, ; 53
	i32 190, ; 54
	i32 149, ; 55
	i32 74, ; 56
	i32 145, ; 57
	i32 62, ; 58
	i32 191, ; 59
	i32 146, ; 60
	i32 176, ; 61
	i32 353, ; 62
	i32 165, ; 63
	i32 345, ; 64
	i32 254, ; 65
	i32 306, ; 66
	i32 12, ; 67
	i32 267, ; 68
	i32 125, ; 69
	i32 152, ; 70
	i32 113, ; 71
	i32 174, ; 72
	i32 166, ; 73
	i32 164, ; 74
	i32 228, ; 75
	i32 269, ; 76
	i32 282, ; 77
	i32 84, ; 78
	i32 332, ; 79
	i32 326, ; 80
	i32 209, ; 81
	i32 221, ; 82
	i32 150, ; 83
	i32 315, ; 84
	i32 60, ; 85
	i32 205, ; 86
	i32 51, ; 87
	i32 103, ; 88
	i32 114, ; 89
	i32 200, ; 90
	i32 40, ; 91
	i32 308, ; 92
	i32 305, ; 93
	i32 120, ; 94
	i32 340, ; 95
	i32 52, ; 96
	i32 44, ; 97
	i32 233, ; 98
	i32 119, ; 99
	i32 259, ; 100
	i32 338, ; 101
	i32 265, ; 102
	i32 81, ; 103
	i32 184, ; 104
	i32 136, ; 105
	i32 301, ; 106
	i32 246, ; 107
	i32 8, ; 108
	i32 198, ; 109
	i32 73, ; 110
	i32 320, ; 111
	i32 155, ; 112
	i32 317, ; 113
	i32 154, ; 114
	i32 92, ; 115
	i32 312, ; 116
	i32 45, ; 117
	i32 335, ; 118
	i32 0, ; 119
	i32 323, ; 120
	i32 316, ; 121
	i32 109, ; 122
	i32 129, ; 123
	i32 25, ; 124
	i32 236, ; 125
	i32 72, ; 126
	i32 55, ; 127
	i32 46, ; 128
	i32 344, ; 129
	i32 222, ; 130
	i32 208, ; 131
	i32 260, ; 132
	i32 22, ; 133
	i32 274, ; 134
	i32 86, ; 135
	i32 43, ; 136
	i32 160, ; 137
	i32 71, ; 138
	i32 287, ; 139
	i32 3, ; 140
	i32 42, ; 141
	i32 63, ; 142
	i32 216, ; 143
	i32 16, ; 144
	i32 53, ; 145
	i32 347, ; 146
	i32 311, ; 147
	i32 105, ; 148
	i32 219, ; 149
	i32 316, ; 150
	i32 309, ; 151
	i32 271, ; 152
	i32 34, ; 153
	i32 158, ; 154
	i32 85, ; 155
	i32 32, ; 156
	i32 12, ; 157
	i32 51, ; 158
	i32 56, ; 159
	i32 291, ; 160
	i32 36, ; 161
	i32 204, ; 162
	i32 322, ; 163
	i32 310, ; 164
	i32 244, ; 165
	i32 35, ; 166
	i32 58, ; 167
	i32 177, ; 168
	i32 278, ; 169
	i32 188, ; 170
	i32 17, ; 171
	i32 313, ; 172
	i32 164, ; 173
	i32 335, ; 174
	i32 277, ; 175
	i32 207, ; 176
	i32 231, ; 177
	i32 304, ; 178
	i32 341, ; 179
	i32 153, ; 180
	i32 300, ; 181
	i32 285, ; 182
	i32 191, ; 183
	i32 339, ; 184
	i32 246, ; 185
	i32 29, ; 186
	i32 52, ; 187
	i32 337, ; 188
	i32 305, ; 189
	i32 5, ; 190
	i32 321, ; 191
	i32 295, ; 192
	i32 299, ; 193
	i32 251, ; 194
	i32 317, ; 195
	i32 243, ; 196
	i32 262, ; 197
	i32 85, ; 198
	i32 234, ; 199
	i32 304, ; 200
	i32 61, ; 201
	i32 112, ; 202
	i32 57, ; 203
	i32 351, ; 204
	i32 291, ; 205
	i32 99, ; 206
	i32 195, ; 207
	i32 19, ; 208
	i32 255, ; 209
	i32 111, ; 210
	i32 101, ; 211
	i32 102, ; 212
	i32 199, ; 213
	i32 319, ; 214
	i32 104, ; 215
	i32 309, ; 216
	i32 189, ; 217
	i32 71, ; 218
	i32 216, ; 219
	i32 38, ; 220
	i32 32, ; 221
	i32 103, ; 222
	i32 73, ; 223
	i32 325, ; 224
	i32 9, ; 225
	i32 123, ; 226
	i32 46, ; 227
	i32 245, ; 228
	i32 209, ; 229
	i32 9, ; 230
	i32 43, ; 231
	i32 4, ; 232
	i32 292, ; 233
	i32 0, ; 234
	i32 329, ; 235
	i32 324, ; 236
	i32 31, ; 237
	i32 138, ; 238
	i32 92, ; 239
	i32 93, ; 240
	i32 344, ; 241
	i32 49, ; 242
	i32 141, ; 243
	i32 112, ; 244
	i32 140, ; 245
	i32 261, ; 246
	i32 115, ; 247
	i32 310, ; 248
	i32 220, ; 249
	i32 157, ; 250
	i32 76, ; 251
	i32 79, ; 252
	i32 281, ; 253
	i32 37, ; 254
	i32 224, ; 255
	i32 303, ; 256
	i32 265, ; 257
	i32 258, ; 258
	i32 64, ; 259
	i32 138, ; 260
	i32 15, ; 261
	i32 116, ; 262
	i32 297, ; 263
	i32 307, ; 264
	i32 253, ; 265
	i32 218, ; 266
	i32 48, ; 267
	i32 70, ; 268
	i32 80, ; 269
	i32 126, ; 270
	i32 94, ; 271
	i32 121, ; 272
	i32 314, ; 273
	i32 26, ; 274
	i32 274, ; 275
	i32 97, ; 276
	i32 28, ; 277
	i32 249, ; 278
	i32 342, ; 279
	i32 320, ; 280
	i32 149, ; 281
	i32 169, ; 282
	i32 4, ; 283
	i32 98, ; 284
	i32 33, ; 285
	i32 93, ; 286
	i32 296, ; 287
	i32 205, ; 288
	i32 21, ; 289
	i32 41, ; 290
	i32 170, ; 291
	i32 190, ; 292
	i32 336, ; 293
	i32 267, ; 294
	i32 328, ; 295
	i32 200, ; 296
	i32 281, ; 297
	i32 313, ; 298
	i32 307, ; 299
	i32 286, ; 300
	i32 2, ; 301
	i32 134, ; 302
	i32 111, ; 303
	i32 206, ; 304
	i32 197, ; 305
	i32 348, ; 306
	i32 236, ; 307
	i32 345, ; 308
	i32 58, ; 309
	i32 306, ; 310
	i32 95, ; 311
	i32 327, ; 312
	i32 39, ; 313
	i32 247, ; 314
	i32 25, ; 315
	i32 94, ; 316
	i32 89, ; 317
	i32 189, ; 318
	i32 99, ; 319
	i32 10, ; 320
	i32 230, ; 321
	i32 87, ; 322
	i32 100, ; 323
	i32 293, ; 324
	i32 201, ; 325
	i32 314, ; 326
	i32 238, ; 327
	i32 324, ; 328
	i32 7, ; 329
	i32 278, ; 330
	i32 319, ; 331
	i32 235, ; 332
	i32 88, ; 333
	i32 273, ; 334
	i32 154, ; 335
	i32 323, ; 336
	i32 33, ; 337
	i32 116, ; 338
	i32 82, ; 339
	i32 20, ; 340
	i32 11, ; 341
	i32 162, ; 342
	i32 3, ; 343
	i32 213, ; 344
	i32 331, ; 345
	i32 230, ; 346
	i32 208, ; 347
	i32 206, ; 348
	i32 84, ; 349
	i32 318, ; 350
	i32 64, ; 351
	i32 333, ; 352
	i32 175, ; 353
	i32 300, ; 354
	i32 143, ; 355
	i32 282, ; 356
	i32 157, ; 357
	i32 41, ; 358
	i32 117, ; 359
	i32 202, ; 360
	i32 237, ; 361
	i32 327, ; 362
	i32 289, ; 363
	i32 131, ; 364
	i32 75, ; 365
	i32 66, ; 366
	i32 337, ; 367
	i32 172, ; 368
	i32 241, ; 369
	i32 143, ; 370
	i32 174, ; 371
	i32 106, ; 372
	i32 151, ; 373
	i32 70, ; 374
	i32 226, ; 375
	i32 156, ; 376
	i32 201, ; 377
	i32 121, ; 378
	i32 127, ; 379
	i32 332, ; 380
	i32 186, ; 381
	i32 152, ; 382
	i32 264, ; 383
	i32 141, ; 384
	i32 251, ; 385
	i32 329, ; 386
	i32 20, ; 387
	i32 14, ; 388
	i32 183, ; 389
	i32 135, ; 390
	i32 75, ; 391
	i32 59, ; 392
	i32 254, ; 393
	i32 167, ; 394
	i32 168, ; 395
	i32 211, ; 396
	i32 15, ; 397
	i32 74, ; 398
	i32 178, ; 399
	i32 6, ; 400
	i32 23, ; 401
	i32 276, ; 402
	i32 225, ; 403
	i32 235, ; 404
	i32 227, ; 405
	i32 91, ; 406
	i32 330, ; 407
	i32 1, ; 408
	i32 136, ; 409
	i32 197, ; 410
	i32 277, ; 411
	i32 299, ; 412
	i32 134, ; 413
	i32 69, ; 414
	i32 146, ; 415
	i32 339, ; 416
	i32 228, ; 417
	i32 318, ; 418
	i32 227, ; 419
	i32 268, ; 420
	i32 207, ; 421
	i32 88, ; 422
	i32 96, ; 423
	i32 258, ; 424
	i32 263, ; 425
	i32 226, ; 426
	i32 334, ; 427
	i32 31, ; 428
	i32 45, ; 429
	i32 272, ; 430
	i32 183, ; 431
	i32 237, ; 432
	i32 109, ; 433
	i32 158, ; 434
	i32 35, ; 435
	i32 22, ; 436
	i32 114, ; 437
	i32 57, ; 438
	i32 297, ; 439
	i32 144, ; 440
	i32 118, ; 441
	i32 120, ; 442
	i32 110, ; 443
	i32 239, ; 444
	i32 139, ; 445
	i32 245, ; 446
	i32 54, ; 447
	i32 179, ; 448
	i32 105, ; 449
	i32 340, ; 450
	i32 218, ; 451
	i32 179, ; 452
	i32 212, ; 453
	i32 213, ; 454
	i32 133, ; 455
	i32 312, ; 456
	i32 302, ; 457
	i32 290, ; 458
	i32 346, ; 459
	i32 268, ; 460
	i32 223, ; 461
	i32 215, ; 462
	i32 159, ; 463
	i32 325, ; 464
	i32 255, ; 465
	i32 231, ; 466
	i32 163, ; 467
	i32 132, ; 468
	i32 290, ; 469
	i32 161, ; 470
	i32 338, ; 471
	i32 279, ; 472
	i32 186, ; 473
	i32 140, ; 474
	i32 302, ; 475
	i32 298, ; 476
	i32 169, ; 477
	i32 214, ; 478
	i32 240, ; 479
	i32 308, ; 480
	i32 40, ; 481
	i32 266, ; 482
	i32 81, ; 483
	i32 182, ; 484
	i32 232, ; 485
	i32 56, ; 486
	i32 37, ; 487
	i32 97, ; 488
	i32 166, ; 489
	i32 172, ; 490
	i32 223, ; 491
	i32 177, ; 492
	i32 303, ; 493
	i32 82, ; 494
	i32 242, ; 495
	i32 98, ; 496
	i32 30, ; 497
	i32 159, ; 498
	i32 18, ; 499
	i32 127, ; 500
	i32 119, ; 501
	i32 262, ; 502
	i32 293, ; 503
	i32 180, ; 504
	i32 275, ; 505
	i32 295, ; 506
	i32 165, ; 507
	i32 270, ; 508
	i32 353, ; 509
	i32 292, ; 510
	i32 283, ; 511
	i32 170, ; 512
	i32 16, ; 513
	i32 144, ; 514
	i32 331, ; 515
	i32 125, ; 516
	i32 118, ; 517
	i32 38, ; 518
	i32 192, ; 519
	i32 115, ; 520
	i32 47, ; 521
	i32 142, ; 522
	i32 117, ; 523
	i32 220, ; 524
	i32 34, ; 525
	i32 188, ; 526
	i32 95, ; 527
	i32 53, ; 528
	i32 284, ; 529
	i32 129, ; 530
	i32 153, ; 531
	i32 178, ; 532
	i32 24, ; 533
	i32 161, ; 534
	i32 261, ; 535
	i32 148, ; 536
	i32 104, ; 537
	i32 89, ; 538
	i32 249, ; 539
	i32 60, ; 540
	i32 142, ; 541
	i32 100, ; 542
	i32 195, ; 543
	i32 5, ; 544
	i32 13, ; 545
	i32 122, ; 546
	i32 135, ; 547
	i32 28, ; 548
	i32 326, ; 549
	i32 72, ; 550
	i32 259, ; 551
	i32 24, ; 552
	i32 176, ; 553
	i32 221, ; 554
	i32 247, ; 555
	i32 288, ; 556
	i32 285, ; 557
	i32 343, ; 558
	i32 137, ; 559
	i32 240, ; 560
	i32 256, ; 561
	i32 168, ; 562
	i32 289, ; 563
	i32 322, ; 564
	i32 101, ; 565
	i32 123, ; 566
	i32 260, ; 567
	i32 203, ; 568
	i32 163, ; 569
	i32 167, ; 570
	i32 263, ; 571
	i32 39, ; 572
	i32 210, ; 573
	i32 182, ; 574
	i32 198, ; 575
	i32 330, ; 576
	i32 225, ; 577
	i32 17, ; 578
	i32 224, ; 579
	i32 171, ; 580
	i32 343, ; 581
	i32 342, ; 582
	i32 137, ; 583
	i32 150, ; 584
	i32 252, ; 585
	i32 187, ; 586
	i32 155, ; 587
	i32 130, ; 588
	i32 19, ; 589
	i32 65, ; 590
	i32 147, ; 591
	i32 47, ; 592
	i32 350, ; 593
	i32 194, ; 594
	i32 238, ; 595
	i32 184, ; 596
	i32 79, ; 597
	i32 61, ; 598
	i32 232, ; 599
	i32 106, ; 600
	i32 287, ; 601
	i32 194, ; 602
	i32 242, ; 603
	i32 49, ; 604
	i32 273, ; 605
	i32 347, ; 606
	i32 284, ; 607
	i32 14, ; 608
	i32 187, ; 609
	i32 202, ; 610
	i32 68, ; 611
	i32 171, ; 612
	i32 248, ; 613
	i32 252, ; 614
	i32 352, ; 615
	i32 78, ; 616
	i32 257, ; 617
	i32 196, ; 618
	i32 108, ; 619
	i32 241, ; 620
	i32 283, ; 621
	i32 233, ; 622
	i32 67, ; 623
	i32 63, ; 624
	i32 27, ; 625
	i32 160, ; 626
	i32 185, ; 627
	i32 250, ; 628
	i32 10, ; 629
	i32 193, ; 630
	i32 181, ; 631
	i32 173, ; 632
	i32 210, ; 633
	i32 11, ; 634
	i32 78, ; 635
	i32 126, ; 636
	i32 83, ; 637
	i32 204, ; 638
	i32 66, ; 639
	i32 107, ; 640
	i32 65, ; 641
	i32 128, ; 642
	i32 122, ; 643
	i32 77, ; 644
	i32 298, ; 645
	i32 288, ; 646
	i32 351, ; 647
	i32 8, ; 648
	i32 256, ; 649
	i32 2, ; 650
	i32 44, ; 651
	i32 301, ; 652
	i32 156, ; 653
	i32 128, ; 654
	i32 286, ; 655
	i32 234, ; 656
	i32 23, ; 657
	i32 217, ; 658
	i32 229, ; 659
	i32 133, ; 660
	i32 244, ; 661
	i32 275, ; 662
	i32 346, ; 663
	i32 328, ; 664
	i32 29, ; 665
	i32 193, ; 666
	i32 173, ; 667
	i32 243, ; 668
	i32 199, ; 669
	i32 175, ; 670
	i32 62, ; 671
	i32 212, ; 672
	i32 90, ; 673
	i32 185, ; 674
	i32 180, ; 675
	i32 222, ; 676
	i32 87, ; 677
	i32 148, ; 678
	i32 181, ; 679
	i32 214, ; 680
	i32 36, ; 681
	i32 86, ; 682
	i32 264, ; 683
	i32 341, ; 684
	i32 336, ; 685
	i32 203, ; 686
	i32 50, ; 687
	i32 6, ; 688
	i32 217, ; 689
	i32 90, ; 690
	i32 348, ; 691
	i32 21, ; 692
	i32 162, ; 693
	i32 96, ; 694
	i32 50, ; 695
	i32 113, ; 696
	i32 280, ; 697
	i32 130, ; 698
	i32 76, ; 699
	i32 27, ; 700
	i32 257, ; 701
	i32 279, ; 702
	i32 7, ; 703
	i32 211, ; 704
	i32 110, ; 705
	i32 280, ; 706
	i32 266 ; 707
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.2xx @ 96b6bb65e8736e45180905177aa343f0e1854ea3"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"NumRegisterParameters", i32 0}
