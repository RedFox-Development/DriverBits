
import 'package:driver_bits/utility_classes/options.dart';

// parameters for different ReadingOptions

Map<String, int> _opt_indoor = {};

// defaults, do not modify with parameters
ReadingOptions _defaults = ReadingOptions();

// actual options, provide parameters
ReadingOptions _indoor = ReadingOptions(
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
  }
);
ReadingOptions _storage = ReadingOptions();
ReadingOptions _sauna = ReadingOptions();
ReadingOptions _summer = ReadingOptions();
ReadingOptions _winter = ReadingOptions();
ReadingOptions _refridgerator = ReadingOptions();
ReadingOptions _freezer = ReadingOptions();

List<int> _coldMonths = [1,2,3,10,11,12];

bool _isItColdTime() {
  return _coldMonths.contains(DateTime.now().month) ? true : false;
}

ReadingOptions getOptions({String optFor = 'default'}) {
  switch (optFor) {
    case 'indoor': return _indoor;
    case 'storage': return _storage;
    case 'sauna': return _sauna;
    case 'outdoor': return _isItColdTime() ? _winter : _summer;
    case 'fridge': return _refridgerator;
    case 'freezer': return _freezer;
    default: return _defaults;
  }
}