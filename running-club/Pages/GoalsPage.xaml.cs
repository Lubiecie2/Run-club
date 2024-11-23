using Firebase.Database;
using Firebase.Database.Query;
using Firebase.Auth;
using System.Collections.ObjectModel;
using running_club.Pages;
using ExCSS;

namespace running_club.Pages;

public partial class GoalsPage : ContentPage
{

    private readonly FirebaseClient _firebaseClient;
    public ObservableCollection<Goals> MyGoalsList { get; set; } = new ObservableCollection<Goals>();


    public GoalsPage()
    {
        InitializeComponent();
        BindingContext = this;
        _firebaseClient = new FirebaseClient("https://running-club-5b96d-default-rtdb.europe-west1.firebasedatabase.app/");

        LoadDataAsync();
    }
    private async void NavigateToPage(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new AddGoalsPage());
    }

    public async Task LoadDataAsync()

    {
        string  uid = await SecureStorage.GetAsync("user_uid");


        MyGoalsList.Clear();
        var result = _firebaseClient.Child(uid).Child("Goals").AsObservable<Goals>().Subscribe((item) =>
        {

            if (item.Object != null)
            {
                MyGoalsList.Add(item.Object);
            }
        });
    }

    protected override async void OnNavigatedTo(NavigatedToEventArgs args)
    {
        base.OnNavigatedTo(args);
        await LoadDataAsync();
    }
}