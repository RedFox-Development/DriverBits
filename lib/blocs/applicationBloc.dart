import 'dart:async';
import 'package:driver_bits/blocs/applicationValidators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

// BLoCin (Business Logic Controller) määrittely
class AppBloc extends Object with AppValidators {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final StreamController _themeController = StreamController<String>();
  final StreamController _notificationController = StreamController<Map<String, String>>.broadcast();
  GoogleSignInAccount? _user;

  void _setUser(GoogleSignInAccount user) {
    _user = user;
  }
  void _resetUser() {
    _user = null;
  }

  // StreamControllerien getterien määrittelyt

  // change data in stream
  Function(String) get switchTheme => _themeController.sink.add;
  Function(Map<String, String>) get changeNotification => _notificationController.sink.add;

  // add data to stream
  Stream<String> get theme => _themeController.stream.transform(validateTheme);
  Stream<Map<String, String>> get notification => _notificationController.stream.transform(validateNotification).asBroadcastStream();

  // avustavien gettereiden määrittely

  Function(GoogleSignInAccount) get signIn => _setUser;
  get signOut => _resetUser;
  get userID => _user?.id;
  get username => _user?.displayName;
  get userphoto => _user?.photoUrl;

  // StreamControllereiden apufunktio, joka sulkee ne (Dartin vaatimus, ei välttämättä oikeaa käyttöä)
  dispose() {
    _themeController.close();
    _notificationController.close();
  }
}