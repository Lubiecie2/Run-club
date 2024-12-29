using System;
using System.ComponentModel;
using System.Globalization;
using System.Timers;

public class WeatherViewModel : INotifyPropertyChanged
{
    private System.Timers.Timer _timer;
    private string _currentDate;

    // Getter dla bieżącej daty
    public string CurrentDate
    {
        get => _currentDate;
        set
        {
            if (_currentDate != value)
            {
                _currentDate = value;
                OnPropertyChanged(nameof(CurrentDate));
                Console.WriteLine($"Nowa data: {CurrentDate}"); // Logowanie w konsoli
            }
        }
    }

    public WeatherViewModel()
    {
        // Ustaw timer na odświeżanie co minutę
        _timer = new System.Timers.Timer(60000); // Sprawdzaj co minutę
        _timer.Elapsed += (s, e) =>
        {
            // Zaktualizuj datę co minutę
            CurrentDate = DateTime.Now.ToString("dddd, dd MMMM", new CultureInfo("pl-PL"));
        };
        _timer.Start();

        // Ustawienie początkowej daty przy inicjalizacji
        CurrentDate = DateTime.Now.ToString("dddd, dd MMMM", new CultureInfo("pl-PL"));

        // Logowanie, gdy konstruktor jest wywoływany
        Console.WriteLine("WeatherViewModel utworzony. Timer został uruchomiony.");
    }

    public event PropertyChangedEventHandler PropertyChanged;

    // Powiadomienie o zmianie właściwości
    protected void OnPropertyChanged(string propertyName)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }
}