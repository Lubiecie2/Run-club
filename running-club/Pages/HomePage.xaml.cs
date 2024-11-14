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
    private double caloriesBurned = 0.0;
    private double speed = 0.0;
    private bool isTracking = false;
    private bool isPaused = false; // Dodana flaga do œledzenia pauzy
    private IDispatcherTimer locationUpdateTimer;

    private const double StepThreshold = 1.2;
    private const int StepCooldown = 300;
    private const double StepLength = 0.78;
    private const double CaloriesPerMeter = 0.05;

    private DateTime _lastStepTime = DateTime.MinValue;
    private DateTime _startTime = DateTime.MinValue;
    private DateTime _lastUpdateTime = DateTime.MinValue;

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

        // Dodanie obs³ugi widocznoœci przycisków
        UpdateButtons();
    }

    private void OnTimerTick(object sender, EventArgs e)
    {
        if (!isPaused)
        {
            TimerLabel.Text = stopwatch.Elapsed.ToString(@"mm\:ss");
            UpdateDistance();
            UpdateCalories();
            UpdateAveragePace();
        }
    }

    private void OnStartStopButtonClicked(object sender, EventArgs e)
    {
        if (stopwatch.IsRunning && !isPaused)
        {
            // Zatrzymanie stopera i zmiana statusu na pauzowany
            stopwatch.Stop();
            timer.Stop();
            isPaused = true;
            UpdateButtons();
        }
        else if (isPaused)
        {
            // Wznawianie liczenia po pauzie
            stopwatch.Start();
            timer.Start();
            isPaused = false;
            UpdateButtons();
        }
        else
        {
            // Rozpoczêcie nowego treningu
            stopwatch.Restart();
            timer.Start();
            StartStopButton.Text = "Wstrzymaj";
            isTracking = true;

            _startTime = DateTime.Now;
            ((PedometerViewModel)BindingContext).StartCommand.Execute(null);

            StartLocationUpdates();
            UpdateButtons();
        }
    }

    private async void OnFinishButtonClicked(object sender, EventArgs e)
    {
        // Zapisanie wartoœci do przekazania
        string time = stopwatch.Elapsed.ToString(@"mm\:ss");
        int steps = stepsCount;
        double calories = caloriesBurned;
        string pace = PaceLabel.Text;
        double totalDistance = distance;

        // Zresetowanie wartoœci na HomePage
        stopwatch.Reset();
        timer.Stop();
        isTracking = false;
        isPaused = false;
        stepsCount = 0;
        distance = 0.0;
        caloriesBurned = 0.0;
        _startTime = DateTime.MinValue;
        _lastUpdateTime = DateTime.MinValue;

        // Zresetowanie etykiet w HomePage
        StepCountLabel.Text = "0";
        DistanceLabel.Text = "0.00 km";
        CaloriesLabel.Text = "0.00 kcal";
        TimerLabel.Text = "00:00";
        PaceLabel.Text = "00:00";

        StopLocationUpdates();
        ((PedometerViewModel)BindingContext).StopCommand.Execute(null);
        UpdateButtons();

        // Nawigacja do strony podsumowania z przekazaniem danych
        await Navigation.PushAsync(new SummaryPage(time, steps, calories, pace, totalDistance));
    }




    private void UpdateButtons()
    {
        StartStopButton.Text = stopwatch.IsRunning ? (isPaused ? "Wznów" : "Wstrzymaj") : "Start";
        FinishButton.IsVisible = stopwatch.IsRunning || isPaused;
    }

    private void StartLocationUpdates()
    {
        locationUpdateTimer = Dispatcher.CreateTimer();
        locationUpdateTimer.Interval = TimeSpan.FromSeconds(1);
        locationUpdateTimer.Tick += async (s, e) =>
        {
            var location = await Geolocation.GetLocationAsync(new GeolocationRequest
            {
                DesiredAccuracy = GeolocationAccuracy.Best,
                Timeout = TimeSpan.FromSeconds(5)
            });

            if (location != null)
            {
                UpdateMapLocation(location);
            }
        };
        locationUpdateTimer.Start();
    }

    private void StopLocationUpdates()
    {
        locationUpdateTimer?.Stop();
        locationUpdateTimer = null;
    }

    private void UpdateMapLocation(Location location)
    {
        if (location == null) return;

        var position = new Position(location.Latitude, location.Longitude);
        var sphericalMercatorCoordinate = SphericalMercator.FromLonLat(location.Longitude, location.Latitude).ToMPoint();

        MyMapView.Map.Navigator.CenterOn(sphericalMercatorCoordinate);
        MyMapView.MyLocationLayer.UpdateMyLocation(position);
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
                var position = new Position(location.Latitude, location.Longitude);
                var sphericalMercatorCoordinate = SphericalMercator.FromLonLat(location.Longitude, location.Latitude).ToMPoint();

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
        if (isTracking && !isPaused)
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

                    UpdateDistance();
                }
            }
        }
    }

    private void UpdateDistance()
    {
        distance = stepsCount * StepLength;
        DistanceLabel.Text = $"{distance / 1000:F2} km";
    }

    private void UpdateCalories()
    {
        caloriesBurned = distance * CaloriesPerMeter;
        CaloriesLabel.Text = $"{caloriesBurned:F2} kcal";
    }

    private void UpdateAveragePace()
    {
        if (distance > 0 && _startTime != DateTime.MinValue)
        {
            if ((DateTime.Now - _lastUpdateTime).TotalSeconds >= 3)
            {
                _lastUpdateTime = DateTime.Now;
                TimeSpan elapsedTime = DateTime.Now - _startTime;
                double paceInMinutesPerKm = (elapsedTime.TotalMinutes / (distance / 1000));

                int minutes = (int)paceInMinutesPerKm;
                int seconds = (int)((paceInMinutesPerKm - minutes) * 60);

                PaceLabel.Text = $"{minutes:D2}:{seconds:D2}";
            }
        }
    }
}
