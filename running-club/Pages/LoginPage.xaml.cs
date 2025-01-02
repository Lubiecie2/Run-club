using Microsoft.Maui.Controls;

#if ANDROID
using running_club.Platforms.Android; 
#endif

namespace running_club.Pages
{
    /// @brief Klasa reprezentuj¹ca stronê logowania w aplikacji.
    /// @details Obs³uguje logowanie u¿ytkownika, nawigacjê do rejestracji i inne funkcje.
    public partial class LoginPage : ContentPage
    {
#if ANDROID
        /// @brief Serwis obs³uguj¹cy czujnik œwiat³a na platformie Android.
        private LightSensorService _lightSensorService;
#endif
        /// @brief Serwis Firebase do uwierzytelniania u¿ytkowników.
        private FirebaseAuthService _authService;

        /// @brief Flaga wskazuj¹ca, czy aplikacja oczekuje na wykonanie operacji.
        private bool _isWaiting = false;

        /// @brief Konstruktor klasy LoginPage.
        public LoginPage()
        {
            InitializeComponent();
            _authService = new FirebaseAuthService();

            var tapGestureRecognizer = new TapGestureRecognizer();
            tapGestureRecognizer.Tapped += OnRegisterLabelTapped;
            RegisterLabel.GestureRecognizers.Add(tapGestureRecognizer);

#if ANDROID   
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; 
    }
#endif
            MessagingCenter.Subscribe<string>(this, "Logout", (sender) =>
            {
                ClearForm(); 
            });
        }

        /// @brief Obs³uguje klikniêcie etykiety rejestracji.
        /// @param sender Obiekt, który wywo³a³ zdarzenie.
        /// @param e Argumenty zdarzenia.
        private async void OnRegisterLabelTapped(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new RegisterPage());
        }

        /// @brief Obs³uguje klikniêcie przycisku logowania.
        /// @param sender Obiekt, który wywo³a³ zdarzenie.
        /// @param e Argumenty zdarzenia.
        private async void OnLoginButtonClicked(object sender, EventArgs e)
        {
            string email = EmailEntry.Text;
            string password = PasswordEntry.Text;

            ErrorLabel.Text = string.Empty;

           
            var result = await _authService.SignInWithEmailAndPasswordAsync(email, password);
            
            
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

        /// @brief Czyœci pola formularza logowania.
        private void ClearForm()
        {
           
            EmailEntry.Text = string.Empty;
            PasswordEntry.Text = string.Empty; 
        }
#if ANDROID

    /// @brief Obs³uguje zmiany poziomu œwiat³a wykryte przez czujnik.
    /// @param lightLevel Poziom œwiat³a wykryty przez czujnik.
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

        /// @brief Wykonywane, gdy strona pojawia siê ponownie.
        protected override void OnAppearing()
        {
            base.OnAppearing();

#if ANDROID
            _lightSensorService?.Start();
#endif
        }
    }

}
