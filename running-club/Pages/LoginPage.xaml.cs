using Microsoft.Maui.Controls;

namespace running_club.Pages
{
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

            // Subskrybuj wiadomo�� wylogowania
            MessagingCenter.Subscribe<string>(this, "Logout", (sender) =>
            {
                ClearForm(); // Wywo�anie metody czyszcz�cej formularz
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

            // Pr�ba logowania u�ytkownika
            string result = await _authService.SignInWithEmailAndPasswordAsync(email, password);

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ErrorLabel.Text = "Prosz� wprowadzi� Email i Has�o!";
                return;
            }

            if (!string.IsNullOrEmpty(result) && result.StartsWith("Error"))
            {
                // Sprawdzenie b��d�w logowania
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
                // Przejd� do strony g��wnej po pomy�lnym logowaniu
                await Shell.Current.GoToAsync("//Home");
            }
        }

        private void ClearForm()
        {
            // Czy�ci pola formularza
            EmailEntry.Text = string.Empty; // Czy�ci pole e-mail
            PasswordEntry.Text = string.Empty; // Czy�ci pole has�a
        }
    }
}