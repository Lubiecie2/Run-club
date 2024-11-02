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
}
