import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';
import 'package:stream_app/services/navigation_service.dart';
import 'package:stream_app/router.dart' as router;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, statusBarBrightness: Brightness.dark));
    return MaterialApp(
      title: 'Stream App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        primaryColor: kPrimaryColor,
        primaryColorDark: kPrimaryDarkColor,
        primaryColorLight: kPrimaryLightColor,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: kFontFamily,
        canvasColor: Colors.transparent,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent),
        bottomAppBarColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          color: Color(0xFFEEEEEE),
        ),
      ),
      navigatorKey: NavigationSerivce.navigatorKey,
      onGenerateRoute: router.generateRoute,
      initialRoute: 'Splash',
    );
  }
}
