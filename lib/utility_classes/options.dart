
class ReadingOptions {
  final String optName;
  final Map<String, int> _temperature;
  final Map<String, int> _humidity;
  final Map<String, int> _pressure;
  final Map<String, int> _voltage;
  final Map<String, int> _rssi = {
    'start': -160,
    'end': 10,
    'veryHigh': -20,
    'high': -50,
    'moderate': -90,
    'low': -120
  };

  ReadingOptions({
    this.optName = 'default',
    Map<String, int> temperature = const {
      'start': -50,
      'end': 50,
      'warnLow': 0,
      'warnHigh': 25,
      'alertLow': -20,
      'alertHigh': 30
    },
    Map<String, int> humidity = const {
      'start': 0,
      'end': 110,
      'warnLow': 25,
      'warnHigh': 80,
      'alertLow': 15,
      'alertHigh': 90
    },
    Map<String, int> pressure = const {
      'start': 90000,
      'end': 110000,
      'warnLow': 99500,
      'warnHigh': 102500,
      'alertLow': 95000,
      'alertHigh': 105000
    },
    Map<String, int> voltage = const {
      'start': 1600,
      'end': 3450,
      'warnLow': 2200,
      'alertLow': 2000,
      'alertHigh': 3350
    }
  }) :
    _temperature = temperature,
    _pressure = pressure,
    _humidity = humidity,
    _voltage = voltage;

  get tempStart => _temperature['start'];
  get tempEnd => _temperature['end'];
  get tempWarnLow => _temperature['warnLow'];
  get tempWarnHigh => _temperature['warnHigh'];
  get tempAlertLow => _temperature['alertLow'];
  get tempAlertHigh => _temperature['alertHigh'];

  get humidStart => _humidity['start'];
  get humidEnd => _humidity['end'];
  get humidWarnLow => _humidity['warnLow'];
  get humidWarnHigh => _humidity['warnHigh'];
  get humidAlertLow => _humidity['alertLow'];
  get humidAlertHigh => _humidity['alertHigh'];

  get presStart => _pressure['start'];
  get presEnd => _pressure['end'];
  get presWarnLow => _pressure['warnLow'];
  get presWarnHigh => _pressure['warnHigh'];
  get presAlertLow => _pressure['alertLow'];
  get presAlertHigh => _pressure['alertHigh'];

  get voltStart => _voltage['start'];
  get voltEnd => _voltage['end'];
  get voltWarnLow => _voltage['warnLow'];
  get voltAlertLow => _voltage['alertLow'];
  get voltAlertHigh => _voltage['alertHigh'];

  get rssiStart => _temperature['start'];
  get rssiEnd => _temperature['end'];
  get rssiLow => _temperature['low'];
  get rssiModerate => _rssi['moderate'];
  get rssiHigh => _rssi['high'];
  get rssiVeryHigh => _rssi['veryHigh'];
}