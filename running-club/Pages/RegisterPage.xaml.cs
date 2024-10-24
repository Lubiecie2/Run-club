namespace running_club.Pages;

public partial class RegisterPage : ContentPage
{
   private FirebaseAuthService _authService;

    public RegisterPage()
	{
        InitializeComponent();
      _authService = new FirebaseAuthService();
    }
    private async void OnRegisterButtonClicked(object sender, EventArgs e)
    {
        string email = EmailEntry.Text;
        string password = PasswordEntry.Text;
        string confirmPassword = ConfirmPasswordEntry.Text;

        // Check if passwords match
        if (password != confirmPassword)
        {
            StatusLabel.Text = "Passwords do not match!";
            return;
        }

        // Call the Firebase Auth Service to register the user
        string result = await _authService.RegisterWithEmailAndPasswordAsync(email, password);

        // Check the result and update the UI accordingly
        if (!string.IsNullOrEmpty(result) && result.StartsWith("Error"))
        {
            StatusLabel.Text = result; // Show the error message
        }
        else
        {
            await DisplayAlert("Registration Success", "Account created successfully!", "OK");
            // Optionally, navigate to a new page or log the user in automatically
            // await Navigation.PushAsync(new LoginPage());
        }
    }
}