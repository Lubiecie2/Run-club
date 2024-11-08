using System;
using System.ComponentModel;
using System.Windows.Input;
using Microsoft.Maui.Devices.Sensors;
using Microsoft.Maui.Controls;

public class PedometerViewModel : INotifyPropertyChanged
{
    private int _stepCount = 0;
    private const double StepThreshold = 2.0; // Zwiększony próg przyspieszenia
    private const int StepCooldown = 500;     // Zwiększony czas między krokami w milisekundach
    private DateTime _lastStepTime = DateTime.MinValue;

    public event PropertyChangedEventHandler PropertyChanged;

    public PedometerViewModel()
    {
        StartCommand = new Command(Start);
        StopCommand = new Command(Stop);
    }

    public int StepCount
    {
        get => _stepCount;
        private set
        {
            _stepCount = value;
            OnPropertyChanged(nameof(StepCount));
        }
    }

    public ICommand StartCommand { get; }
    public ICommand StopCommand { get; }

    // Metoda startująca akcelerometr
    private void Start()
    {
        if (!Accelerometer.IsMonitoring)
        {
            StepCount = 0; // Zresetuj licznik kroków
            Accelerometer.ReadingChanged += Accelerometer_ReadingChanged;
            Accelerometer.Start(SensorSpeed.UI); // Możesz wybrać inną częstotliwość
        }
    }

    // Metoda zatrzymująca akcelerometr
    private void Stop()
    {
        if (Accelerometer.IsMonitoring)
        {
            Accelerometer.ReadingChanged -= Accelerometer_ReadingChanged;
            Accelerometer.Stop();
        }
    }

    // Wydarzenie wywoływane przy zmianie odczytu z akcelerometru
    private void Accelerometer_ReadingChanged(object sender, AccelerometerChangedEventArgs e)
    {
        var reading = e.Reading;
        var totalAcceleration = Math.Sqrt(
            Math.Pow(reading.Acceleration.X, 2) +
            Math.Pow(reading.Acceleration.Y, 2) +
            Math.Pow(reading.Acceleration.Z, 2));

        // Sprawdzenie, czy przyspieszenie przekroczyło próg
        if (totalAcceleration > StepThreshold)
        {
            // Ograniczenie do wykrywania kroków co 500 ms (aby nie liczyć tego samego kroku kilka razy)
            if ((DateTime.Now - _lastStepTime).TotalMilliseconds > StepCooldown)
            {
                StepCount++;
                _lastStepTime = DateTime.Now;
            }
        }
    }

    // Metoda powiadamiająca o zmianie wartości
    private void OnPropertyChanged(string propertyName)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }
}