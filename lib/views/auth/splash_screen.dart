import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Function
  Future<Timer> startSplash() async {
    // Start Splash Timer
    var duration = const Duration(seconds: 4);
    return Timer(
      duration,
      () => Navigator.pushNamedAndRemoveUntil(context, 'Home', (_) => false),
    );
  }

  @override
  void initState() {
    startSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/background.png',
              ),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/applogowithshadow.png',
                  height: 140,
                  width: 170,
                ),
                Text(
                  'Stream',
                  style: kDisplayTitleSB.copyWith(
                    color: kWhite,
                    letterSpacing: kShortClose,
                  ),
                ),
                Text(
                  'Live Stream Application',
                  style: kSmallTitleR.copyWith(color: kWhite),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
