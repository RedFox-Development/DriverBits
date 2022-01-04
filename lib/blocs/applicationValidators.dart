import 'dart:async';

class AppValidators {
  final validateTheme = StreamTransformer<String, String>.fromHandlers(
      handleData: (theme, sink) {
        if (theme == 'dark' || theme == 'light') {
          sink.add(theme);
        } else {
          sink.addError('invalid theme');
        }
      }
  );
  final validateNotification = StreamTransformer<Map<String, String>, Map<String, String>>.fromHandlers(
      handleData: (notification, sink) {
        if (notification['type'] != null && notification['message'] != null) {
          sink.add(notification);
        } else {
          sink.addError('invalid notification');
        }
      }
  );
}