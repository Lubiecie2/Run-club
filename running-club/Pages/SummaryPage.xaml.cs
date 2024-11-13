using Microsoft.Maui.Controls;

namespace running_club.Pages
{
    public partial class SummaryPage : ContentPage
    {
        public SummaryPage(string time, int steps, double calories, string pace, double distance)
        {
            InitializeComponent();

            // Przypisanie wartoœci do etykiet w SummaryPage
            TimeLabel.Text = time;
            StepsLabel.Text = steps.ToString();
            CaloriesLabel.Text = calories.ToString("F2");
            PaceLabel.Text = pace;
            DistanceLabel.Text = distance.ToString("F2");
        }

        private async void OnBackButtonClicked(object sender, EventArgs e)
        {
            await Navigation.PopToRootAsync(); // Powrót do strony g³ównej
        }

    }
}