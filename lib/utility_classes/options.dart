
class ReadingOptions {
  final String optName;
  final Map<String, int> temperature;
  final Map<String, int> humidity;
  final Map<String, int> pressure;
  final Map<String, int> voltage;
  final Map<String, int> rssi = {
    'start': -160,
    'end': 10,
    'veryHigh': -20,
    'high': -50,
    'moderate': -90,
    'low': -120
  };

  ReadingOptions(
    [this.optName = 'default',
    this.temperature = const {
      'start': -50,
      'end': 50,
      'warnLow': 0,
      'warnHigh': 28,
      'alertLow': -20,
      'alertHigh': 35,
      'optimum1': 22,
      'optimum2': 26
    },
    this.humidity = const {
      'start': 0,
      'end': 100,
      'warnLow': 20,
      'warnHigh': 50,
      'alertLow': 10,
      'alertHigh': 65,
      'optimum1': 20,
      'optimum2': 50
    },
    this.pressure = const {
      'start': 98000,
      'end': 102300,
      'warnLow': 100900,
      'warnHigh': 101450,
      'alertLow': 100400,
      'alertHigh': 101800,
      'optimum1': 101250,
      'optimum2': 101450
    },
    this.voltage = const {
      'start': 1600,
      'end': 3450,
      'warnLow': 2200,
      'alertLow': 2000,
      'optimum1': 2200,
      'optimum2': 3300,
      'warnHigh': 3300
    }]
  );

  // List<List<double>>? temperatureRanges() {
  //     return [[temperature['start']?.toDouble(), temperature['alertLow']?.toDouble()],
  //       [temperature['alertLow']?.toDouble(), temperature['warnLow']?.toDouble()],
  //       [temperature['warnLow']?.toDouble(), temperature['warnHigh']?.toDouble()],
  //       [temperature['warnHigh']?.toDouble(), temperature['alertHigh']?.toDouble()],
  //       [temperature['alertHigh']?.toDouble(), temperature['end']?.toDouble()]
  //     ];
  //   }
  //
  //   List<List> pressureRanges() {
  //     return [[pressure['start']?.toDouble(), pressure['alertLow']?.toDouble()],
  //       [pressure['alertLow']?.toDouble(), pressure['warnLow']?.toDouble()],
  //       [pressure['warnLow']?.toDouble(), pressure['warnHigh']?.toDouble()],
  //       [pressure['warnHigh']?.toDouble(), pressure['alertHigh']?.toDouble()],
  //       [pressure['alertHigh']?.toDouble(), pressure['end']?.toDouble()]
  //     ];
  //   }
  //
  //   List<List> humidityRanges() {
  //     return [[humidity['start']?.toDouble(), humidity['alertLow']?.toDouble()],
  //       [humidity['alertLow']?.toDouble(), humidity['warnLow']?.toDouble()],
  //       [humidity['warnLow']?.toDouble(), humidity['warnHigh']?.toDouble()],
  //       [humidity['warnHigh']?.toDouble(), humidity['alertHigh']?.toDouble()],
  //       [humidity['alertHigh']?.toDouble(), humidity['end']?.toDouble()]
  //     ];
  //   }
  //
  //   List<List> voltageRanges() {
  //     return [[voltage['start']?.toDouble(), voltage['alertLow']?.toDouble()],
  //       [voltage['alertLow']?.toDouble(), voltage['warnLow']?.toDouble()],
  //       [voltage['warnLow']?.toDouble(), voltage['warnHigh']?.toDouble()],
  //       [voltage['warnHigh']?.toDouble(), voltage['alertHigh']?.toDouble()],
  //       [voltage['alertHigh']?.toDouble(), voltage['end']?.toDouble()]
  //     ];
  //   }
  //
  //   List<List> rssiRanges() {
  //     return [[rssi['start']?.toDouble(), rssi['alertLow']?.toDouble()],
  //       [rssi['alertLow']?.toDouble(), rssi['warnLow']?.toDouble()],
  //       [rssi['warnLow']?.toDouble(), rssi['warnHigh']?.toDouble()],
  //       [rssi['warnHigh']?.toDouble(), rssi['alertHigh']?.toDouble()],
  //       [rssi['alertHigh']?.toDouble(), rssi['end']?.toDouble()]
  //     ];
  //   }

  get tempStart => temperature['start'];
  get tempEnd => temperature['end'];
  get tempWarnLow => temperature['warnLow'];
  get tempWarnHigh => temperature['warnHigh'];
  get tempAlertLow => temperature['alertLow'];
  get tempAlertHigh => temperature['alertHigh'];
  get tempOptimum1 => temperature['optimum1'];
  get tempOptimum2 => temperature['optimum2'];

  get humidStart => humidity['start'];
  get humidEnd => humidity['end'];
  get humidWarnLow => humidity['warnLow'];
  get humidWarnHigh => humidity['warnHigh'];
  get humidAlertLow => humidity['alertLow'];
  get humidAlertHigh => humidity['alertHigh'];
  get humidOptimum1 => humidity['optimum1'];
  get humidOptimum2 => humidity['optimum2'];

  get presStart => pressure['start'];
  get presEnd => pressure['end'];
  get presWarnLow => pressure['warnLow'];
  get presWarnHigh => pressure['warnHigh'];
  get presAlertLow => pressure['alertLow'];
  get presAlertHigh => pressure['alertHigh'];
  get presOptimum1 => pressure['optimum1'];
  get presOptimum2 => pressure['optimum2'];

  get voltStart => voltage['start'];
  get voltEnd => voltage['end'];
  get voltWarnLow => voltage['warnLow'];
  get voltAlertLow => voltage['alertLow'];
  get voltWarnHigh => voltage['warnHigh'];
  get voltOptimum1 => voltage['optimum1'];
  get voltOptimum2 => voltage['optimum2'];

  get rssiStart => rssi['start'];
  get rssiEnd => rssi['end'];
  get rssiLow => rssi['low'];
  get rssiModerate => rssi['moderate'];
  get rssiHigh => rssi['high'];
  get rssiVeryHigh => rssi['veryHigh'];

}