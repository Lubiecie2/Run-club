using Firebase.Database;
using Microsoft.Extensions.Logging;
using running_club.Pages;
using SkiaSharp.Views.Maui.Controls.Hosting;
using Microsoft.Maui.Hosting;

#if ANDROID
using running_club.Platforms.Android; // Tylko dla platformy Android
#endif

namespace running_club
{
    public static class MauiProgram
    {
        public static MauiApp CreateMauiApp()
        {
            var builder = MauiApp.CreateBuilder();

            builder
                .UseMauiApp<App>()
                .UseSkiaSharp()
                .ConfigureFonts(fonts =>
                {
                    fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                    fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
                });

#if DEBUG
            builder.Logging.AddDebug(); // Logowanie w trybie debug
#endif

#if ANDROID
builder.Services.AddSingleton<LightSensorService>(); // Rejestracja LightSensorService
#endif
            builder.Services.AddTransient<HomePage>(); // Rejestracja HomePage

            return builder.Build();
        }
    }
}
