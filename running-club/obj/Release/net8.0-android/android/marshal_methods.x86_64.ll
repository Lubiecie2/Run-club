; ModuleID = 'marshal_methods.x86_64.ll'
source_filename = "marshal_methods.x86_64.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [213 x ptr] zeroinitializer, align 16

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [426 x i64] [
	i64 40218994123153105, ; 0: ExCSS.dll => 0x8ee2f649ef1ed1 => 36
	i64 96808603140984794, ; 1: Google.Cloud.Location.dll => 0x157eee9616b8fda => 47
	i64 98382396393917666, ; 2: Microsoft.Extensions.Primitives.dll => 0x15d8644ad360ce2 => 69
	i64 120698629574877762, ; 3: Mono.Android => 0x1accec39cafe242 => 212
	i64 131669012237370309, ; 4: Microsoft.Maui.Essentials.dll => 0x1d3c844de55c3c5 => 74
	i64 184471870596806994, ; 5: Svg.Skia => 0x28f60305df97952 => 89
	i64 196720943101637631, ; 6: System.Linq.Expressions.dll => 0x2bae4a7cd73f3ff => 150
	i64 210515253464952879, ; 7: Xamarin.AndroidX.Collection.dll => 0x2ebe681f694702f => 100
	i64 232391251801502327, ; 8: Xamarin.AndroidX.SavedState.dll => 0x3399e9cbc897277 => 117
	i64 404665707914610830, ; 9: Svg.Custom => 0x59da9513d08488e => 87
	i64 435118502366263740, ; 10: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x609d9f8f8bdb9bc => 118
	i64 464346026994987652, ; 11: System.Reactive.dll => 0x671b04057e67284 => 93
	i64 502670939551102150, ; 12: System.Management.dll => 0x6f9d88e66daf4c6 => 92
	i64 545109961164950392, ; 13: fi/Microsoft.Maui.Controls.resources.dll => 0x7909e9f1ec38b78 => 7
	i64 559848537545527438, ; 14: Mapsui.Nts.dll => 0x7c4fb47586c508e => 58
	i64 560278790331054453, ; 15: System.Reflection.Primitives => 0x7c6829760de3975 => 174
	i64 750875890346172408, ; 16: System.Threading.Thread => 0xa6ba5a4da7d1ff8 => 198
	i64 799765834175365804, ; 17: System.ComponentModel.dll => 0xb1956c9f18442ac => 136
	i64 849051935479314978, ; 18: hi/Microsoft.Maui.Controls.resources.dll => 0xbc8703ca21a3a22 => 10
	i64 872800313462103108, ; 19: Xamarin.AndroidX.DrawerLayout => 0xc1ccf42c3c21c44 => 105
	i64 1010599046655515943, ; 20: System.Reflection.Primitives.dll => 0xe065e7a82401d27 => 174
	i64 1120440138749646132, ; 21: Xamarin.Google.Android.Material.dll => 0xf8c9a5eae431534 => 123
	i64 1121665720830085036, ; 22: nb/Microsoft.Maui.Controls.resources.dll => 0xf90f507becf47ac => 18
	i64 1268860745194512059, ; 23: System.Drawing.dll => 0x119be62002c19ebb => 145
	i64 1369545283391376210, ; 24: Xamarin.AndroidX.Navigation.Fragment.dll => 0x13019a2dd85acb52 => 113
	i64 1476839205573959279, ; 25: System.Net.Primitives.dll => 0x147ec96ece9b1e6f => 158
	i64 1486715745332614827, ; 26: Microsoft.Maui.Controls.dll => 0x14a1e017ea87d6ab => 71
	i64 1492954217099365037, ; 27: System.Net.HttpListener => 0x14b809f350210aad => 155
	i64 1513467482682125403, ; 28: Mono.Android.Runtime => 0x1500eaa8245f6c5b => 211
	i64 1537168428375924959, ; 29: System.Threading.Thread.dll => 0x15551e8a954ae0df => 198
	i64 1556147632182429976, ; 30: ko/Microsoft.Maui.Controls.resources.dll => 0x15988c06d24c8918 => 16
	i64 1624659445732251991, ; 31: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0x168bf32877da9957 => 97
	i64 1628611045998245443, ; 32: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0x1699fd1e1a00b643 => 110
	i64 1731380447121279447, ; 33: Newtonsoft.Json => 0x18071957e9b889d7 => 79
	i64 1743969030606105336, ; 34: System.Memory.dll => 0x1833d297e88f2af8 => 153
	i64 1767386781656293639, ; 35: System.Private.Uri.dll => 0x188704e9f5582107 => 168
	i64 1769105627832031750, ; 36: Google.Protobuf => 0x188d203205129a06 => 49
	i64 1795316252682057001, ; 37: Xamarin.AndroidX.AppCompat.dll => 0x18ea3e9eac997529 => 96
	i64 1825687700144851180, ; 38: System.Runtime.InteropServices.RuntimeInformation.dll => 0x1956254a55ef08ec => 177
	i64 1835311033149317475, ; 39: es\Microsoft.Maui.Controls.resources => 0x197855a927386163 => 6
	i64 1836611346387731153, ; 40: Xamarin.AndroidX.SavedState => 0x197cf449ebe482d1 => 117
	i64 1865037103900624886, ; 41: Microsoft.Bcl.AsyncInterfaces => 0x19e1f15d56eb87f6 => 61
	i64 1875417405349196092, ; 42: System.Drawing.Primitives => 0x1a06d2319b6c713c => 144
	i64 1881198190668717030, ; 43: tr\Microsoft.Maui.Controls.resources => 0x1a1b5bc992ea9be6 => 28
	i64 1897575647115118287, ; 44: Xamarin.AndroidX.Security.SecurityCrypto => 0x1a558aff4cba86cf => 118
	i64 1920760634179481754, ; 45: Microsoft.Maui.Controls.Xaml => 0x1aa7e99ec2d2709a => 72
	i64 1959996714666907089, ; 46: tr/Microsoft.Maui.Controls.resources.dll => 0x1b334ea0a2a755d1 => 28
	i64 1972385128188460614, ; 47: System.Security.Cryptography.Algorithms => 0x1b5f51d2edefbe46 => 185
	i64 1981742497975770890, ; 48: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x1b80904d5c241f0a => 109
	i64 1983698669889758782, ; 49: cs/Microsoft.Maui.Controls.resources.dll => 0x1b87836e2031a63e => 2
	i64 2019660174692588140, ; 50: pl/Microsoft.Maui.Controls.resources.dll => 0x1c07463a6f8e1a6c => 20
	i64 2040001226662520565, ; 51: System.Threading.Tasks.Extensions.dll => 0x1c4f8a4ea894a6f5 => 196
	i64 2102659300918482391, ; 52: System.Drawing.Primitives.dll => 0x1d2e257e6aead5d7 => 144
	i64 2108673896768817157, ; 53: NetTopologySuite => 0x1d4383bca40b4805 => 76
	i64 2133195048986300728, ; 54: Newtonsoft.Json.dll => 0x1d9aa1984b735138 => 79
	i64 2165725771938924357, ; 55: Xamarin.AndroidX.Browser => 0x1e0e341d75540745 => 98
	i64 2188974421706709258, ; 56: SkiaSharp.HarfBuzz.dll => 0x1e60cca38c3e990a => 82
	i64 2262844636196693701, ; 57: Xamarin.AndroidX.DrawerLayout.dll => 0x1f673d352266e6c5 => 105
	i64 2287834202362508563, ; 58: System.Collections.Concurrent => 0x1fc00515e8ce7513 => 129
	i64 2302323944321350744, ; 59: ru/Microsoft.Maui.Controls.resources.dll => 0x1ff37f6ddb267c58 => 24
	i64 2329709569556905518, ; 60: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x2054ca829b447e2e => 108
	i64 2335503487726329082, ; 61: System.Text.Encodings.Web => 0x2069600c4d9d1cfa => 192
	i64 2337758774805907496, ; 62: System.Runtime.CompilerServices.Unsafe => 0x207163383edbc828 => 176
	i64 2445261912722553526, ; 63: Google.Cloud.Firestore.dll => 0x21ef50c10a9ebab6 => 45
	i64 2470498323731680442, ; 64: Xamarin.AndroidX.CoordinatorLayout => 0x2248f922dc398cba => 101
	i64 2497223385847772520, ; 65: System.Runtime => 0x22a7eb7046413568 => 183
	i64 2547086958574651984, ; 66: Xamarin.AndroidX.Activity.dll => 0x2359121801df4a50 => 95
	i64 2602673633151553063, ; 67: th\Microsoft.Maui.Controls.resources => 0x241e8de13a460e27 => 27
	i64 2624866290265602282, ; 68: mscorlib.dll => 0x246d65fbde2db8ea => 207
	i64 2632269733008246987, ; 69: System.Net.NameResolution => 0x2487b36034f808cb => 156
	i64 2656907746661064104, ; 70: Microsoft.Extensions.DependencyInjection => 0x24df3b84c8b75da8 => 64
	i64 2662981627730767622, ; 71: cs\Microsoft.Maui.Controls.resources => 0x24f4cfae6c48af06 => 2
	i64 2783046991838674048, ; 72: System.Runtime.CompilerServices.Unsafe.dll => 0x269f5e7e6dc37c80 => 176
	i64 2812926542227278819, ; 73: Google.Apis.Core.dll => 0x270985c960b98be3 => 44
	i64 2895129759130297543, ; 74: fi\Microsoft.Maui.Controls.resources => 0x282d912d479fa4c7 => 7
	i64 3017136373564924869, ; 75: System.Net.WebProxy => 0x29df058bd93f63c5 => 164
	i64 3017704767998173186, ; 76: Xamarin.Google.Android.Material => 0x29e10a7f7d88a002 => 123
	i64 3254037935674351285, ; 77: SkiaSharp.Views.Maui.Controls.Compatibility.dll => 0x2d28aa430983deb5 => 85
	i64 3289520064315143713, ; 78: Xamarin.AndroidX.Lifecycle.Common => 0x2da6b911e3063621 => 107
	i64 3311221304742556517, ; 79: System.Numerics.Vectors.dll => 0x2df3d23ba9e2b365 => 165
	i64 3325875462027654285, ; 80: System.Runtime.Numerics => 0x2e27e21c8958b48d => 180
	i64 3328853167529574890, ; 81: System.Net.Sockets.dll => 0x2e327651a008c1ea => 162
	i64 3344514922410554693, ; 82: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x2e6a1a9a18463545 => 125
	i64 3414639567687375782, ; 83: SkiaSharp.Views.Maui.Controls => 0x2f633c9863ffdba6 => 84
	i64 3429672777697402584, ; 84: Microsoft.Maui.Essentials => 0x2f98a5385a7b1ed8 => 74
	i64 3430216265859992823, ; 85: Grpc.Auth.dll => 0x2f9a93850d5a0cf7 => 50
	i64 3461602852075779363, ; 86: SkiaSharp.HarfBuzz => 0x300a15741f74b523 => 82
	i64 3494946837667399002, ; 87: Microsoft.Extensions.Configuration => 0x30808ba1c00a455a => 62
	i64 3522470458906976663, ; 88: Xamarin.AndroidX.SwipeRefreshLayout => 0x30e2543832f52197 => 119
	i64 3531994851595924923, ; 89: System.Numerics => 0x31042a9aade235bb => 166
	i64 3551103847008531295, ; 90: System.Private.CoreLib.dll => 0x31480e226177735f => 209
	i64 3567343442040498961, ; 91: pt\Microsoft.Maui.Controls.resources => 0x3181bff5bea4ab11 => 22
	i64 3571415421602489686, ; 92: System.Runtime.dll => 0x319037675df7e556 => 183
	i64 3638003163729360188, ; 93: Microsoft.Extensions.Configuration.Abstractions => 0x327cc89a39d5f53c => 63
	i64 3647754201059316852, ; 94: System.Xml.ReaderWriter => 0x329f6d1e86145474 => 202
	i64 3655542548057982301, ; 95: Microsoft.Extensions.Configuration.dll => 0x32bb18945e52855d => 62
	i64 3658489898830683555, ; 96: Svg.Skia.dll => 0x32c5912df2285da3 => 89
	i64 3696698938527704835, ; 97: Mapsui.Rendering.Skia.dll => 0x334d50194081e703 => 59
	i64 3716579019761409177, ; 98: netstandard.dll => 0x3393f0ed5c8c5c99 => 208
	i64 3727469159507183293, ; 99: Xamarin.AndroidX.RecyclerView => 0x33baa1739ba646bd => 116
	i64 3869221888984012293, ; 100: Microsoft.Extensions.Logging.dll => 0x35b23cceda0ed605 => 66
	i64 3890352374528606784, ; 101: Microsoft.Maui.Controls.Xaml.dll => 0x35fd4edf66e00240 => 72
	i64 3893087497687830326, ; 102: Google.Cloud.Firestore.V1.dll => 0x36070673e3328f36 => 46
	i64 3933965368022646939, ; 103: System.Net.Requests => 0x369840a8bfadc09b => 159
	i64 3966267475168208030, ; 104: System.Memory => 0x370b03412596249e => 153
	i64 4009997192427317104, ; 105: System.Runtime.Serialization.Primitives => 0x37a65f335cf1a770 => 182
	i64 4056584864658557221, ; 106: Google.Apis.Auth => 0x384be27113330925 => 43
	i64 4073500526318903918, ; 107: System.Private.Xml.dll => 0x3887fb25779ae26e => 170
	i64 4073631083018132676, ; 108: Microsoft.Maui.Controls.Compatibility.dll => 0x388871e311491cc4 => 70
	i64 4120493066591692148, ; 109: zh-Hant\Microsoft.Maui.Controls.resources => 0x392eee9cdda86574 => 33
	i64 4154383907710350974, ; 110: System.ComponentModel => 0x39a7562737acb67e => 136
	i64 4168469861834746866, ; 111: System.Security.Claims.dll => 0x39d96140fb94ebf2 => 184
	i64 4187479170553454871, ; 112: System.Linq.Expressions => 0x3a1cea1e912fa117 => 150
	i64 4205801962323029395, ; 113: System.ComponentModel.TypeConverter => 0x3a5e0299f7e7ad93 => 135
	i64 4356591372459378815, ; 114: vi/Microsoft.Maui.Controls.resources.dll => 0x3c75b8c562f9087f => 30
	i64 4373617458794931033, ; 115: System.IO.Pipes.dll => 0x3cb235e806eb2359 => 149
	i64 4477672992252076438, ; 116: System.Web.HttpUtility.dll => 0x3e23e3dcdb8ba196 => 200
	i64 4679594760078841447, ; 117: ar/Microsoft.Maui.Controls.resources.dll => 0x40f142a407475667 => 0
	i64 4716677666592453464, ; 118: System.Xml.XmlSerializer => 0x417501590542f358 => 205
	i64 4794310189461587505, ; 119: Xamarin.AndroidX.Activity => 0x4288cfb749e4c631 => 95
	i64 4795410492532947900, ; 120: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0x428cb86f8f9b7bbc => 119
	i64 4809057822547766521, ; 121: System.Drawing => 0x42bd349c3145ecf9 => 145
	i64 4814660307502931973, ; 122: System.Net.NameResolution.dll => 0x42d11c0a5ee2a005 => 156
	i64 4853321196694829351, ; 123: System.Runtime.Loader.dll => 0x435a75ea15de7927 => 179
	i64 5040854987801998111, ; 124: Mapsui.Tiling => 0x45f4b6e76031b31f => 60
	i64 5098983611934048327, ; 125: Google.Cloud.Location => 0x46c33a9458de0047 => 47
	i64 5103417709280584325, ; 126: System.Collections.Specialized => 0x46d2fb5e161b6285 => 132
	i64 5182934613077526976, ; 127: System.Collections.Specialized.dll => 0x47ed7b91fa9009c0 => 132
	i64 5203618020066742981, ; 128: Xamarin.Essentials => 0x4836f704f0e652c5 => 122
	i64 5290786973231294105, ; 129: System.Runtime.Loader => 0x496ca6b869b72699 => 179
	i64 5306356071055648198, ; 130: Svg.Model.dll => 0x49a3f6bb7b0265c6 => 88
	i64 5423376490970181369, ; 131: System.Runtime.InteropServices.RuntimeInformation => 0x4b43b42f2b7b6ef9 => 177
	i64 5446034149219586269, ; 132: System.Diagnostics.Debug => 0x4b94333452e150dd => 140
	i64 5471532531798518949, ; 133: sv\Microsoft.Maui.Controls.resources => 0x4beec9d926d82ca5 => 26
	i64 5507995362134886206, ; 134: System.Core.dll => 0x4c705499688c873e => 138
	i64 5522859530602327440, ; 135: uk\Microsoft.Maui.Controls.resources => 0x4ca5237b51eead90 => 29
	i64 5570799893513421663, ; 136: System.IO.Compression.Brotli => 0x4d4f74fcdfa6c35f => 147
	i64 5573260873512690141, ; 137: System.Security.Cryptography.dll => 0x4d58333c6e4ea1dd => 188
	i64 5650097808083101034, ; 138: System.Security.Cryptography.Algorithms.dll => 0x4e692e055d01a56a => 185
	i64 5665389054145784248, ; 139: Google.Apis.Core => 0x4e9f815406bee9b8 => 44
	i64 5692067934154308417, ; 140: Xamarin.AndroidX.ViewPager2.dll => 0x4efe49a0d4a8bb41 => 121
	i64 5979151488806146654, ; 141: System.Formats.Asn1 => 0x52fa3699a489d25e => 146
	i64 5984759512290286505, ; 142: System.Security.Cryptography.Primitives => 0x530e23115c33dba9 => 186
	i64 5992211918892661412, ; 143: running-club => 0x53289cfdfc757aa4 => 126
	i64 6068057819846744445, ; 144: ro/Microsoft.Maui.Controls.resources.dll => 0x5436126fec7f197d => 23
	i64 6200764641006662125, ; 145: ro\Microsoft.Maui.Controls.resources => 0x560d8a96830131ed => 23
	i64 6218967553231149354, ; 146: Firebase.Auth.dll => 0x564e360a4805d92a => 37
	i64 6222399776351216807, ; 147: System.Text.Json.dll => 0x565a67a0ffe264a7 => 193
	i64 6284145129771520194, ; 148: System.Reflection.Emit.ILGeneration => 0x5735c4b3610850c2 => 171
	i64 6354612700029906737, ; 149: ShimSkiaSharp.dll => 0x58301e951e77ef31 => 80
	i64 6357457916754632952, ; 150: _Microsoft.Android.Resource.Designer => 0x583a3a4ac2a7a0f8 => 34
	i64 6363787360044722189, ; 151: ShimSkiaSharp => 0x5850b6e31d96280d => 80
	i64 6401687960814735282, ; 152: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0x58d75d486341cfb2 => 108
	i64 6478287442656530074, ; 153: hr\Microsoft.Maui.Controls.resources => 0x59e7801b0c6a8e9a => 11
	i64 6504860066809920875, ; 154: Xamarin.AndroidX.Browser.dll => 0x5a45e7c43bd43d6b => 98
	i64 6548213210057960872, ; 155: Xamarin.AndroidX.CustomView.dll => 0x5adfed387b066da8 => 104
	i64 6560151584539558821, ; 156: Microsoft.Extensions.Options => 0x5b0a571be53243a5 => 68
	i64 6617685658146568858, ; 157: System.Text.Encoding.CodePages => 0x5bd6be0b4905fa9a => 189
	i64 6671798237668743565, ; 158: SkiaSharp => 0x5c96fd260152998d => 81
	i64 6743165466166707109, ; 159: nl\Microsoft.Maui.Controls.resources => 0x5d948943c08c43a5 => 19
	i64 6777482997383978746, ; 160: pt/Microsoft.Maui.Controls.resources.dll => 0x5e0e74e0a2525efa => 22
	i64 6786606130239981554, ; 161: System.Diagnostics.TraceSource => 0x5e2ede51877147f2 => 143
	i64 6814185388980153342, ; 162: System.Xml.XDocument.dll => 0x5e90d98217d1abfe => 203
	i64 6876862101832370452, ; 163: System.Xml.Linq => 0x5f6f85a57d108914 => 201
	i64 6894844156784520562, ; 164: System.Numerics.Vectors => 0x5faf683aead1ad72 => 165
	i64 6987056692196838363, ; 165: System.Management => 0x60f7030ae3e88bdb => 92
	i64 7083547580668757502, ; 166: System.Private.Xml.Linq.dll => 0x624dd0fe8f56c5fe => 169
	i64 7220009545223068405, ; 167: sv/Microsoft.Maui.Controls.resources.dll => 0x6432a06d99f35af5 => 26
	i64 7270811800166795866, ; 168: System.Linq => 0x64e71ccf51a90a5a => 152
	i64 7314237870106916923, ; 169: SkiaSharp.Views.Maui.Core.dll => 0x65816497226eb83b => 86
	i64 7338192458477945005, ; 170: System.Reflection => 0x65d67f295d0740ad => 175
	i64 7377312882064240630, ; 171: System.ComponentModel.TypeConverter.dll => 0x66617afac45a2ff6 => 135
	i64 7488575175965059935, ; 172: System.Xml.Linq.dll => 0x67ecc3724534ab5f => 201
	i64 7489048572193775167, ; 173: System.ObjectModel => 0x67ee71ff6b419e3f => 167
	i64 7592577537120840276, ; 174: System.Diagnostics.Process => 0x695e410af5b2aa54 => 142
	i64 7602111570124318452, ; 175: System.Reactive => 0x698020320025a6f4 => 93
	i64 7621211152690795761, ; 176: Google.LongRunning.dll => 0x69c3fb2a1a6154f1 => 48
	i64 7637365915383206639, ; 177: Xamarin.Essentials.dll => 0x69fd5fd5e61792ef => 122
	i64 7654504624184590948, ; 178: System.Net.Http => 0x6a3a4366801b8264 => 154
	i64 7708790323521193081, ; 179: ms/Microsoft.Maui.Controls.resources.dll => 0x6afb1ff4d1730479 => 17
	i64 7714652370974252055, ; 180: System.Private.CoreLib => 0x6b0ff375198b9c17 => 209
	i64 7723873813026311384, ; 181: SkiaSharp.Views.Maui.Controls.dll => 0x6b30b64f63600cd8 => 84
	i64 7735176074855944702, ; 182: Microsoft.CSharp => 0x6b58dda848e391fe => 127
	i64 7735352534559001595, ; 183: Xamarin.Kotlin.StdLib.dll => 0x6b597e2582ce8bfb => 124
	i64 7740912860115050295, ; 184: Google.Api.CommonProtos => 0x6b6d3f3bb0691f37 => 39
	i64 7792632648484821929, ; 185: Topten.RichTextKit.dll => 0x6c24fe1b4e0c9ba9 => 94
	i64 7836164640616011524, ; 186: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x6cbfa6390d64d704 => 97
	i64 7843473411302439824, ; 187: Google.LongRunning => 0x6cd99d82d5e73b90 => 48
	i64 7927939710195668715, ; 188: SkiaSharp.Views.Android.dll => 0x6e05b32992ed16eb => 83
	i64 8064050204834738623, ; 189: System.Collections.dll => 0x6fe942efa61731bf => 133
	i64 8083354569033831015, ; 190: Xamarin.AndroidX.Lifecycle.Common.dll => 0x702dd82730cad267 => 107
	i64 8087206902342787202, ; 191: System.Diagnostics.DiagnosticSource => 0x703b87d46f3aa082 => 141
	i64 8113615946733131500, ; 192: System.Reflection.Extensions => 0x70995ab73cf916ec => 173
	i64 8167236081217502503, ; 193: Java.Interop.dll => 0x7157d9f1a9b8fd27 => 210
	i64 8185542183669246576, ; 194: System.Collections => 0x7198e33f4794aa70 => 133
	i64 8246048515196606205, ; 195: Microsoft.Maui.Graphics.dll => 0x726fd96f64ee56fd => 75
	i64 8264926008854159966, ; 196: System.Diagnostics.Process.dll => 0x72b2ea6a64a3a25e => 142
	i64 8293702073711834350, ; 197: System.Linq.Async => 0x731926181883b4ee => 91
	i64 8357409459873968396, ; 198: Mapsui.Nts => 0x73fb7b9fd246f10c => 58
	i64 8368701292315763008, ; 199: System.Security.Cryptography => 0x7423997c6fd56140 => 188
	i64 8400357532724379117, ; 200: Xamarin.AndroidX.Navigation.UI.dll => 0x749410ab44503ded => 115
	i64 8410671156615598628, ; 201: System.Reflection.Emit.Lightweight.dll => 0x74b8b4daf4b25224 => 172
	i64 8518412311883997971, ; 202: System.Collections.Immutable => 0x76377add7c28e313 => 130
	i64 8563666267364444763, ; 203: System.Private.Uri => 0x76d841191140ca5b => 168
	i64 8614108721271900878, ; 204: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x778b763e14018ace => 21
	i64 8626175481042262068, ; 205: Java.Interop => 0x77b654e585b55834 => 210
	i64 8638972117149407195, ; 206: Microsoft.CSharp.dll => 0x77e3cb5e8b31d7db => 127
	i64 8639588376636138208, ; 207: Xamarin.AndroidX.Navigation.Runtime => 0x77e5fbdaa2fda2e0 => 114
	i64 8677882282824630478, ; 208: pt-BR\Microsoft.Maui.Controls.resources => 0x786e07f5766b00ce => 21
	i64 8685687024490312494, ; 209: Google.Api.Gax.Grpc => 0x7889c2547cf6f32e => 41
	i64 8702320156596882678, ; 210: Firebase.dll => 0x78c4da1357adccf6 => 38
	i64 8725526185868997716, ; 211: System.Diagnostics.DiagnosticSource.dll => 0x79174bd613173454 => 141
	i64 8834232125107082525, ; 212: ExCSS => 0x7a997f4fe05a151d => 36
	i64 8941376889969657626, ; 213: System.Xml.XDocument => 0x7c1626e87187471a => 203
	i64 9018325420426354176, ; 214: Topten.RichTextKit => 0x7d27873051635e00 => 94
	i64 9045785047181495996, ; 215: zh-HK\Microsoft.Maui.Controls.resources => 0x7d891592e3cb0ebc => 31
	i64 9057635389615298436, ; 216: LiteDB => 0x7db32f65bf06d784 => 55
	i64 9119672718617465806, ; 217: Mapsui.Rendering.Skia => 0x7e8f9604fd03d3ce => 59
	i64 9248940107580716988, ; 218: Svg.Custom.dll => 0x805ad6065d3637bc => 87
	i64 9286291782727338381, ; 219: running-club.dll => 0x80df892cee17898d => 126
	i64 9296667808972889535, ; 220: LiteDB.dll => 0x8104661dcca35dbf => 55
	i64 9312692141327339315, ; 221: Xamarin.AndroidX.ViewPager2 => 0x813d54296a634f33 => 121
	i64 9324707631942237306, ; 222: Xamarin.AndroidX.AppCompat => 0x8168042fd44a7c7a => 96
	i64 9324884822702401407, ; 223: NetTopologySuite.IO.GeoJSON4STJ.dll => 0x8168a557449ba77f => 78
	i64 9404599086328396064, ; 224: Grpc.Net.Client.dll => 0x8283d90a93913920 => 52
	i64 9659729154652888475, ; 225: System.Text.RegularExpressions => 0x860e407c9991dd9b => 194
	i64 9662334977499516867, ; 226: System.Numerics.dll => 0x8617827802b0cfc3 => 166
	i64 9678050649315576968, ; 227: Xamarin.AndroidX.CoordinatorLayout.dll => 0x864f57c9feb18c88 => 101
	i64 9702891218465930390, ; 228: System.Collections.NonGeneric.dll => 0x86a79827b2eb3c96 => 131
	i64 9808709177481450983, ; 229: Mono.Android.dll => 0x881f890734e555e7 => 212
	i64 9933555792566666578, ; 230: System.Linq.Queryable.dll => 0x89db145cf475c552 => 151
	i64 9956195530459977388, ; 231: Microsoft.Maui => 0x8a2b8315b36616ac => 73
	i64 9959489431142554298, ; 232: System.CodeDom => 0x8a3736deb7825aba => 90
	i64 9991543690424095600, ; 233: es/Microsoft.Maui.Controls.resources.dll => 0x8aa9180c89861370 => 6
	i64 10038780035334861115, ; 234: System.Net.Http.dll => 0x8b50e941206af13b => 154
	i64 10051358222726253779, ; 235: System.Private.Xml => 0x8b7d990c97ccccd3 => 170
	i64 10051920404523413229, ; 236: Grpc.Net.Common => 0x8b7f9859be1e6eed => 53
	i64 10077284195238799794, ; 237: BruTile.dll => 0x8bd9b49575dde9b2 => 35
	i64 10092835686693276772, ; 238: Microsoft.Maui.Controls => 0x8c10f49539bd0c64 => 71
	i64 10143853363526200146, ; 239: da\Microsoft.Maui.Controls.resources => 0x8cc634e3c2a16b52 => 3
	i64 10144742755892837524, ; 240: Firebase => 0x8cc95dc98eb5bc94 => 38
	i64 10229024438826829339, ; 241: Xamarin.AndroidX.CustomView => 0x8df4cb880b10061b => 104
	i64 10236703004850800690, ; 242: System.Net.ServicePoint.dll => 0x8e101325834e4832 => 161
	i64 10245369515835430794, ; 243: System.Reflection.Emit.Lightweight => 0x8e2edd4ad7fc978a => 172
	i64 10282208442277544177, ; 244: Google.Cloud.Firestore.V1 => 0x8eb1be19cc79c0f1 => 46
	i64 10360651442923773544, ; 245: System.Text.Encoding => 0x8fc86d98211c1e68 => 191
	i64 10364469296367737616, ; 246: System.Reflection.Emit.ILGeneration.dll => 0x8fd5fde967711b10 => 171
	i64 10406448008575299332, ; 247: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x906b2153fcb3af04 => 125
	i64 10430153318873392755, ; 248: Xamarin.AndroidX.Core => 0x90bf592ea44f6673 => 102
	i64 10447083246144586668, ; 249: Microsoft.Bcl.AsyncInterfaces.dll => 0x90fb7edc816203ac => 61
	i64 10506226065143327199, ; 250: ca\Microsoft.Maui.Controls.resources => 0x91cd9cf11ed169df => 1
	i64 10785150219063592792, ; 251: System.Net.Primitives => 0x95ac8cfb68830758 => 158
	i64 10822644899632537592, ; 252: System.Linq.Queryable => 0x9631c23204ca5ff8 => 151
	i64 10823124638835005028, ; 253: Google.Api.Gax.dll => 0x963376840189d664 => 40
	i64 10854473764158213966, ; 254: Grpc.Core.Api.dll => 0x96a2d66108728f4e => 51
	i64 10953751836886437922, ; 255: System.Linq.Async.dll => 0x98038b429b661022 => 91
	i64 11002576679268595294, ; 256: Microsoft.Extensions.Logging.Abstractions => 0x98b1013215cd365e => 67
	i64 11009005086950030778, ; 257: Microsoft.Maui.dll => 0x98c7d7cc621ffdba => 73
	i64 11023048688141570732, ; 258: System.Core => 0x98f9bc61168392ac => 138
	i64 11103970607964515343, ; 259: hu\Microsoft.Maui.Controls.resources => 0x9a193a6fc41a6c0f => 12
	i64 11162124722117608902, ; 260: Xamarin.AndroidX.ViewPager => 0x9ae7d54b986d05c6 => 120
	i64 11216600183782743182, ; 261: Svg.Model => 0x9ba95e7065f39c8e => 88
	i64 11220793807500858938, ; 262: ja\Microsoft.Maui.Controls.resources => 0x9bb8448481fdd63a => 15
	i64 11226290749488709958, ; 263: Microsoft.Extensions.Options.dll => 0x9bcbcbf50c874146 => 68
	i64 11326322297822330275, ; 264: Google.Cloud.Firestore => 0x9d2f2e1ed5493da3 => 45
	i64 11340910727871153756, ; 265: Xamarin.AndroidX.CursorAdapter => 0x9d630238642d465c => 103
	i64 11347436699239206956, ; 266: System.Xml.XmlSerializer.dll => 0x9d7a318e8162502c => 205
	i64 11428185064259490994, ; 267: Mapsui.UI.Maui.dll => 0x9e9911c44e9c94b2 => 57
	i64 11435314654401632883, ; 268: Grpc.Core.Api => 0x9eb266175e6d9a73 => 51
	i64 11441445377436144712, ; 269: Grpc.Net.Common.dll => 0x9ec82df38f1dd448 => 53
	i64 11478254788954680069, ; 270: NetTopologySuite.Features => 0x9f4af3ea8911eb05 => 77
	i64 11485890710487134646, ; 271: System.Runtime.InteropServices => 0x9f6614bf0f8b71b6 => 178
	i64 11518296021396496455, ; 272: id\Microsoft.Maui.Controls.resources => 0x9fd9353475222047 => 13
	i64 11529969570048099689, ; 273: Xamarin.AndroidX.ViewPager.dll => 0xa002ae3c4dc7c569 => 120
	i64 11530571088791430846, ; 274: Microsoft.Extensions.Logging => 0xa004d1504ccd66be => 66
	i64 11543207250219725293, ; 275: Grpc.Net.Client => 0xa031b5d5e60f71ed => 52
	i64 11597940890313164233, ; 276: netstandard => 0xa0f429ca8d1805c9 => 208
	i64 11705530742807338875, ; 277: he/Microsoft.Maui.Controls.resources.dll => 0xa272663128721f7b => 9
	i64 11743665907891708234, ; 278: System.Threading.Tasks => 0xa2f9e1ec30c0214a => 197
	i64 12040886584167504988, ; 279: System.Net.ServicePoint => 0xa719d28d8e121c5c => 161
	i64 12102847907131387746, ; 280: System.Buffers => 0xa7f5f40c43256f62 => 128
	i64 12123043025855404482, ; 281: System.Reflection.Extensions.dll => 0xa83db366c0e359c2 => 173
	i64 12145679461940342714, ; 282: System.Text.Json => 0xa88e1f1ebcb62fba => 193
	i64 12201331334810686224, ; 283: System.Runtime.Serialization.Primitives.dll => 0xa953d6341e3bd310 => 182
	i64 12247834191021032507, ; 284: NetTopologySuite.Features.dll => 0xa9f90c4e0fb1443b => 77
	i64 12269460666702402136, ; 285: System.Collections.Immutable.dll => 0xaa45e178506c9258 => 130
	i64 12437742355241350664, ; 286: Google.Apis.dll => 0xac9bbcc62bfdb608 => 42
	i64 12451044538927396471, ; 287: Xamarin.AndroidX.Fragment.dll => 0xaccaff0a2955b677 => 106
	i64 12466513435562512481, ; 288: Xamarin.AndroidX.Loader.dll => 0xad01f3eb52569061 => 111
	i64 12475113361194491050, ; 289: _Microsoft.Android.Resource.Designer.dll => 0xad2081818aba1caa => 34
	i64 12517810545449516888, ; 290: System.Diagnostics.TraceSource.dll => 0xadb8325e6f283f58 => 143
	i64 12528155905152483962, ; 291: Firebase.Auth => 0xaddcf36b3153827a => 37
	i64 12538491095302438457, ; 292: Xamarin.AndroidX.CardView.dll => 0xae01ab382ae67e39 => 99
	i64 12550732019250633519, ; 293: System.IO.Compression => 0xae2d28465e8e1b2f => 148
	i64 12681088699309157496, ; 294: it/Microsoft.Maui.Controls.resources.dll => 0xaffc46fc178aec78 => 14
	i64 12700543734426720211, ; 295: Xamarin.AndroidX.Collection => 0xb041653c70d157d3 => 100
	i64 12708922737231849740, ; 296: System.Text.Encoding.Extensions => 0xb05f29e50e96e90c => 190
	i64 12823819093633476069, ; 297: th/Microsoft.Maui.Controls.resources.dll => 0xb1f75b85abe525e5 => 27
	i64 12835242264250840079, ; 298: System.IO.Pipes => 0xb21ff0d5d6c0740f => 149
	i64 12843321153144804894, ; 299: Microsoft.Extensions.Primitives => 0xb23ca48abd74d61e => 69
	i64 12859557719246324186, ; 300: System.Net.WebHeaderCollection.dll => 0xb276539ce04f41da => 163
	i64 12958614573187252691, ; 301: Google.Apis => 0xb3d63f4bf006c1d3 => 42
	i64 13068258254871114833, ; 302: System.Runtime.Serialization.Formatters.dll => 0xb55bc7a4eaa8b451 => 181
	i64 13106026140046202731, ; 303: HarfBuzzSharp.dll => 0xb5e1f555ee70176b => 54
	i64 13221551921002590604, ; 304: ca/Microsoft.Maui.Controls.resources.dll => 0xb77c636bdebe318c => 1
	i64 13222659110913276082, ; 305: ja/Microsoft.Maui.Controls.resources.dll => 0xb78052679c1178b2 => 15
	i64 13343850469010654401, ; 306: Mono.Android.Runtime.dll => 0xb92ee14d854f44c1 => 211
	i64 13381594904270902445, ; 307: he\Microsoft.Maui.Controls.resources => 0xb9b4f9aaad3e94ad => 9
	i64 13465488254036897740, ; 308: Xamarin.Kotlin.StdLib => 0xbadf06394d106fcc => 124
	i64 13467053111158216594, ; 309: uk/Microsoft.Maui.Controls.resources.dll => 0xbae49573fde79792 => 29
	i64 13540124433173649601, ; 310: vi\Microsoft.Maui.Controls.resources => 0xbbe82f6eede718c1 => 30
	i64 13545416393490209236, ; 311: id/Microsoft.Maui.Controls.resources.dll => 0xbbfafc7174bc99d4 => 13
	i64 13572454107664307259, ; 312: Xamarin.AndroidX.RecyclerView.dll => 0xbc5b0b19d99f543b => 116
	i64 13578472628727169633, ; 313: System.Xml.XPath => 0xbc706ce9fba5c261 => 204
	i64 13646648927693774012, ; 314: BruTile => 0xbd62a2e58da71cbc => 35
	i64 13717397318615465333, ; 315: System.ComponentModel.Primitives.dll => 0xbe5dfc2ef2f87d75 => 134
	i64 13755568601956062840, ; 316: fr/Microsoft.Maui.Controls.resources.dll => 0xbee598c36b1b9678 => 8
	i64 13782512541859110153, ; 317: Google.Apis.Auth.dll => 0xbf45522249e0dd09 => 43
	i64 13814445057219246765, ; 318: hr/Microsoft.Maui.Controls.resources.dll => 0xbfb6c49664b43aad => 11
	i64 13881769479078963060, ; 319: System.Console.dll => 0xc0a5f3cade5c6774 => 137
	i64 13929311175625981361, ; 320: Mapsui.UI.Maui => 0xc14edab6ad10bdb1 => 57
	i64 13959074834287824816, ; 321: Xamarin.AndroidX.Fragment => 0xc1b8989a7ad20fb0 => 106
	i64 14100563506285742564, ; 322: da/Microsoft.Maui.Controls.resources.dll => 0xc3af43cd0cff89e4 => 3
	i64 14124974489674258913, ; 323: Xamarin.AndroidX.CardView => 0xc405fd76067d19e1 => 99
	i64 14125464355221830302, ; 324: System.Threading.dll => 0xc407bafdbc707a9e => 199
	i64 14254574811015963973, ; 325: System.Text.Encoding.Extensions.dll => 0xc5d26c4442d66545 => 190
	i64 14327695147300244862, ; 326: System.Reflection.dll => 0xc6d632d338eb4d7e => 175
	i64 14327709162229390963, ; 327: System.Security.Cryptography.X509Certificates => 0xc6d63f9253cade73 => 187
	i64 14461014870687870182, ; 328: System.Net.Requests.dll => 0xc8afd8683afdece6 => 159
	i64 14464374589798375073, ; 329: ru\Microsoft.Maui.Controls.resources => 0xc8bbc80dcb1e5ea1 => 24
	i64 14522721392235705434, ; 330: el/Microsoft.Maui.Controls.resources.dll => 0xc98b12295c2cf45a => 5
	i64 14551742072151931844, ; 331: System.Text.Encodings.Web.dll => 0xc9f22c50f1b8fbc4 => 192
	i64 14552901170081803662, ; 332: SkiaSharp.Views.Maui.Core => 0xc9f64a827617ad8e => 86
	i64 14561513370130550166, ; 333: System.Security.Cryptography.Primitives.dll => 0xca14e3428abb8d96 => 186
	i64 14622043554576106986, ; 334: System.Runtime.Serialization.Formatters => 0xcaebef2458cc85ea => 181
	i64 14641944974530824122, ; 335: Mapsui => 0xcb32a360c3b9c7ba => 56
	i64 14650706219563630045, ; 336: Grpc.Auth => 0xcb51c3af15b23ddd => 50
	i64 14669215534098758659, ; 337: Microsoft.Extensions.DependencyInjection.dll => 0xcb9385ceb3993c03 => 64
	i64 14690985099581930927, ; 338: System.Web.HttpUtility => 0xcbe0dd1ca5233daf => 200
	i64 14705122255218365489, ; 339: ko\Microsoft.Maui.Controls.resources => 0xcc1316c7b0fb5431 => 16
	i64 14744092281598614090, ; 340: zh-Hans\Microsoft.Maui.Controls.resources => 0xcc9d89d004439a4a => 32
	i64 14832630590065248058, ; 341: System.Security.Claims => 0xcdd816ef5d6e873a => 184
	i64 14852515768018889994, ; 342: Xamarin.AndroidX.CursorAdapter.dll => 0xce1ebc6625a76d0a => 103
	i64 14892012299694389861, ; 343: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xceab0e490a083a65 => 33
	i64 14904040806490515477, ; 344: ar\Microsoft.Maui.Controls.resources => 0xced5ca2604cb2815 => 0
	i64 14931407803744742450, ; 345: HarfBuzzSharp => 0xcf3704499ab36c32 => 54
	i64 14935719434541007538, ; 346: System.Text.Encoding.CodePages.dll => 0xcf4655b160b702b2 => 189
	i64 14954917835170835695, ; 347: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xcf8a8a895a82ecef => 65
	i64 14984936317414011727, ; 348: System.Net.WebHeaderCollection => 0xcff5302fe54ff34f => 163
	i64 14987728460634540364, ; 349: System.IO.Compression.dll => 0xcfff1ba06622494c => 148
	i64 15015154896917945444, ; 350: System.Net.Security.dll => 0xd0608bd33642dc64 => 160
	i64 15076659072870671916, ; 351: System.ObjectModel.dll => 0xd13b0d8c1620662c => 167
	i64 15097078878581906526, ; 352: Google.Api.Gax.Grpc.dll => 0xd183994097ed5c5e => 41
	i64 15111608613780139878, ; 353: ms\Microsoft.Maui.Controls.resources => 0xd1b737f831192f66 => 17
	i64 15115185479366240210, ; 354: System.IO.Compression.Brotli.dll => 0xd1c3ed1c1bc467d2 => 147
	i64 15133485256822086103, ; 355: System.Linq.dll => 0xd204f0a9127dd9d7 => 152
	i64 15227001540531775957, ; 356: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd3512d3999b8e9d5 => 63
	i64 15299439993936780255, ; 357: System.Xml.XPath.dll => 0xd452879d55019bdf => 204
	i64 15370334346939861994, ; 358: Xamarin.AndroidX.Core.dll => 0xd54e65a72c560bea => 102
	i64 15391712275433856905, ; 359: Microsoft.Extensions.DependencyInjection.Abstractions => 0xd59a58c406411f89 => 65
	i64 15526743539506359484, ; 360: System.Text.Encoding.dll => 0xd77a12fc26de2cbc => 191
	i64 15527772828719725935, ; 361: System.Console => 0xd77dbb1e38cd3d6f => 137
	i64 15530465045505749832, ; 362: System.Net.HttpListener.dll => 0xd7874bacc9fdb348 => 155
	i64 15536481058354060254, ; 363: de\Microsoft.Maui.Controls.resources => 0xd79cab34eec75bde => 4
	i64 15541854775306130054, ; 364: System.Security.Cryptography.X509Certificates.dll => 0xd7afc292e8d49286 => 187
	i64 15557562860424774966, ; 365: System.Net.Sockets => 0xd7e790fe7a6dc536 => 162
	i64 15582737692548360875, ; 366: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xd841015ed86f6aab => 110
	i64 15609085926864131306, ; 367: System.dll => 0xd89e9cf3334914ea => 206
	i64 15661133872274321916, ; 368: System.Xml.ReaderWriter.dll => 0xd9578647d4bfb1fc => 202
	i64 15664356999916475676, ; 369: de/Microsoft.Maui.Controls.resources.dll => 0xd962f9b2b6ecd51c => 4
	i64 15743187114543869802, ; 370: hu/Microsoft.Maui.Controls.resources.dll => 0xda7b09450ae4ef6a => 12
	i64 15783653065526199428, ; 371: el\Microsoft.Maui.Controls.resources => 0xdb0accd674b1c484 => 5
	i64 15817206913877585035, ; 372: System.Threading.Tasks.dll => 0xdb8201e29086ac8b => 197
	i64 15847085070278954535, ; 373: System.Threading.Channels.dll => 0xdbec27e8f35f8e27 => 195
	i64 15928521404965645318, ; 374: Microsoft.Maui.Controls.Compatibility => 0xdd0d79d32c2eec06 => 70
	i64 15963349826457351533, ; 375: System.Threading.Tasks.Extensions => 0xdd893616f748b56d => 196
	i64 16018552496348375205, ; 376: System.Net.NetworkInformation.dll => 0xde4d54a020caa8a5 => 157
	i64 16154507427712707110, ; 377: System => 0xe03056ea4e39aa26 => 206
	i64 16219561732052121626, ; 378: System.Net.Security => 0xe1177575db7c781a => 160
	i64 16288847719894691167, ; 379: nb\Microsoft.Maui.Controls.resources => 0xe20d9cb300c12d5f => 18
	i64 16321164108206115771, ; 380: Microsoft.Extensions.Logging.Abstractions.dll => 0xe2806c487e7b0bbb => 67
	i64 16324796876805858114, ; 381: SkiaSharp.dll => 0xe28d5444586b6342 => 81
	i64 16454459195343277943, ; 382: System.Net.NetworkInformation => 0xe459fb756d988f77 => 157
	i64 16649148416072044166, ; 383: Microsoft.Maui.Graphics => 0xe70da84600bb4e86 => 75
	i64 16677317093839702854, ; 384: Xamarin.AndroidX.Navigation.UI => 0xe771bb8960dd8b46 => 115
	i64 16833383113903931215, ; 385: mscorlib => 0xe99c30c1484d7f4f => 207
	i64 16856067890322379635, ; 386: System.Data.Common.dll => 0xe9ecc87060889373 => 139
	i64 16890310621557459193, ; 387: System.Text.RegularExpressions.dll => 0xea66700587f088f9 => 194
	i64 16933958494752847024, ; 388: System.Net.WebProxy.dll => 0xeb018187f0f3b4b0 => 164
	i64 16942731696432749159, ; 389: sk\Microsoft.Maui.Controls.resources => 0xeb20acb622a01a67 => 25
	i64 16955525858597485057, ; 390: Google.Api.Gax => 0xeb4e20ef25a73a01 => 40
	i64 16991533501433402966, ; 391: Google.Api.CommonProtos.dll => 0xebce0db1ce165656 => 39
	i64 16998075588627545693, ; 392: Xamarin.AndroidX.Navigation.Fragment => 0xebe54bb02d623e5d => 113
	i64 17008137082415910100, ; 393: System.Collections.NonGeneric => 0xec090a90408c8cd4 => 131
	i64 17031351772568316411, ; 394: Xamarin.AndroidX.Navigation.Common.dll => 0xec5b843380a769fb => 112
	i64 17062143951396181894, ; 395: System.ComponentModel.Primitives => 0xecc8e986518c9786 => 134
	i64 17084484735261948889, ; 396: NetTopologySuite.IO.GeoJSON4STJ => 0xed18485967df3bd9 => 78
	i64 17089008752050867324, ; 397: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xed285aeb25888c7c => 32
	i64 17118171214553292978, ; 398: System.Threading.Channels => 0xed8ff6060fc420b2 => 195
	i64 17230721278011714856, ; 399: System.Private.Xml.Linq => 0xef1fd1b5c7a72d28 => 169
	i64 17260702271250283638, ; 400: System.Data.Common => 0xef8a5543bba6bc76 => 139
	i64 17342750010158924305, ; 401: hi\Microsoft.Maui.Controls.resources => 0xf0add33f97ecc211 => 10
	i64 17438153253682247751, ; 402: sk/Microsoft.Maui.Controls.resources.dll => 0xf200c3fe308d7847 => 25
	i64 17452310354824359952, ; 403: Mapsui.Tiling.dll => 0xf2330fcd292d7010 => 60
	i64 17514990004910432069, ; 404: fr\Microsoft.Maui.Controls.resources => 0xf311be9c6f341f45 => 8
	i64 17553799493972570483, ; 405: Google.Protobuf.dll => 0xf39b9fa2c0aab173 => 49
	i64 17623389608345532001, ; 406: pl\Microsoft.Maui.Controls.resources => 0xf492db79dfbef661 => 20
	i64 17671790519499593115, ; 407: SkiaSharp.Views.Android => 0xf53ecfd92be3959b => 83
	i64 17685921127322830888, ; 408: System.Diagnostics.Debug.dll => 0xf571038fafa74828 => 140
	i64 17702523067201099846, ; 409: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xf5abfef008ae1846 => 31
	i64 17704177640604968747, ; 410: Xamarin.AndroidX.Loader => 0xf5b1dfc36cac272b => 111
	i64 17710060891934109755, ; 411: Xamarin.AndroidX.Lifecycle.ViewModel => 0xf5c6c68c9e45303b => 109
	i64 17712670374920797664, ; 412: System.Runtime.InteropServices.dll => 0xf5d00bdc38bd3de0 => 178
	i64 17743407583038752114, ; 413: System.CodeDom.dll => 0xf63d3f302bff4572 => 90
	i64 17777860260071588075, ; 414: System.Runtime.Numerics.dll => 0xf6b7a5b72419c0eb => 180
	i64 17838668724098252521, ; 415: System.Buffers.dll => 0xf78faeb0f5bf3ee9 => 128
	i64 18025913125965088385, ; 416: System.Threading => 0xfa28e87b91334681 => 199
	i64 18096531542100961995, ; 417: NetTopologySuite.dll => 0xfb23cb8ed9946acb => 76
	i64 18099568558057551825, ; 418: nl/Microsoft.Maui.Controls.resources.dll => 0xfb2e95b53ad977d1 => 19
	i64 18121036031235206392, ; 419: Xamarin.AndroidX.Navigation.Common => 0xfb7ada42d3d42cf8 => 112
	i64 18132221390331549284, ; 420: SkiaSharp.Views.Maui.Controls.Compatibility => 0xfba297492f739664 => 85
	i64 18146411883821974900, ; 421: System.Formats.Asn1.dll => 0xfbd50176eb22c574 => 146
	i64 18245806341561545090, ; 422: System.Collections.Concurrent.dll => 0xfd3620327d587182 => 129
	i64 18305135509493619199, ; 423: Xamarin.AndroidX.Navigation.Runtime.dll => 0xfe08e7c2d8c199ff => 114
	i64 18324163916253801303, ; 424: it\Microsoft.Maui.Controls.resources => 0xfe4c81ff0a56ab57 => 14
	i64 18421022575907732603 ; 425: Mapsui.dll => 0xffa49e6f1c6e7c7b => 56
], align 16

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [426 x i32] [
	i32 36, ; 0
	i32 47, ; 1
	i32 69, ; 2
	i32 212, ; 3
	i32 74, ; 4
	i32 89, ; 5
	i32 150, ; 6
	i32 100, ; 7
	i32 117, ; 8
	i32 87, ; 9
	i32 118, ; 10
	i32 93, ; 11
	i32 92, ; 12
	i32 7, ; 13
	i32 58, ; 14
	i32 174, ; 15
	i32 198, ; 16
	i32 136, ; 17
	i32 10, ; 18
	i32 105, ; 19
	i32 174, ; 20
	i32 123, ; 21
	i32 18, ; 22
	i32 145, ; 23
	i32 113, ; 24
	i32 158, ; 25
	i32 71, ; 26
	i32 155, ; 27
	i32 211, ; 28
	i32 198, ; 29
	i32 16, ; 30
	i32 97, ; 31
	i32 110, ; 32
	i32 79, ; 33
	i32 153, ; 34
	i32 168, ; 35
	i32 49, ; 36
	i32 96, ; 37
	i32 177, ; 38
	i32 6, ; 39
	i32 117, ; 40
	i32 61, ; 41
	i32 144, ; 42
	i32 28, ; 43
	i32 118, ; 44
	i32 72, ; 45
	i32 28, ; 46
	i32 185, ; 47
	i32 109, ; 48
	i32 2, ; 49
	i32 20, ; 50
	i32 196, ; 51
	i32 144, ; 52
	i32 76, ; 53
	i32 79, ; 54
	i32 98, ; 55
	i32 82, ; 56
	i32 105, ; 57
	i32 129, ; 58
	i32 24, ; 59
	i32 108, ; 60
	i32 192, ; 61
	i32 176, ; 62
	i32 45, ; 63
	i32 101, ; 64
	i32 183, ; 65
	i32 95, ; 66
	i32 27, ; 67
	i32 207, ; 68
	i32 156, ; 69
	i32 64, ; 70
	i32 2, ; 71
	i32 176, ; 72
	i32 44, ; 73
	i32 7, ; 74
	i32 164, ; 75
	i32 123, ; 76
	i32 85, ; 77
	i32 107, ; 78
	i32 165, ; 79
	i32 180, ; 80
	i32 162, ; 81
	i32 125, ; 82
	i32 84, ; 83
	i32 74, ; 84
	i32 50, ; 85
	i32 82, ; 86
	i32 62, ; 87
	i32 119, ; 88
	i32 166, ; 89
	i32 209, ; 90
	i32 22, ; 91
	i32 183, ; 92
	i32 63, ; 93
	i32 202, ; 94
	i32 62, ; 95
	i32 89, ; 96
	i32 59, ; 97
	i32 208, ; 98
	i32 116, ; 99
	i32 66, ; 100
	i32 72, ; 101
	i32 46, ; 102
	i32 159, ; 103
	i32 153, ; 104
	i32 182, ; 105
	i32 43, ; 106
	i32 170, ; 107
	i32 70, ; 108
	i32 33, ; 109
	i32 136, ; 110
	i32 184, ; 111
	i32 150, ; 112
	i32 135, ; 113
	i32 30, ; 114
	i32 149, ; 115
	i32 200, ; 116
	i32 0, ; 117
	i32 205, ; 118
	i32 95, ; 119
	i32 119, ; 120
	i32 145, ; 121
	i32 156, ; 122
	i32 179, ; 123
	i32 60, ; 124
	i32 47, ; 125
	i32 132, ; 126
	i32 132, ; 127
	i32 122, ; 128
	i32 179, ; 129
	i32 88, ; 130
	i32 177, ; 131
	i32 140, ; 132
	i32 26, ; 133
	i32 138, ; 134
	i32 29, ; 135
	i32 147, ; 136
	i32 188, ; 137
	i32 185, ; 138
	i32 44, ; 139
	i32 121, ; 140
	i32 146, ; 141
	i32 186, ; 142
	i32 126, ; 143
	i32 23, ; 144
	i32 23, ; 145
	i32 37, ; 146
	i32 193, ; 147
	i32 171, ; 148
	i32 80, ; 149
	i32 34, ; 150
	i32 80, ; 151
	i32 108, ; 152
	i32 11, ; 153
	i32 98, ; 154
	i32 104, ; 155
	i32 68, ; 156
	i32 189, ; 157
	i32 81, ; 158
	i32 19, ; 159
	i32 22, ; 160
	i32 143, ; 161
	i32 203, ; 162
	i32 201, ; 163
	i32 165, ; 164
	i32 92, ; 165
	i32 169, ; 166
	i32 26, ; 167
	i32 152, ; 168
	i32 86, ; 169
	i32 175, ; 170
	i32 135, ; 171
	i32 201, ; 172
	i32 167, ; 173
	i32 142, ; 174
	i32 93, ; 175
	i32 48, ; 176
	i32 122, ; 177
	i32 154, ; 178
	i32 17, ; 179
	i32 209, ; 180
	i32 84, ; 181
	i32 127, ; 182
	i32 124, ; 183
	i32 39, ; 184
	i32 94, ; 185
	i32 97, ; 186
	i32 48, ; 187
	i32 83, ; 188
	i32 133, ; 189
	i32 107, ; 190
	i32 141, ; 191
	i32 173, ; 192
	i32 210, ; 193
	i32 133, ; 194
	i32 75, ; 195
	i32 142, ; 196
	i32 91, ; 197
	i32 58, ; 198
	i32 188, ; 199
	i32 115, ; 200
	i32 172, ; 201
	i32 130, ; 202
	i32 168, ; 203
	i32 21, ; 204
	i32 210, ; 205
	i32 127, ; 206
	i32 114, ; 207
	i32 21, ; 208
	i32 41, ; 209
	i32 38, ; 210
	i32 141, ; 211
	i32 36, ; 212
	i32 203, ; 213
	i32 94, ; 214
	i32 31, ; 215
	i32 55, ; 216
	i32 59, ; 217
	i32 87, ; 218
	i32 126, ; 219
	i32 55, ; 220
	i32 121, ; 221
	i32 96, ; 222
	i32 78, ; 223
	i32 52, ; 224
	i32 194, ; 225
	i32 166, ; 226
	i32 101, ; 227
	i32 131, ; 228
	i32 212, ; 229
	i32 151, ; 230
	i32 73, ; 231
	i32 90, ; 232
	i32 6, ; 233
	i32 154, ; 234
	i32 170, ; 235
	i32 53, ; 236
	i32 35, ; 237
	i32 71, ; 238
	i32 3, ; 239
	i32 38, ; 240
	i32 104, ; 241
	i32 161, ; 242
	i32 172, ; 243
	i32 46, ; 244
	i32 191, ; 245
	i32 171, ; 246
	i32 125, ; 247
	i32 102, ; 248
	i32 61, ; 249
	i32 1, ; 250
	i32 158, ; 251
	i32 151, ; 252
	i32 40, ; 253
	i32 51, ; 254
	i32 91, ; 255
	i32 67, ; 256
	i32 73, ; 257
	i32 138, ; 258
	i32 12, ; 259
	i32 120, ; 260
	i32 88, ; 261
	i32 15, ; 262
	i32 68, ; 263
	i32 45, ; 264
	i32 103, ; 265
	i32 205, ; 266
	i32 57, ; 267
	i32 51, ; 268
	i32 53, ; 269
	i32 77, ; 270
	i32 178, ; 271
	i32 13, ; 272
	i32 120, ; 273
	i32 66, ; 274
	i32 52, ; 275
	i32 208, ; 276
	i32 9, ; 277
	i32 197, ; 278
	i32 161, ; 279
	i32 128, ; 280
	i32 173, ; 281
	i32 193, ; 282
	i32 182, ; 283
	i32 77, ; 284
	i32 130, ; 285
	i32 42, ; 286
	i32 106, ; 287
	i32 111, ; 288
	i32 34, ; 289
	i32 143, ; 290
	i32 37, ; 291
	i32 99, ; 292
	i32 148, ; 293
	i32 14, ; 294
	i32 100, ; 295
	i32 190, ; 296
	i32 27, ; 297
	i32 149, ; 298
	i32 69, ; 299
	i32 163, ; 300
	i32 42, ; 301
	i32 181, ; 302
	i32 54, ; 303
	i32 1, ; 304
	i32 15, ; 305
	i32 211, ; 306
	i32 9, ; 307
	i32 124, ; 308
	i32 29, ; 309
	i32 30, ; 310
	i32 13, ; 311
	i32 116, ; 312
	i32 204, ; 313
	i32 35, ; 314
	i32 134, ; 315
	i32 8, ; 316
	i32 43, ; 317
	i32 11, ; 318
	i32 137, ; 319
	i32 57, ; 320
	i32 106, ; 321
	i32 3, ; 322
	i32 99, ; 323
	i32 199, ; 324
	i32 190, ; 325
	i32 175, ; 326
	i32 187, ; 327
	i32 159, ; 328
	i32 24, ; 329
	i32 5, ; 330
	i32 192, ; 331
	i32 86, ; 332
	i32 186, ; 333
	i32 181, ; 334
	i32 56, ; 335
	i32 50, ; 336
	i32 64, ; 337
	i32 200, ; 338
	i32 16, ; 339
	i32 32, ; 340
	i32 184, ; 341
	i32 103, ; 342
	i32 33, ; 343
	i32 0, ; 344
	i32 54, ; 345
	i32 189, ; 346
	i32 65, ; 347
	i32 163, ; 348
	i32 148, ; 349
	i32 160, ; 350
	i32 167, ; 351
	i32 41, ; 352
	i32 17, ; 353
	i32 147, ; 354
	i32 152, ; 355
	i32 63, ; 356
	i32 204, ; 357
	i32 102, ; 358
	i32 65, ; 359
	i32 191, ; 360
	i32 137, ; 361
	i32 155, ; 362
	i32 4, ; 363
	i32 187, ; 364
	i32 162, ; 365
	i32 110, ; 366
	i32 206, ; 367
	i32 202, ; 368
	i32 4, ; 369
	i32 12, ; 370
	i32 5, ; 371
	i32 197, ; 372
	i32 195, ; 373
	i32 70, ; 374
	i32 196, ; 375
	i32 157, ; 376
	i32 206, ; 377
	i32 160, ; 378
	i32 18, ; 379
	i32 67, ; 380
	i32 81, ; 381
	i32 157, ; 382
	i32 75, ; 383
	i32 115, ; 384
	i32 207, ; 385
	i32 139, ; 386
	i32 194, ; 387
	i32 164, ; 388
	i32 25, ; 389
	i32 40, ; 390
	i32 39, ; 391
	i32 113, ; 392
	i32 131, ; 393
	i32 112, ; 394
	i32 134, ; 395
	i32 78, ; 396
	i32 32, ; 397
	i32 195, ; 398
	i32 169, ; 399
	i32 139, ; 400
	i32 10, ; 401
	i32 25, ; 402
	i32 60, ; 403
	i32 8, ; 404
	i32 49, ; 405
	i32 20, ; 406
	i32 83, ; 407
	i32 140, ; 408
	i32 31, ; 409
	i32 111, ; 410
	i32 109, ; 411
	i32 178, ; 412
	i32 90, ; 413
	i32 180, ; 414
	i32 128, ; 415
	i32 199, ; 416
	i32 76, ; 417
	i32 19, ; 418
	i32 112, ; 419
	i32 85, ; 420
	i32 146, ; 421
	i32 129, ; 422
	i32 114, ; 423
	i32 14, ; 424
	i32 56 ; 425
], align 16

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 8

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 8

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
	store ptr %fn, ptr @get_function_pointer, align 8, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 16

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.2xx @ 96b6bb65e8736e45180905177aa343f0e1854ea3"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
