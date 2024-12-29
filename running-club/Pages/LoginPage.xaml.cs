using Microsoft.Maui.Controls;

#if ANDROID
using running_club.Platforms.Android; 
#endif

namespace running_club.Pages
{
    public partial class LoginPage : ContentPage
    {
#if ANDROID
        private LightSensorService _lightSensorService;
#endif
        private FirebaseAuthService _authService;
        private bool _isWaiting = false;
        public LoginPage()
        {
            InitializeComponent();
            _authService = new FirebaseAuthService();

            var tapGestureRecognizer = new TapGestureRecognizer();
            tapGestureRecognizer.Tapped += OnRegisterLabelTapped;
            RegisterLabel.GestureRecognizers.Add(tapGestureRecognizer);

#if ANDROID
    // Pobranie instancji LightSensorService
   
            _lightSensorService = MauiApplication.Current.Services.GetService<LightSensorService>();
    {
        _lightSensorService.LightLevelChanged += OnLightLevelChanged; // Subskrybuj zdarzenie
    }
#endif

            MessagingCenter.Subscribe<string>(this, "Logout", (sender) =>
            {
                ClearForm(); 
            });
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

        private void ClearForm()
        {
           
            EmailEntry.Text = string.Empty;
            PasswordEntry.Text = string.Empty; 
        }
#if ANDROID
private async void OnLightLevelChanged(float lightLevel)
{
    if (_isWaiting)
        return;

    _isWaiting = true;
    await Task.Delay(3000); // Czekaj przez 3 sekundy, aby nie za czêsto zmieniaæ kolor

    // Zmieniamy t³o strony na podstawie poziomu œwiat³a
    if (lightLevel < 10) // Niski poziom œwiat³a
    {
        this.BackgroundColor = new Microsoft.Maui.Graphics.Color(170 / 255f, 170 / 255f, 170 / 255f);
       
    }
    else // Wysoki poziom œwiat³a
    {
        this.BackgroundColor = Colors.White; // Jasne t³o
    }

    _isWaiting = false;
}


#endif

        protected override void OnDisappearing()
        {
            base.OnDisappearing();

#if ANDROID
            _lightSensorService.Stop(); // Zatrzymanie detekcji œwiat³a
#endif
        }

        protected override void OnAppearing()
        {
            base.OnAppearing();

#if ANDROID
            // Uruchamianie czujnika po powrocie na stronê
            _lightSensorService?.Start();
#endif
        }
    }

}
