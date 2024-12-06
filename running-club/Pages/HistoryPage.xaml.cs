using Firebase.Database;
using Firebase.Database.Query;
using Firebase.Auth;
using System.Collections.ObjectModel;
using running_club.Pages;

#if ANDROID
using running_club.Platforms.Android; 
#endif

namespace running_club.Pages
{
    public partial class HistoryPage : ContentPage
    {
        private readonly FirebaseClient _firebaseClient;
        public ObservableCollection<History> MyHistoryList { get; set; } = new ObservableCollection<History>();

#if ANDROID
        private LightSensorService _lightSensorService;
#endif
        private bool _isDarkMode = false;

        public HistoryPage()
        {
            // Domy�lnie ustawiamy tryb jasny
            InitializeLightOrDarkModeUI(0); // Zaczynamy od jasnego motywu

#if ANDROID
            // Pobranie instancji LightSensorService
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
            if (_lightSensorService != null)
            {
                _lightSensorService.LightLevelChanged += OnLightLevelChanged; // Subskrybuj zdarzenie
            }
#endif

            BindingContext = this;
            _firebaseClient = new FirebaseClient("https://running-club-5b96d-default-rtdb.europe-west1.firebasedatabase.app/");

            LoadDataAsync();
        }

        // Ta metoda b�dzie nas�uchiwa� zmian poziomu �wiat�a i zmienia� tryb
        private async void OnLightLevelChanged(float lightLevel)
        {
            bool shouldBeDark = lightLevel < 10; // Je�li �wiat�o poni�ej 10 luks�w, prze��czamy na ciemny motyw

            // Je�li aktualny tryb r�ni si� od wykrytego, zmieniamy motyw
            if (shouldBeDark != _isDarkMode)
            {
                _isDarkMode = shouldBeDark;
                InitializeLightOrDarkModeUI(lightLevel); // Zmieniamy widok
            }
        }

        // �adowanie odpowiedniego widoku na podstawie trybu
        private void InitializeLightOrDarkModeUI(float lightLevel)
        {
            if (_isDarkMode)
            {
                // Za�aduj ciemny motyw
                this.LoadFromXaml(typeof(HistoryPageDark));
            }
            else
            {
                // Za�aduj jasny motyw
                this.LoadFromXaml(typeof(HistoryPage));
            }
        }

        public async Task LoadDataAsync()
        {
            string uid = await SecureStorage.GetAsync("user_uid");

            MyHistoryList.Clear();
            var result = _firebaseClient.Child(uid).Child("History").AsObservable<History>().Subscribe((item) =>
            {
                if (item.Object != null)
                {
                    MyHistoryList.Add(item.Object);
                }
            });
        }

        private async void OnHistoryItemSelected(object sender, SelectionChangedEventArgs e)
        {
            // Pobranie wybranego elementu
            if (e.CurrentSelection.FirstOrDefault() is History selectedHistory)
            {
                // Nawigacja do strony szczeg�owej
                await Navigation.PushAsync(new HistoryDetailPage(selectedHistory));
            }

            // Odznaczanie wybranego elementu
            ((CollectionView)sender).SelectedItem = null;
        }

        protected override void OnAppearing()
        {
            base.OnAppearing();
#if ANDROID
            _lightSensorService?.Start(); // Rozpoczynamy nas�uchiwanie zmian poziomu �wiat�a
#endif
        }

        protected override void OnDisappearing()
        {
            base.OnDisappearing();
#if ANDROID
            _lightSensorService?.Stop(); // Zatrzymujemy nas�uchiwanie zmian poziomu �wiat�a
#endif
        }
    }
}
