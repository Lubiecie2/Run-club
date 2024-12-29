#if ANDROID
using running_club.Platforms.Android; 
#endif

namespace running_club.Pages
{
    public partial class ProfilPage : ContentPage
    {
        private FirebaseAuthService _authService;

#if ANDROID
        private LightSensorService _lightSensorService;
#endif
        private bool _isWaiting = false;

        public ProfilPage()
        {
            InitializeComponent();
            _authService = new FirebaseAuthService();
            DisplayUserEmail();  // Wywo³uje funkcjê asynchroniczn¹ do wyœwietlenia adresu email

#if ANDROID
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; 
    }
#endif

        }

        private async void DisplayUserEmail()
        {
            var email = await _authService.GetCurrentUserEmailAsync();
            EmailLabel.Text = $"Witaj, {email}";  // Aktualizuje etykietê email
        }
        private async void OnLogoutButtonClicked(object sender, EventArgs e)
        {
            await _authService.LogoutAsync(); // Wylogowanie i czyszczenie danych u¿ytkownika
            MessagingCenter.Send<string>("", "Logout"); // Wys³anie wiadomoœci do LoginPage
            await Shell.Current.GoToAsync("//LoginPage"); // Przeniesienie do strony logowania
        }
        private void OnCalculateCaloriesClicked(object sender, EventArgs e)
        {

            if (double.TryParse(WeightEntry.Text, out double weight) &&
                double.TryParse(HeightEntry.Text, out double height) &&
                double.TryParse(AgeEntry.Text, out double age) &&
                GenderPicker.SelectedItem != null &&
                ActivityLevelPicker.SelectedItem != null)
            {

                bool isFemale = GenderPicker.SelectedItem.ToString() == "Kobieta";


                double activityMultiplier = GetActivityMultiplier(ActivityLevelPicker.SelectedItem.ToString());


                double bmr = CalculateBMR(weight, height, age, isFemale);


                double caloriesToMaintain = bmr * activityMultiplier;
                double caloriesToLose = caloriesToMaintain - 500;
                double caloriesToGain = caloriesToMaintain + 500;


                CaloriesMaintainLabel.Text = $"Utrzymanie wagi: {Math.Round(caloriesToMaintain)} kcal";
                CaloriesDeficitLabel.Text = $"Aby schudn¹æ: {Math.Round(caloriesToLose)} kcal";
                CaloriesSurplusLabel.Text = $"Aby przytyæ: {Math.Round(caloriesToGain)} kcal";
            }
            else
            {

                DisplayAlert("B³¹d", "Proszê wprowadziæ wszystkie dane.", "OK");
            }
        }

        private double CalculateBMR(double weight, double height, double age, bool isFemale)
        {
            // Mifflin-St Jeor Equation
            return isFemale
                ? 10 * weight + 6.25 * height - 5 * age - 161 // Kobiety
                : 10 * weight + 6.25 * height - 5 * age + 5;  // Mê¿czyŸni
        }

        private double GetActivityMultiplier(string activityLevel)
        {
            switch (activityLevel)
            {
                case "Brak aktywnoœci":
                    return 1.2;
                case "Ma³a aktywnoœæ":
                    return 1.375;
                case "Umiarkowana aktywnoœæ":
                    return 1.55;
                case "Wysoka aktywnoœæ":
                    return 1.725;
                case "Bardzo wysoka aktywnoœæ":
                    return 1.9;
                default:
                    return 1.0;
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
}