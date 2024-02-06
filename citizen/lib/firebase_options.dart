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
    apiKey: 'AIzaSyAEXVdaGq9-HLa7ax5saiX_ifuGXPagkfE',
    appId: '1:549467151088:web:c091663e135ee467288035',
    messagingSenderId: '549467151088',
    projectId: 'urban-seva-7f9eb',
    authDomain: 'urban-seva-7f9eb.firebaseapp.com',
    storageBucket: 'urban-seva-7f9eb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJhmRiA8edaQfASN0MQGws8I5qi6aJ44w',
    appId: '1:549467151088:android:c201275b63c79726288035',
    messagingSenderId: '549467151088',
    projectId: 'urban-seva-7f9eb',
    storageBucket: 'urban-seva-7f9eb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBF14XWT_ZpM0mtkrKNzXyprYpzS_Bqx9E',
    appId: '1:549467151088:ios:e0d088edea3a933a288035',
    messagingSenderId: '549467151088',
    projectId: 'urban-seva-7f9eb',
    storageBucket: 'urban-seva-7f9eb.appspot.com',
    iosBundleId: 'com.example.citizen',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBF14XWT_ZpM0mtkrKNzXyprYpzS_Bqx9E',
    appId: '1:549467151088:ios:a736b146442d201b288035',
    messagingSenderId: '549467151088',
    projectId: 'urban-seva-7f9eb',
    storageBucket: 'urban-seva-7f9eb.appspot.com',
    iosBundleId: 'com.example.citizen.RunnerTests',
  );
}
