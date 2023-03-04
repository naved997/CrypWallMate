import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CrypWallMateFirebaseUser {
  CrypWallMateFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

CrypWallMateFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CrypWallMateFirebaseUser> crypWallMateFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<CrypWallMateFirebaseUser>(
      (user) {
        currentUser = CrypWallMateFirebaseUser(user);
        return currentUser!;
      },
    );
