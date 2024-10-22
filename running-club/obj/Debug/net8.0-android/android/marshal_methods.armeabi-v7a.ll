; ModuleID = 'marshal_methods.armeabi-v7a.ll'
source_filename = "marshal_methods.armeabi-v7a.ll"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv7-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [332 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [658 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 68
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 67
	i32 15721112, ; 2: System.Runtime.Intrinsics.dll => 0xefe298 => 108
	i32 32687329, ; 3: Xamarin.AndroidX.Lifecycle.Runtime => 0x1f2c4e1 => 252
	i32 34715100, ; 4: Xamarin.Google.Guava.ListenableFuture.dll => 0x211b5dc => 286
	i32 34839235, ; 5: System.IO.FileSystem.DriveInfo => 0x2139ac3 => 48
	i32 39485524, ; 6: System.Net.WebSockets.dll => 0x25a8054 => 80
	i32 42639949, ; 7: System.Threading.Thread => 0x28aa24d => 145
	i32 66541672, ; 8: System.Diagnostics.StackTrace => 0x3f75868 => 30
	i32 67008169, ; 9: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 327
	i32 68219467, ; 10: System.Security.Cryptography.Primitives => 0x410f24b => 124
	i32 72070932, ; 11: Microsoft.Maui.Graphics.dll => 0x44bb714 => 197
	i32 82292897, ; 12: System.Runtime.CompilerServices.VisualC.dll => 0x4e7b0a1 => 102
	i32 101534019, ; 13: Xamarin.AndroidX.SlidingPaneLayout => 0x60d4943 => 270
	i32 117431740, ; 14: System.Runtime.InteropServices => 0x6ffddbc => 107
	i32 120558881, ; 15: Xamarin.AndroidX.SlidingPaneLayout.dll => 0x72f9521 => 270
	i32 122350210, ; 16: System.Threading.Channels.dll => 0x74aea82 => 139
	i32 134690465, ; 17: Xamarin.Kotlin.StdLib.Jdk7.dll => 0x80736a1 => 290
	i32 142721839, ; 18: System.Net.WebHeaderCollection => 0x881c32f => 77
	i32 149764678, ; 19: Svg.Skia.dll => 0x8ed3a46 => 209
	i32 149972175, ; 20: System.Security.Cryptography.Primitives.dll => 0x8f064cf => 124
	i32 159306688, ; 21: System.ComponentModel.Annotations => 0x97ed3c0 => 13
	i32 165246403, ; 22: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 226
	i32 176265551, ; 23: System.ServiceProcess => 0xa81994f => 132
	i32 182336117, ; 24: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 272
	i32 184328833, ; 25: System.ValueTuple.dll => 0xafca281 => 151
	i32 195452805, ; 26: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 324
	i32 199333315, ; 27: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 325
	i32 205061960, ; 28: System.ComponentModel => 0xc38ff48 => 18
	i32 209399409, ; 29: Xamarin.AndroidX.Browser.dll => 0xc7b2e71 => 224
	i32 220171995, ; 30: System.Diagnostics.Debug => 0xd1f8edb => 26
	i32 230216969, ; 31: Xamarin.AndroidX.Legacy.Support.Core.Utils.dll => 0xdb8d509 => 246
	i32 230752869, ; 32: Microsoft.CSharp.dll => 0xdc10265 => 1
	i32 231409092, ; 33: System.Linq.Parallel => 0xdcb05c4 => 59
	i32 231814094, ; 34: System.Globalization => 0xdd133ce => 42
	i32 246610117, ; 35: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 91
	i32 261689757, ; 36: Xamarin.AndroidX.ConstraintLayout.dll => 0xf99119d => 229
	i32 276479776, ; 37: System.Threading.Timer.dll => 0x107abf20 => 147
	i32 278686392, ; 38: Xamarin.AndroidX.Lifecycle.LiveData.dll => 0x109c6ab8 => 248
	i32 280482487, ; 39: Xamarin.AndroidX.Interpolator => 0x10b7d2b7 => 245
	i32 280992041, ; 40: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 296
	i32 291076382, ; 41: System.IO.Pipes.AccessControl.dll => 0x1159791e => 54
	i32 292822316, ; 42: Mapsui.UI.Maui => 0x11741d2c => 179
	i32 298918909, ; 43: System.Net.Ping.dll => 0x11d123fd => 69
	i32 317674968, ; 44: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 324
	i32 318968648, ; 45: Xamarin.AndroidX.Activity.dll => 0x13031348 => 215
	i32 321597661, ; 46: System.Numerics => 0x132b30dd => 83
	i32 336156722, ; 47: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 309
	i32 342366114, ; 48: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 247
	i32 356389973, ; 49: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 308
	i32 360082299, ; 50: System.ServiceModel.Web => 0x15766b7b => 131
	i32 367780167, ; 51: System.IO.Pipes => 0x15ebe147 => 55
	i32 374914964, ; 52: System.Transactions.Local => 0x1658bf94 => 149
	i32 375677976, ; 53: System.Net.ServicePoint.dll => 0x16646418 => 74
	i32 379916513, ; 54: System.Threading.Thread.dll => 0x16a510e1 => 145
	i32 385762202, ; 55: System.Memory.dll => 0x16fe439a => 62
	i32 392610295, ; 56: System.Threading.ThreadPool.dll => 0x1766c1f7 => 146
	i32 395744057, ; 57: _Microsoft.Android.Resource.Designer => 0x17969339 => 328
	i32 403441872, ; 58: WindowsBase => 0x180c08d0 => 165
	i32 435591531, ; 59: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 320
	i32 441335492, ; 60: Xamarin.AndroidX.ConstraintLayout.Core => 0x1a4e3ec4 => 230
	i32 442565967, ; 61: System.Collections => 0x1a61054f => 12
	i32 450948140, ; 62: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 243
	i32 451504562, ; 63: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 125
	i32 456227837, ; 64: System.Web.HttpUtility.dll => 0x1b317bfd => 152
	i32 459347974, ; 65: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 113
	i32 465658307, ; 66: ExCSS => 0x1bc161c3 => 175
	i32 465846621, ; 67: mscorlib => 0x1bc4415d => 166
	i32 469710990, ; 68: System.dll => 0x1bff388e => 164
	i32 469965489, ; 69: Svg.Model => 0x1c031ab1 => 208
	i32 476646585, ; 70: Xamarin.AndroidX.Interpolator.dll => 0x1c690cb9 => 245
	i32 486930444, ; 71: Xamarin.AndroidX.LocalBroadcastManager.dll => 0x1d05f80c => 258
	i32 498788369, ; 72: System.ObjectModel => 0x1dbae811 => 84
	i32 500358224, ; 73: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 307
	i32 503918385, ; 74: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 301
	i32 513247710, ; 75: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 191
	i32 525008092, ; 76: SkiaSharp.dll => 0x1f4afcdc => 202
	i32 526420162, ; 77: System.Transactions.dll => 0x1f6088c2 => 150
	i32 527452488, ; 78: Xamarin.Kotlin.StdLib.Jdk7 => 0x1f704948 => 290
	i32 530272170, ; 79: System.Linq.Queryable => 0x1f9b4faa => 60
	i32 539058512, ; 80: Microsoft.Extensions.Logging => 0x20216150 => 187
	i32 540030774, ; 81: System.IO.FileSystem.dll => 0x20303736 => 51
	i32 545304856, ; 82: System.Runtime.Extensions => 0x2080b118 => 103
	i32 546455878, ; 83: System.Runtime.Serialization.Xml => 0x20924146 => 114
	i32 549171840, ; 84: System.Globalization.Calendars => 0x20bbb280 => 40
	i32 557405415, ; 85: Jsr305Binding => 0x213954e7 => 283
	i32 569601784, ; 86: Xamarin.AndroidX.Window.Extensions.Core.Core => 0x21f36ef8 => 281
	i32 577335427, ; 87: System.Security.Cryptography.Cng => 0x22697083 => 120
	i32 592146354, ; 88: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 315
	i32 601371474, ; 89: System.IO.IsolatedStorage.dll => 0x23d83352 => 52
	i32 605376203, ; 90: System.IO.Compression.FileSystem => 0x24154ecb => 44
	i32 613668793, ; 91: System.Security.Cryptography.Algorithms => 0x2493d7b9 => 119
	i32 627609679, ; 92: Xamarin.AndroidX.CustomView => 0x2568904f => 235
	i32 627931235, ; 93: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 313
	i32 639843206, ; 94: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 0x26233b86 => 241
	i32 643868501, ; 95: System.Net => 0x2660a755 => 81
	i32 662205335, ; 96: System.Text.Encodings.Web.dll => 0x27787397 => 136
	i32 663517072, ; 97: Xamarin.AndroidX.VersionedParcelable => 0x278c7790 => 277
	i32 666292255, ; 98: Xamarin.AndroidX.Arch.Core.Common.dll => 0x27b6d01f => 222
	i32 672442732, ; 99: System.Collections.Concurrent => 0x2814a96c => 8
	i32 680049820, ; 100: Mapsui.Rendering.Skia.dll => 0x2888bc9c => 181
	i32 683518922, ; 101: System.Net.Security => 0x28bdabca => 73
	i32 688181140, ; 102: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 295
	i32 690569205, ; 103: System.Xml.Linq.dll => 0x29293ff5 => 155
	i32 691348768, ; 104: Xamarin.KotlinX.Coroutines.Android.dll => 0x29352520 => 292
	i32 693804605, ; 105: System.Windows => 0x295a9e3d => 154
	i32 699345723, ; 106: System.Reflection.Emit => 0x29af2b3b => 92
	i32 700284507, ; 107: Xamarin.Jetbrains.Annotations => 0x29bd7e5b => 287
	i32 700358131, ; 108: System.IO.Compression.ZipFile => 0x29be9df3 => 45
	i32 706645707, ; 109: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 310
	i32 707666095, ; 110: running-club => 0x2a2e20af => 0
	i32 709557578, ; 111: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 298
	i32 720511267, ; 112: Xamarin.Kotlin.StdLib.Jdk8 => 0x2af22123 => 291
	i32 722857257, ; 113: System.Runtime.Loader.dll => 0x2b15ed29 => 109
	i32 735137430, ; 114: System.Security.SecureString.dll => 0x2bd14e96 => 129
	i32 752232764, ; 115: System.Diagnostics.Contracts.dll => 0x2cd6293c => 25
	i32 755313932, ; 116: Xamarin.Android.Glide.Annotations.dll => 0x2d052d0c => 212
	i32 759454413, ; 117: System.Net.Requests => 0x2d445acd => 72
	i32 762598435, ; 118: System.IO.Pipes.dll => 0x2d745423 => 55
	i32 775507847, ; 119: System.IO.Compression => 0x2e394f87 => 46
	i32 777317022, ; 120: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 319
	i32 778756650, ; 121: SkiaSharp.HarfBuzz.dll => 0x2e6ae22a => 203
	i32 789151979, ; 122: Microsoft.Extensions.Options => 0x2f0980eb => 190
	i32 790371945, ; 123: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 0x2f1c1e69 => 236
	i32 804715423, ; 124: System.Data.Common => 0x2ff6fb9f => 22
	i32 807930345, ; 125: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 0x302809e9 => 250
	i32 823281589, ; 126: System.Private.Uri.dll => 0x311247b5 => 86
	i32 830298997, ; 127: System.IO.Compression.Brotli => 0x317d5b75 => 43
	i32 832635846, ; 128: System.Xml.XPath.dll => 0x31a103c6 => 160
	i32 834051424, ; 129: System.Net.Quic => 0x31b69d60 => 71
	i32 843511501, ; 130: Xamarin.AndroidX.Print => 0x3246f6cd => 263
	i32 873119928, ; 131: Microsoft.VisualBasic => 0x340ac0b8 => 3
	i32 877678880, ; 132: System.Globalization.dll => 0x34505120 => 42
	i32 878954865, ; 133: System.Net.Http.Json => 0x3463c971 => 63
	i32 899130691, ; 134: NetTopologySuite.dll => 0x3597a543 => 198
	i32 904024072, ; 135: System.ComponentModel.Primitives.dll => 0x35e25008 => 16
	i32 911108515, ; 136: System.IO.MemoryMappedFiles.dll => 0x364e69a3 => 53
	i32 926902833, ; 137: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 322
	i32 928116545, ; 138: Xamarin.Google.Guava.ListenableFuture => 0x3751ef41 => 286
	i32 952186615, ; 139: System.Runtime.InteropServices.JavaScript.dll => 0x38c136f7 => 105
	i32 956575887, ; 140: Xamarin.Kotlin.StdLib.Jdk8.dll => 0x3904308f => 291
	i32 966729478, ; 141: Xamarin.Google.Crypto.Tink.Android => 0x399f1f06 => 284
	i32 967690846, ; 142: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 247
	i32 975236339, ; 143: System.Diagnostics.Tracing => 0x3a20ecf3 => 34
	i32 975874589, ; 144: System.Xml.XDocument => 0x3a2aaa1d => 158
	i32 986514023, ; 145: System.Private.DataContractSerialization.dll => 0x3acd0267 => 85
	i32 987214855, ; 146: System.Diagnostics.Tools => 0x3ad7b407 => 32
	i32 992768348, ; 147: System.Collections.dll => 0x3b2c715c => 12
	i32 994442037, ; 148: System.IO.FileSystem => 0x3b45fb35 => 51
	i32 1001831731, ; 149: System.IO.UnmanagedMemoryStream.dll => 0x3bb6bd33 => 56
	i32 1012816738, ; 150: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 267
	i32 1019214401, ; 151: System.Drawing => 0x3cbffa41 => 36
	i32 1028951442, ; 152: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 186
	i32 1029334545, ; 153: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 297
	i32 1031528504, ; 154: Xamarin.Google.ErrorProne.Annotations.dll => 0x3d7be038 => 285
	i32 1035644815, ; 155: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 220
	i32 1036536393, ; 156: System.Drawing.Primitives.dll => 0x3dc84a49 => 35
	i32 1044663988, ; 157: System.Linq.Expressions.dll => 0x3e444eb4 => 58
	i32 1052210849, ; 158: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 254
	i32 1067306892, ; 159: GoogleGson => 0x3f9dcf8c => 176
	i32 1082857460, ; 160: System.ComponentModel.TypeConverter => 0x408b17f4 => 17
	i32 1084122840, ; 161: Xamarin.Kotlin.StdLib => 0x409e66d8 => 288
	i32 1098259244, ; 162: System => 0x41761b2c => 164
	i32 1118262833, ; 163: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 310
	i32 1121599056, ; 164: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 0x42da3e50 => 253
	i32 1127624469, ; 165: Microsoft.Extensions.Logging.Debug => 0x43362f15 => 189
	i32 1149092582, ; 166: Xamarin.AndroidX.Window => 0x447dc2e6 => 280
	i32 1168523401, ; 167: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 316
	i32 1170634674, ; 168: System.Web.dll => 0x45c677b2 => 153
	i32 1175144683, ; 169: Xamarin.AndroidX.VectorDrawable.Animated => 0x460b48eb => 276
	i32 1178241025, ; 170: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 261
	i32 1203215381, ; 171: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 314
	i32 1204270330, ; 172: Xamarin.AndroidX.Arch.Core.Common => 0x47c7b4fa => 222
	i32 1208641965, ; 173: System.Diagnostics.Process => 0x480a69ad => 29
	i32 1219128291, ; 174: System.IO.IsolatedStorage => 0x48aa6be3 => 52
	i32 1234928153, ; 175: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 312
	i32 1240993432, ; 176: BruTile.XmlSerializers => 0x49f80e98 => 173
	i32 1243150071, ; 177: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 0x4a18f6f7 => 281
	i32 1253011324, ; 178: Microsoft.Win32.Registry => 0x4aaf6f7c => 5
	i32 1260983243, ; 179: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 296
	i32 1264511973, ; 180: Xamarin.AndroidX.Startup.StartupRuntime.dll => 0x4b5eebe5 => 271
	i32 1267360935, ; 181: Xamarin.AndroidX.VectorDrawable => 0x4b8a64a7 => 275
	i32 1273260888, ; 182: Xamarin.AndroidX.Collection.Ktx => 0x4be46b58 => 227
	i32 1275534314, ; 183: Xamarin.KotlinX.Coroutines.Android => 0x4c071bea => 292
	i32 1278448581, ; 184: Xamarin.AndroidX.Annotation.Jvm => 0x4c3393c5 => 219
	i32 1293217323, ; 185: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 238
	i32 1309188875, ; 186: System.Private.DataContractSerialization => 0x4e08a30b => 85
	i32 1313028017, ; 187: Topten.RichTextKit => 0x4e4337b1 => 210
	i32 1322716291, ; 188: Xamarin.AndroidX.Window.dll => 0x4ed70c83 => 280
	i32 1324164729, ; 189: System.Linq => 0x4eed2679 => 61
	i32 1335329327, ; 190: System.Runtime.Serialization.Json.dll => 0x4f97822f => 112
	i32 1364015309, ; 191: System.IO => 0x514d38cd => 57
	i32 1373134921, ; 192: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 326
	i32 1376866003, ; 193: Xamarin.AndroidX.SavedState => 0x52114ed3 => 267
	i32 1379779777, ; 194: System.Resources.ResourceManager => 0x523dc4c1 => 99
	i32 1388087747, ; 195: Mapsui.dll => 0x52bc89c3 => 178
	i32 1402170036, ; 196: System.Configuration.dll => 0x53936ab4 => 19
	i32 1406073936, ; 197: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 231
	i32 1408764838, ; 198: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 111
	i32 1411638395, ; 199: System.Runtime.CompilerServices.Unsafe => 0x5423e47b => 101
	i32 1422545099, ; 200: System.Runtime.CompilerServices.VisualC => 0x54ca50cb => 102
	i32 1422967952, ; 201: Mapsui.Tiling.dll => 0x54d0c490 => 182
	i32 1430672901, ; 202: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 294
	i32 1434145427, ; 203: System.Runtime.Handles => 0x557b5293 => 104
	i32 1435222561, ; 204: Xamarin.Google.Crypto.Tink.Android.dll => 0x558bc221 => 284
	i32 1439761251, ; 205: System.Net.Quic.dll => 0x55d10363 => 71
	i32 1443938015, ; 206: NetTopologySuite => 0x5610bedf => 198
	i32 1452070440, ; 207: System.Formats.Asn1.dll => 0x568cd628 => 38
	i32 1453312822, ; 208: System.Diagnostics.Tools.dll => 0x569fcb36 => 32
	i32 1457743152, ; 209: System.Runtime.Extensions.dll => 0x56e36530 => 103
	i32 1458022317, ; 210: System.Net.Security.dll => 0x56e7a7ad => 73
	i32 1461004990, ; 211: es\Microsoft.Maui.Controls.resources => 0x57152abe => 300
	i32 1461234159, ; 212: System.Collections.Immutable.dll => 0x5718a9ef => 9
	i32 1461719063, ; 213: System.Security.Cryptography.OpenSsl => 0x57201017 => 123
	i32 1462112819, ; 214: System.IO.Compression.dll => 0x57261233 => 46
	i32 1469204771, ; 215: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 221
	i32 1470490898, ; 216: Microsoft.Extensions.Primitives => 0x57a5e912 => 191
	i32 1479771757, ; 217: System.Collections.Immutable => 0x5833866d => 9
	i32 1480492111, ; 218: System.IO.Compression.Brotli.dll => 0x583e844f => 43
	i32 1487239319, ; 219: Microsoft.Win32.Primitives => 0x58a57897 => 4
	i32 1490025113, ; 220: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 0x58cffa99 => 268
	i32 1490249645, ; 221: running-club.dll => 0x58d367ad => 0
	i32 1493001747, ; 222: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 304
	i32 1514721132, ; 223: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 299
	i32 1536373174, ; 224: System.Diagnostics.TextWriterTraceListener => 0x5b9331b6 => 31
	i32 1543031311, ; 225: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 138
	i32 1543355203, ; 226: System.Reflection.Emit.dll => 0x5bfdbb43 => 92
	i32 1550322496, ; 227: System.Reflection.Extensions.dll => 0x5c680b40 => 93
	i32 1551623176, ; 228: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 319
	i32 1565862583, ; 229: System.IO.FileSystem.Primitives => 0x5d552ab7 => 49
	i32 1566207040, ; 230: System.Threading.Tasks.Dataflow.dll => 0x5d5a6c40 => 141
	i32 1573704789, ; 231: System.Runtime.Serialization.Json => 0x5dccd455 => 112
	i32 1580037396, ; 232: System.Threading.Overlapped => 0x5e2d7514 => 140
	i32 1582372066, ; 233: Xamarin.AndroidX.DocumentFile.dll => 0x5e5114e2 => 237
	i32 1592978981, ; 234: System.Runtime.Serialization.dll => 0x5ef2ee25 => 115
	i32 1597949149, ; 235: Xamarin.Google.ErrorProne.Annotations => 0x5f3ec4dd => 285
	i32 1600541741, ; 236: ShimSkiaSharp => 0x5f66542d => 201
	i32 1601112923, ; 237: System.Xml.Serialization => 0x5f6f0b5b => 157
	i32 1604827217, ; 238: System.Net.WebClient => 0x5fa7b851 => 76
	i32 1618516317, ; 239: System.Net.WebSockets.Client.dll => 0x6078995d => 79
	i32 1622152042, ; 240: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 257
	i32 1622358360, ; 241: System.Dynamic.Runtime => 0x60b33958 => 37
	i32 1623212457, ; 242: SkiaSharp.Views.Maui.Controls => 0x60c041a9 => 205
	i32 1624863272, ; 243: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 279
	i32 1635184631, ; 244: Xamarin.AndroidX.Emoji2.ViewsHelper => 0x6176eff7 => 241
	i32 1636350590, ; 245: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 234
	i32 1639515021, ; 246: System.Net.Http.dll => 0x61b9038d => 64
	i32 1639986890, ; 247: System.Text.RegularExpressions => 0x61c036ca => 138
	i32 1641389582, ; 248: System.ComponentModel.EventBasedAsync.dll => 0x61d59e0e => 15
	i32 1657153582, ; 249: System.Runtime => 0x62c6282e => 116
	i32 1658241508, ; 250: Xamarin.AndroidX.Tracing.Tracing.dll => 0x62d6c1e4 => 273
	i32 1658251792, ; 251: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 282
	i32 1670060433, ; 252: Xamarin.AndroidX.ConstraintLayout => 0x638b1991 => 229
	i32 1672364457, ; 253: NetTopologySuite.IO.GeoJSON4STJ.dll => 0x63ae41a9 => 200
	i32 1675553242, ; 254: System.IO.FileSystem.DriveInfo.dll => 0x63dee9da => 48
	i32 1677501392, ; 255: System.Net.Primitives.dll => 0x63fca3d0 => 70
	i32 1678508291, ; 256: System.Net.WebSockets => 0x640c0103 => 80
	i32 1679769178, ; 257: System.Security.Cryptography => 0x641f3e5a => 126
	i32 1691477237, ; 258: System.Reflection.Metadata => 0x64d1e4f5 => 94
	i32 1696967625, ; 259: System.Security.Cryptography.Csp => 0x6525abc9 => 121
	i32 1698840827, ; 260: Xamarin.Kotlin.StdLib.Common => 0x654240fb => 289
	i32 1701541528, ; 261: System.Diagnostics.Debug.dll => 0x656b7698 => 26
	i32 1720223769, ; 262: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 0x66888819 => 250
	i32 1726116996, ; 263: System.Reflection.dll => 0x66e27484 => 97
	i32 1728033016, ; 264: System.Diagnostics.FileVersionInfo.dll => 0x66ffb0f8 => 28
	i32 1729485958, ; 265: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 225
	i32 1736233607, ; 266: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 317
	i32 1743415430, ; 267: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 295
	i32 1744735666, ; 268: System.Transactions.Local.dll => 0x67fe8db2 => 149
	i32 1746316138, ; 269: Mono.Android.Export => 0x6816ab6a => 169
	i32 1750313021, ; 270: Microsoft.Win32.Primitives.dll => 0x6853a83d => 4
	i32 1758240030, ; 271: System.Resources.Reader.dll => 0x68cc9d1e => 98
	i32 1763938596, ; 272: System.Diagnostics.TraceSource.dll => 0x69239124 => 33
	i32 1765942094, ; 273: System.Reflection.Extensions => 0x6942234e => 93
	i32 1766324549, ; 274: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 272
	i32 1770582343, ; 275: Microsoft.Extensions.Logging.dll => 0x6988f147 => 187
	i32 1776026572, ; 276: System.Core.dll => 0x69dc03cc => 21
	i32 1777075843, ; 277: System.Globalization.Extensions.dll => 0x69ec0683 => 41
	i32 1780572499, ; 278: Mono.Android.Runtime.dll => 0x6a216153 => 170
	i32 1782862114, ; 279: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 311
	i32 1788241197, ; 280: Xamarin.AndroidX.Fragment => 0x6a96652d => 243
	i32 1793755602, ; 281: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 303
	i32 1808609942, ; 282: Xamarin.AndroidX.Loader => 0x6bcd3296 => 257
	i32 1813058853, ; 283: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 288
	i32 1813201214, ; 284: Xamarin.Google.Android.Material => 0x6c13413e => 282
	i32 1818569960, ; 285: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 262
	i32 1818787751, ; 286: Microsoft.VisualBasic.Core => 0x6c687fa7 => 2
	i32 1824175904, ; 287: System.Text.Encoding.Extensions => 0x6cbab720 => 134
	i32 1824722060, ; 288: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 111
	i32 1828688058, ; 289: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 188
	i32 1839733746, ; 290: Mapsui.Nts.dll => 0x6da81bf2 => 180
	i32 1842015223, ; 291: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 323
	i32 1847515442, ; 292: Xamarin.Android.Glide.Annotations => 0x6e1ed932 => 212
	i32 1853025655, ; 293: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 320
	i32 1858542181, ; 294: System.Linq.Expressions => 0x6ec71a65 => 58
	i32 1870277092, ; 295: System.Reflection.Primitives => 0x6f7a29e4 => 95
	i32 1875935024, ; 296: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 302
	i32 1879696579, ; 297: System.Formats.Tar.dll => 0x7009e4c3 => 39
	i32 1885316902, ; 298: Xamarin.AndroidX.Arch.Core.Runtime.dll => 0x705fa726 => 223
	i32 1888955245, ; 299: System.Diagnostics.Contracts => 0x70972b6d => 25
	i32 1889954781, ; 300: System.Reflection.Metadata.dll => 0x70a66bdd => 94
	i32 1898237753, ; 301: System.Reflection.DispatchProxy => 0x7124cf39 => 89
	i32 1900610850, ; 302: System.Resources.ResourceManager.dll => 0x71490522 => 99
	i32 1910275211, ; 303: System.Collections.NonGeneric.dll => 0x71dc7c8b => 10
	i32 1939592360, ; 304: System.Private.Xml.Linq => 0x739bd4a8 => 87
	i32 1956758971, ; 305: System.Resources.Writer => 0x74a1c5bb => 100
	i32 1961813231, ; 306: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x74eee4ef => 269
	i32 1968388702, ; 307: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 183
	i32 1983156543, ; 308: Xamarin.Kotlin.StdLib.Common.dll => 0x7634913f => 289
	i32 1985761444, ; 309: Xamarin.Android.Glide.GifDecoder => 0x765c50a4 => 214
	i32 2003115576, ; 310: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 299
	i32 2011961780, ; 311: System.Buffers.dll => 0x77ec19b4 => 7
	i32 2019465201, ; 312: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 254
	i32 2025202353, ; 313: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 294
	i32 2031763787, ; 314: Xamarin.Android.Glide => 0x791a414b => 211
	i32 2045470958, ; 315: System.Private.Xml => 0x79eb68ee => 88
	i32 2055257422, ; 316: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 249
	i32 2060060697, ; 317: System.Windows.dll => 0x7aca0819 => 154
	i32 2066184531, ; 318: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 298
	i32 2070888862, ; 319: System.Diagnostics.TraceSource => 0x7b6f419e => 33
	i32 2079903147, ; 320: System.Runtime.dll => 0x7bf8cdab => 116
	i32 2090596640, ; 321: System.Numerics.Vectors => 0x7c9bf920 => 82
	i32 2127167465, ; 322: System.Console => 0x7ec9ffe9 => 20
	i32 2142473426, ; 323: System.Collections.Specialized => 0x7fb38cd2 => 11
	i32 2143790110, ; 324: System.Xml.XmlSerializer.dll => 0x7fc7a41e => 162
	i32 2146852085, ; 325: Microsoft.VisualBasic.dll => 0x7ff65cf5 => 3
	i32 2159891885, ; 326: Microsoft.Maui => 0x80bd55ad => 195
	i32 2169148018, ; 327: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 306
	i32 2181898931, ; 328: Microsoft.Extensions.Options.dll => 0x820d22b3 => 190
	i32 2192057212, ; 329: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 188
	i32 2193016926, ; 330: System.ObjectModel.dll => 0x82b6c85e => 84
	i32 2201107256, ; 331: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 293
	i32 2201231467, ; 332: System.Net.Http => 0x8334206b => 64
	i32 2207618523, ; 333: it\Microsoft.Maui.Controls.resources => 0x839595db => 308
	i32 2217644978, ; 334: Xamarin.AndroidX.VectorDrawable.Animated.dll => 0x842e93b2 => 276
	i32 2222056684, ; 335: System.Threading.Tasks.Parallel => 0x8471e4ec => 143
	i32 2244775296, ; 336: Xamarin.AndroidX.LocalBroadcastManager => 0x85cc8d80 => 258
	i32 2252106437, ; 337: System.Xml.Serialization.dll => 0x863c6ac5 => 157
	i32 2256313426, ; 338: System.Globalization.Extensions => 0x867c9c52 => 41
	i32 2265110946, ; 339: System.Security.AccessControl.dll => 0x8702d9a2 => 117
	i32 2266799131, ; 340: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 184
	i32 2267999099, ; 341: Xamarin.Android.Glide.DiskLruCache.dll => 0x872eeb7b => 213
	i32 2270573516, ; 342: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 302
	i32 2279755925, ; 343: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 265
	i32 2293034957, ; 344: System.ServiceModel.Web.dll => 0x88acefcd => 131
	i32 2295906218, ; 345: System.Net.Sockets => 0x88d8bfaa => 75
	i32 2298471582, ; 346: System.Net.Mail => 0x88ffe49e => 66
	i32 2303942373, ; 347: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 312
	i32 2305521784, ; 348: System.Private.CoreLib.dll => 0x896b7878 => 172
	i32 2315684594, ; 349: Xamarin.AndroidX.Annotation.dll => 0x8a068af2 => 217
	i32 2320631194, ; 350: System.Threading.Tasks.Parallel.dll => 0x8a52059a => 143
	i32 2327893114, ; 351: ExCSS.dll => 0x8ac0d47a => 175
	i32 2340441535, ; 352: System.Runtime.InteropServices.RuntimeInformation.dll => 0x8b804dbf => 106
	i32 2344264397, ; 353: System.ValueTuple => 0x8bbaa2cd => 151
	i32 2353062107, ; 354: System.Net.Primitives => 0x8c40e0db => 70
	i32 2364201794, ; 355: SkiaSharp.Views.Maui.Core => 0x8ceadb42 => 206
	i32 2368005991, ; 356: System.Xml.ReaderWriter.dll => 0x8d24e767 => 156
	i32 2371007202, ; 357: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 183
	i32 2378619854, ; 358: System.Security.Cryptography.Csp.dll => 0x8dc6dbce => 121
	i32 2383496789, ; 359: System.Security.Principal.Windows.dll => 0x8e114655 => 127
	i32 2395872292, ; 360: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 307
	i32 2401565422, ; 361: System.Web.HttpUtility => 0x8f24faee => 152
	i32 2403452196, ; 362: Xamarin.AndroidX.Emoji2.dll => 0x8f41c524 => 240
	i32 2421380589, ; 363: System.Threading.Tasks.Dataflow => 0x905355ed => 141
	i32 2423080555, ; 364: Xamarin.AndroidX.Collection.Ktx.dll => 0x906d466b => 227
	i32 2427813419, ; 365: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 304
	i32 2435356389, ; 366: System.Console.dll => 0x912896e5 => 20
	i32 2435904999, ; 367: System.ComponentModel.DataAnnotations.dll => 0x9130f5e7 => 14
	i32 2454642406, ; 368: System.Text.Encoding.dll => 0x924edee6 => 135
	i32 2458678730, ; 369: System.Net.Sockets.dll => 0x928c75ca => 75
	i32 2459001652, ; 370: System.Linq.Parallel.dll => 0x92916334 => 59
	i32 2465532216, ; 371: Xamarin.AndroidX.ConstraintLayout.Core.dll => 0x92f50938 => 230
	i32 2471841756, ; 372: netstandard.dll => 0x93554fdc => 167
	i32 2475788418, ; 373: Java.Interop.dll => 0x93918882 => 168
	i32 2480646305, ; 374: Microsoft.Maui.Controls => 0x93dba8a1 => 193
	i32 2483903535, ; 375: System.ComponentModel.EventBasedAsync => 0x940d5c2f => 15
	i32 2484371297, ; 376: System.Net.ServicePoint => 0x94147f61 => 74
	i32 2490993605, ; 377: System.AppContext.dll => 0x94798bc5 => 6
	i32 2501346920, ; 378: System.Data.DataSetExtensions => 0x95178668 => 23
	i32 2505896520, ; 379: Xamarin.AndroidX.Lifecycle.Runtime.dll => 0x955cf248 => 252
	i32 2522472828, ; 380: Xamarin.Android.Glide.dll => 0x9659e17c => 211
	i32 2523023297, ; 381: Svg.Custom.dll => 0x966247c1 => 207
	i32 2538310050, ; 382: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 91
	i32 2550873716, ; 383: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 305
	i32 2562349572, ; 384: Microsoft.CSharp => 0x98ba5a04 => 1
	i32 2570120770, ; 385: System.Text.Encodings.Web => 0x9930ee42 => 136
	i32 2577414832, ; 386: Mapsui.Nts => 0x99a03ab0 => 180
	i32 2581783588, ; 387: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 0x99e2e424 => 253
	i32 2581819634, ; 388: Xamarin.AndroidX.VectorDrawable.dll => 0x99e370f2 => 275
	i32 2585220780, ; 389: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 134
	i32 2585805581, ; 390: System.Net.Ping => 0x9a20430d => 69
	i32 2589602615, ; 391: System.Threading.ThreadPool => 0x9a5a3337 => 146
	i32 2593496499, ; 392: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 314
	i32 2602257211, ; 393: Svg.Model.dll => 0x9b1b4b3b => 208
	i32 2605712449, ; 394: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 293
	i32 2609324236, ; 395: Svg.Custom => 0x9b8720cc => 207
	i32 2615233544, ; 396: Xamarin.AndroidX.Fragment.Ktx => 0x9be14c08 => 244
	i32 2616218305, ; 397: Microsoft.Extensions.Logging.Debug.dll => 0x9bf052c1 => 189
	i32 2617129537, ; 398: System.Private.Xml.dll => 0x9bfe3a41 => 88
	i32 2618712057, ; 399: System.Reflection.TypeExtensions.dll => 0x9c165ff9 => 96
	i32 2620871830, ; 400: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 234
	i32 2624644809, ; 401: Xamarin.AndroidX.DynamicAnimation => 0x9c70e6c9 => 239
	i32 2625339995, ; 402: SkiaSharp.Views.Maui.Core.dll => 0x9c7b825b => 206
	i32 2626831493, ; 403: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 309
	i32 2627185994, ; 404: System.Diagnostics.TextWriterTraceListener.dll => 0x9c97ad4a => 31
	i32 2629843544, ; 405: System.IO.Compression.ZipFile.dll => 0x9cc03a58 => 45
	i32 2633051222, ; 406: Xamarin.AndroidX.Lifecycle.LiveData => 0x9cf12c56 => 248
	i32 2663391936, ; 407: Xamarin.Android.Glide.DiskLruCache => 0x9ec022c0 => 213
	i32 2663698177, ; 408: System.Runtime.Loader => 0x9ec4cf01 => 109
	i32 2664396074, ; 409: System.Xml.XDocument.dll => 0x9ecf752a => 158
	i32 2665622720, ; 410: System.Drawing.Primitives => 0x9ee22cc0 => 35
	i32 2676780864, ; 411: System.Data.Common.dll => 0x9f8c6f40 => 22
	i32 2686887180, ; 412: System.Runtime.Serialization.Xml.dll => 0xa026a50c => 114
	i32 2693849962, ; 413: System.IO.dll => 0xa090e36a => 57
	i32 2701096212, ; 414: Xamarin.AndroidX.Tracing.Tracing => 0xa0ff7514 => 273
	i32 2715334215, ; 415: System.Threading.Tasks.dll => 0xa1d8b647 => 144
	i32 2717744543, ; 416: System.Security.Claims => 0xa1fd7d9f => 118
	i32 2719963679, ; 417: System.Security.Cryptography.Cng.dll => 0xa21f5a1f => 120
	i32 2724373263, ; 418: System.Runtime.Numerics.dll => 0xa262a30f => 110
	i32 2732626843, ; 419: Xamarin.AndroidX.Activity => 0xa2e0939b => 215
	i32 2735172069, ; 420: System.Threading.Channels => 0xa30769e5 => 139
	i32 2737747696, ; 421: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 221
	i32 2740948882, ; 422: System.IO.Pipes.AccessControl => 0xa35f8f92 => 54
	i32 2748088231, ; 423: System.Runtime.InteropServices.JavaScript => 0xa3cc7fa7 => 105
	i32 2752995522, ; 424: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 315
	i32 2756874198, ; 425: NetTopologySuite.IO.GeoJSON4STJ => 0xa4528fd6 => 200
	i32 2758225723, ; 426: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 194
	i32 2764765095, ; 427: Microsoft.Maui.dll => 0xa4caf7a7 => 195
	i32 2765824710, ; 428: System.Text.Encoding.CodePages.dll => 0xa4db22c6 => 133
	i32 2770495804, ; 429: Xamarin.Jetbrains.Annotations.dll => 0xa522693c => 287
	i32 2778768386, ; 430: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 278
	i32 2779977773, ; 431: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 0xa5b3182d => 266
	i32 2785988530, ; 432: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 321
	i32 2788224221, ; 433: Xamarin.AndroidX.Fragment.Ktx.dll => 0xa630ecdd => 244
	i32 2795602088, ; 434: SkiaSharp.Views.Android.dll => 0xa6a180a8 => 204
	i32 2801831435, ; 435: Microsoft.Maui.Graphics => 0xa7008e0b => 197
	i32 2803228030, ; 436: System.Xml.XPath.XDocument.dll => 0xa715dd7e => 159
	i32 2806116107, ; 437: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 300
	i32 2810250172, ; 438: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 231
	i32 2819470561, ; 439: System.Xml.dll => 0xa80db4e1 => 163
	i32 2821205001, ; 440: System.ServiceProcess.dll => 0xa8282c09 => 132
	i32 2821294376, ; 441: Xamarin.AndroidX.ResourceInspection.Annotation => 0xa8298928 => 266
	i32 2824502124, ; 442: System.Xml.XmlDocument => 0xa85a7b6c => 161
	i32 2831556043, ; 443: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 313
	i32 2838993487, ; 444: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 0xa9379a4f => 255
	i32 2849599387, ; 445: System.Threading.Overlapped.dll => 0xa9d96f9b => 140
	i32 2853208004, ; 446: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 278
	i32 2855708567, ; 447: Xamarin.AndroidX.Transition => 0xaa36a797 => 274
	i32 2861098320, ; 448: Mono.Android.Export.dll => 0xaa88e550 => 169
	i32 2861189240, ; 449: Microsoft.Maui.Essentials => 0xaa8a4878 => 196
	i32 2870099610, ; 450: Xamarin.AndroidX.Activity.Ktx.dll => 0xab123e9a => 216
	i32 2875164099, ; 451: Jsr305Binding.dll => 0xab5f85c3 => 283
	i32 2875220617, ; 452: System.Globalization.Calendars.dll => 0xab606289 => 40
	i32 2884993177, ; 453: Xamarin.AndroidX.ExifInterface => 0xabf58099 => 242
	i32 2887636118, ; 454: System.Net.dll => 0xac1dd496 => 81
	i32 2899753641, ; 455: System.IO.UnmanagedMemoryStream => 0xacd6baa9 => 56
	i32 2900621748, ; 456: System.Dynamic.Runtime.dll => 0xace3f9b4 => 37
	i32 2901442782, ; 457: System.Reflection => 0xacf080de => 97
	i32 2905242038, ; 458: mscorlib.dll => 0xad2a79b6 => 166
	i32 2909740682, ; 459: System.Private.CoreLib => 0xad6f1e8a => 172
	i32 2912489636, ; 460: SkiaSharp.Views.Android => 0xad9910a4 => 204
	i32 2916838712, ; 461: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 279
	i32 2919462931, ; 462: System.Numerics.Vectors.dll => 0xae037813 => 82
	i32 2921128767, ; 463: Xamarin.AndroidX.Annotation.Experimental.dll => 0xae1ce33f => 218
	i32 2936416060, ; 464: System.Resources.Reader => 0xaf06273c => 98
	i32 2940926066, ; 465: System.Diagnostics.StackTrace.dll => 0xaf4af872 => 30
	i32 2942453041, ; 466: System.Xml.XPath.XDocument => 0xaf624531 => 159
	i32 2959614098, ; 467: System.ComponentModel.dll => 0xb0682092 => 18
	i32 2968338931, ; 468: System.Security.Principal.Windows => 0xb0ed41f3 => 127
	i32 2972252294, ; 469: System.Security.Cryptography.Algorithms.dll => 0xb128f886 => 119
	i32 2978675010, ; 470: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 238
	i32 2987532451, ; 471: Xamarin.AndroidX.Security.SecurityCrypto => 0xb21220a3 => 269
	i32 2996846495, ; 472: Xamarin.AndroidX.Lifecycle.Process.dll => 0xb2a03f9f => 251
	i32 3016983068, ; 473: Xamarin.AndroidX.Startup.StartupRuntime => 0xb3d3821c => 271
	i32 3023353419, ; 474: WindowsBase.dll => 0xb434b64b => 165
	i32 3024354802, ; 475: Xamarin.AndroidX.Legacy.Support.Core.Utils => 0xb443fdf2 => 246
	i32 3038032645, ; 476: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 328
	i32 3056245963, ; 477: Xamarin.AndroidX.SavedState.SavedState.Ktx => 0xb62a9ccb => 268
	i32 3057625584, ; 478: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 259
	i32 3059408633, ; 479: Mono.Android.Runtime => 0xb65adef9 => 170
	i32 3059793426, ; 480: System.ComponentModel.Primitives => 0xb660be12 => 16
	i32 3075834255, ; 481: System.Threading.Tasks => 0xb755818f => 144
	i32 3077302341, ; 482: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 306
	i32 3090735792, ; 483: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 125
	i32 3099732863, ; 484: System.Security.Claims.dll => 0xb8c22b7f => 118
	i32 3103600923, ; 485: System.Formats.Asn1 => 0xb8fd311b => 38
	i32 3111772706, ; 486: System.Runtime.Serialization => 0xb979e222 => 115
	i32 3121463068, ; 487: System.IO.FileSystem.AccessControl.dll => 0xba0dbf1c => 47
	i32 3124832203, ; 488: System.Threading.Tasks.Extensions => 0xba4127cb => 142
	i32 3132293585, ; 489: System.Security.AccessControl => 0xbab301d1 => 117
	i32 3134694676, ; 490: ShimSkiaSharp.dll => 0xbad7a514 => 201
	i32 3147165239, ; 491: System.Diagnostics.Tracing.dll => 0xbb95ee37 => 34
	i32 3148237826, ; 492: GoogleGson.dll => 0xbba64c02 => 176
	i32 3159123045, ; 493: System.Reflection.Primitives.dll => 0xbc4c6465 => 95
	i32 3160747431, ; 494: System.IO.MemoryMappedFiles => 0xbc652da7 => 53
	i32 3178803400, ; 495: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 260
	i32 3192346100, ; 496: System.Security.SecureString => 0xbe4755f4 => 129
	i32 3193515020, ; 497: System.Web => 0xbe592c0c => 153
	i32 3204380047, ; 498: System.Data.dll => 0xbefef58f => 24
	i32 3209718065, ; 499: System.Xml.XmlDocument.dll => 0xbf506931 => 161
	i32 3211777861, ; 500: Xamarin.AndroidX.DocumentFile => 0xbf6fd745 => 237
	i32 3220365878, ; 501: System.Threading => 0xbff2e236 => 148
	i32 3226221578, ; 502: System.Runtime.Handles.dll => 0xc04c3c0a => 104
	i32 3251039220, ; 503: System.Reflection.DispatchProxy.dll => 0xc1c6ebf4 => 89
	i32 3258312781, ; 504: Xamarin.AndroidX.CardView => 0xc235e84d => 225
	i32 3265493905, ; 505: System.Linq.Queryable.dll => 0xc2a37b91 => 60
	i32 3265893370, ; 506: System.Threading.Tasks.Extensions.dll => 0xc2a993fa => 142
	i32 3277815716, ; 507: System.Resources.Writer.dll => 0xc35f7fa4 => 100
	i32 3278552754, ; 508: Mapsui => 0xc36abeb2 => 178
	i32 3279906254, ; 509: Microsoft.Win32.Registry.dll => 0xc37f65ce => 5
	i32 3280506390, ; 510: System.ComponentModel.Annotations.dll => 0xc3888e16 => 13
	i32 3290767353, ; 511: System.Security.Cryptography.Encoding => 0xc4251ff9 => 122
	i32 3299363146, ; 512: System.Text.Encoding => 0xc4a8494a => 135
	i32 3303498502, ; 513: System.Diagnostics.FileVersionInfo => 0xc4e76306 => 28
	i32 3305363605, ; 514: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 301
	i32 3316684772, ; 515: System.Net.Requests.dll => 0xc5b097e4 => 72
	i32 3317135071, ; 516: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 235
	i32 3317144872, ; 517: System.Data => 0xc5b79d28 => 24
	i32 3340387945, ; 518: SkiaSharp => 0xc71a4669 => 202
	i32 3340431453, ; 519: Xamarin.AndroidX.Arch.Core.Runtime => 0xc71af05d => 223
	i32 3345895724, ; 520: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 0xc76e512c => 264
	i32 3346324047, ; 521: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 261
	i32 3357674450, ; 522: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 318
	i32 3358260929, ; 523: System.Text.Json => 0xc82afec1 => 137
	i32 3362336904, ; 524: Xamarin.AndroidX.Activity.Ktx => 0xc8693088 => 216
	i32 3362522851, ; 525: Xamarin.AndroidX.Core => 0xc86c06e3 => 232
	i32 3366347497, ; 526: Java.Interop => 0xc8a662e9 => 168
	i32 3374999561, ; 527: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 265
	i32 3381016424, ; 528: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 297
	i32 3395150330, ; 529: System.Runtime.CompilerServices.Unsafe.dll => 0xca5de1fa => 101
	i32 3403906625, ; 530: System.Security.Cryptography.OpenSsl.dll => 0xcae37e41 => 123
	i32 3405233483, ; 531: Xamarin.AndroidX.CustomView.PoolingContainer => 0xcaf7bd4b => 236
	i32 3428513518, ; 532: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 185
	i32 3429136800, ; 533: System.Xml => 0xcc6479a0 => 163
	i32 3430777524, ; 534: netstandard => 0xcc7d82b4 => 167
	i32 3441283291, ; 535: Xamarin.AndroidX.DynamicAnimation.dll => 0xcd1dd0db => 239
	i32 3445260447, ; 536: System.Formats.Tar => 0xcd5a809f => 39
	i32 3452344032, ; 537: Microsoft.Maui.Controls.Compatibility.dll => 0xcdc696e0 => 192
	i32 3459815001, ; 538: Mapsui.Rendering.Skia => 0xce389659 => 181
	i32 3463511458, ; 539: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 305
	i32 3471940407, ; 540: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 17
	i32 3473156932, ; 541: SkiaSharp.Views.Maui.Controls.dll => 0xcf042b44 => 205
	i32 3476120550, ; 542: Mono.Android => 0xcf3163e6 => 171
	i32 3479583265, ; 543: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 318
	i32 3484440000, ; 544: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 317
	i32 3485117614, ; 545: System.Text.Json.dll => 0xcfbaacae => 137
	i32 3486566296, ; 546: System.Transactions => 0xcfd0c798 => 150
	i32 3493954962, ; 547: Xamarin.AndroidX.Concurrent.Futures.dll => 0xd0418592 => 228
	i32 3509114376, ; 548: System.Xml.Linq => 0xd128d608 => 155
	i32 3515174580, ; 549: System.Security.dll => 0xd1854eb4 => 130
	i32 3530912306, ; 550: System.Configuration => 0xd2757232 => 19
	i32 3539954161, ; 551: System.Net.HttpListener => 0xd2ff69f1 => 65
	i32 3560100363, ; 552: System.Threading.Timer => 0xd432d20b => 147
	i32 3570554715, ; 553: System.IO.FileSystem.AccessControl => 0xd4d2575b => 47
	i32 3574246105, ; 554: BruTile.XmlSerializers.dll => 0xd50aaad9 => 173
	i32 3580758918, ; 555: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 325
	i32 3597029428, ; 556: Xamarin.Android.Glide.GifDecoder.dll => 0xd6665034 => 214
	i32 3598340787, ; 557: System.Net.WebSockets.Client => 0xd67a52b3 => 79
	i32 3608519521, ; 558: System.Linq.dll => 0xd715a361 => 61
	i32 3624195450, ; 559: System.Runtime.InteropServices.RuntimeInformation => 0xd804d57a => 106
	i32 3627220390, ; 560: Xamarin.AndroidX.Print.dll => 0xd832fda6 => 263
	i32 3633644679, ; 561: Xamarin.AndroidX.Annotation.Experimental => 0xd8950487 => 218
	i32 3638274909, ; 562: System.IO.FileSystem.Primitives.dll => 0xd8dbab5d => 49
	i32 3641597786, ; 563: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 249
	i32 3643446276, ; 564: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 322
	i32 3643854240, ; 565: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 260
	i32 3645089577, ; 566: System.ComponentModel.DataAnnotations => 0xd943a729 => 14
	i32 3657292374, ; 567: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 184
	i32 3660523487, ; 568: System.Net.NetworkInformation => 0xda2f27df => 68
	i32 3672681054, ; 569: Mono.Android.dll => 0xdae8aa5e => 171
	i32 3682565725, ; 570: Xamarin.AndroidX.Browser => 0xdb7f7e5d => 224
	i32 3684561358, ; 571: Xamarin.AndroidX.Concurrent.Futures => 0xdb9df1ce => 228
	i32 3697841164, ; 572: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 327
	i32 3700866549, ; 573: System.Net.WebProxy.dll => 0xdc96bdf5 => 78
	i32 3706696989, ; 574: Xamarin.AndroidX.Core.Core.Ktx.dll => 0xdcefb51d => 233
	i32 3712156464, ; 575: Mapsui.UI.Maui.dll => 0xdd430330 => 179
	i32 3716563718, ; 576: System.Runtime.Intrinsics => 0xdd864306 => 108
	i32 3718780102, ; 577: Xamarin.AndroidX.Annotation => 0xdda814c6 => 217
	i32 3724971120, ; 578: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 259
	i32 3732100267, ; 579: System.Net.NameResolution => 0xde7354ab => 67
	i32 3737834244, ; 580: System.Net.Http.Json.dll => 0xdecad304 => 63
	i32 3748608112, ; 581: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 27
	i32 3751444290, ; 582: System.Xml.XPath => 0xdf9a7f42 => 160
	i32 3786282454, ; 583: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 226
	i32 3792276235, ; 584: System.Collections.NonGeneric => 0xe2098b0b => 10
	i32 3792835768, ; 585: HarfBuzzSharp => 0xe21214b8 => 177
	i32 3798102808, ; 586: BruTile => 0xe2627318 => 174
	i32 3800979733, ; 587: Microsoft.Maui.Controls.Compatibility => 0xe28e5915 => 192
	i32 3802395368, ; 588: System.Collections.Specialized.dll => 0xe2a3f2e8 => 11
	i32 3819260425, ; 589: System.Net.WebProxy => 0xe3a54a09 => 78
	i32 3823082795, ; 590: System.Security.Cryptography.dll => 0xe3df9d2b => 126
	i32 3829621856, ; 591: System.Numerics.dll => 0xe4436460 => 83
	i32 3841636137, ; 592: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 186
	i32 3844307129, ; 593: System.Net.Mail.dll => 0xe52378b9 => 66
	i32 3849253459, ; 594: System.Runtime.InteropServices.dll => 0xe56ef253 => 107
	i32 3870376305, ; 595: System.Net.HttpListener.dll => 0xe6b14171 => 65
	i32 3873536506, ; 596: System.Security.Principal => 0xe6e179fa => 128
	i32 3875112723, ; 597: System.Security.Cryptography.Encoding.dll => 0xe6f98713 => 122
	i32 3885497537, ; 598: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 77
	i32 3885922214, ; 599: Xamarin.AndroidX.Transition.dll => 0xe79e77a6 => 274
	i32 3888767677, ; 600: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 0xe7c9e2bd => 264
	i32 3889960447, ; 601: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 326
	i32 3896106733, ; 602: System.Collections.Concurrent.dll => 0xe839deed => 8
	i32 3896760992, ; 603: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 232
	i32 3901907137, ; 604: Microsoft.VisualBasic.Core.dll => 0xe89260c1 => 2
	i32 3920810846, ; 605: System.IO.Compression.FileSystem.dll => 0xe9b2d35e => 44
	i32 3921031405, ; 606: Xamarin.AndroidX.VersionedParcelable.dll => 0xe9b630ed => 277
	i32 3928044579, ; 607: System.Xml.ReaderWriter => 0xea213423 => 156
	i32 3930554604, ; 608: System.Security.Principal.dll => 0xea4780ec => 128
	i32 3931092270, ; 609: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 262
	i32 3934069706, ; 610: Topten.RichTextKit.dll => 0xea7d23ca => 210
	i32 3945713374, ; 611: System.Data.DataSetExtensions.dll => 0xeb2ecede => 23
	i32 3952289091, ; 612: NetTopologySuite.Features.dll => 0xeb932543 => 199
	i32 3953583589, ; 613: Svg.Skia => 0xeba6e5e5 => 209
	i32 3953953790, ; 614: System.Text.Encoding.CodePages => 0xebac8bfe => 133
	i32 3955647286, ; 615: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 220
	i32 3959773229, ; 616: Xamarin.AndroidX.Lifecycle.Process => 0xec05582d => 251
	i32 3980434154, ; 617: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 321
	i32 3987592930, ; 618: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 303
	i32 4003436829, ; 619: System.Diagnostics.Process.dll => 0xee9f991d => 29
	i32 4003906742, ; 620: HarfBuzzSharp.dll => 0xeea6c4b6 => 177
	i32 4013003792, ; 621: BruTile.dll => 0xef319410 => 174
	i32 4015948917, ; 622: Xamarin.AndroidX.Annotation.Jvm.dll => 0xef5e8475 => 219
	i32 4022681963, ; 623: Mapsui.Tiling => 0xefc5416b => 182
	i32 4025784931, ; 624: System.Memory => 0xeff49a63 => 62
	i32 4046471985, ; 625: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 194
	i32 4054681211, ; 626: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 90
	i32 4066802364, ; 627: SkiaSharp.HarfBuzz => 0xf2667abc => 203
	i32 4068434129, ; 628: System.Private.Xml.Linq.dll => 0xf27f60d1 => 87
	i32 4073602200, ; 629: System.Threading.dll => 0xf2ce3c98 => 148
	i32 4094352644, ; 630: Microsoft.Maui.Essentials.dll => 0xf40add04 => 196
	i32 4099507663, ; 631: System.Drawing.dll => 0xf45985cf => 36
	i32 4100113165, ; 632: System.Private.Uri => 0xf462c30d => 86
	i32 4101593132, ; 633: Xamarin.AndroidX.Emoji2 => 0xf479582c => 240
	i32 4102112229, ; 634: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 316
	i32 4125707920, ; 635: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 311
	i32 4126470640, ; 636: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 185
	i32 4127667938, ; 637: System.IO.FileSystem.Watcher => 0xf60736e2 => 50
	i32 4130442656, ; 638: System.AppContext => 0xf6318da0 => 6
	i32 4144557198, ; 639: NetTopologySuite.Features => 0xf708ec8e => 199
	i32 4147896353, ; 640: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 90
	i32 4150914736, ; 641: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 323
	i32 4151237749, ; 642: System.Core => 0xf76edc75 => 21
	i32 4159265925, ; 643: System.Xml.XmlSerializer => 0xf7e95c85 => 162
	i32 4161255271, ; 644: System.Reflection.TypeExtensions => 0xf807b767 => 96
	i32 4164802419, ; 645: System.IO.FileSystem.Watcher.dll => 0xf83dd773 => 50
	i32 4181436372, ; 646: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 113
	i32 4182413190, ; 647: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 256
	i32 4185676441, ; 648: System.Security => 0xf97c5a99 => 130
	i32 4196529839, ; 649: System.Net.WebClient.dll => 0xfa21f6af => 76
	i32 4213026141, ; 650: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 27
	i32 4256097574, ; 651: Xamarin.AndroidX.Core.Core.Ktx => 0xfdaee526 => 233
	i32 4258378803, ; 652: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 0xfdd1b433 => 255
	i32 4260525087, ; 653: System.Buffers => 0xfdf2741f => 7
	i32 4271975918, ; 654: Microsoft.Maui.Controls.dll => 0xfea12dee => 193
	i32 4274976490, ; 655: System.Runtime.Numerics => 0xfecef6ea => 110
	i32 4292120959, ; 656: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 256
	i32 4294763496 ; 657: Xamarin.AndroidX.ExifInterface.dll => 0xfffce3e8 => 242
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [658 x i32] [
	i32 68, ; 0
	i32 67, ; 1
	i32 108, ; 2
	i32 252, ; 3
	i32 286, ; 4
	i32 48, ; 5
	i32 80, ; 6
	i32 145, ; 7
	i32 30, ; 8
	i32 327, ; 9
	i32 124, ; 10
	i32 197, ; 11
	i32 102, ; 12
	i32 270, ; 13
	i32 107, ; 14
	i32 270, ; 15
	i32 139, ; 16
	i32 290, ; 17
	i32 77, ; 18
	i32 209, ; 19
	i32 124, ; 20
	i32 13, ; 21
	i32 226, ; 22
	i32 132, ; 23
	i32 272, ; 24
	i32 151, ; 25
	i32 324, ; 26
	i32 325, ; 27
	i32 18, ; 28
	i32 224, ; 29
	i32 26, ; 30
	i32 246, ; 31
	i32 1, ; 32
	i32 59, ; 33
	i32 42, ; 34
	i32 91, ; 35
	i32 229, ; 36
	i32 147, ; 37
	i32 248, ; 38
	i32 245, ; 39
	i32 296, ; 40
	i32 54, ; 41
	i32 179, ; 42
	i32 69, ; 43
	i32 324, ; 44
	i32 215, ; 45
	i32 83, ; 46
	i32 309, ; 47
	i32 247, ; 48
	i32 308, ; 49
	i32 131, ; 50
	i32 55, ; 51
	i32 149, ; 52
	i32 74, ; 53
	i32 145, ; 54
	i32 62, ; 55
	i32 146, ; 56
	i32 328, ; 57
	i32 165, ; 58
	i32 320, ; 59
	i32 230, ; 60
	i32 12, ; 61
	i32 243, ; 62
	i32 125, ; 63
	i32 152, ; 64
	i32 113, ; 65
	i32 175, ; 66
	i32 166, ; 67
	i32 164, ; 68
	i32 208, ; 69
	i32 245, ; 70
	i32 258, ; 71
	i32 84, ; 72
	i32 307, ; 73
	i32 301, ; 74
	i32 191, ; 75
	i32 202, ; 76
	i32 150, ; 77
	i32 290, ; 78
	i32 60, ; 79
	i32 187, ; 80
	i32 51, ; 81
	i32 103, ; 82
	i32 114, ; 83
	i32 40, ; 84
	i32 283, ; 85
	i32 281, ; 86
	i32 120, ; 87
	i32 315, ; 88
	i32 52, ; 89
	i32 44, ; 90
	i32 119, ; 91
	i32 235, ; 92
	i32 313, ; 93
	i32 241, ; 94
	i32 81, ; 95
	i32 136, ; 96
	i32 277, ; 97
	i32 222, ; 98
	i32 8, ; 99
	i32 181, ; 100
	i32 73, ; 101
	i32 295, ; 102
	i32 155, ; 103
	i32 292, ; 104
	i32 154, ; 105
	i32 92, ; 106
	i32 287, ; 107
	i32 45, ; 108
	i32 310, ; 109
	i32 0, ; 110
	i32 298, ; 111
	i32 291, ; 112
	i32 109, ; 113
	i32 129, ; 114
	i32 25, ; 115
	i32 212, ; 116
	i32 72, ; 117
	i32 55, ; 118
	i32 46, ; 119
	i32 319, ; 120
	i32 203, ; 121
	i32 190, ; 122
	i32 236, ; 123
	i32 22, ; 124
	i32 250, ; 125
	i32 86, ; 126
	i32 43, ; 127
	i32 160, ; 128
	i32 71, ; 129
	i32 263, ; 130
	i32 3, ; 131
	i32 42, ; 132
	i32 63, ; 133
	i32 198, ; 134
	i32 16, ; 135
	i32 53, ; 136
	i32 322, ; 137
	i32 286, ; 138
	i32 105, ; 139
	i32 291, ; 140
	i32 284, ; 141
	i32 247, ; 142
	i32 34, ; 143
	i32 158, ; 144
	i32 85, ; 145
	i32 32, ; 146
	i32 12, ; 147
	i32 51, ; 148
	i32 56, ; 149
	i32 267, ; 150
	i32 36, ; 151
	i32 186, ; 152
	i32 297, ; 153
	i32 285, ; 154
	i32 220, ; 155
	i32 35, ; 156
	i32 58, ; 157
	i32 254, ; 158
	i32 176, ; 159
	i32 17, ; 160
	i32 288, ; 161
	i32 164, ; 162
	i32 310, ; 163
	i32 253, ; 164
	i32 189, ; 165
	i32 280, ; 166
	i32 316, ; 167
	i32 153, ; 168
	i32 276, ; 169
	i32 261, ; 170
	i32 314, ; 171
	i32 222, ; 172
	i32 29, ; 173
	i32 52, ; 174
	i32 312, ; 175
	i32 173, ; 176
	i32 281, ; 177
	i32 5, ; 178
	i32 296, ; 179
	i32 271, ; 180
	i32 275, ; 181
	i32 227, ; 182
	i32 292, ; 183
	i32 219, ; 184
	i32 238, ; 185
	i32 85, ; 186
	i32 210, ; 187
	i32 280, ; 188
	i32 61, ; 189
	i32 112, ; 190
	i32 57, ; 191
	i32 326, ; 192
	i32 267, ; 193
	i32 99, ; 194
	i32 178, ; 195
	i32 19, ; 196
	i32 231, ; 197
	i32 111, ; 198
	i32 101, ; 199
	i32 102, ; 200
	i32 182, ; 201
	i32 294, ; 202
	i32 104, ; 203
	i32 284, ; 204
	i32 71, ; 205
	i32 198, ; 206
	i32 38, ; 207
	i32 32, ; 208
	i32 103, ; 209
	i32 73, ; 210
	i32 300, ; 211
	i32 9, ; 212
	i32 123, ; 213
	i32 46, ; 214
	i32 221, ; 215
	i32 191, ; 216
	i32 9, ; 217
	i32 43, ; 218
	i32 4, ; 219
	i32 268, ; 220
	i32 0, ; 221
	i32 304, ; 222
	i32 299, ; 223
	i32 31, ; 224
	i32 138, ; 225
	i32 92, ; 226
	i32 93, ; 227
	i32 319, ; 228
	i32 49, ; 229
	i32 141, ; 230
	i32 112, ; 231
	i32 140, ; 232
	i32 237, ; 233
	i32 115, ; 234
	i32 285, ; 235
	i32 201, ; 236
	i32 157, ; 237
	i32 76, ; 238
	i32 79, ; 239
	i32 257, ; 240
	i32 37, ; 241
	i32 205, ; 242
	i32 279, ; 243
	i32 241, ; 244
	i32 234, ; 245
	i32 64, ; 246
	i32 138, ; 247
	i32 15, ; 248
	i32 116, ; 249
	i32 273, ; 250
	i32 282, ; 251
	i32 229, ; 252
	i32 200, ; 253
	i32 48, ; 254
	i32 70, ; 255
	i32 80, ; 256
	i32 126, ; 257
	i32 94, ; 258
	i32 121, ; 259
	i32 289, ; 260
	i32 26, ; 261
	i32 250, ; 262
	i32 97, ; 263
	i32 28, ; 264
	i32 225, ; 265
	i32 317, ; 266
	i32 295, ; 267
	i32 149, ; 268
	i32 169, ; 269
	i32 4, ; 270
	i32 98, ; 271
	i32 33, ; 272
	i32 93, ; 273
	i32 272, ; 274
	i32 187, ; 275
	i32 21, ; 276
	i32 41, ; 277
	i32 170, ; 278
	i32 311, ; 279
	i32 243, ; 280
	i32 303, ; 281
	i32 257, ; 282
	i32 288, ; 283
	i32 282, ; 284
	i32 262, ; 285
	i32 2, ; 286
	i32 134, ; 287
	i32 111, ; 288
	i32 188, ; 289
	i32 180, ; 290
	i32 323, ; 291
	i32 212, ; 292
	i32 320, ; 293
	i32 58, ; 294
	i32 95, ; 295
	i32 302, ; 296
	i32 39, ; 297
	i32 223, ; 298
	i32 25, ; 299
	i32 94, ; 300
	i32 89, ; 301
	i32 99, ; 302
	i32 10, ; 303
	i32 87, ; 304
	i32 100, ; 305
	i32 269, ; 306
	i32 183, ; 307
	i32 289, ; 308
	i32 214, ; 309
	i32 299, ; 310
	i32 7, ; 311
	i32 254, ; 312
	i32 294, ; 313
	i32 211, ; 314
	i32 88, ; 315
	i32 249, ; 316
	i32 154, ; 317
	i32 298, ; 318
	i32 33, ; 319
	i32 116, ; 320
	i32 82, ; 321
	i32 20, ; 322
	i32 11, ; 323
	i32 162, ; 324
	i32 3, ; 325
	i32 195, ; 326
	i32 306, ; 327
	i32 190, ; 328
	i32 188, ; 329
	i32 84, ; 330
	i32 293, ; 331
	i32 64, ; 332
	i32 308, ; 333
	i32 276, ; 334
	i32 143, ; 335
	i32 258, ; 336
	i32 157, ; 337
	i32 41, ; 338
	i32 117, ; 339
	i32 184, ; 340
	i32 213, ; 341
	i32 302, ; 342
	i32 265, ; 343
	i32 131, ; 344
	i32 75, ; 345
	i32 66, ; 346
	i32 312, ; 347
	i32 172, ; 348
	i32 217, ; 349
	i32 143, ; 350
	i32 175, ; 351
	i32 106, ; 352
	i32 151, ; 353
	i32 70, ; 354
	i32 206, ; 355
	i32 156, ; 356
	i32 183, ; 357
	i32 121, ; 358
	i32 127, ; 359
	i32 307, ; 360
	i32 152, ; 361
	i32 240, ; 362
	i32 141, ; 363
	i32 227, ; 364
	i32 304, ; 365
	i32 20, ; 366
	i32 14, ; 367
	i32 135, ; 368
	i32 75, ; 369
	i32 59, ; 370
	i32 230, ; 371
	i32 167, ; 372
	i32 168, ; 373
	i32 193, ; 374
	i32 15, ; 375
	i32 74, ; 376
	i32 6, ; 377
	i32 23, ; 378
	i32 252, ; 379
	i32 211, ; 380
	i32 207, ; 381
	i32 91, ; 382
	i32 305, ; 383
	i32 1, ; 384
	i32 136, ; 385
	i32 180, ; 386
	i32 253, ; 387
	i32 275, ; 388
	i32 134, ; 389
	i32 69, ; 390
	i32 146, ; 391
	i32 314, ; 392
	i32 208, ; 393
	i32 293, ; 394
	i32 207, ; 395
	i32 244, ; 396
	i32 189, ; 397
	i32 88, ; 398
	i32 96, ; 399
	i32 234, ; 400
	i32 239, ; 401
	i32 206, ; 402
	i32 309, ; 403
	i32 31, ; 404
	i32 45, ; 405
	i32 248, ; 406
	i32 213, ; 407
	i32 109, ; 408
	i32 158, ; 409
	i32 35, ; 410
	i32 22, ; 411
	i32 114, ; 412
	i32 57, ; 413
	i32 273, ; 414
	i32 144, ; 415
	i32 118, ; 416
	i32 120, ; 417
	i32 110, ; 418
	i32 215, ; 419
	i32 139, ; 420
	i32 221, ; 421
	i32 54, ; 422
	i32 105, ; 423
	i32 315, ; 424
	i32 200, ; 425
	i32 194, ; 426
	i32 195, ; 427
	i32 133, ; 428
	i32 287, ; 429
	i32 278, ; 430
	i32 266, ; 431
	i32 321, ; 432
	i32 244, ; 433
	i32 204, ; 434
	i32 197, ; 435
	i32 159, ; 436
	i32 300, ; 437
	i32 231, ; 438
	i32 163, ; 439
	i32 132, ; 440
	i32 266, ; 441
	i32 161, ; 442
	i32 313, ; 443
	i32 255, ; 444
	i32 140, ; 445
	i32 278, ; 446
	i32 274, ; 447
	i32 169, ; 448
	i32 196, ; 449
	i32 216, ; 450
	i32 283, ; 451
	i32 40, ; 452
	i32 242, ; 453
	i32 81, ; 454
	i32 56, ; 455
	i32 37, ; 456
	i32 97, ; 457
	i32 166, ; 458
	i32 172, ; 459
	i32 204, ; 460
	i32 279, ; 461
	i32 82, ; 462
	i32 218, ; 463
	i32 98, ; 464
	i32 30, ; 465
	i32 159, ; 466
	i32 18, ; 467
	i32 127, ; 468
	i32 119, ; 469
	i32 238, ; 470
	i32 269, ; 471
	i32 251, ; 472
	i32 271, ; 473
	i32 165, ; 474
	i32 246, ; 475
	i32 328, ; 476
	i32 268, ; 477
	i32 259, ; 478
	i32 170, ; 479
	i32 16, ; 480
	i32 144, ; 481
	i32 306, ; 482
	i32 125, ; 483
	i32 118, ; 484
	i32 38, ; 485
	i32 115, ; 486
	i32 47, ; 487
	i32 142, ; 488
	i32 117, ; 489
	i32 201, ; 490
	i32 34, ; 491
	i32 176, ; 492
	i32 95, ; 493
	i32 53, ; 494
	i32 260, ; 495
	i32 129, ; 496
	i32 153, ; 497
	i32 24, ; 498
	i32 161, ; 499
	i32 237, ; 500
	i32 148, ; 501
	i32 104, ; 502
	i32 89, ; 503
	i32 225, ; 504
	i32 60, ; 505
	i32 142, ; 506
	i32 100, ; 507
	i32 178, ; 508
	i32 5, ; 509
	i32 13, ; 510
	i32 122, ; 511
	i32 135, ; 512
	i32 28, ; 513
	i32 301, ; 514
	i32 72, ; 515
	i32 235, ; 516
	i32 24, ; 517
	i32 202, ; 518
	i32 223, ; 519
	i32 264, ; 520
	i32 261, ; 521
	i32 318, ; 522
	i32 137, ; 523
	i32 216, ; 524
	i32 232, ; 525
	i32 168, ; 526
	i32 265, ; 527
	i32 297, ; 528
	i32 101, ; 529
	i32 123, ; 530
	i32 236, ; 531
	i32 185, ; 532
	i32 163, ; 533
	i32 167, ; 534
	i32 239, ; 535
	i32 39, ; 536
	i32 192, ; 537
	i32 181, ; 538
	i32 305, ; 539
	i32 17, ; 540
	i32 205, ; 541
	i32 171, ; 542
	i32 318, ; 543
	i32 317, ; 544
	i32 137, ; 545
	i32 150, ; 546
	i32 228, ; 547
	i32 155, ; 548
	i32 130, ; 549
	i32 19, ; 550
	i32 65, ; 551
	i32 147, ; 552
	i32 47, ; 553
	i32 173, ; 554
	i32 325, ; 555
	i32 214, ; 556
	i32 79, ; 557
	i32 61, ; 558
	i32 106, ; 559
	i32 263, ; 560
	i32 218, ; 561
	i32 49, ; 562
	i32 249, ; 563
	i32 322, ; 564
	i32 260, ; 565
	i32 14, ; 566
	i32 184, ; 567
	i32 68, ; 568
	i32 171, ; 569
	i32 224, ; 570
	i32 228, ; 571
	i32 327, ; 572
	i32 78, ; 573
	i32 233, ; 574
	i32 179, ; 575
	i32 108, ; 576
	i32 217, ; 577
	i32 259, ; 578
	i32 67, ; 579
	i32 63, ; 580
	i32 27, ; 581
	i32 160, ; 582
	i32 226, ; 583
	i32 10, ; 584
	i32 177, ; 585
	i32 174, ; 586
	i32 192, ; 587
	i32 11, ; 588
	i32 78, ; 589
	i32 126, ; 590
	i32 83, ; 591
	i32 186, ; 592
	i32 66, ; 593
	i32 107, ; 594
	i32 65, ; 595
	i32 128, ; 596
	i32 122, ; 597
	i32 77, ; 598
	i32 274, ; 599
	i32 264, ; 600
	i32 326, ; 601
	i32 8, ; 602
	i32 232, ; 603
	i32 2, ; 604
	i32 44, ; 605
	i32 277, ; 606
	i32 156, ; 607
	i32 128, ; 608
	i32 262, ; 609
	i32 210, ; 610
	i32 23, ; 611
	i32 199, ; 612
	i32 209, ; 613
	i32 133, ; 614
	i32 220, ; 615
	i32 251, ; 616
	i32 321, ; 617
	i32 303, ; 618
	i32 29, ; 619
	i32 177, ; 620
	i32 174, ; 621
	i32 219, ; 622
	i32 182, ; 623
	i32 62, ; 624
	i32 194, ; 625
	i32 90, ; 626
	i32 203, ; 627
	i32 87, ; 628
	i32 148, ; 629
	i32 196, ; 630
	i32 36, ; 631
	i32 86, ; 632
	i32 240, ; 633
	i32 316, ; 634
	i32 311, ; 635
	i32 185, ; 636
	i32 50, ; 637
	i32 6, ; 638
	i32 199, ; 639
	i32 90, ; 640
	i32 323, ; 641
	i32 21, ; 642
	i32 162, ; 643
	i32 96, ; 644
	i32 50, ; 645
	i32 113, ; 646
	i32 256, ; 647
	i32 130, ; 648
	i32 76, ; 649
	i32 27, ; 650
	i32 233, ; 651
	i32 255, ; 652
	i32 7, ; 653
	i32 193, ; 654
	i32 110, ; 655
	i32 256, ; 656
	i32 242 ; 657
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
attributes #0 = { "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" }

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
!7 = !{i32 1, !"min_enum_size", i32 4}
