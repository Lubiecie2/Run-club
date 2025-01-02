using Firebase.Database;
using Firebase.Database.Query;
using Firebase.Auth;
using System.Collections.ObjectModel;
using running_club.Pages;

#if ANDROID
using running_club.Platforms.Android; 
#endif

namespace running_club.Pages;

/// @brief Klasa reprezentuj�ca stron� z celami u�ytkownika.
/// @details Obs�uguje pobieranie cel�w z Firebase, ich aktualizacj�, oraz dynamiczne zmiany interfejsu w zale�no�ci od poziomu �wiat�a na platformie Android.
public partial class GoalsPage : ContentPage
{
    /// @brief Klient Firebase do komunikacji z baz� danych.
    private readonly FirebaseClient _firebaseClient;

#if ANDROID
    /// @brief Serwis obs�uguj�cy czujnik �wiat�a na platformie Android.
    private LightSensorService _lightSensorService;
#endif
    /// @brief Flaga wskazuj�ca, czy aplikacja oczekuje na zako�czenie operacji zwi�zanej z czujnikiem �wiat�a.
    private bool _isWaiting = false;

    /// @brief Kolekcja przechowuj�ca list� cel�w u�ytkownika.
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

    /// @brief Nawiguje do strony umo�liwiaj�cej dodanie nowych cel�w.
    /// @param sender Obiekt wywo�uj�cy zdarzenie.
    /// @param e Argumenty zdarzenia.
    private async void NavigateToPage(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new AddGoalsPage());
    }

    /// @brief Asynchronicznie �aduje cele i sprawdza ich status w oparciu o histori� u�ytkownika.
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

    /// @brief Wywo�ywana, gdy strona jest nawigowana.
    /// @param args Argumenty nawigacji.
    protected override async void OnNavigatedTo(NavigatedToEventArgs args)
    {
        base.OnNavigatedTo(args);

        await LoadDataAsync();
    }
#if ANDROID

    /// @brief Obs�uguje zmiany poziomu �wiat�a wykryte przez czujnik.
    /// @param lightLevel Aktualny poziom �wiat�a wykryty przez czujnik.
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
    /// @brief Wywo�ywana, gdy strona przestaje by� wy�wietlana.
    protected override void OnDisappearing()
    {
        base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop();
#endif
    }

    /// @brief Wywo�ywana, gdy strona pojawia si� ponownie.
    protected override void OnAppearing()
    {
        base.OnAppearing();

#if ANDROID
            
            _lightSensorService?.Start();
#endif
    }
}

