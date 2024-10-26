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
        
        await Navigation.PushAsync(new RegisterPage());
    }

    private async void OnLoginButtonClicked(object sender, EventArgs e)
    {
        string email = EmailEntry.Text;
        string password = PasswordEntry.Text;

        ErrorLabel.Text = string.Empty;

        
        string result = await _authService.SignInWithEmailAndPasswordAsync(email, password);

      
        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
        {
            ErrorLabel.Text = "Proszê wprowadziæ Email i Has³o!";
            return;
        }

        if (!string.IsNullOrEmpty(result) && result.StartsWith("Error"))
        {
         
            if (result.Contains("invalid-email"))
            {
                ErrorLabel.Text = "Z³y mail!";
            }
            else if (result.Contains("wrong-password"))
            {
                ErrorLabel.Text = "B³êdne has³o!";
            }
            else
            {
                ErrorLabel.Text = "B³êdny Email lub Has³o!"; 
            }
        }
        else
        {

            await Shell.Current.GoToAsync("//Home");
        }
    }
}