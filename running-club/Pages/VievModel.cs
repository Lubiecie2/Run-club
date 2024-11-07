using System;
using System.ComponentModel;
using System.Timers; // Upewnij się, że to jest System.Timers
// Używaj tego, jeśli potrzebujesz
// using System.Threading; // Tylko jeśli używasz Timer z tej przestrzeni

namespace WeatherApp
{
    public class WeatherViewModel : INotifyPropertyChanged
    {
        private string currentDateTime;
        private System.Timers.Timer timer; // Określamy, że używamy Timer z System.Timers

        public WeatherViewModel()
        {
            UpdateDateTime();
            timer = new System.Timers.Timer(1000); // Odśwież co 1 sekundę
            timer.Elapsed += (sender, e) => UpdateDateTime();
            timer.Start();
        }

        public string CurrentDateTime
        {
            get => currentDateTime;
            set
            {
                currentDateTime = value;
                OnPropertyChanged(nameof(CurrentDateTime));
            }
        }

        private void UpdateDateTime()
        {
            CurrentDateTime = DateTime.Now.ToString("MMMM dd, hh:mm tt");
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}