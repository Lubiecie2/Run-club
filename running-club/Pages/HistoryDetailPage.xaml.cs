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

/// @brief Klasa reprezentujaca strone szczegolow aktywnosci.
public partial class HistoryDetailPage : ContentPage
{
    private MemoryLayer? _lineStringLayer;

#if ANDROID
        private LightSensorService _lightSensorService;
#endif
    private bool _isWaiting = false;

    /// @brief Konstruktor klasy HistoryDetailPage.
    public HistoryDetailPage(History history)
    {
        InitializeComponent();
        BindingContext = history;

        
        HistoryMapView.Map.Layers.Add(OpenStreetMap.CreateTileLayer());

       
        var routeCoordinates = history.coordinates.Select(coord => (Latitude: coord.X, Longitude: coord.Y)).ToList();

       
        CenterMapOnFirstCoordinate(routeCoordinates);

        
        _lineStringLayer = CreateLineStringLayer(CreateLineStringStyle(), routeCoordinates);

       
        if (_lineStringLayer != null)
        {
            HistoryMapView.Map.Layers.Add(_lineStringLayer);
        }

   
        HistoryMapView.IsMyLocationButtonVisible = false;
        HistoryMapView.IsNorthingButtonVisible = false;

        var tileLayer = OpenStreetMap.CreateTileLayer();
        tileLayer.MaxVisible = 0.0001; 
        tileLayer.MinVisible = 0.0000001; 
        HistoryMapView.Map.Layers.Add(tileLayer);

#if ANDROID
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; 
    }
#endif


    }

    /// @brief Funkcja centrujaca mape na pierwszej wspolrzednej.
    private void CenterMapOnFirstCoordinate(List<(double Latitude, double Longitude)> coordinates)
    {
        if (coordinates.Count > 0)
        {
           
            var firstCoordinate = coordinates.First();

            
            var sphericalMercatorCoordinate = SphericalMercator.FromLonLat(firstCoordinate.Longitude, firstCoordinate.Latitude).ToMPoint();

            Console.WriteLine($"Centrowanie mapy na wspó³rzêdnych: {firstCoordinate.Latitude}, {firstCoordinate.Longitude}");

           
            HistoryMapView.Map.Home = n => n.CenterOn(sphericalMercatorCoordinate);
            HistoryMapView.Map.Navigator.ZoomTo(2); 
        }
        else
        {
            Console.WriteLine("Brak wspó³rzêdnych do ustawienia widoku mapy.");
        }
    }


    /// @brief Funkcja tworzaca warstwe liniowa na podstawie wspolrzednych.  <summary>
    /// @param style Styl warstwy.
    /// @param coordinates Lista wspolrzednych.
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

    /// @brief Funkcja tworzaca styl dla lini.
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

    /// @brief Funkcja usuwajaca marker lokalizacji uzytkownika.
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
