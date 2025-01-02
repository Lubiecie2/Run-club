using Firebase.Database;
using Firebase.Database.Query;
using Firebase.Auth;
using System.Collections.ObjectModel;
using running_club.Pages;

#if ANDROID
using running_club.Platforms.Android; 
#endif


namespace running_club.Pages;

/// @brief Klasa reprezentująca stronę historii aktywności.
/// @details Obsługuje pobieranie i wyświetlanie danych z Firebase, zarządza nawigacją do szczegółów aktywności oraz obsługuje czujnik światła na platformie Android.
public partial class HistoryPage : ContentPage
{
    /// @brief Klient Firebase do połączenia z bazą danych.
    private readonly FirebaseClient _firebaseClient;

    /// @brief Kolekcja przechowująca dane o historii aktywności.
    public ObservableCollection<History> MyHistoryList { get; set; } = new ObservableCollection<History>();

#if ANDROID
    /// @brief Serwis do obsługi czujnika światła na platformie Android.
    private LightSensorService _lightSensorService;
#endif
    /// @brief Flaga wskazująca, czy aplikacja oczekuje na wykonanie operacji związanej z czujnikiem światła.
    private bool _isWaiting = false;

    /// @brief Konstruktor klasy HistoryPage.
    public HistoryPage()
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

        LoadDataAsync();

    }

    /// @brief Asynchronicznie ładuje dane o historii aktywności użytkownika z Firebase.
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

    /// @brief Obsługuje wybór elementu z listy historii.
    /// @param sender Obiekt, który wywołał zdarzenie.
    /// @param e Argumenty zdarzenia SelectionChangedEventArgs.
    private async void OnHistoryItemSelected(object sender, SelectionChangedEventArgs e)
    {
        if (e.CurrentSelection.FirstOrDefault() is History selectedHistory)
        {
            await Navigation.PushAsync(new HistoryDetailPage(selectedHistory));
        }
        ((CollectionView)sender).SelectedItem = null;
    }

#if ANDROID

    /// @brief Obsługuje zmiany poziomu światła wykryte przez czujnik.
    /// @param lightLevel Aktualny poziom światła wykryty przez czujnik.
    private async void OnLightLevelChanged(float lightLevel)
    {
    if (_isWaiting)
        return;

    _isWaiting = true;
    await Task.Delay(3000); 


    if (lightLevel < 10)
    {
        this.BackgroundColor = new Microsoft.Maui.Graphics.Color(170 / 255f, 170 / 255f, 170 / 255f);
        UpdateTextColor(Colors.White);
    }
    else 
    {
        this.BackgroundColor = Colors.White;
        UpdateTextColor(Colors.Red); 
    }
    _isWaiting = false;
}

    /// @brief Zmienia kolor tekstu na stronie.
    /// @param textColor Kolor, na który zmieniony zostanie tekst.
    private void UpdateTextColor(Microsoft.Maui.Graphics.Color textColor)
    {
    UpdateTextColorRecursively(this.Content, textColor); 
    }

private void UpdateTextColorRecursively(IView view, Microsoft.Maui.Graphics.Color textColor)
{
    if (view is Microsoft.Maui.Controls.Label label)
    {
        label.TextColor = textColor;
    }
    else if (view is Microsoft.Maui.Controls.Button button)
    {
        button.TextColor = textColor;
    }
    else if (view is Microsoft.Maui.Controls.Entry entry)
    {
        entry.TextColor = textColor; 
    }

    if (view is Microsoft.Maui.Controls.Layout layout)
    {
        foreach (var child in layout.Children)
        {
            UpdateTextColorRecursively(child, textColor);
        }
    }
}
#endif

    protected override void OnDisappearing()
    {
        base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop();
#endif
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();

#if ANDROID
            _lightSensorService?.Start();
#endif
    }
}