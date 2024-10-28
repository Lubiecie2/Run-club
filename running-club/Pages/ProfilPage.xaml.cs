namespace running_club.Pages
{
    public partial class ProfilPage : ContentPage
    {
        private FirebaseAuthService _authService;

        public ProfilPage()
        {
            InitializeComponent();
            _authService = new FirebaseAuthService();
            DisplayUserEmail();  // Wywo�uje funkcj� asynchroniczn� do wy�wietlenia adresu email
        }

        private async void DisplayUserEmail()
        {
            var email = await _authService.GetCurrentUserEmailAsync();
            EmailLabel.Text = $"Witaj, {email}";  // Aktualizuje etykiet� email
        }
        private async void OnLogoutButtonClicked(object sender, EventArgs e)
        {
            await _authService.LogoutAsync(); // Wylogowanie i czyszczenie danych u�ytkownika
            await Shell.Current.GoToAsync("//LoginPage"); // Przeniesienie do strony logowania
        }
    }
}