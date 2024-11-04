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
            StatusLabel.Text = "Has³a s¹ ró¿ne!";
            StatusLabel.TextColor = Colors.Red;
            return;
        }

        if (!IsValidEmail(email))
        {
            StatusLabel.Text = "Nieprawid³owy format adresu e-mail!";
            StatusLabel.TextColor = Colors.Red;
            return;
        }

        if (password.Length < 6)
        {
            StatusLabel.Text = "Has³o musi siê sk³adaæ z minimum 6 znaków!";
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
            StatusLabel.Text = "Pomyœlnie utworzono konto!";
            //StatusLabel.Text = "Mo¿esz teraz siê zalogowaæ!";
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