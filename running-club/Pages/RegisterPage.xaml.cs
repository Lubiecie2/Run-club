using System.Text.RegularExpressions;

#if ANDROID
using running_club.Platforms.Android; 
#endif

namespace running_club.Pages;

/// @brief Klasa reprezentująca stronę rejestracji w aplikacji.
/// @details Obsługuje rejestrację nowego użytkownika, walidację danych oraz obsługę czujnika światła na platformie Android.
public partial class RegisterPage : ContentPage
{
    /// @brief Serwis Firebase do obsługi uwierzytelniania.
    private FirebaseAuthService _authService;

#if ANDROID
    /// @brief Serwis obsługujący czujnik światła na platformie Android.
    private LightSensorService _lightSensorService;
#endif
    /// @brief Flaga wskazująca, czy aplikacja oczekuje na wykonanie operacji.
    private bool _isWaiting = false;

    /// @brief Konstruktor klasy RegisterPage.
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

    /// @brief Obsługuje kliknięcie linku do strony logowania.
    /// @param sender Obiekt, który wywołał zdarzenie.
    /// @param e Argumenty zdarzenia.
    private async void OnLoginLinkTapped(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new LoginPage());
    }

    /// @brief Obsługuje kliknięcie przycisku rejestracji.
    /// @param sender Obiekt, który wywołał zdarzenie.
    /// @param e Argumenty zdarzenia.
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
            StatusLabel.Text = result; 
        }
        else
        {
            StatusLabel.Text = "Pomyślnie utworzono konto!";
            StatusLabel.TextColor = Colors.Green;
            EmailEntry.Text = string.Empty;
            PasswordEntry.Text = string.Empty;
            ConfirmPasswordEntry.Text = string.Empty;
        }
    }

    /// @brief Sprawdza poprawność formatu adresu e-mail.
    /// @param email Adres e-mail do sprawdzenia.
    /// @return True, jeśli adres e-mail jest poprawny; w przeciwnym razie False.
    private bool IsValidEmail(string email)
    {
        string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
        return Regex.IsMatch(email, emailPattern);
    }
#if ANDROID

    /// @brief Obsługuje zmiany poziomu światła wykryte przez czujnik.
    /// @param lightLevel Poziom światła wykryty przez czujnik.
    private async void OnLightLevelChanged(float lightLevel)
{
    if (_isWaiting)
        return;

    _isWaiting = true;
    await Task.Delay(3000);

    if (lightLevel < 10) 
    {
        this.BackgroundColor = new Microsoft.Maui.Graphics.Color(170 / 255f, 170 / 255f, 170 / 255f);
       
    }
    else 
    {
        this.BackgroundColor = Colors.White; 
    }

    _isWaiting = false;
}
#endif

    /// @brief Wykonywane, gdy strona znika.
    protected override void OnDisappearing()
    {
        base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop();
#endif
    }

    /// @brief Wykonywane, gdy strona pojawia się ponownie.
    protected override void OnAppearing()
    {
        base.OnAppearing();

#if ANDROID
            _lightSensorService?.Start();
#endif
    }
}


