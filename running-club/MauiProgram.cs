using Firebase.Database;
using Microsoft.Extensions.Logging;
using running_club.Pages;
using SkiaSharp.Views.Maui.Controls.Hosting;

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
        builder.Logging.AddDebug();
#endif

            //builder.Services.AddSingleton(new FirebaseClient("https://running-club-5b96d-default-rtdb.europe-west1.firebasedatabase.app/"));
           // builder.Services.AddSingleton<AddGoalsPage>();
            return builder.Build();
        }
    }
}
