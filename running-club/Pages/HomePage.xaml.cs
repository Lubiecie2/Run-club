using Mapsui.Layers;
using Mapsui.UI.Maui;
using Mapsui.Tiling.Layers;
using Mapsui.Utilities;
using Mapsui.Tiling;
using System.Diagnostics; // Do u¿ycia Stopwatch
using Microsoft.Maui.Dispatching; // Do u¿ycia DispatcherTimer
using Mapsui.Projections;
using Mapsui.Styles;
using Mapsui.Providers;
using Microsoft.Maui.Controls;
using System.Diagnostics;
using Mapsui;


namespace running_club.Pages;

public partial class HomePage : ContentPage
{
    // Inicjalizacja Stopwatch
    private Stopwatch stopwatch = new Stopwatch();

    // Inicjalizacja DispatcherTimer do aktualizowania czasu na UI
    private IDispatcherTimer timer;

    public HomePage()
	{
		InitializeComponent();
        
        timer = Dispatcher.CreateTimer();
        timer.Interval = TimeSpan.FromMilliseconds(100); // Odœwie¿anie co 100 ms
        timer.Tick += OnTimerTick;
        // Ustawienie Ÿród³a mapy na OpenStreetMap
        var tileLayer = OpenStreetMap.CreateTileLayer();
        MyMapView.Map = new Mapsui.Map
        {
            Layers = { tileLayer }
        };

        // Opcjonalnie ustawienie kamery na dany punkt
        var center = SphericalMercator.FromLonLat(19.9449799, 50.0646501); // np. Kraków

    }

    // Aktualizowanie wyœwietlanego czasu
    private void OnTimerTick(object sender, EventArgs e)
    {
        TimerLabel.Text = stopwatch.Elapsed.ToString(@"hh\:mm\:ss\.fff");
    }

    // Obs³uga klikniêcia przycisku Start
    private void OnStartButtonClicked(object sender, EventArgs e)
    {
        if (!stopwatch.IsRunning)
        {
            stopwatch.Start();
            timer.Start();
        }
    }

    // Obs³uga klikniêcia przycisku Stop
    private void OnStopButtonClicked(object sender, EventArgs e)
    {
        if (stopwatch.IsRunning)
        {
            stopwatch.Stop();
            timer.Stop();
        }
    }

    // Obs³uga klikniêcia przycisku Reset
    private void OnResetButtonClicked(object sender, EventArgs e)
    {
        stopwatch.Reset();
        TimerLabel.Text = "00:00:00.000";
    }

    private async void OnGoToMyLocationClicked(object sender, EventArgs e)
    {
        try
        {
            // Sprawdzenie uprawnieñ i pobranie bie¿¹cej lokalizacji
            var location = await Geolocation.GetLastKnownLocationAsync();

            if (location == null)
            {
                location = await Geolocation.GetLocationAsync(new GeolocationRequest
                {
                    DesiredAccuracy = GeolocationAccuracy.Medium,
                    Timeout = TimeSpan.FromSeconds(30)
                });
            }

            if (location != null)
            {
                // Przekszta³cenie lokalizacji na wspó³rzêdne mapy
                // var position = new Mapsui.Geometries.Point(location.Longitude, location.Latitude);
                // var sphericalMercator = SphericalMercator.FromLonLat(location.Longitude, location.Latitude);

                // Przejœcie do bie¿¹cej lokalizacji na mapie
                //MyMapView. NavigateTo(sphericalMercator, MyMapView.Navigator.Zoom);

                // Dodanie markera w bie¿¹cej lokalizacji
                //AddMarker(position);
                //TimerLabel.Text = location.Longitude.ToString();
                //TimerLabel.Text = location.Latitude.ToString();

                var centerOfLondonOntario = new MPoint(-81.2497, 42.9837);
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Unable to get location: {ex.Message}", "OK");
        }
    }

}