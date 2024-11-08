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
using Microsoft.Maui.Devices.Sensors;

namespace running_club.Pages;

public partial class HomePage : ContentPage
{
    // Inicjalizacja Stopwatch
    private Stopwatch stopwatch = new Stopwatch();

    // Inicjalizacja DispatcherTimer do aktualizowania czasu na UI
    private IDispatcherTimer timer;

    // Zmienna do liczenia kroków
    private int stepsCount = 0;
    private bool isTracking = false; // Okreœla, czy pedometr jest uruchomiony

    // Parametry dla detekcji kroków
    private const double StepThreshold = 1.2; // Próg wykrycia kroku
    private const int StepCooldown = 300;     // Czas miêdzy krokami w milisekundach
    private DateTime _lastStepTime = DateTime.MinValue;

    public HomePage()
    {
        InitializeComponent();

        BindingContext = new PedometerViewModel();

        // Timer do aktualizowania czasu na ekranie
        timer = Dispatcher.CreateTimer();
        timer.Interval = TimeSpan.FromMilliseconds(100); // Odœwie¿anie co 100 ms
        timer.Tick += OnTimerTick;

        // Ustawienie Ÿród³a mapy na OpenStreetMap
        var tileLayer = OpenStreetMap.CreateTileLayer();
        MyMapView.Map = new Mapsui.Map
        {
            Layers = { tileLayer }
        };

        // Automatyczne pobranie lokalizacji po wejœciu na stronê
        LoadLocationAsync();

        MyMapView.IsMyLocationButtonVisible = false;
        MyMapView.IsNorthingButtonVisible = false;
        MyMapView.IsZoomButtonVisible = false;

        // Sprawdzanie i ¿¹danie uprawnieñ do sensorów
        RequestPermissions();
    }

    // Aktualizowanie wyœwietlanego czasu
    private void OnTimerTick(object sender, EventArgs e)
    {
        TimerLabel.Text = stopwatch.Elapsed.ToString(@"mm\:ss");
    }

    // Obs³uga klikniêcia przycisku Start/Zakoñcz
    private void OnStartStopButtonClicked(object sender, EventArgs e)
    {
        if (stopwatch.IsRunning)
        {
            // Zatrzymaj stoper
            stopwatch.Stop();
            timer.Stop();
            StartStopButton.Text = "Start"; // Zmieñ tekst przycisku na "Start"
            isTracking = false;

            // Zatrzymanie liczenia kroków w modelu widoku
            ((PedometerViewModel)BindingContext).StopCommand.Execute(null);
        }
        else
        {
            // Uruchom stoper
            stopwatch.Start();
            timer.Start();
            StartStopButton.Text = "Wstrzymaj"; // Zmieñ tekst przycisku na "Wstrzymaj"
            isTracking = true;

            // Rozpoczêcie liczenia kroków w modelu widoku
            ((PedometerViewModel)BindingContext).StartCommand.Execute(null);
        }
    }

    // Pobranie bie¿¹cej lokalizacji i ustawienie mapy
    private async Task LoadLocationAsync()
    {
        try
        {
            // Sprawdzenie uprawnieñ i pobranie bie¿¹cej lokalizacji
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
                // Przekszta³cenie lokalizacji na wspó³rzêdne mapy
                var centerOfLocation = new MPoint(location.Longitude, location.Latitude);
                var sphericalMercatorCoordinate = SphericalMercator.FromLonLat(centerOfLocation.X, centerOfLocation.Y).ToMPoint();
                var position = new Position(location.Latitude, location.Longitude);

                // Ustawienie mapy na bie¿¹cej lokalizacji
                MyMapView.Map.Navigator.CenterOnAndZoomTo(sphericalMercatorCoordinate, MyMapView.Map.Navigator.Resolutions[16]);

                // Dodanie markera lub aktualizacja pozycji u¿ytkownika (jeœli MyLocationLayer jest u¿ywana)
                MyMapView.MyLocationLayer.UpdateMyLocation(position);
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Unable to get location: {ex.Message}", "OK");
        }
    }

    // Funkcja do obs³ugi pedometru
    private void RequestPermissions()
    {
        // Sprawdzamy uprawnienia do sensorów
        if (DeviceInfo.Platform == DevicePlatform.Android || DeviceInfo.Platform == DevicePlatform.iOS)
        {
            // Sprawdzanie uprawnieñ do odczytu sensorów kroków
            Permissions.RequestAsync<Permissions.Sensors>();
            StartStepCounter();
        }
    }

    // Rozpoczêcie liczenia kroków
    private void StartStepCounter()
    {
        if (Accelerometer.IsSupported)
        {
            Accelerometer.ReadingChanged += Accelerometer_ReadingChanged;
            Accelerometer.Start(SensorSpeed.UI);
        }
        else
        {
            DisplayAlert("Brak wsparcia", "Twój telefon nie wspiera akcelerometru", "OK");
        }
    }

    // Obs³uga odczytu kroków
    private void Accelerometer_ReadingChanged(object sender, AccelerometerChangedEventArgs e)
    {
        if (isTracking)
        {
            var reading = e.Reading;
            var totalAcceleration = Math.Sqrt(
                Math.Pow(reading.Acceleration.X, 2) +
                Math.Pow(reading.Acceleration.Y, 2) +
                Math.Pow(reading.Acceleration.Z, 2));

            // Sprawdzenie, czy przyspieszenie przekroczy³o próg wykrycia kroku
            if (totalAcceleration > StepThreshold)
            {
                // Ograniczenie liczby kroków przez czas, aby nie liczono ich wielokrotnie w tym samym czasie
                if ((DateTime.Now - _lastStepTime).TotalMilliseconds > StepCooldown)
                {
                    stepsCount++;
                    StepCountLabel.Text = stepsCount.ToString(); // Zaktualizuj liczbê kroków na ekranie
                    _lastStepTime = DateTime.Now; // Zaktualizuj czas ostatniego wykrycia kroku
                }
            }
        }
    }
}
