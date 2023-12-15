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
    apiKey: 'AIzaSyAx3c4JLoWJNn70BWaVbsVrV-biv94Mlws',
    appId: '1:769166604098:web:8f714f5ee145fccf837adb',
    messagingSenderId: '769166604098',
    projectId: 'epics-pj',
    authDomain: 'epics-pj.firebaseapp.com',
    storageBucket: 'epics-pj.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBO-nq9NY1rRpdtGwnwfpo76lEM3dpadZ0',
    appId: '1:769166604098:android:173443ee96d7fe23837adb',
    messagingSenderId: '769166604098',
    projectId: 'epics-pj',
    storageBucket: 'epics-pj.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAua8rfCAhXJE1dXAVZLwm00CwbQtaE3DI',
    appId: '1:769166604098:ios:2efea42fe114e082837adb',
    messagingSenderId: '769166604098',
    projectId: 'epics-pj',
    storageBucket: 'epics-pj.appspot.com',
    iosBundleId: 'com.example.epicsPj',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAua8rfCAhXJE1dXAVZLwm00CwbQtaE3DI',
    appId: '1:769166604098:ios:07e14438d37dde2d837adb',
    messagingSenderId: '769166604098',
    projectId: 'epics-pj',
    storageBucket: 'epics-pj.appspot.com',
    iosBundleId: 'com.example.epicsPj.RunnerTests',
  );
}