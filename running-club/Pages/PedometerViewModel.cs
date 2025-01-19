using System;
using System.ComponentModel;
using System.Windows.Input;
using Microsoft.Maui.Devices.Sensors;
using Microsoft.Maui.Controls;

/// @brief Klasa reprezentujaca ViewModel dla licznika krokow.
public class PedometerViewModel : INotifyPropertyChanged
{
    private int _stepCount = 0;
    private const double StepThreshold = 2.0; 
    private const int StepCooldown = 500;     
    private DateTime _lastStepTime = DateTime.MinValue;

    public event PropertyChangedEventHandler PropertyChanged;

    /// @brief Konstruktor klasy PedometerViewModel.
    public PedometerViewModel()
    {
        StartCommand = new Command(Start);
        StopCommand = new Command(Stop);
    }

    /// @brief Liczba krokow.
    public int StepCount
    {
        get => _stepCount;
        private set
        {
            _stepCount = value;
            OnPropertyChanged(nameof(StepCount));
        }
    }

    /// @brief Komenda startujaca akcelerometr.
    public ICommand StartCommand { get; }
    public ICommand StopCommand { get; }

   
    private void Start()
    {
        if (!Accelerometer.IsMonitoring)
        {
            StepCount = 0; 
            Accelerometer.ReadingChanged += Accelerometer_ReadingChanged;
            Accelerometer.Start(SensorSpeed.UI); 
        }
    }

    /// @brief Metoda zatrzymujaca akcelerometr.
    private void Stop()
    {
        if (Accelerometer.IsMonitoring)
        {
            Accelerometer.ReadingChanged -= Accelerometer_ReadingChanged;
            Accelerometer.Stop();
        }
    }

    /// @brief Metoda wywolywana przy zmianie odczytu akcelerometru.
    private void Accelerometer_ReadingChanged(object sender, AccelerometerChangedEventArgs e)
    {
        var reading = e.Reading;
        var totalAcceleration = Math.Sqrt(
            Math.Pow(reading.Acceleration.X, 2) +
            Math.Pow(reading.Acceleration.Y, 2) +
            Math.Pow(reading.Acceleration.Z, 2));

        
        if (totalAcceleration > StepThreshold)
        {
            
            if ((DateTime.Now - _lastStepTime).TotalMilliseconds > StepCooldown)
            {
                StepCount++;
                _lastStepTime = DateTime.Now;
            }
        }
    }

    /// @brief Metoda wywolywana przy zmianie wartosci wlasciwosci.
    private void OnPropertyChanged(string propertyName)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }
}