using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace running_club.Pages
{
    public class Goals : INotifyPropertyChanged
    {
        private bool _isCompleted;
        private string _goalImage;

        public int Id { get; set; }
        public string Kcal { get; set; }
        public string Distance { get; set; }
        public string Steps { get; set; }
        public string data { get; set; }

        public bool IsCompleted
        {
            get => _isCompleted;
            set
            {
                if (_isCompleted != value)
                {
                    _isCompleted = value;
                    OnPropertyChanged(nameof(IsCompleted));
                    GoalImage = _isCompleted ? "checked.png" : "multiply.png";
                }
            }
        }

        public string GoalImage
        {
            get => _goalImage;
            set
            {
                if (_goalImage != value)
                {
                    _goalImage = value;
                    OnPropertyChanged(nameof(GoalImage));
                }
            }
        }

        public ICommand ToggleGoalCommand { get; set; }

        public Goals()
        {
            ToggleGoalCommand = new Command<int>((id) =>
            {
                // Przełącz stan osiągnięcia celu
                IsCompleted = !IsCompleted;
            });
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

}
