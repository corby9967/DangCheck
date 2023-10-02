// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA_MMCfZNiY-hjplw6O39gEAvNJhwA3_58',
    appId: '1:1034772184006:web:4c63da5f9e46b029b490c7',
    messagingSenderId: '1034772184006',
    projectId: 'dangcheck-6abe6',
    authDomain: 'dangcheck-6abe6.firebaseapp.com',
    storageBucket: 'dangcheck-6abe6.appspot.com',
    measurementId: 'G-75T2XGYEHG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHojAjLZtUYfqwkdXmXBPFgatdOhduj6w',
    appId: '1:1034772184006:android:a9f204a4adc9367fb490c7',
    messagingSenderId: '1034772184006',
    projectId: 'dangcheck-6abe6',
    storageBucket: 'dangcheck-6abe6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBehyAQe7-qTYwHYv9orbWodL0q-mQwS0w',
    appId: '1:1034772184006:ios:a16ca0eabd0ce80cb490c7',
    messagingSenderId: '1034772184006',
    projectId: 'dangcheck-6abe6',
    storageBucket: 'dangcheck-6abe6.appspot.com',
    iosBundleId: 'com.example.dangcheck',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBehyAQe7-qTYwHYv9orbWodL0q-mQwS0w',
    appId: '1:1034772184006:ios:77b0028b5c7971cab490c7',
    messagingSenderId: '1034772184006',
    projectId: 'dangcheck-6abe6',
    storageBucket: 'dangcheck-6abe6.appspot.com',
    iosBundleId: 'com.example.dangcheck.RunnerTests',
  );
}
