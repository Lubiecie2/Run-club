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
    private Stopwatch stopwatch = new Stopwatch();
    private IDispatcherTimer timer;
    private int stepsCount = 0;
    private double distance = 0.0;
    private double caloriesBurned = 0.0; // Licznik spalonych kalorii
    private bool isTracking = false;

    // Parametry dla detekcji kroków
    private const double StepThreshold = 1.2;
    private const int StepCooldown = 300;
    private const double StepLength = 0.78;      // Œrednia d³ugoœæ kroku w metrach
    private const double CaloriesPerMeter = 0.062; // Sta³a: 0.05 kcal na metr

    private DateTime _lastStepTime = DateTime.MinValue;

    public HomePage()
    {
        InitializeComponent();

        BindingContext = new PedometerViewModel();

        timer = Dispatcher.CreateTimer();
        timer.Interval = TimeSpan.FromMilliseconds(100);
        timer.Tick += OnTimerTick;

        var tileLayer = OpenStreetMap.CreateTileLayer();
        MyMapView.Map = new Mapsui.Map
        {
            Layers = { tileLayer }
        };

        LoadLocationAsync();

        MyMapView.IsMyLocationButtonVisible = false;
        MyMapView.IsNorthingButtonVisible = false;
        MyMapView.IsZoomButtonVisible = false;

        RequestPermissions();
    }

    private void OnTimerTick(object sender, EventArgs e)
    {
        TimerLabel.Text = stopwatch.Elapsed.ToString(@"mm\:ss");
        UpdateCalories(); // Aktualizacja spalonych kalorii
    }

    private void OnStartStopButtonClicked(object sender, EventArgs e)
    {
        if (stopwatch.IsRunning)
        {
            stopwatch.Stop();
            timer.Stop();
            StartStopButton.Text = "Start";
            isTracking = false;

            ((PedometerViewModel)BindingContext).StopCommand.Execute(null);
        }
        else
        {
            stopwatch.Start();
            timer.Start();
            StartStopButton.Text = "Wstrzymaj";
            isTracking = true;

            ((PedometerViewModel)BindingContext).StartCommand.Execute(null);
        }
    }

    private async Task LoadLocationAsync()
    {
        try
        {
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
                var centerOfLocation = new MPoint(location.Longitude, location.Latitude);
                var sphericalMercatorCoordinate = SphericalMercator.FromLonLat(centerOfLocation.X, centerOfLocation.Y).ToMPoint();
                var position = new Position(location.Latitude, location.Longitude);

                MyMapView.Map.Navigator.CenterOnAndZoomTo(sphericalMercatorCoordinate, MyMapView.Map.Navigator.Resolutions[16]);

                MyMapView.MyLocationLayer.UpdateMyLocation(position);
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Unable to get location: {ex.Message}", "OK");
        }
    }

    private void RequestPermissions()
    {
        if (DeviceInfo.Platform == DevicePlatform.Android || DeviceInfo.Platform == DevicePlatform.iOS)
        {
            Permissions.RequestAsync<Permissions.Sensors>();
            StartStepCounter();
        }
    }

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

    private void Accelerometer_ReadingChanged(object sender, AccelerometerChangedEventArgs e)
    {
        if (isTracking)
        {
            var reading = e.Reading;
            var totalAcceleration = Math.Sqrt(
                Math.Pow(reading.Acceleration.X, 2) +
                Math.Pow(reading.Acceleration.Y, 2) +
                Math.Pow(reading.Acceleration.Z, 2));

            if (totalAcceleration > StepThreshold)
            {
                if ((DateTime.Now - _lastStepTime).TotalMilliseconds > StepCooldown)
                {
                    stepsCount++;
                    StepCountLabel.Text = stepsCount.ToString();
                    _lastStepTime = DateTime.Now;

                    UpdateDistance(); // Aktualizacja przebytego dystansu
                }
            }
        }
    }

    private void UpdateDistance()
    {
        distance = stepsCount * StepLength;
        DistanceLabel.Text = $"{distance / 1000:F2} km";
    }

    // Metoda do aktualizowania liczby spalonych kalorii
    private void UpdateCalories()
    {
        caloriesBurned = distance * CaloriesPerMeter; // Obliczenie spalonych kalorii na podstawie dystansu
        CaloriesLabel.Text = $"{caloriesBurned:F2} kcal"; // Wyœwietlenie liczby spalonych kalorii z dok³adnoœci¹ do dwóch miejsc po przecinku
    }
}

