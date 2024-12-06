namespace running_club.Pages;

public partial class HistoryPageDark : ContentPage
{
    public HistoryPageDark()
    {
        InitializeComponent();
    }

    private async void OnHistoryItemSelected(object sender, SelectionChangedEventArgs e)
    {
        // Sprawdzanie, czy wybrano element
        if (e.CurrentSelection.FirstOrDefault() is History selectedHistory)
        {
            // Nawigacja do szczegó³ów wybranego elementu
            await Navigation.PushAsync(new HistoryDetailPage(selectedHistory));
        }

        // Usuwanie zaznaczenia
        ((CollectionView)sender).SelectedItem = null;
    }
}