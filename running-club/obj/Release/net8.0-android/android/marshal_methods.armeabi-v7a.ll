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

@assembly_image_cache = dso_local local_unnamed_addr global [213 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [426 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 157
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 156
	i32 39109920, ; 2: Newtonsoft.Json.dll => 0x254c520 => 79
	i32 42639949, ; 3: System.Threading.Thread => 0x28aa24d => 198
	i32 67008169, ; 4: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 33
	i32 68219467, ; 5: System.Security.Cryptography.Primitives => 0x410f24b => 186
	i32 72070932, ; 6: Microsoft.Maui.Graphics.dll => 0x44bb714 => 75
	i32 117431740, ; 7: System.Runtime.InteropServices => 0x6ffddbc => 178
	i32 122350210, ; 8: System.Threading.Channels.dll => 0x74aea82 => 195
	i32 142721839, ; 9: System.Net.WebHeaderCollection => 0x881c32f => 163
	i32 149764678, ; 10: Svg.Skia.dll => 0x8ed3a46 => 89
	i32 149972175, ; 11: System.Security.Cryptography.Primitives.dll => 0x8f064cf => 186
	i32 165246403, ; 12: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 100
	i32 182336117, ; 13: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 119
	i32 195452805, ; 14: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 30
	i32 199333315, ; 15: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 31
	i32 205061960, ; 16: System.ComponentModel => 0xc38ff48 => 136
	i32 209399409, ; 17: Xamarin.AndroidX.Browser.dll => 0xc7b2e71 => 98
	i32 220171995, ; 18: System.Diagnostics.Debug => 0xd1f8edb => 140
	i32 230752869, ; 19: Microsoft.CSharp.dll => 0xdc10265 => 127
	i32 246610117, ; 20: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 172
	i32 280992041, ; 21: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 2
	i32 292822316, ; 22: Mapsui.UI.Maui => 0x11741d2c => 57
	i32 317674968, ; 23: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 30
	i32 318968648, ; 24: Xamarin.AndroidX.Activity.dll => 0x13031348 => 95
	i32 321597661, ; 25: System.Numerics => 0x132b30dd => 166
	i32 336156722, ; 26: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 15
	i32 342366114, ; 27: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 107
	i32 356389973, ; 28: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 14
	i32 364956269, ; 29: Grpc.Net.Common => 0x15c0ca6d => 53
	i32 367780167, ; 30: System.IO.Pipes => 0x15ebe147 => 149
	i32 371306672, ; 31: Grpc.Core.Api.dll => 0x1621b0b0 => 51
	i32 375677976, ; 32: System.Net.ServicePoint.dll => 0x16646418 => 161
	i32 379916513, ; 33: System.Threading.Thread.dll => 0x16a510e1 => 198
	i32 385762202, ; 34: System.Memory.dll => 0x16fe439a => 153
	i32 391886110, ; 35: Grpc.Net.Client.dll => 0x175bb51e => 52
	i32 393699800, ; 36: Firebase => 0x177761d8 => 38
	i32 395744057, ; 37: _Microsoft.Android.Resource.Designer => 0x17969339 => 34
	i32 435591531, ; 38: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 26
	i32 442521989, ; 39: Xamarin.Essentials => 0x1a605985 => 122
	i32 442565967, ; 40: System.Collections => 0x1a61054f => 133
	i32 450948140, ; 41: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 106
	i32 451504562, ; 42: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 187
	i32 456227837, ; 43: System.Web.HttpUtility.dll => 0x1b317bfd => 200
	i32 459347974, ; 44: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 182
	i32 465658307, ; 45: ExCSS => 0x1bc161c3 => 36
	i32 465846621, ; 46: mscorlib => 0x1bc4415d => 207
	i32 469710990, ; 47: System.dll => 0x1bff388e => 206
	i32 469965489, ; 48: Svg.Model => 0x1c031ab1 => 88
	i32 498788369, ; 49: System.ObjectModel => 0x1dbae811 => 167
	i32 500358224, ; 50: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 13
	i32 503918385, ; 51: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 7
	i32 513247710, ; 52: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 69
	i32 525008092, ; 53: SkiaSharp.dll => 0x1f4afcdc => 81
	i32 530272170, ; 54: System.Linq.Queryable => 0x1f9b4faa => 151
	i32 539058512, ; 55: Microsoft.Extensions.Logging => 0x20216150 => 66
	i32 548916678, ; 56: Microsoft.Bcl.AsyncInterfaces => 0x20b7cdc6 => 61
	i32 592146354, ; 57: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 21
	i32 610194910, ; 58: System.Reactive.dll => 0x245ed5de => 93
	i32 613668793, ; 59: System.Security.Cryptography.Algorithms => 0x2493d7b9 => 185
	i32 627609679, ; 60: Xamarin.AndroidX.CustomView => 0x2568904f => 104
	i32 627931235, ; 61: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 19
	i32 646990296, ; 62: Google.Cloud.Firestore.V1.dll => 0x269049d8 => 46
	i32 662205335, ; 63: System.Text.Encodings.Web.dll => 0x27787397 => 192
	i32 672442732, ; 64: System.Collections.Concurrent => 0x2814a96c => 129
	i32 680049820, ; 65: Mapsui.Rendering.Skia.dll => 0x2888bc9c => 59
	i32 683518922, ; 66: System.Net.Security => 0x28bdabca => 160
	i32 688181140, ; 67: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 1
	i32 690569205, ; 68: System.Xml.Linq.dll => 0x29293ff5 => 201
	i32 706645707, ; 69: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 16
	i32 707666095, ; 70: running-club => 0x2a2e20af => 126
	i32 709557578, ; 71: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 4
	i32 722857257, ; 72: System.Runtime.Loader.dll => 0x2b15ed29 => 179
	i32 759454413, ; 73: System.Net.Requests => 0x2d445acd => 159
	i32 762598435, ; 74: System.IO.Pipes.dll => 0x2d745423 => 149
	i32 775507847, ; 75: System.IO.Compression => 0x2e394f87 => 148
	i32 777317022, ; 76: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 25
	i32 778756650, ; 77: SkiaSharp.HarfBuzz.dll => 0x2e6ae22a => 82
	i32 789151979, ; 78: Microsoft.Extensions.Options => 0x2f0980eb => 68
	i32 804715423, ; 79: System.Data.Common => 0x2ff6fb9f => 139
	i32 823281589, ; 80: System.Private.Uri.dll => 0x311247b5 => 168
	i32 830298997, ; 81: System.IO.Compression.Brotli => 0x317d5b75 => 147
	i32 832635846, ; 82: System.Xml.XPath.dll => 0x31a103c6 => 204
	i32 899130691, ; 83: NetTopologySuite.dll => 0x3597a543 => 76
	i32 904024072, ; 84: System.ComponentModel.Primitives.dll => 0x35e25008 => 134
	i32 926902833, ; 85: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 28
	i32 955402788, ; 86: Newtonsoft.Json => 0x38f24a24 => 79
	i32 967690846, ; 87: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 107
	i32 975874589, ; 88: System.Xml.XDocument => 0x3a2aaa1d => 203
	i32 992768348, ; 89: System.Collections.dll => 0x3b2c715c => 133
	i32 1012816738, ; 90: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 117
	i32 1019214401, ; 91: System.Drawing => 0x3cbffa41 => 145
	i32 1028951442, ; 92: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 65
	i32 1029334545, ; 93: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 3
	i32 1035644815, ; 94: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 96
	i32 1036536393, ; 95: System.Drawing.Primitives.dll => 0x3dc84a49 => 144
	i32 1044663988, ; 96: System.Linq.Expressions.dll => 0x3e444eb4 => 150
	i32 1049751285, ; 97: Google.Api.CommonProtos.dll => 0x3e91eef5 => 39
	i32 1052210849, ; 98: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 109
	i32 1082857460, ; 99: System.ComponentModel.TypeConverter => 0x408b17f4 => 135
	i32 1084122840, ; 100: Xamarin.Kotlin.StdLib => 0x409e66d8 => 124
	i32 1098259244, ; 101: System => 0x41761b2c => 206
	i32 1118262833, ; 102: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 16
	i32 1145085672, ; 103: System.Linq.Async.dll => 0x44409ee8 => 91
	i32 1168523401, ; 104: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 22
	i32 1178241025, ; 105: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 114
	i32 1203173028, ; 106: Grpc.Net.Client => 0x47b6f6a4 => 52
	i32 1203215381, ; 107: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 20
	i32 1208641965, ; 108: System.Diagnostics.Process => 0x480a69ad => 142
	i32 1234928153, ; 109: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 18
	i32 1260983243, ; 110: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 2
	i32 1293217323, ; 111: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 105
	i32 1313028017, ; 112: Topten.RichTextKit => 0x4e4337b1 => 94
	i32 1324164729, ; 113: System.Linq => 0x4eed2679 => 152
	i32 1373134921, ; 114: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 32
	i32 1376866003, ; 115: Xamarin.AndroidX.SavedState => 0x52114ed3 => 117
	i32 1388087747, ; 116: Mapsui.dll => 0x52bc89c3 => 56
	i32 1406073936, ; 117: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 101
	i32 1408764838, ; 118: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 181
	i32 1411638395, ; 119: System.Runtime.CompilerServices.Unsafe => 0x5423e47b => 176
	i32 1422967952, ; 120: Mapsui.Tiling.dll => 0x54d0c490 => 60
	i32 1430672901, ; 121: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 0
	i32 1437713837, ; 122: Grpc.Auth => 0x55b1c5ad => 50
	i32 1443938015, ; 123: NetTopologySuite => 0x5610bedf => 76
	i32 1452070440, ; 124: System.Formats.Asn1.dll => 0x568cd628 => 146
	i32 1458022317, ; 125: System.Net.Security.dll => 0x56e7a7ad => 160
	i32 1461004990, ; 126: es\Microsoft.Maui.Controls.resources => 0x57152abe => 6
	i32 1461234159, ; 127: System.Collections.Immutable.dll => 0x5718a9ef => 130
	i32 1462112819, ; 128: System.IO.Compression.dll => 0x57261233 => 148
	i32 1469204771, ; 129: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 97
	i32 1470490898, ; 130: Microsoft.Extensions.Primitives => 0x57a5e912 => 69
	i32 1479771757, ; 131: System.Collections.Immutable => 0x5833866d => 130
	i32 1480492111, ; 132: System.IO.Compression.Brotli.dll => 0x583e844f => 147
	i32 1490249645, ; 133: running-club.dll => 0x58d367ad => 126
	i32 1493001747, ; 134: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 10
	i32 1514721132, ; 135: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 5
	i32 1543031311, ; 136: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 194
	i32 1550322496, ; 137: System.Reflection.Extensions.dll => 0x5c680b40 => 173
	i32 1551623176, ; 138: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 25
	i32 1600541741, ; 139: ShimSkiaSharp => 0x5f66542d => 80
	i32 1622152042, ; 140: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 111
	i32 1623212457, ; 141: SkiaSharp.Views.Maui.Controls => 0x60c041a9 => 84
	i32 1624863272, ; 142: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 121
	i32 1636350590, ; 143: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 103
	i32 1639515021, ; 144: System.Net.Http.dll => 0x61b9038d => 154
	i32 1639986890, ; 145: System.Text.RegularExpressions => 0x61c036ca => 194
	i32 1657153582, ; 146: System.Runtime => 0x62c6282e => 183
	i32 1658251792, ; 147: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 123
	i32 1672364457, ; 148: NetTopologySuite.IO.GeoJSON4STJ.dll => 0x63ae41a9 => 78
	i32 1677501392, ; 149: System.Net.Primitives.dll => 0x63fca3d0 => 158
	i32 1679769178, ; 150: System.Security.Cryptography => 0x641f3e5a => 188
	i32 1701541528, ; 151: System.Diagnostics.Debug.dll => 0x656b7698 => 140
	i32 1726116996, ; 152: System.Reflection.dll => 0x66e27484 => 175
	i32 1729485958, ; 153: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 99
	i32 1736233607, ; 154: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 23
	i32 1743415430, ; 155: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 1
	i32 1763938596, ; 156: System.Diagnostics.TraceSource.dll => 0x69239124 => 143
	i32 1765942094, ; 157: System.Reflection.Extensions => 0x6942234e => 173
	i32 1766324549, ; 158: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 119
	i32 1770582343, ; 159: Microsoft.Extensions.Logging.dll => 0x6988f147 => 66
	i32 1776026572, ; 160: System.Core.dll => 0x69dc03cc => 138
	i32 1780572499, ; 161: Mono.Android.Runtime.dll => 0x6a216153 => 211
	i32 1782161461, ; 162: Grpc.Core.Api => 0x6a39a035 => 51
	i32 1782862114, ; 163: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 17
	i32 1788241197, ; 164: Xamarin.AndroidX.Fragment => 0x6a96652d => 106
	i32 1793755602, ; 165: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 9
	i32 1796167890, ; 166: Microsoft.Bcl.AsyncInterfaces.dll => 0x6b0f58d2 => 61
	i32 1808609942, ; 167: Xamarin.AndroidX.Loader => 0x6bcd3296 => 111
	i32 1813058853, ; 168: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 124
	i32 1813201214, ; 169: Xamarin.Google.Android.Material => 0x6c13413e => 123
	i32 1818569960, ; 170: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 115
	i32 1824175904, ; 171: System.Text.Encoding.Extensions => 0x6cbab720 => 190
	i32 1824722060, ; 172: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 181
	i32 1828688058, ; 173: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 67
	i32 1839733746, ; 174: Mapsui.Nts.dll => 0x6da81bf2 => 58
	i32 1842015223, ; 175: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 29
	i32 1853025655, ; 176: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 26
	i32 1858542181, ; 177: System.Linq.Expressions => 0x6ec71a65 => 150
	i32 1867746548, ; 178: Xamarin.Essentials.dll => 0x6f538cf4 => 122
	i32 1870277092, ; 179: System.Reflection.Primitives => 0x6f7a29e4 => 174
	i32 1875935024, ; 180: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 8
	i32 1900519031, ; 181: Grpc.Auth.dll => 0x71479e77 => 50
	i32 1910275211, ; 182: System.Collections.NonGeneric.dll => 0x71dc7c8b => 131
	i32 1927897671, ; 183: System.CodeDom.dll => 0x72e96247 => 90
	i32 1939592360, ; 184: System.Private.Xml.Linq => 0x739bd4a8 => 169
	i32 1961813231, ; 185: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x74eee4ef => 118
	i32 1968388702, ; 186: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 62
	i32 2003115576, ; 187: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 5
	i32 2011961780, ; 188: System.Buffers.dll => 0x77ec19b4 => 128
	i32 2019465201, ; 189: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 109
	i32 2025202353, ; 190: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 0
	i32 2045470958, ; 191: System.Private.Xml => 0x79eb68ee => 170
	i32 2055257422, ; 192: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 108
	i32 2066184531, ; 193: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 4
	i32 2070888862, ; 194: System.Diagnostics.TraceSource => 0x7b6f419e => 143
	i32 2079903147, ; 195: System.Runtime.dll => 0x7bf8cdab => 183
	i32 2090596640, ; 196: System.Numerics.Vectors => 0x7c9bf920 => 165
	i32 2127167465, ; 197: System.Console => 0x7ec9ffe9 => 137
	i32 2142473426, ; 198: System.Collections.Specialized => 0x7fb38cd2 => 132
	i32 2143790110, ; 199: System.Xml.XmlSerializer.dll => 0x7fc7a41e => 205
	i32 2159891885, ; 200: Microsoft.Maui => 0x80bd55ad => 73
	i32 2169148018, ; 201: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 12
	i32 2178612968, ; 202: System.CodeDom => 0x81dafee8 => 90
	i32 2181898931, ; 203: Microsoft.Extensions.Options.dll => 0x820d22b3 => 68
	i32 2192057212, ; 204: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 67
	i32 2193016926, ; 205: System.ObjectModel.dll => 0x82b6c85e => 167
	i32 2201107256, ; 206: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 125
	i32 2201231467, ; 207: System.Net.Http => 0x8334206b => 154
	i32 2207618523, ; 208: it\Microsoft.Maui.Controls.resources => 0x839595db => 14
	i32 2216717168, ; 209: Firebase.Auth.dll => 0x84206b70 => 37
	i32 2266799131, ; 210: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 63
	i32 2270573516, ; 211: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 8
	i32 2279755925, ; 212: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 116
	i32 2295906218, ; 213: System.Net.Sockets => 0x88d8bfaa => 162
	i32 2303942373, ; 214: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 18
	i32 2305521784, ; 215: System.Private.CoreLib.dll => 0x896b7878 => 209
	i32 2327893114, ; 216: ExCSS.dll => 0x8ac0d47a => 36
	i32 2340441535, ; 217: System.Runtime.InteropServices.RuntimeInformation.dll => 0x8b804dbf => 177
	i32 2353062107, ; 218: System.Net.Primitives => 0x8c40e0db => 158
	i32 2364201794, ; 219: SkiaSharp.Views.Maui.Core => 0x8ceadb42 => 86
	i32 2368005991, ; 220: System.Xml.ReaderWriter.dll => 0x8d24e767 => 202
	i32 2371007202, ; 221: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 62
	i32 2395872292, ; 222: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 13
	i32 2397347608, ; 223: Google.LongRunning.dll => 0x8ee49f18 => 48
	i32 2401565422, ; 224: System.Web.HttpUtility => 0x8f24faee => 200
	i32 2427813419, ; 225: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 10
	i32 2435356389, ; 226: System.Console.dll => 0x912896e5 => 137
	i32 2441199521, ; 227: Google.Cloud.Firestore => 0x9181bfa1 => 45
	i32 2454642406, ; 228: System.Text.Encoding.dll => 0x924edee6 => 191
	i32 2458678730, ; 229: System.Net.Sockets.dll => 0x928c75ca => 162
	i32 2471841756, ; 230: netstandard.dll => 0x93554fdc => 208
	i32 2475788418, ; 231: Java.Interop.dll => 0x93918882 => 210
	i32 2480646305, ; 232: Microsoft.Maui.Controls => 0x93dba8a1 => 71
	i32 2484371297, ; 233: System.Net.ServicePoint => 0x94147f61 => 161
	i32 2486847491, ; 234: Google.Api.Gax => 0x943a4803 => 40
	i32 2521915375, ; 235: SkiaSharp.Views.Maui.Controls.Compatibility => 0x96515fef => 85
	i32 2523023297, ; 236: Svg.Custom.dll => 0x966247c1 => 87
	i32 2538310050, ; 237: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 172
	i32 2550873716, ; 238: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 11
	i32 2562349572, ; 239: Microsoft.CSharp => 0x98ba5a04 => 127
	i32 2570120770, ; 240: System.Text.Encodings.Web => 0x9930ee42 => 192
	i32 2577414832, ; 241: Mapsui.Nts => 0x99a03ab0 => 58
	i32 2585220780, ; 242: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 190
	i32 2593496499, ; 243: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 20
	i32 2602257211, ; 244: Svg.Model.dll => 0x9b1b4b3b => 88
	i32 2605712449, ; 245: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 125
	i32 2609324236, ; 246: Svg.Custom => 0x9b8720cc => 87
	i32 2617129537, ; 247: System.Private.Xml.dll => 0x9bfe3a41 => 170
	i32 2620871830, ; 248: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 103
	i32 2625339995, ; 249: SkiaSharp.Views.Maui.Core.dll => 0x9c7b825b => 86
	i32 2626831493, ; 250: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 15
	i32 2635732976, ; 251: Google.Cloud.Firestore.dll => 0x9d1a17f0 => 45
	i32 2663698177, ; 252: System.Runtime.Loader => 0x9ec4cf01 => 179
	i32 2664396074, ; 253: System.Xml.XDocument.dll => 0x9ecf752a => 203
	i32 2665622720, ; 254: System.Drawing.Primitives => 0x9ee22cc0 => 144
	i32 2676780864, ; 255: System.Data.Common.dll => 0x9f8c6f40 => 139
	i32 2715334215, ; 256: System.Threading.Tasks.dll => 0xa1d8b647 => 197
	i32 2717744543, ; 257: System.Security.Claims => 0xa1fd7d9f => 184
	i32 2724373263, ; 258: System.Runtime.Numerics.dll => 0xa262a30f => 180
	i32 2732626843, ; 259: Xamarin.AndroidX.Activity => 0xa2e0939b => 95
	i32 2735172069, ; 260: System.Threading.Channels => 0xa30769e5 => 195
	i32 2737747696, ; 261: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 97
	i32 2744327253, ; 262: Google.Api.Gax.Grpc.dll => 0xa3931c55 => 41
	i32 2752995522, ; 263: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 21
	i32 2756874198, ; 264: NetTopologySuite.IO.GeoJSON4STJ => 0xa4528fd6 => 78
	i32 2757554483, ; 265: Google.Api.Gax.Grpc => 0xa45cf133 => 41
	i32 2758225723, ; 266: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 72
	i32 2764765095, ; 267: Microsoft.Maui.dll => 0xa4caf7a7 => 73
	i32 2765824710, ; 268: System.Text.Encoding.CodePages.dll => 0xa4db22c6 => 189
	i32 2778768386, ; 269: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 120
	i32 2785988530, ; 270: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 27
	i32 2795602088, ; 271: SkiaSharp.Views.Android.dll => 0xa6a180a8 => 83
	i32 2801831435, ; 272: Microsoft.Maui.Graphics => 0xa7008e0b => 75
	i32 2806116107, ; 273: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 6
	i32 2810250172, ; 274: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 101
	i32 2818335264, ; 275: System.Linq.Async => 0xa7fc6220 => 91
	i32 2831556043, ; 276: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 19
	i32 2839679515, ; 277: Google.LongRunning => 0xa942121b => 48
	i32 2853208004, ; 278: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 120
	i32 2861189240, ; 279: Microsoft.Maui.Essentials => 0xaa8a4878 => 74
	i32 2893550578, ; 280: Google.Apis.Core => 0xac7813f2 => 44
	i32 2898407901, ; 281: System.Management => 0xacc231dd => 92
	i32 2901442782, ; 282: System.Reflection => 0xacf080de => 175
	i32 2905242038, ; 283: mscorlib.dll => 0xad2a79b6 => 207
	i32 2909740682, ; 284: System.Private.CoreLib => 0xad6f1e8a => 209
	i32 2912489636, ; 285: SkiaSharp.Views.Android => 0xad9910a4 => 83
	i32 2912646636, ; 286: Google.Api.CommonProtos => 0xad9b75ec => 39
	i32 2916838712, ; 287: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 121
	i32 2919462931, ; 288: System.Numerics.Vectors.dll => 0xae037813 => 165
	i32 2959614098, ; 289: System.ComponentModel.dll => 0xb0682092 => 136
	i32 2972252294, ; 290: System.Security.Cryptography.Algorithms.dll => 0xb128f886 => 185
	i32 2978675010, ; 291: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 105
	i32 2987532451, ; 292: Xamarin.AndroidX.Security.SecurityCrypto => 0xb21220a3 => 118
	i32 2990604888, ; 293: Google.Apis => 0xb2410258 => 42
	i32 3038032645, ; 294: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 34
	i32 3057625584, ; 295: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 112
	i32 3059408633, ; 296: Mono.Android.Runtime => 0xb65adef9 => 211
	i32 3059793426, ; 297: System.ComponentModel.Primitives => 0xb660be12 => 134
	i32 3075834255, ; 298: System.Threading.Tasks => 0xb755818f => 197
	i32 3077302341, ; 299: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 12
	i32 3090735792, ; 300: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 187
	i32 3099732863, ; 301: System.Security.Claims.dll => 0xb8c22b7f => 184
	i32 3103600923, ; 302: System.Formats.Asn1 => 0xb8fd311b => 146
	i32 3106263381, ; 303: Grpc.Net.Common.dll => 0xb925d155 => 53
	i32 3124832203, ; 304: System.Threading.Tasks.Extensions => 0xba4127cb => 196
	i32 3134694676, ; 305: ShimSkiaSharp.dll => 0xbad7a514 => 80
	i32 3159123045, ; 306: System.Reflection.Primitives.dll => 0xbc4c6465 => 174
	i32 3178803400, ; 307: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 113
	i32 3203277885, ; 308: Google.Api.Gax.dll => 0xbeee243d => 40
	i32 3220365878, ; 309: System.Threading => 0xbff2e236 => 199
	i32 3258312781, ; 310: Xamarin.AndroidX.CardView => 0xc235e84d => 99
	i32 3265493905, ; 311: System.Linq.Queryable.dll => 0xc2a37b91 => 151
	i32 3265893370, ; 312: System.Threading.Tasks.Extensions.dll => 0xc2a993fa => 196
	i32 3278552754, ; 313: Mapsui => 0xc36abeb2 => 56
	i32 3299363146, ; 314: System.Text.Encoding => 0xc4a8494a => 191
	i32 3305363605, ; 315: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 7
	i32 3316684772, ; 316: System.Net.Requests.dll => 0xc5b097e4 => 159
	i32 3317135071, ; 317: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 104
	i32 3322403133, ; 318: Firebase.dll => 0xc607d93d => 38
	i32 3340387945, ; 319: SkiaSharp => 0xc71a4669 => 81
	i32 3346324047, ; 320: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 114
	i32 3357674450, ; 321: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 24
	i32 3358260929, ; 322: System.Text.Json => 0xc82afec1 => 193
	i32 3362522851, ; 323: Xamarin.AndroidX.Core => 0xc86c06e3 => 102
	i32 3366347497, ; 324: Java.Interop => 0xc8a662e9 => 210
	i32 3374999561, ; 325: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 116
	i32 3381016424, ; 326: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 3
	i32 3395150330, ; 327: System.Runtime.CompilerServices.Unsafe.dll => 0xca5de1fa => 176
	i32 3428513518, ; 328: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 64
	i32 3430777524, ; 329: netstandard => 0xcc7d82b4 => 208
	i32 3452344032, ; 330: Microsoft.Maui.Controls.Compatibility.dll => 0xcdc696e0 => 70
	i32 3453592554, ; 331: Google.Apis.Core.dll => 0xcdd9a3ea => 44
	i32 3459815001, ; 332: Mapsui.Rendering.Skia => 0xce389659 => 59
	i32 3463511458, ; 333: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 11
	i32 3466574376, ; 334: SkiaSharp.Views.Maui.Controls.Compatibility.dll => 0xce9fba28 => 85
	i32 3471940407, ; 335: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 135
	i32 3473156932, ; 336: SkiaSharp.Views.Maui.Controls.dll => 0xcf042b44 => 84
	i32 3476120550, ; 337: Mono.Android => 0xcf3163e6 => 212
	i32 3479583265, ; 338: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 24
	i32 3484440000, ; 339: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 23
	i32 3485117614, ; 340: System.Text.Json.dll => 0xcfbaacae => 193
	i32 3499097210, ; 341: Google.Protobuf.dll => 0xd08ffc7a => 49
	i32 3509114376, ; 342: System.Xml.Linq => 0xd128d608 => 201
	i32 3539954161, ; 343: System.Net.HttpListener => 0xd2ff69f1 => 155
	i32 3580758918, ; 344: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 31
	i32 3596207933, ; 345: LiteDB.dll => 0xd659c73d => 55
	i32 3598063517, ; 346: Google.Cloud.Firestore.V1 => 0xd676179d => 46
	i32 3608519521, ; 347: System.Linq.dll => 0xd715a361 => 152
	i32 3612435020, ; 348: System.Management.dll => 0xd751624c => 92
	i32 3624195450, ; 349: System.Runtime.InteropServices.RuntimeInformation => 0xd804d57a => 177
	i32 3629588173, ; 350: LiteDB => 0xd8571ecd => 55
	i32 3641597786, ; 351: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 108
	i32 3643446276, ; 352: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 28
	i32 3643854240, ; 353: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 113
	i32 3645630983, ; 354: Google.Protobuf => 0xd94bea07 => 49
	i32 3657292374, ; 355: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 63
	i32 3660523487, ; 356: System.Net.NetworkInformation => 0xda2f27df => 157
	i32 3672681054, ; 357: Mono.Android.dll => 0xdae8aa5e => 212
	i32 3682565725, ; 358: Xamarin.AndroidX.Browser => 0xdb7f7e5d => 98
	i32 3697841164, ; 359: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 33
	i32 3700866549, ; 360: System.Net.WebProxy.dll => 0xdc96bdf5 => 164
	i32 3712156464, ; 361: Mapsui.UI.Maui.dll => 0xdd430330 => 57
	i32 3724971120, ; 362: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 112
	i32 3731644420, ; 363: System.Reactive => 0xde6c6004 => 93
	i32 3732100267, ; 364: System.Net.NameResolution => 0xde7354ab => 156
	i32 3748608112, ; 365: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 141
	i32 3751444290, ; 366: System.Xml.XPath => 0xdf9a7f42 => 204
	i32 3757995660, ; 367: Google.Cloud.Location.dll => 0xdffe768c => 47
	i32 3786282454, ; 368: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 100
	i32 3792276235, ; 369: System.Collections.NonGeneric => 0xe2098b0b => 131
	i32 3792835768, ; 370: HarfBuzzSharp => 0xe21214b8 => 54
	i32 3793997468, ; 371: Google.Apis.Auth.dll => 0xe223ce9c => 43
	i32 3798102808, ; 372: BruTile => 0xe2627318 => 35
	i32 3800979733, ; 373: Microsoft.Maui.Controls.Compatibility => 0xe28e5915 => 70
	i32 3802395368, ; 374: System.Collections.Specialized.dll => 0xe2a3f2e8 => 132
	i32 3819260425, ; 375: System.Net.WebProxy => 0xe3a54a09 => 164
	i32 3823082795, ; 376: System.Security.Cryptography.dll => 0xe3df9d2b => 188
	i32 3829621856, ; 377: System.Numerics.dll => 0xe4436460 => 166
	i32 3841636137, ; 378: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 65
	i32 3849253459, ; 379: System.Runtime.InteropServices.dll => 0xe56ef253 => 178
	i32 3870376305, ; 380: System.Net.HttpListener.dll => 0xe6b14171 => 155
	i32 3885497537, ; 381: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 163
	i32 3889960447, ; 382: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 32
	i32 3896106733, ; 383: System.Collections.Concurrent.dll => 0xe839deed => 129
	i32 3896760992, ; 384: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 102
	i32 3928044579, ; 385: System.Xml.ReaderWriter => 0xea213423 => 202
	i32 3931092270, ; 386: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 115
	i32 3934069706, ; 387: Topten.RichTextKit.dll => 0xea7d23ca => 94
	i32 3952289091, ; 388: NetTopologySuite.Features.dll => 0xeb932543 => 77
	i32 3953583589, ; 389: Svg.Skia => 0xeba6e5e5 => 89
	i32 3953953790, ; 390: System.Text.Encoding.CodePages => 0xebac8bfe => 189
	i32 3955647286, ; 391: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 96
	i32 3980434154, ; 392: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 27
	i32 3987592930, ; 393: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 9
	i32 4003436829, ; 394: System.Diagnostics.Process.dll => 0xee9f991d => 142
	i32 4003906742, ; 395: HarfBuzzSharp.dll => 0xeea6c4b6 => 54
	i32 4013003792, ; 396: BruTile.dll => 0xef319410 => 35
	i32 4022681963, ; 397: Mapsui.Tiling => 0xefc5416b => 60
	i32 4024013275, ; 398: Firebase.Auth => 0xefd991db => 37
	i32 4025784931, ; 399: System.Memory => 0xeff49a63 => 153
	i32 4046471985, ; 400: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 72
	i32 4054681211, ; 401: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 171
	i32 4056144661, ; 402: Google.Cloud.Location => 0xf1c3db15 => 47
	i32 4059682726, ; 403: Google.Apis.dll => 0xf1f9d7a6 => 42
	i32 4066802364, ; 404: SkiaSharp.HarfBuzz => 0xf2667abc => 82
	i32 4068434129, ; 405: System.Private.Xml.Linq.dll => 0xf27f60d1 => 169
	i32 4073602200, ; 406: System.Threading.dll => 0xf2ce3c98 => 199
	i32 4082882467, ; 407: Google.Apis.Auth => 0xf35bd7a3 => 43
	i32 4094352644, ; 408: Microsoft.Maui.Essentials.dll => 0xf40add04 => 74
	i32 4099507663, ; 409: System.Drawing.dll => 0xf45985cf => 145
	i32 4100113165, ; 410: System.Private.Uri => 0xf462c30d => 168
	i32 4102112229, ; 411: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 22
	i32 4125707920, ; 412: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 17
	i32 4126470640, ; 413: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 64
	i32 4144557198, ; 414: NetTopologySuite.Features => 0xf708ec8e => 77
	i32 4147896353, ; 415: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 171
	i32 4150914736, ; 416: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 29
	i32 4151237749, ; 417: System.Core => 0xf76edc75 => 138
	i32 4159265925, ; 418: System.Xml.XmlSerializer => 0xf7e95c85 => 205
	i32 4181436372, ; 419: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 182
	i32 4182413190, ; 420: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 110
	i32 4213026141, ; 421: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 141
	i32 4260525087, ; 422: System.Buffers => 0xfdf2741f => 128
	i32 4271975918, ; 423: Microsoft.Maui.Controls.dll => 0xfea12dee => 71
	i32 4274976490, ; 424: System.Runtime.Numerics => 0xfecef6ea => 180
	i32 4292120959 ; 425: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 110
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [426 x i32] [
	i32 157, ; 0
	i32 156, ; 1
	i32 79, ; 2
	i32 198, ; 3
	i32 33, ; 4
	i32 186, ; 5
	i32 75, ; 6
	i32 178, ; 7
	i32 195, ; 8
	i32 163, ; 9
	i32 89, ; 10
	i32 186, ; 11
	i32 100, ; 12
	i32 119, ; 13
	i32 30, ; 14
	i32 31, ; 15
	i32 136, ; 16
	i32 98, ; 17
	i32 140, ; 18
	i32 127, ; 19
	i32 172, ; 20
	i32 2, ; 21
	i32 57, ; 22
	i32 30, ; 23
	i32 95, ; 24
	i32 166, ; 25
	i32 15, ; 26
	i32 107, ; 27
	i32 14, ; 28
	i32 53, ; 29
	i32 149, ; 30
	i32 51, ; 31
	i32 161, ; 32
	i32 198, ; 33
	i32 153, ; 34
	i32 52, ; 35
	i32 38, ; 36
	i32 34, ; 37
	i32 26, ; 38
	i32 122, ; 39
	i32 133, ; 40
	i32 106, ; 41
	i32 187, ; 42
	i32 200, ; 43
	i32 182, ; 44
	i32 36, ; 45
	i32 207, ; 46
	i32 206, ; 47
	i32 88, ; 48
	i32 167, ; 49
	i32 13, ; 50
	i32 7, ; 51
	i32 69, ; 52
	i32 81, ; 53
	i32 151, ; 54
	i32 66, ; 55
	i32 61, ; 56
	i32 21, ; 57
	i32 93, ; 58
	i32 185, ; 59
	i32 104, ; 60
	i32 19, ; 61
	i32 46, ; 62
	i32 192, ; 63
	i32 129, ; 64
	i32 59, ; 65
	i32 160, ; 66
	i32 1, ; 67
	i32 201, ; 68
	i32 16, ; 69
	i32 126, ; 70
	i32 4, ; 71
	i32 179, ; 72
	i32 159, ; 73
	i32 149, ; 74
	i32 148, ; 75
	i32 25, ; 76
	i32 82, ; 77
	i32 68, ; 78
	i32 139, ; 79
	i32 168, ; 80
	i32 147, ; 81
	i32 204, ; 82
	i32 76, ; 83
	i32 134, ; 84
	i32 28, ; 85
	i32 79, ; 86
	i32 107, ; 87
	i32 203, ; 88
	i32 133, ; 89
	i32 117, ; 90
	i32 145, ; 91
	i32 65, ; 92
	i32 3, ; 93
	i32 96, ; 94
	i32 144, ; 95
	i32 150, ; 96
	i32 39, ; 97
	i32 109, ; 98
	i32 135, ; 99
	i32 124, ; 100
	i32 206, ; 101
	i32 16, ; 102
	i32 91, ; 103
	i32 22, ; 104
	i32 114, ; 105
	i32 52, ; 106
	i32 20, ; 107
	i32 142, ; 108
	i32 18, ; 109
	i32 2, ; 110
	i32 105, ; 111
	i32 94, ; 112
	i32 152, ; 113
	i32 32, ; 114
	i32 117, ; 115
	i32 56, ; 116
	i32 101, ; 117
	i32 181, ; 118
	i32 176, ; 119
	i32 60, ; 120
	i32 0, ; 121
	i32 50, ; 122
	i32 76, ; 123
	i32 146, ; 124
	i32 160, ; 125
	i32 6, ; 126
	i32 130, ; 127
	i32 148, ; 128
	i32 97, ; 129
	i32 69, ; 130
	i32 130, ; 131
	i32 147, ; 132
	i32 126, ; 133
	i32 10, ; 134
	i32 5, ; 135
	i32 194, ; 136
	i32 173, ; 137
	i32 25, ; 138
	i32 80, ; 139
	i32 111, ; 140
	i32 84, ; 141
	i32 121, ; 142
	i32 103, ; 143
	i32 154, ; 144
	i32 194, ; 145
	i32 183, ; 146
	i32 123, ; 147
	i32 78, ; 148
	i32 158, ; 149
	i32 188, ; 150
	i32 140, ; 151
	i32 175, ; 152
	i32 99, ; 153
	i32 23, ; 154
	i32 1, ; 155
	i32 143, ; 156
	i32 173, ; 157
	i32 119, ; 158
	i32 66, ; 159
	i32 138, ; 160
	i32 211, ; 161
	i32 51, ; 162
	i32 17, ; 163
	i32 106, ; 164
	i32 9, ; 165
	i32 61, ; 166
	i32 111, ; 167
	i32 124, ; 168
	i32 123, ; 169
	i32 115, ; 170
	i32 190, ; 171
	i32 181, ; 172
	i32 67, ; 173
	i32 58, ; 174
	i32 29, ; 175
	i32 26, ; 176
	i32 150, ; 177
	i32 122, ; 178
	i32 174, ; 179
	i32 8, ; 180
	i32 50, ; 181
	i32 131, ; 182
	i32 90, ; 183
	i32 169, ; 184
	i32 118, ; 185
	i32 62, ; 186
	i32 5, ; 187
	i32 128, ; 188
	i32 109, ; 189
	i32 0, ; 190
	i32 170, ; 191
	i32 108, ; 192
	i32 4, ; 193
	i32 143, ; 194
	i32 183, ; 195
	i32 165, ; 196
	i32 137, ; 197
	i32 132, ; 198
	i32 205, ; 199
	i32 73, ; 200
	i32 12, ; 201
	i32 90, ; 202
	i32 68, ; 203
	i32 67, ; 204
	i32 167, ; 205
	i32 125, ; 206
	i32 154, ; 207
	i32 14, ; 208
	i32 37, ; 209
	i32 63, ; 210
	i32 8, ; 211
	i32 116, ; 212
	i32 162, ; 213
	i32 18, ; 214
	i32 209, ; 215
	i32 36, ; 216
	i32 177, ; 217
	i32 158, ; 218
	i32 86, ; 219
	i32 202, ; 220
	i32 62, ; 221
	i32 13, ; 222
	i32 48, ; 223
	i32 200, ; 224
	i32 10, ; 225
	i32 137, ; 226
	i32 45, ; 227
	i32 191, ; 228
	i32 162, ; 229
	i32 208, ; 230
	i32 210, ; 231
	i32 71, ; 232
	i32 161, ; 233
	i32 40, ; 234
	i32 85, ; 235
	i32 87, ; 236
	i32 172, ; 237
	i32 11, ; 238
	i32 127, ; 239
	i32 192, ; 240
	i32 58, ; 241
	i32 190, ; 242
	i32 20, ; 243
	i32 88, ; 244
	i32 125, ; 245
	i32 87, ; 246
	i32 170, ; 247
	i32 103, ; 248
	i32 86, ; 249
	i32 15, ; 250
	i32 45, ; 251
	i32 179, ; 252
	i32 203, ; 253
	i32 144, ; 254
	i32 139, ; 255
	i32 197, ; 256
	i32 184, ; 257
	i32 180, ; 258
	i32 95, ; 259
	i32 195, ; 260
	i32 97, ; 261
	i32 41, ; 262
	i32 21, ; 263
	i32 78, ; 264
	i32 41, ; 265
	i32 72, ; 266
	i32 73, ; 267
	i32 189, ; 268
	i32 120, ; 269
	i32 27, ; 270
	i32 83, ; 271
	i32 75, ; 272
	i32 6, ; 273
	i32 101, ; 274
	i32 91, ; 275
	i32 19, ; 276
	i32 48, ; 277
	i32 120, ; 278
	i32 74, ; 279
	i32 44, ; 280
	i32 92, ; 281
	i32 175, ; 282
	i32 207, ; 283
	i32 209, ; 284
	i32 83, ; 285
	i32 39, ; 286
	i32 121, ; 287
	i32 165, ; 288
	i32 136, ; 289
	i32 185, ; 290
	i32 105, ; 291
	i32 118, ; 292
	i32 42, ; 293
	i32 34, ; 294
	i32 112, ; 295
	i32 211, ; 296
	i32 134, ; 297
	i32 197, ; 298
	i32 12, ; 299
	i32 187, ; 300
	i32 184, ; 301
	i32 146, ; 302
	i32 53, ; 303
	i32 196, ; 304
	i32 80, ; 305
	i32 174, ; 306
	i32 113, ; 307
	i32 40, ; 308
	i32 199, ; 309
	i32 99, ; 310
	i32 151, ; 311
	i32 196, ; 312
	i32 56, ; 313
	i32 191, ; 314
	i32 7, ; 315
	i32 159, ; 316
	i32 104, ; 317
	i32 38, ; 318
	i32 81, ; 319
	i32 114, ; 320
	i32 24, ; 321
	i32 193, ; 322
	i32 102, ; 323
	i32 210, ; 324
	i32 116, ; 325
	i32 3, ; 326
	i32 176, ; 327
	i32 64, ; 328
	i32 208, ; 329
	i32 70, ; 330
	i32 44, ; 331
	i32 59, ; 332
	i32 11, ; 333
	i32 85, ; 334
	i32 135, ; 335
	i32 84, ; 336
	i32 212, ; 337
	i32 24, ; 338
	i32 23, ; 339
	i32 193, ; 340
	i32 49, ; 341
	i32 201, ; 342
	i32 155, ; 343
	i32 31, ; 344
	i32 55, ; 345
	i32 46, ; 346
	i32 152, ; 347
	i32 92, ; 348
	i32 177, ; 349
	i32 55, ; 350
	i32 108, ; 351
	i32 28, ; 352
	i32 113, ; 353
	i32 49, ; 354
	i32 63, ; 355
	i32 157, ; 356
	i32 212, ; 357
	i32 98, ; 358
	i32 33, ; 359
	i32 164, ; 360
	i32 57, ; 361
	i32 112, ; 362
	i32 93, ; 363
	i32 156, ; 364
	i32 141, ; 365
	i32 204, ; 366
	i32 47, ; 367
	i32 100, ; 368
	i32 131, ; 369
	i32 54, ; 370
	i32 43, ; 371
	i32 35, ; 372
	i32 70, ; 373
	i32 132, ; 374
	i32 164, ; 375
	i32 188, ; 376
	i32 166, ; 377
	i32 65, ; 378
	i32 178, ; 379
	i32 155, ; 380
	i32 163, ; 381
	i32 32, ; 382
	i32 129, ; 383
	i32 102, ; 384
	i32 202, ; 385
	i32 115, ; 386
	i32 94, ; 387
	i32 77, ; 388
	i32 89, ; 389
	i32 189, ; 390
	i32 96, ; 391
	i32 27, ; 392
	i32 9, ; 393
	i32 142, ; 394
	i32 54, ; 395
	i32 35, ; 396
	i32 60, ; 397
	i32 37, ; 398
	i32 153, ; 399
	i32 72, ; 400
	i32 171, ; 401
	i32 47, ; 402
	i32 42, ; 403
	i32 82, ; 404
	i32 169, ; 405
	i32 199, ; 406
	i32 43, ; 407
	i32 74, ; 408
	i32 145, ; 409
	i32 168, ; 410
	i32 22, ; 411
	i32 17, ; 412
	i32 64, ; 413
	i32 77, ; 414
	i32 171, ; 415
	i32 29, ; 416
	i32 138, ; 417
	i32 205, ; 418
	i32 182, ; 419
	i32 110, ; 420
	i32 141, ; 421
	i32 128, ; 422
	i32 71, ; 423
	i32 180, ; 424
	i32 110 ; 425
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
