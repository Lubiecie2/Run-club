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
using Mapsui.Nts;
using Mapsui.Nts.Extensions;
using NetTopologySuite.Geometries;
using NetTopologySuite.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Globalization;
using Firebase.Database;
using Firebase.Database.Query;
#if ANDROID
using running_club.Platforms.Android; 
#endif

namespace running_club.Pages;

/// @brief Strona glowna aplikacji sledzacej aktywnosc uzytkownika.
public partial class HomePage : ContentPage
{
    /// @brief Stoper do mierzenia czasu aktywnosci.
    private Stopwatch stopwatch = new Stopwatch();

    /// @brief Timer do aktualizowania interfejsu uzytkownika.
    private IDispatcherTimer timer;

    /// @brief Licznik krokow uzytkownika.
    private int stepsCount = 0;

    /// @brief Przebyty dystans w metrach.
    private double distance = 0.0;

    /// @brief Liczba spalonych kalorii.
    private double caloriesBurned = 0.0;

    /// @brief Aktualna predkosc uzytkownika.
    private double speed = 0.0;

    /// @brief Flaga wskazujaca, czy trwa sledzenie aktywnosci.
    private bool isTracking = false;

    /// @brief Flaga wskazujaca, czy sledzenie zostalo wstrzymane.
    private bool isPaused = false;

    /// @brief Timer do aktualizacji lokalizacji.
    private IDispatcherTimer locationUpdateTimer;

    /// @brief Minimalny prog przyspieszenia dla wykrycia kroku.
    private const double StepThreshold = 1.2;

    /// @brief Minimalny czas miedzy krokami w milisekundach.
    private const int StepCooldown = 300;

    /// @brief Dlugosc kroku w metrach.
    private const double StepLength = 0.78;

    /// @brief Liczba spalanych kalorii na metr.
    private const double CaloriesPerMeter = 0.05;

    /// @brief Flaga wskazujaca, czy trwa opoznienie czujnika światla.
    private bool _isWaiting = false;

    /// @brief Czas ostatniego kroku.
    private DateTime _lastStepTime = DateTime.MinValue;

    /// @brief Czas rozpoczecia aktywnosci.
    private DateTime _startTime = DateTime.MinValue;

    /// @brief Czas ostatniej aktualizacji danych.
    private DateTime _lastUpdateTime = DateTime.MinValue;

#if ANDROID
        private LightSensorService _lightSensorService;
#endif

    /// @brief Etykieta pokazujaca jakosc sygnalu GPS.
    private Label _qualityLabel;

    /// @brief Lista wspolrzednych trasy uzytkownika.
    private static List<(double X, double Y)> coordinates = new List<(double X, double Y)>();

    /// @brief Warstwa do rysowania trasy na mapie.
    private MemoryLayer? _lineStringLayer;

    /// @brief Konstruktor inicjalizujacy strone HomePage.
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

        MyMapView.IsMyLocationButtonVisible = false;
        MyMapView.IsNorthingButtonVisible = false;
        MyMapView.IsZoomButtonVisible = true;
      

#if ANDROID
    // Pobranie instancji LightSensorService
   
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; // Subskrybuj zdarzenie
    }
