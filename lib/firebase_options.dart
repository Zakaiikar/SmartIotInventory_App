// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCrZMno56Y-1hK_c3Szi_c348JaIrkUwA4',
    appId: '1:830966514696:web:2d1f2b70a7082d2eeb3dbd',
    messagingSenderId: '830966514696',
    projectId: 'smartiotinventory',
    authDomain: 'smartiotinventory.firebaseapp.com',
    storageBucket: 'smartiotinventory.firebasestorage.app',
    measurementId: 'G-7BYYMGCR09',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDiInLJI04vjGovkOiT2R3ZwXIPAjMRfEU',
    appId: '1:830966514696:android:19d085a5e9401c59eb3dbd',
    messagingSenderId: '830966514696',
    projectId: 'smartiotinventory',
    storageBucket: 'smartiotinventory.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnyDJSWdw96mpfnMAYqOKPdUbVhuomh5k',
    appId: '1:830966514696:ios:b0fb6f49e8a36810eb3dbd',
    messagingSenderId: '830966514696',
    projectId: 'smartiotinventory',
    storageBucket: 'smartiotinventory.firebasestorage.app',
    iosBundleId: 'com.example.smartinventory',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBnyDJSWdw96mpfnMAYqOKPdUbVhuomh5k',
    appId: '1:830966514696:ios:b0fb6f49e8a36810eb3dbd',
    messagingSenderId: '830966514696',
    projectId: 'smartiotinventory',
    storageBucket: 'smartiotinventory.firebasestorage.app',
    iosBundleId: 'com.example.smartinventory',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCrZMno56Y-1hK_c3Szi_c348JaIrkUwA4',
    appId: '1:830966514696:web:4b66a622e630d992eb3dbd',
    messagingSenderId: '830966514696',
    projectId: 'smartiotinventory',
    authDomain: 'smartiotinventory.firebaseapp.com',
    storageBucket: 'smartiotinventory.firebasestorage.app',
    measurementId: 'G-9QRJQZ9J00',
  );
}
