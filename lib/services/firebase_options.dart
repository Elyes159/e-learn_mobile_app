// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
// ignore: depend_on_referenced_packages
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
    apiKey: 'AIzaSyCxGLuDeEblb6-4W2Uk6r6C1CLaTYc-1bY',
    appId: '1:630126534373:web:1d0f1b55cf2263ebfb3e0c',
    messagingSenderId: '630126534373',
    projectId: 'pfe1-1939b',
    authDomain: 'pfe1-1939b.firebaseapp.com',
    storageBucket: 'pfe1-1939b.appspot.com',
    measurementId: 'G-2RKCJVGT9Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKd8NmQ4Tf-j9H1U5DkQKLY34e-26FeF0',
    appId: '1:630126534373:android:d000101edc723ff3fb3e0c',
    messagingSenderId: '630126534373',
    projectId: 'pfe1-1939b',
    storageBucket: 'pfe1-1939b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9vnvIlYX14SzV7DFaykOlGvBK42hUtVk',
    appId: '1:630126534373:ios:3b7ee3334168f9cafb3e0c',
    messagingSenderId: '630126534373',
    projectId: 'pfe1-1939b',
    storageBucket: 'pfe1-1939b.appspot.com',
    iosBundleId: 'com.example.pfe1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD9vnvIlYX14SzV7DFaykOlGvBK42hUtVk',
    appId: '1:630126534373:ios:d53c6d3fae2d50f6fb3e0c',
    messagingSenderId: '630126534373',
    projectId: 'pfe1-1939b',
    storageBucket: 'pfe1-1939b.appspot.com',
    iosBundleId: 'com.example.pfe1.RunnerTests',
  );
}
