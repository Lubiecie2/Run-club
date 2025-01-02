#if ANDROID
using running_club.Platforms.Android;
#endif

namespace running_club.Pages
{

    /// @class ProfilPage
    /// @brief Klasa reprezentujaca strone profilu w aplikacji.
    public partial class ProfilPage : ContentPage
    {
        /// @brief Serwis Firebase do zarzadzania uwierzytelnieniem.
        private FirebaseAuthService _authService;

#if ANDROID
        /// @brief Serwis czujnika swiatla na platformie Android.
        private LightSensorService _lightSensorService;
#endif
        /// @brief Flaga wskazujaca, czy aplikacja oczekuje na wykonanie operacji.
        private bool _isWaiting = false;

        /// @brief Konstruktor klasy ProfilPage.
        public ProfilPage()
        {
            InitializeComponent();
            _authService = new FirebaseAuthService();
            DisplayUserEmail();  

#if ANDROID
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; 
    }
#endif

        }
        /// @brief Wyswietla email zalogowanego uzytkownika.
        private async void DisplayUserEmail()
        {
            var email = await _authService.GetCurrentUserEmailAsync();
            EmailLabel.Text = $"Witaj, {email}";  
        }

        /// @brief Obsluguje wylogowanie uzytkownika.
        /// @param sender Obiekt, ktory wywolal zdarzenie.
        /// @param e Argumenty zdarzenia.
        private async void OnLogoutButtonClicked(object sender, EventArgs e)
        {
            await _authService.LogoutAsync(); // Wylogowanie i czyszczenie danych u¿ytkownika
            MessagingCenter.Send<string>("", "Logout"); // Wys³anie wiadomoœci do LoginPage
            await Shell.Current.GoToAsync("//LoginPage"); // Przeniesienie do strony logowania
        }

        /// @brief Oblicza zapotrzebowanie kaloryczne na podstawie danych uzytkownika.
        /// @param sender Obiekt, ktory wywolal zdarzenie.
        /// @param e Argumenty zdarzenia.
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

        /// @brief Oblicza podstawowa przemiane materii (BMR) uzytkownika.
        /// @param weight Waga uzytkownika w kilogramach.
        /// @param height Wzrost uzytkownika w centymetrach.
        /// @param age Wiek uzytkownika w latach.
        /// @param isFemale Czy uzytkownik jest kobieta.
        /// @return Wartosc BMR.
        private double CalculateBMR(double weight, double height, double age, bool isFemale)
        {
            // Mifflin-St Jeor Equation
            return isFemale
                ? 10 * weight + 6.25 * height - 5 * age - 161 // Kobiety
                : 10 * weight + 6.25 * height - 5 * age + 5;  // Mê¿czyŸni
        }

        /// @brief Zwraca mnoznik aktywnosci na podstawie wybranego poziomu aktywnosci.
        /// @param activityLevel Poziom aktywnosci wybrany przez uzytkownika.
        /// @return Mnoznik aktywnosci.
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
    /// @brief Obsluguje zmiany poziomu swiatla wykryte przez czujnik.
    /// @param lightLevel Poziom swiatla wykryty przez czujnik.
    private async void OnLightLevelChanged(float lightLevel)
    {
    if (_isWaiting)
        return;

    _isWaiting = true;
    await Task.Delay(3000); 

    if (lightLevel < 10) 
    {
        this.BackgroundColor = new Microsoft.Maui.Graphics.Color(170 / 255f, 170 / 255f, 170 / 255f);
       
    }
    else 
    {
        this.BackgroundColor = Colors.White; 
    }

    _isWaiting = false;
}


#endif
        /// @brief Wykonywane, gdy strona znika.
        protected override void OnDisappearing()
        {
            base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop(); 
#endif
        }
        /// @brief Wykonywane, gdy strona pojawia sie ponownie.
        protected override void OnAppearing()
        {
            base.OnAppearing();

#if ANDROID
            _lightSensorService?.Start();
#endif
        }
    }
}