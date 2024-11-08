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

    // Zmienna do liczenia krok�w
    private int stepsCount = 0;
    private bool isTracking = false; // Okre�la, czy pedometr jest uruchomiony

    // Parametry dla detekcji krok�w
    private const double StepThreshold = 1.2; // Pr�g wykrycia kroku
    private const int StepCooldown = 300;     // Czas mi�dzy krokami w milisekundach
    private DateTime _lastStepTime = DateTime.MinValue;

    public HomePage()
    {
        InitializeComponent();

        BindingContext = new PedometerViewModel();

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

        // Sprawdzanie i ��danie uprawnie� do sensor�w
        RequestPermissions();
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
            isTracking = false;

            // Zatrzymanie liczenia krok�w w modelu widoku
            ((PedometerViewModel)BindingContext).StopCommand.Execute(null);
        }
        else
        {
            // Uruchom stoper
            stopwatch.Start();
            timer.Start();
            StartStopButton.Text = "Wstrzymaj"; // Zmie� tekst przycisku na "Wstrzymaj"
            isTracking = true;

            // Rozpocz�cie liczenia krok�w w modelu widoku
            ((PedometerViewModel)BindingContext).StartCommand.Execute(null);
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

    // Funkcja do obs�ugi pedometru
    private void RequestPermissions()
    {
        // Sprawdzamy uprawnienia do sensor�w
        if (DeviceInfo.Platform == DevicePlatform.Android || DeviceInfo.Platform == DevicePlatform.iOS)
        {
            // Sprawdzanie uprawnie� do odczytu sensor�w krok�w
            Permissions.RequestAsync<Permissions.Sensors>();
            StartStepCounter();
        }
    }

    // Rozpocz�cie liczenia krok�w
    private void StartStepCounter()
    {
        if (Accelerometer.IsSupported)
        {
            Accelerometer.ReadingChanged += Accelerometer_ReadingChanged;
            Accelerometer.Start(SensorSpeed.UI);
        }
        else
        {
            DisplayAlert("Brak wsparcia", "Tw�j telefon nie wspiera akcelerometru", "OK");
        }
    }

    // Obs�uga odczytu krok�w
    private void Accelerometer_ReadingChanged(object sender, AccelerometerChangedEventArgs e)
    {
        if (isTracking)
        {
            var reading = e.Reading;
            var totalAcceleration = Math.Sqrt(
                Math.Pow(reading.Acceleration.X, 2) +
                Math.Pow(reading.Acceleration.Y, 2) +
                Math.Pow(reading.Acceleration.Z, 2));

            // Sprawdzenie, czy przyspieszenie przekroczy�o pr�g wykrycia kroku
            if (totalAcceleration > StepThreshold)
            {
                // Ograniczenie liczby krok�w przez czas, aby nie liczono ich wielokrotnie w tym samym czasie
                if ((DateTime.Now - _lastStepTime).TotalMilliseconds > StepCooldown)
                {
                    stepsCount++;
                    StepCountLabel.Text = stepsCount.ToString(); // Zaktualizuj liczb� krok�w na ekranie
                    _lastStepTime = DateTime.Now; // Zaktualizuj czas ostatniego wykrycia kroku
                }
            }
        }
    }
}
