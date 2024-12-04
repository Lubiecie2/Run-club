using Android.Hardware;

namespace YourApp.Platforms.Android;

public class LightSensorService : Java.Lang.Object, ISensorEventListener
{
    private SensorManager _sensorManager;
    private Sensor _lightSensor;
    public event Action<float> LightLevelChanged;

    public LightSensorService()
    {
        _sensorManager = (SensorManager)Android.App.Application.Context.GetSystemService(Android.Content.Context.SensorService);
        _lightSensor = _sensorManager.GetDefaultSensor(SensorType.Light);
    }

    public void Start()
    {
        if (_lightSensor != null)
        {
            _sensorManager.RegisterListener(this, _lightSensor, SensorDelay.Ui);
        }
    }

    public void Stop()
    {
        _sensorManager.UnregisterListener(this);
    }

    public void OnSensorChanged(SensorEvent e)
    {
        if (e.Sensor.Type == SensorType.Light)
        {
            LightLevelChanged?.Invoke(e.Values[0]); // Wartość światła w luxach
        }
    }

    public void OnAccuracyChanged(Sensor sensor, SensorStatus accuracy)
    {
        // Niepotrzebne w tym przypadku
    }
}