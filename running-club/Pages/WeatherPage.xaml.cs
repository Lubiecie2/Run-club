namespace running_club.Pages;
using Microsoft.Maui.Devices.Sensors;
using Newtonsoft.Json;

public partial class WeatherPage : ContentPage
{
    RestService _restService;

    public WeatherPage()
    {
        InitializeComponent();
        _restService = new RestService();

        // Wywo³anie metody przy starcie aplikacji
        GetWeatherForCurrentLocation();
    }

    async void GetWeatherForCurrentLocation()
    {
        try
        {
            // Pobierz aktualn¹ lokalizacjê u¿ytkownika z wysok¹ dok³adnoœci¹
            Location location = await Geolocation.GetLocationAsync(new GeolocationRequest(GeolocationAccuracy.Best, TimeSpan.FromSeconds(10)));

            if (location != null)
            {
                // Pobierz dane pogodowe na podstawie aktualnej lokalizacji
                string requestUrl = GenerateRequestURL(Constants.OpenWeatherMapEndpoint, location);
                WeatherData weatherData = await _restService.GetWeatherData(requestUrl);

                // Debugging - wyœwietl pe³n¹ odpowiedŸ JSON
                Console.WriteLine(JsonConvert.SerializeObject(weatherData));

                // Przypisz dane pogodowe do kontekstu wi¹zania
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

    string GenerateRequestURL(string endPoint, Location location)
    {
        string requestUri = endPoint;
        requestUri += $"?lat={location.Latitude}&lon={location.Longitude}";
        requestUri += "&units=metric"; // lub "imperial" dla Fahrenheita
        requestUri += $"&APPID={Constants.OpenWeatherMapAPIKey}";
        return requestUri;
    }
}
