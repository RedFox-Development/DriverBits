
class Reading {
  final int _timestamp;
  final String _driver;
  final int _rssi;
  final double _temperature;
  final double _humidity;
  final int _pressure;
  final int _battery;
  final int _measurementSequenceNumber;
  final String _tag;

  Reading(Map<String, dynamic> measurement)
      : _timestamp = measurement['timestamp'],
        _driver = measurement['driver'],
        _rssi = measurement['rssi'],
        _temperature = measurement['temperature'],
        _humidity = measurement['humidity'],
        _pressure = measurement['pressure'] ?? -1,
        _battery = measurement['battery'],
        _measurementSequenceNumber = measurement['measurementSequenceNumber'],
        _tag = measurement['tag'];

  String _timeSinceMeasured() {
    Duration diff = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(_timestamp));
    if (diff.inDays < 1) {
      if (diff.inHours < 1) {
        if (diff.inMinutes < 1) {
          return "< 1 min ago";
        } else if (diff.inMinutes < 30) {
          return "${diff.inMinutes} min ago";
        } else {
          return "< 1 hour ago";
        }
      } else {
        return "${diff.inHours} hours ago";
      }
    } else {
      return "${diff.inDays} days ago";
    }
  }

  int get timestamp => _timestamp;
  String get timeSince => _timeSinceMeasured();
  String get driver => _driver;
  int get rssi => _rssi;
  double get temperature => _temperature;
  double get humidity => _humidity;
  int get pressure => _pressure;
  int get battery => _battery;
  int get sequenceNo => _measurementSequenceNumber;
  String get tagID => _tag;
}