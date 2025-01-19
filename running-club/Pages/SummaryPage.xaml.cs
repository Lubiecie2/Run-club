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

#if ANDROID
using running_club.Platforms.Android; 
#endif

namespace running_club.Pages
{
    /// @brief Klasa reprezentujaca strone podsumowania aktywnosci.
    public partial class SummaryPage : ContentPage
    {
        private MemoryLayer? _lineStringLayer;
        private readonly FirebaseClient _firebaseClient;

#if ANDROID
        private LightSensorService _lightSensorService;
#endif
        private bool _isWaiting = false;

        /// @brief Konstruktor klasy SummaryPage.
        public SummaryPage(string time, int steps, double calories, string pace, double distance, List<(double Latitude, double Longitude)> routeCoordinates)
        {
            InitializeComponent();

            
            TimeLabel.Text = time;
            StepsLabel.Text = steps.ToString();
            CaloriesLabel.Text = calories.ToString("F2");
            PaceLabel.Text = pace;
            DistanceLabel.Text = distance.ToString("F2");

            BindingContext = this;
            _firebaseClient = new FirebaseClient("https://running-club-5b96d-default-rtdb.europe-west1.firebasedatabase.app/");

            OnSave(time, steps, calories, pace, distance, routeCoordinates);

            
            var tileLayer = OpenStreetMap.CreateTileLayer();
            SummaryMapView.Map = new Mapsui.Map
            {
                Layers = { tileLayer }
            };

            
            CenterMapOnFirstCoordinate(routeCoordinates);

            
            _lineStringLayer = (MemoryLayer?)CreateLineStringLayer(CreateLineStringStyle(), routeCoordinates);
            SummaryMapView.Map.Layers.Add(_lineStringLayer);

#if ANDROID
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; 
    }
#endif
        }

        /// @brief Funkcja zapisujaca dane o aktywnosci do bazy Firebase.
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


        /// @brief Funkcja centrujaca mape na pierwszej wspolrzednej.
        private void CenterMapOnFirstCoordinate(List<(double Latitude, double Longitude)> coordinates)
        {
            if (coordinates.Count > 0)
            {
                
                var firstCoordinate = coordinates.First();

                
                var sphericalMercatorCoordinate = SphericalMercator.FromLonLat(firstCoordinate.Longitude, firstCoordinate.Latitude).ToMPoint();

                Console.WriteLine($"Centrowanie mapy na wspó³rzêdnych: {firstCoordinate.Latitude}, {firstCoordinate.Longitude}");

                
                SummaryMapView.Map.Home = n => n.CenterOn(sphericalMercatorCoordinate);
                SummaryMapView.Map.Navigator.ZoomTo(2); 
            }
            else
            {
                Console.WriteLine("Brak wspó³rzêdnych do ustawienia widoku mapy.");
            }
        }

        /// @brief Funkcja tworzaca warstwe liniowa na podstawie wspolrzednych.
        public static ILayer CreateLineStringLayer(IStyle style, List<(double Latitude, double Longitude)> coordinates)
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

        /// @brief Funkcja tworzaca styl dla warstwy liniowej.
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

        /// @brief Funkcja wywolywana
        private async void OnBackButtonClicked(object sender, EventArgs e)
        {
            await Navigation.PopToRootAsync(); 
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

}
