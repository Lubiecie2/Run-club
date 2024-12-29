namespace running_club.Pages;
using Microsoft.Maui.Devices.Sensors;
using Newtonsoft.Json;
using WeatherApp;

#if ANDROID
using running_club.Platforms.Android; 
#endif


public partial class WeatherPage : ContentPage
{
    RestService _restService;
#if ANDROID
        private LightSensorService _lightSensorService;
#endif
    private bool _isWaiting = false;

    public WeatherPage()
    {
        InitializeComponent();
        _restService = new RestService();
        BindingContext = new WeatherViewModel();

#if ANDROID
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; 
    }
#endif

        // Wywo�anie metody przy starcie aplikacji
        GetWeatherForCurrentLocation();
    }

    async void GetWeatherForCurrentLocation()
    {
        try
        {
            // Pobierz aktualn� lokalizacj� u�ytkownika z wysok� dok�adno�ci�
            Location location = await Geolocation.GetLocationAsync(new GeolocationRequest(GeolocationAccuracy.Best, TimeSpan.FromSeconds(10)));

            if (location != null)
            {
                // Pobierz dane pogodowe na podstawie aktualnej lokalizacji
                string requestUrl = GenerateRequestURL(Constants.OpenWeatherMapEndpoint, location);
                WeatherData weatherData = await _restService.GetWeatherData(requestUrl);

                // Debugging - wy�wietl pe�n� odpowied� JSON
                Console.WriteLine(JsonConvert.SerializeObject(weatherData));

                // Przypisz dane pogodowe do kontekstu wi�zania
                BindingContext = weatherData;
            }
            else
            {
                await DisplayAlert("B��d", "Nie mo�na uzyska� dost�pu do aktualnej lokalizacji.", "OK");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("B��d", $"Wyst�pi� problem: {ex.Message}", "OK");
        }
    }

    string GenerateRequestURL(string endPoint, Location location)
    {
        string requestUri = endPoint;
        requestUri += $"?lat={location.Latitude}&lon={location.Longitude}";
        requestUri += "&units=metric"; // lub "imperial" dla Fahrenheita
        requestUri += $"&APPID={Constants.OpenWeatherMapAPIKey}";
        return requestUri;
    }
#if ANDROID
private async void OnLightLevelChanged(float lightLevel)
{
    if (_isWaiting)
        return;

    _isWaiting = true;
    await Task.Delay(3000); // Czekaj przez 3 sekundy, aby nie za cz�sto zmienia� kolor

    // Zmieniamy t�o strony na podstawie poziomu �wiat�a
    if (lightLevel < 10) // Niski poziom �wiat�a
    {
        this.BackgroundColor = new Microsoft.Maui.Graphics.Color(170 / 255f, 170 / 255f, 170 / 255f);
       
    }
    else // Wysoki poziom �wiat�a
    {
        this.BackgroundColor = Colors.White; // Jasne t�o
    }

    _isWaiting = false;
}


#endif

    protected override void OnDisappearing()
    {
        base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop(); // Zatrzymanie detekcji �wiat�a
#endif
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();

#if ANDROID
            // Uruchamianie czujnika po powrocie na stron�
            _lightSensorService?.Start();
#endif
    }

}
