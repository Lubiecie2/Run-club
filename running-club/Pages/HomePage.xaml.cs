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
    private bool isPaused = false; // Dodana flaga do �ledzenia pauzy
    private IDispatcherTimer locationUpdateTimer;

    private const double StepThreshold = 1.2;
    private const int StepCooldown = 300;
    private const double StepLength = 0.78;
    private const double CaloriesPerMeter = 0.05;

    private DateTime _lastStepTime = DateTime.MinValue;
    private DateTime _startTime = DateTime.MinValue;
    private DateTime _lastUpdateTime = DateTime.MinValue;


    private Label _qualityLabel;

    private static List<(double X, double Y)> coordinates = new List<(double X, double Y)>();


    private MemoryLayer? _lineStringLayer;

    public HomePage()
    {
        InitializeComponent();
        BindingContext = new PedometerViewModel();

        // Inicjalizacja timera
        timer = Dispatcher.CreateTimer();
        timer.Interval = TimeSpan.FromMilliseconds(100);
        timer.Tick += OnTimerTick;

        // Inicjalizacja mapy
        var tileLayer = OpenStreetMap.CreateTileLayer();
        MyMapView.Map = new Mapsui.Map
        {
            Layers = { tileLayer }
        };

        MyMapView.IsMyLocationButtonVisible = false;
        MyMapView.IsNorthingButtonVisible = false;
        MyMapView.IsZoomButtonVisible = true;


        MyMapView.Map.Layers.Add(OpenStreetMap.CreateTileLayer());
        _lineStringLayer = (MemoryLayer?)CreateLineStringLayer(CreateLineStringStyle());
        MyMapView.Map.Layers.Add(_lineStringLayer);

        RequestPermissions();

        // Inicjalizacja etykiety jako�ci GPS
        _qualityLabel = new Label
        {
            Text = "Unknown",
            FontSize = 15,
            HorizontalOptions = LayoutOptions.End, // Ustawienie etykiety w prawym rogu
            VerticalOptions = LayoutOptions.Start, // Ustawienie w g�rnym rogu
            TextColor = Colors.Gray,
            Margin = new Thickness(0, 40, 30, 0)  // Przesuni�cie etykiety w g�r�
        };

        // Dodanie etykiety do uk�adu Grid
        MainGrid.Children.Add(_qualityLabel); // Upewnij si�, �e MainGrid to element w XAML

        // Inicjalizacja monitorowania GPS
        StartGpsMonitoring();

        // Startuj lokalizacj� po za�adowaniu strony
        LoadLocationAsync();

    }

    // ------------------- BAZA DANYCH -------------------

    // -------------------KONIEC BAZA DANYCH -------------------



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
            // Rozpocz�cie nowego treningu
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
        // Zapisanie warto�ci do przekazania
        string time = stopwatch.Elapsed.ToString(@"mm\:ss");
        int steps = stepsCount;
        double calories = caloriesBurned;
        string pace = PaceLabel.Text;
        double totalDistance = distance;

        var routeCoordinates = new List<(double Latitude, double Longitude)>(coordinates);

        // Zresetowanie warto�ci na HomePage
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


        coordinates.Clear();

        // Nawigacja do strony podsumowania z przekazaniem danych
        await Navigation.PushAsync(new SummaryPage(time, steps, calories, pace, totalDistance, routeCoordinates));

        MyMapView.Map.Layers.Remove(_lineStringLayer);  // Usuni�cie warstwy z mapy
        _lineStringLayer = (MemoryLayer?)CreateLineStringLayer(CreateLineStringStyle());
        MyMapView.Map.Layers.Add(_lineStringLayer);  // Dodanie nowej (pustej) warstwy
    }




    private void UpdateButtons()
    {
        StartStopButton.Text = stopwatch.IsRunning ? (isPaused ? "Wzn�w" : "Wstrzymaj") : "Start";
        FinishButton.IsVisible = stopwatch.IsRunning || isPaused;
    }

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

    private void StopLocationUpdates()
    {
        locationUpdateTimer?.Stop();
        locationUpdateTimer = null;
    }

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
            DisplayAlert("Brak wsparcia", "Tw�j telefon nie wspiera akcelerometru", "OK");
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

    private async void StartGpsMonitoring()
    {
        while (true)
        {
            var quality = await GetGpsSignalQuality();
            UpdateQualityLabel(quality);  // Aktualizacja etykiety z nowym stanem

            // Od�wie�aj co kilka sekund, aby uzyska� aktualny stan GPS
            await Task.Delay(5000);
        }
    }

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
                // Upewniamy si�, �e Accuracy nie jest null
                double accuracy = location.Accuracy ?? double.MaxValue; // Ustawiamy warto�� domy�ln�, np. maksymaln�
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

    private string GetQualityFromAccuracy(double accuracy)
    {
        if (accuracy <= 5) // w metrach
            return "�wietny";
        else if (accuracy <= 10)
            return "Dobry";
        else if (accuracy <= 20)
            return "�redni";
        else if (accuracy <= 50)
            return "S�aby";
        else
            return "Brak";
    }

    private void UpdateQualityLabel(string quality)
    {
        _qualityLabel.Text = $"{quality}";

        // Kolorowanie w zale�no�ci od jako�ci sygna�u
        switch (quality)
        {
            case "�wietny":
                _qualityLabel.TextColor = Colors.Green; // Zielony
                break;
            case "Dobry":
                _qualityLabel.TextColor = Colors.Green; // Zielony
                break;
            case "�redni":
                _qualityLabel.TextColor = Colors.Orange; // ��ty
                break;
            case "��aby":
                _qualityLabel.TextColor = Colors.Orange; // Pomara�czowy
                break;
            case "Brak":
                _qualityLabel.TextColor = Colors.Red; // Czerwony
                break;
            default:
                _qualityLabel.TextColor = Colors.Gray; // Szary dla nieznanego
                break;
        }
    }

    public static ILayer CreateLineStringLayer(IStyle? style = null)
    {
        // Je�eli lista wsp�rz�dnych jest pusta, nie tw�rz linii
        if (coordinates.Count < 2)
        {
            return new MemoryLayer
            {
                Features = new GeometryFeature[0], // Pusta warstwa, bo brak wystarczaj�cej liczby wsp�rz�dnych
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

    public static IStyle CreateLineStringStyle()
    {
        return new VectorStyle
        {
            Fill = null,
            Outline = null,
#pragma warning disable CS8670 // Object or collection initializer implicitly dereferences possibly null member.
            Line = { Color = Mapsui.Styles.Color.FromString("Blue"), Width = 4 }
        };
    }

    public string GetWKT()
    {
        string lineString = string.Join(", ", coordinates.Select(coord => $"{coord.X} {coord.Y}"));
        return $"LINESTRING({lineString})";
    }
    //    public void AddCoordinates(params (double X, double Y)[] coords)
    //    {
    //        coordinates.AddRange(coords);
    //    }




}