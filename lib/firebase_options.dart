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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYgnYTrNd_tfndSBPavAP43RFSJD0G_38',
    appId: '1:112815281080:android:043bad8a914daa859ff54d',
    messagingSenderId: '112815281080',
    projectId: 'streamapp-fe2e3',
    storageBucket: 'streamapp-fe2e3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnNjk4rGRd2SbEeLgeAysus4hm2V_62Zo',
    appId: '1:112815281080:ios:23600d08ee2552f29ff54d',
    messagingSenderId: '112815281080',
    projectId: 'streamapp-fe2e3',
    storageBucket: 'streamapp-fe2e3.appspot.com',
    androidClientId: '112815281080-cnsjlu0sqonrd4dbee56guhu6qii7ot5.apps.googleusercontent.com',
    iosClientId: '112815281080-3umhsi5f0mikpf9of7m58ql7804i34o6.apps.googleusercontent.com',
    iosBundleId: 'com.backb.stream',
  );
}
