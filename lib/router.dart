import 'package:flutter/material.dart';
import 'package:stream_app/models/stream/stream_model.dart';
import 'package:stream_app/views/app/home_tab.dart';
import 'package:stream_app/views/app/stream/stream_screen.dart';
import 'package:stream_app/views/app/stream/streamplay_screen.dart';
import 'package:stream_app/views/auth/login_screen.dart';
import 'package:stream_app/views/auth/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings? settings) {
  switch (settings?.name) {
    case 'Splash':
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case 'Login':
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case 'Stream':
      Stream stream = settings?.arguments as Stream;
      return MaterialPageRoute(
          builder: (context) => StreamScreen(stream: stream));
    case 'StreamPlay':
      Stream stream = settings?.arguments as Stream;
      return MaterialPageRoute(
          builder: (context) => StreamPlayScreen(stream: stream));
    case 'Home':
      return MaterialPageRoute(builder: (context) => HomeNavigation());

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings?.name}'),
          ),
        ),
      );
  }
}
