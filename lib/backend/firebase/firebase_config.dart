import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCIvkiPzeUfOvJNg7H1us8-rKld2e5Saas",
            authDomain: "smartcitysync.firebaseapp.com",
            projectId: "smartcitysync",
            storageBucket: "smartcitysync.appspot.com",
            messagingSenderId: "42416306344",
            appId: "1:42416306344:web:9e1393f7f2c1a5d85caa9d",
            measurementId: "G-7YXBP981V2"));
  } else {
    await Firebase.initializeApp();
  }
}
