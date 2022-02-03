
import 'package:driver_bits/utility_classes/options.dart';

// defaults, do not modify with parameters
ReadingOptions _defaults = ReadingOptions();

// actual options, provide parameters
ReadingOptions _indoorW = ReadingOptions(
  'indoor',
  {
    'start': 0,
    'end': 45,
    'warnLow': 15,
    'warnHigh': 29,
    'alertLow': 10,
    'alertHigh': 35,
    'optimum1': 22,
    'optimum2': 26
  },
  {
    'start': 0,
    'end': 100,
    'warnLow': 15,
    'warnHigh': 50,
    'alertLow': 10,
    'alertHigh': 65,
    'optimum1': 20,
    'optimum2': 40
  }
);
ReadingOptions _indoorS = ReadingOptions(
    'indoor',
    {
      'start': 0,
      'end': 45,
      'warnLow': 15,
      'warnHigh': 29,
      'alertLow': 10,
      'alertHigh': 35,
      'optimum1': 22,
      'optimum2': 26
    },
    {
      'start': 0,
      'end': 100,
      'warnLow': 20,
      'warnHigh': 70,
      'alertLow': 10,
      'alertHigh': 80,
      'optimum1': 40,
      'optimum2': 65
    }
);
ReadingOptions _storage = ReadingOptions(
    'storage',
    {
      'start': -10,
      'end': 45,
      'warnLow': 10,
      'warnHigh': 29,
      'alertLow': 5,
      'alertHigh': 35,
      'optimum1': 15,
      'optimum2': 25
    },
    {
      'start': 0,
      'end': 100,
      'warnLow': 20,
      'warnHigh': 50,
      'alertLow': 10,
      'alertHigh': 65,
      'optimum1': 20,
      'optimum2': 50
    }
);
ReadingOptions _sauna = ReadingOptions(
    'sauna',
    {
      'start': 0,
      'end': 130,
      'warnLow': 40,
      'warnHigh': 90,
      'alertLow': 20,
      'alertHigh': 100,
      'optimum1': 65,
      'optimum2': 85
    },
    {
      'start': 0,
      'end': 100,
      'warnLow': 20,
      'warnHigh': 50,
      'alertLow': 10,
      'alertHigh': 65,
      'optimum1': 20,
      'optimum2': 50
    }
);
ReadingOptions _summer = ReadingOptions(
    'outdoor-s',
    {
      'start': 0,
      'end': 50,
      'warnLow': 15,
      'warnHigh': 29,
      'alertLow': 8,
      'alertHigh': 35,
      'optimum1': 17,
      'optimum2': 24
    },
    {
      'start': 0,
      'end': 100,
      'warnLow': 20,
      'warnHigh': 50,
      'alertLow': 10,
      'alertHigh': 65,
      'optimum1': 20,
      'optimum2': 50
    }
);
ReadingOptions _winter = ReadingOptions(
    'outdoor-w',
    {
      'start': -45,
      'end': 10,
      'warnLow': -15,
      'warnHigh': -2,
      'alertLow': -25,
      'alertHigh': 3,
      'optimum1': -12,
      'optimum2': -5
    },
    {
      'start': 0,
      'end': 100,
      'warnLow': 20,
      'warnHigh': 50,
      'alertLow': 10,
      'alertHigh': 65,
      'optimum1': 20,
      'optimum2': 50
    }
);
ReadingOptions _refridgerator = ReadingOptions(
    'fridge',
    {
      'start': 0,
      'end': 45,
      'warnLow': 15,
      'warnHigh': 29,
      'alertLow': 10,
      'alertHigh': 35,
      'optimum1': 22,
      'optimum2': 26
    },
    {
      'start': 0,
      'end': 100,
      'warnLow': 20,
      'warnHigh': 50,
      'alertLow': 10,
      'alertHigh': 65,
      'optimum1': 20,
      'optimum2': 50
    }
);
ReadingOptions _freezer = ReadingOptions(
    'freezer',
    {
      'start': 0,
      'end': 45,
      'warnLow': 15,
      'warnHigh': 29,
      'alertLow': 10,
      'alertHigh': 35,
      'optimum1': 22,
      'optimum2': 26
    },
    {
      'start': 0,
      'end': 100,
      'warnLow': 20,
      'warnHigh': 50,
      'alertLow': 10,
      'alertHigh': 65,
      'optimum1': 20,
      'optimum2': 50
    }
);

List<int> _coldMonths = [1,2,3,10,11,12];

bool _isItColdTime() {
  return _coldMonths.contains(DateTime.now().month) ? true : false;
}

ReadingOptions getOptions({String optFor = 'default'}) {
  switch (optFor) {
    case 'indoor': return _isItColdTime() ? _indoorW : _indoorS;
    case 'storage': return _storage;
    case 'sauna': return _sauna;
    case 'outdoor': return _isItColdTime() ? _winter : _summer;
    case 'fridge': return _refridgerator;
    case 'freezer': return _freezer;
    default: return _defaults;
  }
}