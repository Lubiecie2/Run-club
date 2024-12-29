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

        // Centrum mapy na podstawie pierwszego koordynatu
        CenterMapOnFirstCoordinate(routeCoordinates);

        // Utworzenie warstwy tylko, je�li jest wystarczaj�ca liczba wsp�rz�dnych
        _lineStringLayer = CreateLineStringLayer(CreateLineStringStyle(), routeCoordinates);

        // Dodanie warstwy do mapy, je�li nie jest null
        if (_lineStringLayer != null)
        {
            HistoryMapView.Map.Layers.Add(_lineStringLayer);
        }

        // Ukrycie przycisk�w
        HistoryMapView.IsMyLocationButtonVisible = false;
        HistoryMapView.IsNorthingButtonVisible = false;

        var tileLayer = OpenStreetMap.CreateTileLayer();
        tileLayer.MaxVisible = 0.0001; // Obs�uga du�ego przybli�enia
        tileLayer.MinVisible = 0.0000001; // Opcjonalne dodatkowe ustawienia
        HistoryMapView.Map.Layers.Add(tileLayer);

    }

    private void CenterMapOnFirstCoordinate(List<(double Latitude, double Longitude)> coordinates)
    {
        if (coordinates.Count > 0)
        {
            // Pobranie pierwszego koordynatu
            var firstCoordinate = coordinates.First();

            // Konwersja wsp�rz�dnych na SphericalMercator
            var sphericalMercatorCoordinate = SphericalMercator.FromLonLat(firstCoordinate.Longitude, firstCoordinate.Latitude).ToMPoint();

            Console.WriteLine($"Centrowanie mapy na wsp�rz�dnych: {firstCoordinate.Latitude}, {firstCoordinate.Longitude}");

            // Ustawienie widoku mapy
            HistoryMapView.Map.Home = n => n.CenterOn(sphericalMercatorCoordinate);
            HistoryMapView.Map.Navigator.ZoomTo(2); // Ustawienie poziomu przybli�enia
        }
        else
        {
            Console.WriteLine("Brak wsp�rz�dnych do ustawienia widoku mapy.");
        }
    }


    public static MemoryLayer? CreateLineStringLayer(IStyle style, List<(double Latitude, double Longitude)> coordinates)
    {
        if (coordinates.Count < 2)
        {
            Console.WriteLine("Za ma�o wsp�rz�dnych, aby narysowa� lini�");
            return null;
        }

        string line = string.Join(", ", coordinates.Select(coord => $"{coord.Latitude.ToString(CultureInfo.InvariantCulture)} {coord.Longitude.ToString(CultureInfo.InvariantCulture)}"));
        Console.WriteLine($"Wsp�rz�dne linii: {line}");

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
}
