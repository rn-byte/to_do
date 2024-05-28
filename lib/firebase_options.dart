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
    apiKey: 'AIzaSyCrYgvv5FYEw26EHrJgqtTr8WJLBVJBtAM',
    appId: '1:890548154412:web:becf811a4f78d858e5e189',
    messagingSenderId: '890548154412',
    projectId: 'to-do-proj-54c51',
    authDomain: 'to-do-proj-54c51.firebaseapp.com',
    storageBucket: 'to-do-proj-54c51.appspot.com',
    measurementId: 'G-RQBBKK501G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMomANbt4b4gjSOurOvdjXfrwvOoWeRD8',
    appId: '1:890548154412:android:db9bad094b4ac5b6e5e189',
    messagingSenderId: '890548154412',
    projectId: 'to-do-proj-54c51',
    storageBucket: 'to-do-proj-54c51.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCS69i-PsmOZ6B5cY7Z3Lz6QDOYQ0JrugQ',
    appId: '1:890548154412:ios:890b59c02a382f56e5e189',
    messagingSenderId: '890548154412',
    projectId: 'to-do-proj-54c51',
    storageBucket: 'to-do-proj-54c51.appspot.com',
    iosBundleId: 'com.example.toDoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCS69i-PsmOZ6B5cY7Z3Lz6QDOYQ0JrugQ',
    appId: '1:890548154412:ios:890b59c02a382f56e5e189',
    messagingSenderId: '890548154412',
    projectId: 'to-do-proj-54c51',
    storageBucket: 'to-do-proj-54c51.appspot.com',
    iosBundleId: 'com.example.toDoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCrYgvv5FYEw26EHrJgqtTr8WJLBVJBtAM',
    appId: '1:890548154412:web:ef7a307a6fccc73fe5e189',
    messagingSenderId: '890548154412',
    projectId: 'to-do-proj-54c51',
    authDomain: 'to-do-proj-54c51.firebaseapp.com',
    storageBucket: 'to-do-proj-54c51.appspot.com',
    measurementId: 'G-3644J2J9BQ',
  );

}