namespace running_club.Pages;
using Firebase.Database;
using Firebase.Database.Query;
using System.Collections.ObjectModel;

public partial class AddGoalsPage : ContentPage
{
    private readonly FirebaseClient _firebaseClient;
    public ObservableCollection<Goals> MyGoalsList { get; set; } = new ObservableCollection<Goals>();
    int count = 0;



    public AddGoalsPage()
	{
		InitializeComponent();
        BindingContext = this;
        _firebaseClient = new FirebaseClient("https://running-club-5b96d-default-rtdb.europe-west1.firebasedatabase.app/");


    }
    private async void NavigateToPage(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new GoalsPage());
    }

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
}