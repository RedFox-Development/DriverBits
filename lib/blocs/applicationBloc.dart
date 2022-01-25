import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

// BLoCin (Business Logic Controller) määrittely
class AppBloc extends Object {
  GoogleSignInAccount? _user;

  void _setUser(GoogleSignInAccount user) {
    _user = user;
  }
  void _resetUser() {
    _user = null;
  }

  Function(GoogleSignInAccount) get signIn => _setUser;
  get signOut => _resetUser;
  get userID => _user?.id;
  get username => _user?.displayName;
  get userphoto => _user?.photoUrl;

  // StreamControllereiden apufunktio, joka sulkee ne (Dartin vaatimus, ei välttämättä oikeaa käyttöä)
  dispose() {}
}