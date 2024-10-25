using System.Text.RegularExpressions;

namespace running_club.Pages;

public partial class RegisterPage : ContentPage
{
   private FirebaseAuthService _authService;

    public RegisterPage()
	{
        InitializeComponent();
      _authService = new FirebaseAuthService();
    }

    private async void OnLoginLinkTapped(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new LoginPage());
    }

    private async void OnRegisterButtonClicked(object sender, EventArgs e)
    {
        string email = EmailEntry.Text;
        string password = PasswordEntry.Text;
        string confirmPassword = ConfirmPasswordEntry.Text;

       
        if (password != confirmPassword)
        {
            StatusLabel.Text = "Has�a s� r�ne!";
            StatusLabel.TextColor = Colors.Red;
            return;
        }

        if (!IsValidEmail(email))
        {
            StatusLabel.Text = "Nieprawid�owy format adresu e-mail!";
            StatusLabel.TextColor = Colors.Red;
            return;
        }

        if (password.Length < 6)  
        {
            StatusLabel.Text = "Has�o musi si� sk�ada� z minimum 6 znak�w!";
            StatusLabel.TextColor = Colors.Red;
            return;
        }



       
        string result = await _authService.RegisterWithEmailAndPasswordAsync(email, password);

       
        if (!string.IsNullOrEmpty(result) && result.StartsWith("Error"))
        {
            StatusLabel.Text = result; // Show the error message
        }
        else
        {
            StatusLabel.Text = "Pomy�lnie utworzono konto!";
            //StatusLabel.Text = "Mo�esz teraz si� zalogowa�!";
            StatusLabel.TextColor = Colors.Green;

            //await DisplayAlert("Registration Success", "Account created successfully!", "OK");
            // Optionally, navigate to a new page or log the user in automatically
            // await Navigation.PushAsync(new LoginPage());

            EmailEntry.Text = string.Empty;
            PasswordEntry.Text = string.Empty;
            ConfirmPasswordEntry.Text = string.Empty;
        }
    }
    private bool IsValidEmail(string email)
    {
        string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
        return Regex.IsMatch(email, emailPattern);
    }
}