using Android.Hardware;
using Android.Content;
using Microsoft.Maui.Controls; // Dodaj przestrzeń nazw MAUI

namespace running_club.Platforms.Android
{
    public class LightSensorService : Java.Lang.Object, ISensorEventListener
    {
        private SensorManager _sensorManager;
        private Sensor _lightSensor;
        public event Action<float>? LightLevelChanged; // Event do wysyłania poziomu światła

        public LightSensorService()
        {
            var context = Microsoft.Maui.ApplicationModel.Platform.CurrentActivity.ApplicationContext; // Uzyskiwanie kontekstu aktywności Android
            _sensorManager = (SensorManager)context.GetSystemService(Context.SensorService);
            _lightSensor = _sensorManager?.GetDefaultSensor(SensorType.Light); // Pobranie sensora światła
        }

        public void Start()
        {
            if (_lightSensor != null)
            {
                _sensorManager?.RegisterListener(this, _lightSensor, SensorDelay.Ui);
            }
        }

        public void Stop()
        {
            if (_lightSensor != null)
            {
                _sensorManager?.UnregisterListener(this);
            }
        }

        public void OnSensorChanged(SensorEvent? e)
        {
            if (e?.Sensor?.Type == SensorType.Light && e.Values != null && e.Values.Count > 0)
            {
                LightLevelChanged?.Invoke(e.Values[0]); // Emitowanie poziomu światła
            }
        }

        public void OnAccuracyChanged(Sensor? sensor, SensorStatus accuracy)
        {
            // Niepotrzebne w tej implementacji
        }
    }
}