#endif


        MyMapView.Map.Layers.Add(OpenStreetMap.CreateTileLayer());
        _lineStringLayer = (MemoryLayer?)CreateLineStringLayer(CreateLineStringStyle());
        MyMapView.Map.Layers.Add(_lineStringLayer);
        MyMapView.Map.Layers.Add(MyMapView.MyLocationLayer);

        RequestPermissions();

        _qualityLabel = new Label
        {
            Text = "Unknown",
            FontSize = 15,
            HorizontalOptions = LayoutOptions.End, 
            VerticalOptions = LayoutOptions.Start, 
            TextColor = Colors.Gray,
            Margin = new Thickness(0, 40, 30, 0)  
        };


        MainGrid.Children.Add(_qualityLabel); 


        StartGpsMonitoring();


        LoadLocationAsync();

    }

    /// @brief Obsluguje zdarzenie tykniecia timera.
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

    /// @brief Obsluguje klikniecie przycisku Start/Stop.
    private void OnStartStopButtonClicked(object sender, EventArgs e)
    {
        if (stopwatch.IsRunning && !isPaused)
        {
           
            stopwatch.Stop();
            timer.Stop();
            isPaused = true;
            UpdateButtons();
        }
        else if (isPaused)
        {
           
            stopwatch.Start();
            timer.Start();
            isPaused = false;
            UpdateButtons();
        }
        else
        {
            
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

    /// @brief Obsluguje klikniecie przycisku Finish.
    private async void OnFinishButtonClicked(object sender, EventArgs e)
    {
       
        string time = stopwatch.Elapsed.ToString(@"mm\:ss");
        int steps = stepsCount;
        double calories = caloriesBurned;
        string pace = PaceLabel.Text;
        double totalDistance = distance;

        var routeCoordinates = new List<(double Latitude, double Longitude)>(coordinates);


        stopwatch.Reset();
        timer.Stop();
        isTracking = false;
        isPaused = false;
        stepsCount = 0;
        distance = 0.0;
        caloriesBurned = 0.0;
        _startTime = DateTime.MinValue;
        _lastUpdateTime = DateTime.MinValue;


        StepCountLabel.Text = "0";
        DistanceLabel.Text = "0.00 km";
        CaloriesLabel.Text = "0.00 kcal";
        TimerLabel.Text = "00:00";
        PaceLabel.Text = "00:00";

        StopLocationUpdates();
        ((PedometerViewModel)BindingContext).StopCommand.Execute(null);
        UpdateButtons();


        coordinates.Clear();

        await Navigation.PushAsync(new SummaryPage(time, steps, calories, pace, totalDistance, routeCoordinates));

        MyMapView.Map.Layers.Remove(_lineStringLayer);  
        _lineStringLayer = (MemoryLayer?)CreateLineStringLayer(CreateLineStringStyle());
        MyMapView.Map.Layers.Add(_lineStringLayer); 
    }



    /// @brief Aktualizuje stan przyciskow.
    private void UpdateButtons()
    {
        StartStopButton.Text = stopwatch.IsRunning ? (isPaused ? "Wzn�w" : "Wstrzymaj") : "Start";
        FinishButton.IsVisible = stopwatch.IsRunning || isPaused;
    }

    /// @brief Rozpoczyna aktualizacje lokalizacji.
    private async void StartLocationUpdates()
    {
        locationUpdateTimer = Dispatcher.CreateTimer();
        locationUpdateTimer.Interval = TimeSpan.FromSeconds(3);
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

    /// @brief Zatrzymuje aktualizacje lokalizacji.
    private void StopLocationUpdates()
    {
        locationUpdateTimer?.Stop();
        locationUpdateTimer = null;
    }

    /// @brief Aktualizuje lokalizacje na mapie.
    private void UpdateMapLocation(Microsoft.Maui.Devices.Sensors.Location location)
    {
        if (location == null) return;

        var position = new Mapsui.UI.Maui.Position(location.Latitude, location.Longitude);
        var sphericalMercatorCoordinate = SphericalMercator.FromLonLat(location.Longitude, location.Latitude).ToMPoint();


        MyMapView.Map.Navigator.CenterOn(sphericalMercatorCoordinate);
        MyMapView.MyLocationLayer.UpdateMyLocation(position);


        coordinates.Add((position.Latitude, position.Longitude));


        if (coordinates.Count >= 2)
        {

            string line = string.Join(", ", coordinates.Select(coord =>
                $"{coord.X.ToString(CultureInfo.InvariantCulture)} {coord.Y.ToString(CultureInfo.InvariantCulture)}"));

            try
            {

                var lineString = new WKTReader().Read($"LINESTRING({line})") as LineString;
                if (lineString != null)
                {

                    lineString = new LineString(lineString.Coordinates
                        .Select(v => SphericalMercator.FromLonLat(v.Y, v.X).ToCoordinate()).ToArray());


                    _lineStringLayer.Features = new[] { new GeometryFeature { Geometry = lineString } };
                }
                else
                {
                    Console.WriteLine("Failed to create LineString from WKT.");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error creating LineString: {ex.Message}");
            }
        }
    }

    /// @brief Wczytuje lokalizacje uzytkownika.
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
                var position = new Mapsui.UI.Maui.Position(location.Latitude, location.Longitude);
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

    /// @brief Wyswietla okno z prosba o uprawnienia.
    private void RequestPermissions()
    {
        if (DeviceInfo.Platform == DevicePlatform.Android || DeviceInfo.Platform == DevicePlatform.iOS)
        {
            Permissions.RequestAsync<Permissions.Sensors>();
            StartStepCounter();
        }
    }

    /// @brief Rozpoczyna liczenie krokow.
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

    /// @brief Obsluguje zmiane odczytu akcelerometru.
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

    /// @brief Aktualizuje przebyty dystans.
    private void UpdateDistance()
    {
        distance = stepsCount * StepLength;
        DistanceLabel.Text = $"{distance / 1000:F2} km";
    }

    /// @brief Aktualizuje liczbe spalonych kalorii.
    private void UpdateCalories()
    {
        caloriesBurned = distance * CaloriesPerMeter;
        CaloriesLabel.Text = $"{caloriesBurned:F2} kcal";
    }

    /// @brief Aktualizuje sredni czas na kilometr.
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

    /// @brief Rozpoczyna monitorowanie jakosci sygnalu GPS.
    private async void StartGpsMonitoring()
    {
        while (true)
        {
            var quality = await GetGpsSignalQuality();
            UpdateQualityLabel(quality);  

            await Task.Delay(5000);
        }
    }

    /// @brief Pobiera jakosc sygnalu GPS.
    private async Task<string> GetGpsSignalQuality()
    {
        try
        {
            var location = await Geolocation.GetLastKnownLocationAsync();

            if (location == null)
            {
                location = await Geolocation.GetLocationAsync(new GeolocationRequest
                {
                    DesiredAccuracy = GeolocationAccuracy.High,
                    Timeout = TimeSpan.FromSeconds(10)
                });
            }

            if (location != null)
            {
                double accuracy = location.Accuracy ?? double.MaxValue; 
                return GetQualityFromAccuracy(accuracy);
            }
            else
            {
                return "No GPS Signal";
            }
        }
        catch
        {
            return "Error Retrieving GPS Signal";
        }
    }

    /// @brief Pobiera jakosc sygnalu GPS na podstawie dokladnosci.
    private string GetQualityFromAccuracy(double accuracy)
    {
        if (accuracy <= 5) 
            return "świetny";
        else if (accuracy <= 10)
            return "Dobry";
        else if (accuracy <= 20)
            return "średni";
        else if (accuracy <= 50)
            return "Słaby";
        else
            return "Brak";
    }

    /// @brief Aktualizuje etykiete z jakoscia sygnalu GPS.
    private void UpdateQualityLabel(string quality)
    {
        _qualityLabel.Text = $"{quality}";


        switch (quality)
        {
            case "świetny":
                _qualityLabel.TextColor = Colors.Green; 
                break;
            case "Dobry":
                _qualityLabel.TextColor = Colors.Green; 
                break;
            case "średni":
                _qualityLabel.TextColor = Colors.Orange; 
                break;
            case "słaby":
                _qualityLabel.TextColor = Colors.Orange; 
                break;
            case "Brak":
                _qualityLabel.TextColor = Colors.Red; 
                break;
            default:
                _qualityLabel.TextColor = Colors.Gray; 
                break;
        }
    }

    /// @brief Tworzy warstwe z linia trasy.
    public static ILayer CreateLineStringLayer(IStyle? style = null)
    {
        if (coordinates.Count < 2)
        {
            return new MemoryLayer
            {
                Features = new GeometryFeature[0], 
                Name = "LineStringLayer",
                Style = style
            };
        }

        string line = string.Join(", ", coordinates.Select(coord => $"{coord.X.ToString(CultureInfo.InvariantCulture)} {coord.Y.ToString(CultureInfo.InvariantCulture)}"));
        Console.WriteLine($"Number: {line}");

        var lineString = new WKTReader().Read($"LINESTRING({line})") as LineString;
        lineString = new LineString(lineString.Coordinates.Select(v => SphericalMercator.FromLonLat(v.Y, v.X).ToCoordinate()).ToArray());

        return new MemoryLayer
        {
            Features = new[] { new GeometryFeature { Geometry = lineString } },
            Name = "LineStringLayer",
            Style = style
        };
    }

    /// @brief Tworzy styl dla linii trasy.
    public static IStyle CreateLineStringStyle()
    {
        return new VectorStyle
        {
            Fill = null,
            Outline = null,
#pragma warning disable CS8670 
            Line = { Color = Mapsui.Styles.Color.FromString("Blue"), Width = 4 }
        };
    }

    /// @brief Pobiera reprezentacje WKT linii trasy.
    public string GetWKT()
    {
        string lineString = string.Join(", ", coordinates.Select(coord => $"{coord.X} {coord.Y}"));
        return $"LINESTRING({lineString})";
    }

#if ANDROID
private async void OnLightLevelChanged(float lightLevel)
{
    // Sprawdzenie, czy opóźnienie jest już w trakcie
    if (_isWaiting)
        return;

    _isWaiting = true;

    await Task.Delay(3000);  // Czekamy przez 3 sekundy

    // Zmieniamy tło strony na podstawie poziomu światła
    if (lightLevel < 10) // Niski poziom światła - ustaw kolor tła ciemnoszary i kolor tekstu na biały
    {
        this.BackgroundColor = new Microsoft.Maui.Graphics.Color(170 / 255f, 170 / 255f, 170 / 255f); // Kolor #3A3B3C
    }
    else // Wysoki poziom światła - ustaw jasne tło i ciemnoszary tekst
    {
        this.BackgroundColor = Colors.White; // Jasne tło
       
    }

    // Po zakończeniu opóźnienia, zresetuj flagę
    _isWaiting = false;
}
#endif


    protected override void OnDisappearing()
    {
        base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop();
#endif


    }
    protected override void OnAppearing()
    {
        base.OnAppearing();

#if ANDROID
    // Uruchamianie czujnika po powrocie na stronę
    _lightSensorService?.Start();
#endif
    }


}