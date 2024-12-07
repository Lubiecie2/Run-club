using Firebase.Database;
using Firebase.Database.Query;
using Firebase.Auth;
using System.Collections.ObjectModel;
using running_club.Pages;

#if ANDROID
using running_club.Platforms.Android; 
#endif


namespace running_club.Pages;

public partial class HistoryPage : ContentPage
{

    private readonly FirebaseClient _firebaseClient;
    public ObservableCollection<History> MyHistoryList { get; set; } = new ObservableCollection<History>();

#if ANDROID
        private LightSensorService _lightSensorService;
#endif
    private bool _isWaiting = false;

    public HistoryPage()
    {
        InitializeComponent();

        BindingContext = this;
        _firebaseClient = new FirebaseClient("https://running-club-5b96d-default-rtdb.europe-west1.firebasedatabase.app/");

#if ANDROID
    // Pobranie instancji LightSensorService
   
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; // Subskrybuj zdarzenie
    }
#endif

        LoadDataAsync();

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
            // Nawigacja do strony szczegółowej
            await Navigation.PushAsync(new HistoryDetailPage(selectedHistory));
        }

        // Odznaczanie wybranego elementu
        ((CollectionView)sender).SelectedItem = null;
    }

#if ANDROID
private async void OnLightLevelChanged(float lightLevel)
{
    if (_isWaiting)
        return;

    _isWaiting = true;
    await Task.Delay(3000); // Czekaj przez 3 sekundy, aby nie za często zmieniać kolor

    // Zmieniamy tło strony na podstawie poziomu światła
    if (lightLevel < 10) // Niski poziom światła
    {
        this.BackgroundColor = new Microsoft.Maui.Graphics.Color(170 / 255f, 170 / 255f, 170 / 255f);
        UpdateTextColor(Colors.White); // Kolor tekstu na biały
    }
    else // Wysoki poziom światła
    {
        this.BackgroundColor = Colors.White; // Jasne tło
        UpdateTextColor(Colors.Red); // Kolor tekstu na czerwony
    }

    _isWaiting = false;
}


private void UpdateTextColor(Microsoft.Maui.Graphics.Color textColor)
{
    UpdateTextColorRecursively(this.Content, textColor); // Zmieniamy kolor dla wszystkich kontrolek na stronie
}

private void UpdateTextColorRecursively(IView view, Microsoft.Maui.Graphics.Color textColor)
{
    // Jeśli kontrolka jest typu Label, zmieniamy jej kolor tekstu
    if (view is Microsoft.Maui.Controls.Label label)
    {
        label.TextColor = textColor;
    }
    else if (view is Microsoft.Maui.Controls.Button button)
    {
        button.TextColor = textColor; // Zmieniamy tekst Button
    }
    else if (view is Microsoft.Maui.Controls.Entry entry)
    {
        entry.TextColor = textColor; // Zmieniamy tekst Entry
    }

    // Jeśli kontrolka jest Layout-em, sprawdzamy wszystkie dzieci
    if (view is Microsoft.Maui.Controls.Layout layout)
    {
        foreach (var child in layout.Children)
        {
            UpdateTextColorRecursively(child, textColor); // Rekurencyjnie sprawdzamy dzieci
        }
    }
}
#endif

    protected override void OnDisappearing()
    {
        base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop(); // Zatrzymanie detekcji światła
#endif
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();

#if ANDROID
            // Uruchamianie czujnika po powrocie na stronę
            _lightSensorService?.Start();
#endif
    }
}