namespace running_club.Pages;
using Firebase.Database;
using Firebase.Database.Query;
using System.Collections.ObjectModel;

#if ANDROID
using running_club.Platforms.Android; 
#endif

/// @brief Strona dodawania celow
public partial class AddGoalsPage : ContentPage
{
    private readonly FirebaseClient _firebaseClient;

#if ANDROID
        private LightSensorService _lightSensorService;
#endif
    private bool _isWaiting = false;

    public ObservableCollection<Goals> MyGoalsList { get; set; } = new ObservableCollection<Goals>();
    int count = 0;


    /// @brief Konstruktor klasy AddGoalsPage
    public AddGoalsPage()
	{
		InitializeComponent();
        BindingContext = this;
        _firebaseClient = new FirebaseClient("https://running-club-5b96d-default-rtdb.europe-west1.firebasedatabase.app/");

#if ANDROID
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; 
    }
#endif

    }

    /// @brief Funkcja nawigujaca do strony celow
    private async void NavigateToPage(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new GoalsPage());
    }

    /// @brief Funkcja zapisujaca cele
    private async void OnSave(object sender, EventArgs e)
    {
        string uid = await SecureStorage.GetAsync("user_uid");

        DateTime selectedDate = DatePickerControl.Date;

        string formattedDate = selectedDate.ToString("yyyy-MM-dd");


        _firebaseClient.Child(uid).Child("Goals").PostAsync(new Goals
        {
            Kcal = EntryKcal.Text,
            Distance = EntryDistance.Text,
            Steps = EntrySteps.Text,
            data = formattedDate,
        });

        EntryKcal.Text = string.Empty;
        EntryDistance.Text = string.Empty;
        EntrySteps.Text = string.Empty;


        NavigateToPage(sender , e);
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