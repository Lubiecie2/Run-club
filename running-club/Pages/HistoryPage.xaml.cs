using Firebase.Database;
using Firebase.Database.Query;
using Firebase.Auth;
using System.Collections.ObjectModel;
using running_club.Pages;
using ExCSS;

namespace running_club.Pages;

public partial class HistoryPage : ContentPage
{

    private readonly FirebaseClient _firebaseClient;
    public ObservableCollection<History> MyHistoryList { get; set; } = new ObservableCollection<History>();
    public HistoryPage()
	{
		InitializeComponent();

        BindingContext = this;
        _firebaseClient = new FirebaseClient("https://running-club-5b96d-default-rtdb.europe-west1.firebasedatabase.app/");

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
            // Nawigacja do strony szczegó³owej
            await Navigation.PushAsync(new HistoryDetailPage(selectedHistory));
        }

        // Odznaczanie wybranego elementu
        ((CollectionView)sender).SelectedItem = null;
    }
}