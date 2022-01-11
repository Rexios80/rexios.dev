// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDR_fz0Zppxi9U8Rjg2XMNmJWwaK752iLo',
    appId: '1:243190586876:web:b9237792127ac879cd2679',
    messagingSenderId: '243190586876',
    projectId: 'rexios-dev-website',
    authDomain: 'rexios-dev-website.firebaseapp.com',
    storageBucket: 'rexios-dev-website.appspot.com',
    measurementId: 'G-DWC3HXPP1K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuYVMauZSvgoam_2415YMI4fBZIRjhI0Q',
    appId: '1:243190586876:android:5b201073b3b873f1cd2679',
    messagingSenderId: '243190586876',
    projectId: 'rexios-dev-website',
    storageBucket: 'rexios-dev-website.appspot.com',
  );
}