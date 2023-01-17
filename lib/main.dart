import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';
import 'package:stream_app/firebase_options.dart';

import 'package:stream_app/providers/user_provider.dart';
import 'package:stream_app/services/navigation_service.dart';
import 'package:stream_app/router.dart' as router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'StreamApp', options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, statusBarBrightness: Brightness.dark));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Stream App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          primaryColor: kPrimaryColor,
          primaryColorDark: kPrimaryDarkColor,
          primaryColorLight: kPrimaryLightColor,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          fontFamily: kFamilyName,
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
      ),
    );
  }
}
