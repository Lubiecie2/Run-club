using Microsoft.Maui.Controls;


namespace running_club
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();

            MainPage = new AppShell();
            GoToLoginPage();


        }

        private async void GoToLoginPage()
        {
            await Shell.Current.GoToAsync("//LoginPage");
        }
    }
}
