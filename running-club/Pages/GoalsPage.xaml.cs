using Firebase.Database;
using Firebase.Database.Query;
using Firebase.Auth;
using System.Collections.ObjectModel;
using running_club.Pages;

#if ANDROID
using running_club.Platforms.Android; 
#endif

namespace running_club.Pages;

/// @brief Klasa reprezentuj¹ca stronê z celami u¿ytkownika.
/// @details Obs³uguje pobieranie celów z Firebase, ich aktualizacjê, oraz dynamiczne zmiany interfejsu w zale¿noœci od poziomu œwiat³a na platformie Android.
public partial class GoalsPage : ContentPage
{
    /// @brief Klient Firebase do komunikacji z baz¹ danych.
    private readonly FirebaseClient _firebaseClient;

#if ANDROID
    /// @brief Serwis obs³uguj¹cy czujnik œwiat³a na platformie Android.
    private LightSensorService _lightSensorService;
#endif
    /// @brief Flaga wskazuj¹ca, czy aplikacja oczekuje na zakoñczenie operacji zwi¹zanej z czujnikiem œwiat³a.
    private bool _isWaiting = false;

    /// @brief Kolekcja przechowuj¹ca listê celów u¿ytkownika.
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

    /// @brief Nawiguje do strony umo¿liwiaj¹cej dodanie nowych celów.
    /// @param sender Obiekt wywo³uj¹cy zdarzenie.
    /// @param e Argumenty zdarzenia.
    private async void NavigateToPage(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new AddGoalsPage());
    }

    /// @brief Asynchronicznie ³aduje cele i sprawdza ich status w oparciu o historiê u¿ytkownika.
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

    /// @brief Wywo³ywana, gdy strona jest nawigowana.
    /// @param args Argumenty nawigacji.
    protected override async void OnNavigatedTo(NavigatedToEventArgs args)
    {
        base.OnNavigatedTo(args);

        await LoadDataAsync();
    }
#if ANDROID

    /// @brief Obs³uguje zmiany poziomu œwiat³a wykryte przez czujnik.
    /// @param lightLevel Aktualny poziom œwiat³a wykryty przez czujnik.
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
    /// @brief Wywo³ywana, gdy strona przestaje byæ wyœwietlana.
    protected override void OnDisappearing()
    {
        base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop();
#endif
    }

    /// @brief Wywo³ywana, gdy strona pojawia siê ponownie.
    protected override void OnAppearing()
    {
        base.OnAppearing();

#if ANDROID
            
            _lightSensorService?.Start();
#endif
    }
}

