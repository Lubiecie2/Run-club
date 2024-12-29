using Firebase.Database;
using Firebase.Database.Query;
using Firebase.Auth;
using System.Collections.ObjectModel;
using running_club.Pages;

#if ANDROID
using running_club.Platforms.Android; 
#endif

namespace running_club.Pages;

public partial class GoalsPage : ContentPage
{
    private readonly FirebaseClient _firebaseClient;

#if ANDROID
        private LightSensorService _lightSensorService;
#endif
    private bool _isWaiting = false;

    // Kolekcja do przechowywania cel�w u�ytkownika
    public ObservableCollection<Goals> MyGoalsList { get; set; } = new ObservableCollection<Goals>();

    public GoalsPage()
    {
        InitializeComponent();
        BindingContext = this;

        // Inicjalizacja Firebase
        _firebaseClient = new FirebaseClient("https://running-club-5b96d-default-rtdb.europe-west1.firebasedatabase.app/");

        // Wczytaj dane
        LoadDataAsync();

#if ANDROID
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; 
    }
#endif
    }

    private async void NavigateToPage(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new AddGoalsPage());
    }

    public async Task LoadDataAsync()
    {
        // Pobranie UID u�ytkownika
        string uid = await SecureStorage.GetAsync("user_uid");

        // Pobierz cele u�ytkownika z bazy danych
        MyGoalsList.Clear();
        var goals = (await _firebaseClient
            .Child(uid)
            .Child("Goals")
            .OnceAsync<Goals>())
            .Select(item => item.Object)
            .ToList();

        // Pobierz histori� trening�w z bazy danych
        var history = (await _firebaseClient
            .Child(uid)
            .Child("History")
            .OnceAsync<History>())
            .Select(item => item.Object)
            .ToList();

        // Por�wnaj cele z histori� trening�w i ustaw odpowiedni status
        foreach (var goal in goals)
        {
            bool isCompleted = history.Any(h => h.data == goal.data);
            goal.IsCompleted = isCompleted;
            goal.GoalImage = isCompleted ? "checked.png" : "multiply.png"; // Ustaw obrazek w zale�no�ci od statusu celu

            MyGoalsList.Add(goal);
        }
    }

    protected override async void OnNavigatedTo(NavigatedToEventArgs args)
    {
        base.OnNavigatedTo(args);

        await LoadDataAsync();
    }
#if ANDROID
private async void OnLightLevelChanged(float lightLevel)
{
    if (_isWaiting)
        return;

    _isWaiting = true;
    await Task.Delay(3000); // Czekaj przez 3 sekundy, aby nie za cz�sto zmienia� kolor

    // Zmieniamy t�o strony na podstawie poziomu �wiat�a
    if (lightLevel < 10) // Niski poziom �wiat�a
    {
        this.BackgroundColor = new Microsoft.Maui.Graphics.Color(170 / 255f, 170 / 255f, 170 / 255f);
       
    }
    else // Wysoki poziom �wiat�a
    {
        this.BackgroundColor = Colors.White; // Jasne t�o
    }

    _isWaiting = false;
}


#endif

    protected override void OnDisappearing()
    {
        base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop(); // Zatrzymanie detekcji �wiat�a
#endif
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();

#if ANDROID
            // Uruchamianie czujnika po powrocie na stron�
            _lightSensorService?.Start();
#endif
    }
}

