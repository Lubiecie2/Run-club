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
namespace running_club.Pages;
public partial class HistoryDetailPage : ContentPage
{
    private MemoryLayer? _lineStringLayer;
    public HistoryDetailPage(History history)
    {
        InitializeComponent();
        BindingContext = history;
        // Dodanie warstwy OpenStreetMap
        HistoryMapView.Map.Layers.Add(OpenStreetMap.CreateTileLayer());
        // Zdefiniowanie routeCoordinates
        var routeCoordinates = history.coordinates.Select(coord => (Latitude: coord.X, Longitude: coord.Y)).ToList();
        // Utworzenie warstwy tylko, je?li jest wystarczaj?ca liczba wspó?rz?dnych
        _lineStringLayer = CreateLineStringLayer(CreateLineStringStyle(), routeCoordinates);
        // Dodanie warstwy do mapy, je?li nie jest null
        if (_lineStringLayer != null)
        {
            HistoryMapView.Map.Layers.Add(_lineStringLayer);
        }
        // Ukrycie przycisków
        HistoryMapView.IsMyLocationButtonVisible = false;
        HistoryMapView.IsNorthingButtonVisible = false;
        // Wywo?anie asynchroniczne metody ?adowania lokalizacji
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
    // Utworzenie warstwy linii (tylko dla odpowiedniej liczby wspó?rz?dnych)
    public static MemoryLayer? CreateLineStringLayer(IStyle style, List<(double Latitude, double Longitude)> coordinates)
    {
        // Je?li mniej ni? 2 wspó?rz?dne, zwracamy null
        if (coordinates.Count < 2)
        {
            Console.WriteLine("Za ma?o wspó?rz?dnych, aby narysowa? lini?");
            return null;
        }
        // Tworzenie linii w formacie WKT
        string line = string.Join(", ", coordinates.Select(coord => $"{coord.Latitude.ToString(CultureInfo.InvariantCulture)} {coord.Longitude.ToString(CultureInfo.InvariantCulture)}"));
        Console.WriteLine($"Wspó?rz?dne linii: {line}");
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
}