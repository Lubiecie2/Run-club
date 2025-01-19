using Firebase.Database;
using Firebase.Database.Query;
using Firebase.Auth;
using System.Collections.ObjectModel;
using running_club.Pages;

#if ANDROID
using running_club.Platforms.Android; 
#endif

namespace running_club.Pages;

/// @brief Klasa reprezentujaca strone z celami uzytkownika.
/// @details Obsluguje pobieranie celow z Firebase, ich aktualizacje, oraz dynamiczne zmiany interfejsu w zaleznosci od poziomu swiatla na platformie Android.
public partial class GoalsPage : ContentPage
{
    /// @brief Klient Firebase do komunikacji z baza danych.
    private readonly FirebaseClient _firebaseClient;

#if ANDROID
    /// @brief Serwis obslugujacy czujnik swiatla na platformie Android.
    private LightSensorService _lightSensorService;
#endif
    /// @brief Flaga wskazujaca, czy aplikacja oczekuje na zakonczenie operacji zwiazanej z czujnikiem swiatla.
    private bool _isWaiting = false;

    /// @brief Kolekcja przechowujaca liste celow uzytkownika.
    public ObservableCollection<Goals> MyGoalsList { get; set; } = new ObservableCollection<Goals>();

    /// @brief Konstruktor klasy GoalsPage.
    public GoalsPage()
    {
        InitializeComponent();
        BindingContext = this;


        _firebaseClient = new FirebaseClient("https://running-club-5b96d-default-rtdb.europe-west1.firebasedatabase.app/");


        LoadDataAsync();

#if ANDROID
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; 
    }
#endif
    }

    /// @brief Nawiguje do strony umozliwiajacej dodanie nowych celow.
    /// @param sender Obiekt wywolujacy zdarzenie.
    /// @param e Argumenty zdarzenia.
    private async void NavigateToPage(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new AddGoalsPage());
    }

    /// @brief Asynchronicznie laduje cele i sprawdza ich status w oparciu o historie uzytkownika.
    public async Task LoadDataAsync()
    {

        string uid = await SecureStorage.GetAsync("user_uid");

 
        MyGoalsList.Clear();
        var goals = (await _firebaseClient
            .Child(uid)
            .Child("Goals")
            .OnceAsync<Goals>())
            .Select(item => item.Object)
            .ToList();

        var history = (await _firebaseClient
            .Child(uid)
            .Child("History")
            .OnceAsync<History>())
            .Select(item => item.Object)
            .ToList();

        foreach (var goal in goals)
        {
            bool isCompleted = history.Any(h => h.data == goal.data);
            goal.IsCompleted = isCompleted;
            goal.GoalImage = isCompleted ? "checked.png" : "multiply.png"; 

            MyGoalsList.Add(goal);
        }
    }

    /// @brief Wywolana, gdy strona jest nawigowana.
    /// @param args Argumenty nawigacji.
    protected override async void OnNavigatedTo(NavigatedToEventArgs args)
    {
        base.OnNavigatedTo(args);

        await LoadDataAsync();
    }
#if ANDROID

    /// @brief Obsluguje zmiany poziomu swiatla wykryte przez czujnik.
    /// @param lightLevel Aktualny poziom swiatla wykryty przez czujnik.
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
    /// @brief Wywolana, gdy strona przestaje byc wyswietlana.
    protected override void OnDisappearing()
    {
        base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop();
#endif
    }

    /// @brief Wywolana, gdy strona pojawia sie ponownie.
    protected override void OnAppearing()
    {
        base.OnAppearing();

#if ANDROID
            
            _lightSensorService?.Start();
#endif
    }
}

