namespace running_club.Pages;

public partial class LoginPage : ContentPage
{

    private FirebaseAuthService _authService;

    public LoginPage()
	{
        InitializeComponent();
        _authService = new FirebaseAuthService();

        var tapGestureRecognizer = new TapGestureRecognizer();
        tapGestureRecognizer.Tapped += OnRegisterLabelTapped;
        RegisterLabel.GestureRecognizers.Add(tapGestureRecognizer);
    }

    private async void OnRegisterLabelTapped(object sender, EventArgs e)
    {
        // Przenieœ u¿ytkownika do RegisterPage
        await Navigation.PushAsync(new RegisterPage());
    }

    private async void OnLoginButtonClicked(object sender, EventArgs e)
    {
        string email = EmailEntry.Text;
        string password = PasswordEntry.Text;

        string result = await _authService.SignInWithEmailAndPasswordAsync(email, password);

        if (!string.IsNullOrEmpty(result) && result.StartsWith("Error"))
        {
            await DisplayAlert("Login Failed", result, "OK");
        }
        else
        {
            await DisplayAlert("Login Success", "You have logged in successfully!", "OK");

            await Navigation.PushAsync(new HomePage());
        }
    }
}