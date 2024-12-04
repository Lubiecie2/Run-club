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

            // Ustaw mapê na bie¿¹c¹ lokalizacjê u¿ytkownika
            _ = LoadLocationAsync();

            SummaryMapView.Map.Layers.Add(OpenStreetMap.CreateTileLayer());
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

        private void UpdateMapLocation(Microsoft.Maui.Devices.Sensors.Location location)
        {
            if (location == null) return;

            var position = new Mapsui.UI.Maui.Position(location.Latitude, location.Longitude);
            var sphericalMercatorCoordinate = SphericalMercator.FromLonLat(location.Longitude, location.Latitude).ToMPoint();


            SummaryMapView.Map.Navigator.CenterOn(sphericalMercatorCoordinate);
            SummaryMapView.MyLocationLayer.UpdateMyLocation(position);
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

                    SummaryMapView.Map.Navigator.CenterOnAndZoomTo(sphericalMercatorCoordinate, SummaryMapView.Map.Navigator.Resolutions[16]);
                    SummaryMapView.MyLocationLayer.UpdateMyLocation(position);
                }
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", $"Unable to get location: {ex.Message}", "OK");
            }
        }

        public void ResetValues()
        {
            TimeLabel.Text = "00:00";
            StepsLabel.Text = "0";
            CaloriesLabel.Text = "0.00";
            PaceLabel.Text = "00:00";
            DistanceLabel.Text = "0.00 km";
        }

        private async void OnBackButtonClicked(object sender, EventArgs e)
        {
            await Navigation.PopToRootAsync(); // Powrót do strony g³ównej


            ResetValues(); 

        }

        public static ILayer CreateLineStringLayer(IStyle style, List<(double Latitude, double Longitude)> coordinates)
        {
            // Je¿eli lista wspó³rzêdnych jest pusta, nie twórz linii
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


    }
}



