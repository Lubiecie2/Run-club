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

        // Centrum mapy na podstawie pierwszego koordynatu
        CenterMapOnFirstCoordinate(routeCoordinates);

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

        var tileLayer = OpenStreetMap.CreateTileLayer();
        tileLayer.MaxVisible = 0.0001; // Obs³uga du¿ego przybli¿enia
        tileLayer.MinVisible = 0.0000001; // Opcjonalne dodatkowe ustawienia
        HistoryMapView.Map.Layers.Add(tileLayer);

#if ANDROID
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; 
    }
#endif


    }

    private void CenterMapOnFirstCoordinate(List<(double Latitude, double Longitude)> coordinates)
    {
        if (coordinates.Count > 0)
        {
            // Pobranie pierwszego koordynatu
            var firstCoordinate = coordinates.First();

            // Konwersja wspó³rzêdnych na SphericalMercator
            var sphericalMercatorCoordinate = SphericalMercator.FromLonLat(firstCoordinate.Longitude, firstCoordinate.Latitude).ToMPoint();

            Console.WriteLine($"Centrowanie mapy na wspó³rzêdnych: {firstCoordinate.Latitude}, {firstCoordinate.Longitude}");

            // Ustawienie widoku mapy
            HistoryMapView.Map.Home = n => n.CenterOn(sphericalMercatorCoordinate);
            HistoryMapView.Map.Navigator.ZoomTo(2); // Ustawienie poziomu przybli¿enia
        }
        else
        {
            Console.WriteLine("Brak wspó³rzêdnych do ustawienia widoku mapy.");
        }
    }


    public static MemoryLayer? CreateLineStringLayer(IStyle style, List<(double Latitude, double Longitude)> coordinates)
    {
        if (coordinates.Count < 2)
        {
            Console.WriteLine("Za ma³o wspó³rzêdnych, aby narysowaæ liniê");
            return null;
        }

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
    if (_isWaiting)
        return;

    _isWaiting = true;
    await Task.Delay(3000); // Czekaj przez 3 sekundy, aby nie za czêsto zmieniaæ kolor

    // Zmieniamy t³o strony na podstawie poziomu œwiat³a
    if (lightLevel < 10) // Niski poziom œwiat³a
    {
        this.BackgroundColor = new Microsoft.Maui.Graphics.Color(170 / 255f, 170 / 255f, 170 / 255f);
       
    }
    else // Wysoki poziom œwiat³a
    {
        this.BackgroundColor = Colors.White; // Jasne t³o
    }

    _isWaiting = false;
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
