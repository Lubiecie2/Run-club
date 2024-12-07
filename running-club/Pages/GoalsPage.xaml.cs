using Firebase.Database;
using Firebase.Database.Query;
using Firebase.Auth;
using System.Collections.ObjectModel;
using running_club.Pages;

namespace running_club.Pages;

public partial class GoalsPage : ContentPage
{
    private readonly FirebaseClient _firebaseClient;

    // Kolekcja do przechowywania celów u¿ytkownika
    public ObservableCollection<Goals> MyGoalsList { get; set; } = new ObservableCollection<Goals>();

    public GoalsPage()
    {
        InitializeComponent();
        BindingContext = this;

        // Inicjalizacja Firebase
        _firebaseClient = new FirebaseClient("https://running-club-5b96d-default-rtdb.europe-west1.firebasedatabase.app/");

        // Wczytaj dane
        LoadDataAsync();
    }

    private async void NavigateToPage(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new AddGoalsPage());
    }

    public async Task LoadDataAsync()
    {
        // Pobranie UID u¿ytkownika
        string uid = await SecureStorage.GetAsync("user_uid");

        // Pobierz cele u¿ytkownika z bazy danych
        MyGoalsList.Clear();
        var goals = (await _firebaseClient
            .Child(uid)
            .Child("Goals")
            .OnceAsync<Goals>())
            .Select(item => item.Object)
            .ToList();

        // Pobierz historiê treningów z bazy danych
        var history = (await _firebaseClient
            .Child(uid)
            .Child("History")
            .OnceAsync<History>())
            .Select(item => item.Object)
            .ToList();

        // Porównaj cele z histori¹ treningów i ustaw odpowiedni status
        foreach (var goal in goals)
        {
            bool isCompleted = history.Any(h => h.data == goal.data);
            goal.IsCompleted = isCompleted;
            goal.GoalImage = isCompleted ? "checked.png" : "multiply.png"; // Ustaw obrazek w zale¿noœci od statusu celu

            MyGoalsList.Add(goal);
        }
    }

    protected override async void OnNavigatedTo(NavigatedToEventArgs args)
    {
        base.OnNavigatedTo(args);

        await LoadDataAsync();
    }
}

