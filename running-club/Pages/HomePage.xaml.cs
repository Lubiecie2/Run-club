using Mapsui.Layers;
using Mapsui.UI.Maui;
using Mapsui.Tiling.Layers;
using Mapsui.Utilities;
using Mapsui.Tiling;
using System.Diagnostics;
using Microsoft.Maui.Dispatching;
using Mapsui.Projections;
using Mapsui.Styles;
using Mapsui.Providers;
using Microsoft.Maui.Controls;
using Mapsui;
using Mapsui.Extensions;
using Microsoft.Maui.ApplicationModel;

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

        // Timer do aktualizowania czasu na ekranie
        timer = Dispatcher.CreateTimer();
        timer.Interval = TimeSpan.FromMilliseconds(100); // Od�wie�anie co 100 ms
        timer.Tick += OnTimerTick;

        // Ustawienie �r�d�a mapy na OpenStreetMap
        var tileLayer = OpenStreetMap.CreateTileLayer();
        MyMapView.Map = new Mapsui.Map
        {
            Layers = { tileLayer }
        };

        // Automatyczne pobranie lokalizacji po wej�ciu na stron�
        LoadLocationAsync();

        MyMapView.IsMyLocationButtonVisible = false;
        MyMapView.IsNorthingButtonVisible = false;
        MyMapView.IsZoomButtonVisible = false;
       

    }

    // Aktualizowanie wy�wietlanego czasu
    private void OnTimerTick(object sender, EventArgs e)
    {
        TimerLabel.Text = stopwatch.Elapsed.ToString(@"mm\:ss");
    }

    // Obs�uga klikni�cia przycisku Start/Zako�cz
    private void OnStartStopButtonClicked(object sender, EventArgs e)
    {
        if (stopwatch.IsRunning)
        {
            // Zatrzymaj stoper
            stopwatch.Stop();
            timer.Stop();
            StartStopButton.Text = "Start"; // Zmie� tekst przycisku na "Start"
        }
        else
        {
            // Uruchom stoper
            stopwatch.Start();
            timer.Start();
            StartStopButton.Text = "Wstrzymaj"; // Zmie� tekst przycisku na "Zako�cz"
        }
    }

    // Pobranie bie��cej lokalizacji i ustawienie mapy
    private async Task LoadLocationAsync()
    {
        try
        {
            // Sprawdzenie uprawnie� i pobranie bie��cej lokalizacji
            var location = await Geolocation.GetLocationAsync();

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
                // Przekszta�cenie lokalizacji na wsp�rz�dne mapy
                var centerOfLocation = new MPoint(location.Longitude, location.Latitude);
                var sphericalMercatorCoordinate = SphericalMercator.FromLonLat(centerOfLocation.X, centerOfLocation.Y).ToMPoint();
                var position = new Position(location.Latitude, location.Longitude);

                // Ustawienie mapy na bie��cej lokalizacji
                MyMapView.Map.Navigator.CenterOnAndZoomTo(sphericalMercatorCoordinate, MyMapView.Map.Navigator.Resolutions[16]);

                // Dodanie markera lub aktualizacja pozycji u�ytkownika (je�li MyLocationLayer jest u�ywana)
                MyMapView.MyLocationLayer.UpdateMyLocation(position);
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Unable to get location: {ex.Message}", "OK");
        }
    }
}