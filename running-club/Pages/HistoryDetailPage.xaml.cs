using Mapsui.Extensions;
using Mapsui.Layers;
using Mapsui.Nts;
using Mapsui.Nts.Extensions;
using Mapsui.Projections;
using Mapsui.Styles;
using Mapsui.Tiling;
using Mapsui.UI.Maui;
using NetTopologySuite.Geometries;
using NetTopologySuite.IO;
using System.Globalization;

#if ANDROID
using running_club.Platforms.Android;
#endif

namespace running_club.Pages;

public partial class HistoryDetailPage : ContentPage
{
    private MemoryLayer? _lineStringLayer;

#if ANDROID
        private LightSensorService _lightSensorService;
#endif
    private bool _isWaiting = false;

    public HistoryDetailPage(History history)
    {
        InitializeComponent();

        BindingContext = history;

        // Dodanie warstwy OpenStreetMap
        HistoryMapView.Map.Layers.Add(OpenStreetMap.CreateTileLayer());

        // Zdefiniowanie routeCoordinates
        var routeCoordinates = history.coordinates.Select(coord => (Latitude: coord.X, Longitude: coord.Y)).ToList();

#if ANDROID
            // Pobranie instancji LightSensorService
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
            _lightSensorService.LightLevelChanged += OnLightLevelChanged; // Subskrybuj zdarzenie
#endif


        // Utworzenie warstwy tylko, jeœli jest wystarczaj¹ca liczba wspó³rzêdnych
        _lineStringLayer = CreateLineStringLayer(CreateLineStringStyle(), routeCoordinates);

        // Dodanie warstwy do mapy, jeœli nie jest null
        if (_lineStringLayer != null)
        {
            HistoryMapView.Map.Layers.Add(_lineStringLayer);
        }

        // Ukrycie przycisków
        HistoryMapView.IsMyLocationButtonVisible = false;
        HistoryMapView.IsNorthingButtonVisible = false;

        // Wywo³anie asynchroniczne metody ³adowania lokalizacji
        _ = LoadLocationAsync();
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

                // Centrum mapy
                HistoryMapView.Map.Navigator.CenterOnAndZoomTo(sphericalMercatorCoordinate, HistoryMapView.Map.Navigator.Resolutions[18]);
                HistoryMapView.MyLocationLayer.UpdateMyLocation(position);
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Unable to get location: {ex.Message}", "OK");
        }
    }

    // Utworzenie warstwy linii (tylko dla odpowiedniej liczby wspó³rzêdnych)
    public static MemoryLayer? CreateLineStringLayer(IStyle style, List<(double Latitude, double Longitude)> coordinates)
    {
        // Jeœli mniej ni¿ 2 wspó³rzêdne, zwracamy null
        if (coordinates.Count < 2)
        {
            Console.WriteLine("Za ma³o wspó³rzêdnych, aby narysowaæ liniê");
            return null;
        }

        // Tworzenie linii w formacie WKT
        string line = string.Join(", ", coordinates.Select(coord => $"{coord.Latitude.ToString(CultureInfo.InvariantCulture)} {coord.Longitude.ToString(CultureInfo.InvariantCulture)}"));
        Console.WriteLine($"Wspó³rzêdne linii: {line}");

        var lineString = new WKTReader().Read($"LINESTRING({line})") as LineString;
        if (lineString != null)
        {
            lineString = new LineString(lineString.Coordinates.Select(v => SphericalMercator.FromLonLat(v.Y, v.X).ToCoordinate()).ToArray());
        }

        return new MemoryLayer
        {
            Features = new[] { new GeometryFeature { Geometry = lineString } },
            Name = "LineStringLayer",
            Style = style
        };
    }

    // Styl linii
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

    private void RemoveMyLocationMarker()
    {
        var myLocationLayer = HistoryMapView.Map.Layers.FirstOrDefault(layer => layer.Name == "MyLocationLayer");
        if (myLocationLayer != null)
        {
            HistoryMapView.Map.Layers.Remove(myLocationLayer);
        }
    }


#if ANDROID
private async void OnLightLevelChanged(float lightLevel)
{
    // Sprawdzenie, czy opóŸnienie jest ju¿ w trakcie
    if (_isWaiting)
        return;

    _isWaiting = true;

    await Task.Delay(3000);  // Czekamy przez 3 sekundy

    // Logowanie poziomu œwiat³a
    Console.WriteLine($"Poziom œwiat³a: {lightLevel}");

    // Zmieniamy t³o strony na podstawie poziomu œwiat³a
    if (lightLevel < 10) // Niski poziom œwiat³a - ustaw kolor t³a ciemnoszary i kolor tekstu na bia³y
    {
        this.BackgroundColor = new Microsoft.Maui.Graphics.Color(58 / 255f, 59 / 255f, 60 / 255f); // Kolor #3A3B3C
        UpdateTextColor(Colors.White); // Zmieniamy kolor tekstu wszystkich labeli na bia³y
    }
    else // Wysoki poziom œwiat³a - ustaw jasne t³o i ciemnoszary tekst
    {
        this.BackgroundColor = Colors.White; // Jasne t³o
        UpdateTextColor(Colors.Red); // Ciemnoszary tekst #3A3B3C
    }

    // Po zakoñczeniu opóŸnienia, zresetuj flagê
    _isWaiting = false;
}

// Funkcja pomocnicza do zmiany koloru tekstu
private void UpdateTextColor(Microsoft.Maui.Graphics.Color textColor)
{
    // Logowanie zmiany koloru
    Console.WriteLine($"Zmiana koloru tekstu na {textColor}");

    // Zmieniamy kolor tekstu we wszystkich kontrolkach na stronie
    UpdateTextColorRecursively(this.Content, textColor); // Rekurencyjnie zmieniamy kolor tekstu
}

// Funkcja rekurencyjna, która przechodzi przez kontrolki, aby zmieniæ kolor tekstu
private void UpdateTextColorRecursively(IView view, Microsoft.Maui.Graphics.Color textColor)
{
    if (view is Microsoft.Maui.Controls.Label label)
    {
        Console.WriteLine("Zmiana koloru tekstu w Label");
        label.TextColor = textColor; // Zmieniamy kolor tekstu w Label
    }
    else if (view is Microsoft.Maui.Controls.Button button)
    {
        Console.WriteLine("Zmiana koloru tekstu w Button");
        button.TextColor = textColor; // Zmieniamy kolor tekstu w Button
    }
    else if (view is Microsoft.Maui.Controls.Entry entry)
    {
        Console.WriteLine("Zmiana koloru tekstu w Entry");
        entry.TextColor = textColor; // Zmieniamy kolor tekstu w Entry
    }

    // Jeœli kontrolka jest Layout-em, przechodzimy przez jego dzieci
    if (view is Microsoft.Maui.Controls.Layout layout)
    {
        foreach (var child in layout.Children)
        {
            UpdateTextColorRecursively(child, textColor); // Rekurencyjnie sprawdzamy dzieci
        }
    }
}
#endif

    protected override void OnDisappearing()
    {
        base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop(); // Zatrzymanie detekcji œwiat³a
#endif
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();

#if ANDROID
            // Uruchamianie czujnika po powrocie na stronê
            _lightSensorService?.Start();
#endif
    }
}

