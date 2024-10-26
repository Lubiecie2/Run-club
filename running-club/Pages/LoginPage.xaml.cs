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
            ErrorLabel.Text = "Prosz� wprowadzi� Email i Has�o!";
            return;
        }

        if (!string.IsNullOrEmpty(result) && result.StartsWith("Error"))
        {
         
            if (result.Contains("invalid-email"))
            {
                ErrorLabel.Text = "Z�y mail!";
            }
            else if (result.Contains("wrong-password"))
            {
                ErrorLabel.Text = "B��dne has�o!";
            }
            else
            {
                ErrorLabel.Text = "B��dny Email lub Has�o!"; 
            }
        }
        else
        {

            await Shell.Current.GoToAsync("//Home");
        }
    }
}