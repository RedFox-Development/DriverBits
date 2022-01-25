
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

  get timestamp => _timestamp;
  get timeSince => _timeSinceMeasured();
  get driver => _driver;
  get rssi => _rssi;
  get temperature => _temperature;
  get humidity => _humidity;
  get pressure => _pressure;
  get battery => _battery;
  get sequenceNo => _measurementSequenceNumber;
  get tagID => _tag;
}