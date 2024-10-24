
namespace running_club
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();

            MainPage = new NavigationPage(new Pages.LoginPage());
        }
    }
}
