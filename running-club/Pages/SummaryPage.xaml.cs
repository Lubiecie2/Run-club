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
using NetTopologySuite.Algorithm;
using Firebase.Database;
using Firebase.Database.Query;

namespace running_club.Pages
{
    public partial class SummaryPage : ContentPage
    {
        private MemoryLayer? _lineStringLayer;
        private readonly FirebaseClient _firebaseClient;

        public SummaryPage(string time, int steps, double calories, string pace, double distance, List<(double Latitude, double Longitude)> routeCoordinates)
        {
            InitializeComponent();

            // Przypisanie wartoœci do etykiet w SummaryPage
            TimeLabel.Text = time;
            StepsLabel.Text = steps.ToString();
            CaloriesLabel.Text = calories.ToString("F2");
            PaceLabel.Text = pace;
            DistanceLabel.Text = distance.ToString("F2");

            BindingContext = this;
            _firebaseClient = new FirebaseClient("https://running-club-5b96d-default-rtdb.europe-west1.firebasedatabase.app/");

            OnSave(time, steps, calories, pace, distance, routeCoordinates);

            // Inicjalizacja mapy z warstw¹ OpenStreetMap
            var tileLayer = OpenStreetMap.CreateTileLayer();
            SummaryMapView.Map = new Mapsui.Map
            {
                Layers = { tileLayer }
            };

            // Ustaw mapê na podstawie pierwszego wspó³rzêdnego z tablicy
            CenterMapOnFirstCoordinate(routeCoordinates);

            // Dodanie warstwy z lini¹
            _lineStringLayer = (MemoryLayer?)CreateLineStringLayer(CreateLineStringStyle(), routeCoordinates);
            SummaryMapView.Map.Layers.Add(_lineStringLayer);
        }

        private async Task OnSave(string time, int steps, double calories, string pace, double distance, List<(double Latitude, double Longitude)> routeCoordinates)
        {
            string uid = await SecureStorage.GetAsync("user_uid");

            string currentdate = DateTime.Now.ToString("yyyy-MM-dd");

            int roundedDistance = (int)Math.Round(distance);
            int roundedCalories = (int)Math.Round(calories);

            _firebaseClient.Child(uid).Child("History").PostAsync(new History
            {
                data = currentdate,
                Steps = steps.ToString(),
                Distance = roundedDistance.ToString(),
                Kcal = roundedCalories.ToString(),
                Time = time,
                coordinates = routeCoordinates
            });
        }

        // Funkcja centrowania mapy na pierwszym wspó³rzêdnym z tablicy
        private void CenterMapOnFirstCoordinate(List<(double Latitude, double Longitude)> coordinates)
        {
            if (coordinates.Count > 0)
            {
                // Pobranie pierwszego wspó³rzêdnego
                var firstCoordinate = coordinates.First();

                // Konwersja wspó³rzêdnych na SphericalMercator
                var sphericalMercatorCoordinate = SphericalMercator.FromLonLat(firstCoordinate.Longitude, firstCoordinate.Latitude).ToMPoint();

                Console.WriteLine($"Centrowanie mapy na wspó³rzêdnych: {firstCoordinate.Latitude}, {firstCoordinate.Longitude}");

                // Ustawienie widoku mapy
                SummaryMapView.Map.Home = n => n.CenterOn(sphericalMercatorCoordinate);
                SummaryMapView.Map.Navigator.ZoomTo(2); // Ustawienie poziomu przybli¿enia (w zale¿noœci od tego, jak blisko chcesz byæ)
            }
            else
            {
                Console.WriteLine("Brak wspó³rzêdnych do ustawienia widoku mapy.");
            }
        }

        // Funkcja tworzenia warstwy linii
        public static ILayer CreateLineStringLayer(IStyle style, List<(double Latitude, double Longitude)> coordinates)
        {
            if (coordinates.Count < 2)
            {
                return new MemoryLayer
                {
                    Features = new GeometryFeature[0], // Pusta warstwa, bo brak wystarczaj¹cej liczby wspó³rzêdnych
                    Name = "LineStringLayer",
                    Style = style
                };
            }

            string line = string.Join(", ", coordinates.Select(coord => $"{coord.Latitude.ToString(CultureInfo.InvariantCulture)} {coord.Longitude.ToString(CultureInfo.InvariantCulture)}"));
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

        private async void OnBackButtonClicked(object sender, EventArgs e)
        {
            await Navigation.PopToRootAsync(); // Powrót do strony g³ównej
        }
    }
}
