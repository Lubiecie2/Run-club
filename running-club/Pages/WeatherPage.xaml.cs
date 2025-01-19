namespace running_club.Pages;
using Microsoft.Maui.Devices.Sensors;
using Newtonsoft.Json;
using WeatherApp;
using running_club.Pages;
using System.Globalization;

#if ANDROID
using running_club.Platforms.Android; 
#endif

/// @brief Klasa reprezentujaca strone pogody.
public partial class WeatherPage : ContentPage
{
    RestService _restService;
#if ANDROID
        private LightSensorService _lightSensorService;
#endif
    private bool _isWaiting = false;

    /// @brief Konstruktor klasy WeatherPage.
    public WeatherPage()
    {
        InitializeComponent();
        _restService = new RestService();
        currentDateLabel.Text = DateTime.Now.ToString("dddd, dd MMMM", new CultureInfo("pl-PL"));


#if ANDROID
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; 
    }
#endif

        
        GetWeatherForCurrentLocation();
    }

    /// @brief Funkcja generujaca zapytanie do API OpenWeatherMap.
    async void GetWeatherForCurrentLocation()
    {
        try
        {
            
            Location location = await Geolocation.GetLocationAsync(new GeolocationRequest(GeolocationAccuracy.Best, TimeSpan.FromSeconds(10)));

            if (location != null)
            {
                
                string requestUrl = GenerateRequestURL(Constants.OpenWeatherMapEndpoint, location);
                WeatherData weatherData = await _restService.GetWeatherData(requestUrl);

                
                Console.WriteLine(JsonConvert.SerializeObject(weatherData));

                
                BindingContext = weatherData;
            }
            else
            {
                await DisplayAlert("B³¹d", "Nie mo¿na uzyskaæ dostêpu do aktualnej lokalizacji.", "OK");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("B³¹d", $"Wyst¹pi³ problem: {ex.Message}", "OK");
        }
    }

    /// @brief Generuje URL zapytania do API OpenWeatherMap.
    string GenerateRequestURL(string endPoint, Location location)
    {
        string requestUri = endPoint;
        requestUri += $"?lat={location.Latitude}&lon={location.Longitude}";
        requestUri += "&units=metric"; 
        requestUri += $"&APPID={Constants.OpenWeatherMapAPIKey}";
        return requestUri;
    }
#if ANDROID
private async void OnLightLevelChanged(float lightLevel)
{
    if (_isWaiting)
        return;

    _isWaiting = true;
    await Task.Delay(3000); // Czekaj przez 3 sekundy, aby nie za czêsto zmieniaæ kolor

    // Zmieniamy t³o strony na podstawie poziomu œwiat³a
    if (lightLevel < 10) // Niski poziom œwiat³a
    {
        this.BackgroundColor = new Microsoft.Maui.Graphics.Color(170 / 255f, 170 / 255f, 170 / 255f);
       
    }
    else // Wysoki poziom œwiat³a
    {
        this.BackgroundColor = Colors.White; // Jasne t³o
    }

    _isWaiting = false;
}


#endif

    protected override void OnDisappearing()
    {
        base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop(); // Zatrzymanie detekcji œwiat³a
#endif
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();

#if ANDROID
            // Uruchamianie czujnika po powrocie na stronê
            _lightSensorService?.Start();
#endif
    }

}
