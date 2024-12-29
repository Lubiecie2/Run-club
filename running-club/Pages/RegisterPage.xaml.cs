using System.Text.RegularExpressions;

#if ANDROID
using running_club.Platforms.Android; 
#endif

namespace running_club.Pages;

public partial class RegisterPage : ContentPage
{
    private FirebaseAuthService _authService;

    #if ANDROID
        private LightSensorService _lightSensorService;
    #endif
    private bool _isWaiting = false;

    public RegisterPage()
    {
        InitializeComponent();
        _authService = new FirebaseAuthService();

#if ANDROID
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; 
    }
#endif
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
            StatusLabel.Text = "Nieprawidłowy format adresu e-mail!";
            StatusLabel.TextColor = Colors.Red;
            return;
        }

        if (password.Length < 6)
        {
            StatusLabel.Text = "Hasło musi się składać z minimum 6 znaków!";
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
            StatusLabel.Text = "Pomyślnie utworzono konto!";

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
#if ANDROID
private async void OnLightLevelChanged(float lightLevel)
{
    if (_isWaiting)
        return;

    _isWaiting = true;
    await Task.Delay(3000); // Czekaj przez 3 sekundy, aby nie za często zmieniać kolor

    // Zmieniamy tło strony na podstawie poziomu światła
    if (lightLevel < 10) // Niski poziom światła
    {
        this.BackgroundColor = new Microsoft.Maui.Graphics.Color(170 / 255f, 170 / 255f, 170 / 255f);
       
    }
    else // Wysoki poziom światła
    {
        this.BackgroundColor = Colors.White; // Jasne tło
    }

    _isWaiting = false;
}


#endif

    protected override void OnDisappearing()
    {
        base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop(); // Zatrzymanie detekcji światła
#endif
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();

#if ANDROID
            // Uruchamianie czujnika po powrocie na stronę
            _lightSensorService?.Start();
#endif
    }
}


