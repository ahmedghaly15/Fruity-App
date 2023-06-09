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
    apiKey: 'AIzaSyDcMwuyFK0nCJF1R_tbF07QRkjbTVT-3W0',
    appId: '1:201088112292:web:b2f0452d61024e3a0db831',
    messagingSenderId: '201088112292',
    projectId: 'fruity-app-54060',
    authDomain: 'fruity-app-54060.firebaseapp.com',
    storageBucket: 'fruity-app-54060.appspot.com',
    measurementId: 'G-HDG6539W32',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQShIdMzMvhEN-eCexRz4opg_FgnI-bGk',
    appId: '1:201088112292:android:f09aa5314b2f074b0db831',
    messagingSenderId: '201088112292',
    projectId: 'fruity-app-54060',
    storageBucket: 'fruity-app-54060.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZbA31n3JC7YrJak5m_MLS0P9MEpX-hLM',
    appId: '1:201088112292:ios:be8e086353ed08d80db831',
    messagingSenderId: '201088112292',
    projectId: 'fruity-app-54060',
    storageBucket: 'fruity-app-54060.appspot.com',
    iosClientId: '201088112292-9q7pj1isuc52cgkp0r6djbls6mdudgqb.apps.googleusercontent.com',
    iosBundleId: 'com.example.fruityApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZbA31n3JC7YrJak5m_MLS0P9MEpX-hLM',
    appId: '1:201088112292:ios:be8e086353ed08d80db831',
    messagingSenderId: '201088112292',
    projectId: 'fruity-app-54060',
    storageBucket: 'fruity-app-54060.appspot.com',
    iosClientId: '201088112292-9q7pj1isuc52cgkp0r6djbls6mdudgqb.apps.googleusercontent.com',
    iosBundleId: 'com.example.fruityApp',
  );
}
