import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class SmartcitysyncFirebaseUser {
  SmartcitysyncFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

SmartcitysyncFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<SmartcitysyncFirebaseUser> smartcitysyncFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<SmartcitysyncFirebaseUser>(
      (user) {
        currentUser = SmartcitysyncFirebaseUser(user);
        return currentUser!;
      },
    );
