import 'package:flutter/material.dart';
import 'package:stream_app/views/app/home_tab.dart';
import 'package:stream_app/views/app/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings? settings) {
  switch (settings?.name) {
    case 'Splash':
      return MaterialPageRoute(builder: (context) => const SplashScreen());
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
