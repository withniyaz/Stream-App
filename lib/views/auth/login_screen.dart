import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:stream_app/components/Snackbars/popup_snackbar.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';
import 'package:http/http.dart' as http;
import 'package:stream_app/models/stream/user_model.dart' as user_model;
import 'package:stream_app/providers/user_provider.dart';
import 'package:stream_app/services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignIn? googleSignIn = GoogleSignIn();
  final storage = const FlutterSecureStorage();
  final ApiService _apiProvider = ApiService();
  // States
  bool isLoading = false;

  Future signInWithGoogle() async {
    String? userId;
    setState(() {
      isLoading = true;
    });
    GoogleSignInAccount? googleSignInAccount = await googleSignIn?.signIn();

    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );
    UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = authResult.user;
    if (user != null) {
      userId = await user.getIdToken();
    }
    final http.Response res =
        await _apiProvider.post('/auth/google', {"googleAuthToken": userId});
    dynamic data = jsonDecode(res.body);
    if (res.statusCode == 201) {
      user_model.User usermodel =
          user_model.User.fromJson(data["data"]["user"]);
      await storage.write(key: 'token', value: data['data']['token']);
      if (!mounted) return;
      Provider.of<UserProvider>(context, listen: false).updateUser(usermodel);
      setState(() {
        isLoading = false;
      });
    }
    if (user == null || res.statusCode != 201) {
      googleSignIn?.disconnect();
      showSnackBar(message: 'Something went wrong', context: context);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
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
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                onPressed: signInWithGoogle,
                icon: SvgPicture.asset(
                  'assets/svg/google.svg',
                  height: 17,
                  width: 17,
                ),
                label: isLoading
                    ? Text(
                        'Signing with Google ....',
                        style: kBodyTitleR.copyWith(color: kSecondaryColor),
                      )
                    : Text(
                        'Google Sign In',
                        style: kBodyTitleR.copyWith(color: kSecondaryColor),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
