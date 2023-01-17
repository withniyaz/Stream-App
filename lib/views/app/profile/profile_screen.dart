import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';
import 'package:stream_app/providers/user_provider.dart';
import 'package:stream_app/services/navigation_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
// Initalizations
  final NavigationSerivce _providerNavgation = NavigationSerivce();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  bool isLoading = false;

  void logoutUser() async {
    setState(() {
      isLoading = true;
    });
    await storage.delete(key: 'token');
    await storage.deleteAll();
    await _providerNavgation.pushNamedAndRemoveUntil('Login');
    if (!mounted) return;
    await Provider.of<UserProvider>(context, listen: false).clearUser();
    //Models
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDarkColor,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/applogowithshadow.png',
            height: 80,
            width: 80,
          ),
          Text(
            'Stream',
            style: kBodyTitleB.copyWith(
              color: kWhite,
            ),
          ),
          Text(
            'Live Stream Application',
            style: kSmallTitleR.copyWith(color: kWhite),
          ),
          Text(
            'Version 1.0.0',
            style: kSmallTitleR.copyWith(color: kWhite),
          ),
          const SizedBox(
            height: 4,
          )
        ],
      ),
      body: SafeArea(
        child: Consumer<UserProvider>(builder: (contex, data, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl: '${data.user?.profile?.profileImage}',
                  height: 65,
                  width: 65,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  '${data.user?.profile?.name}',
                  style: kHeadTitleB.copyWith(color: kWhite),
                ),
              ),
              Center(
                child: Text(
                  '${data.user?.username}',
                  style: kSmallTitleR.copyWith(color: kGreyLight),
                ),
              ),
              TextButton.icon(
                onPressed: logoutUser,
                icon: SvgPicture.asset(
                  'assets/svg/google.svg',
                  height: 17,
                  width: 17,
                ),
                label: Text(
                  isLoading ? 'Google Loggin Out' : 'Google Sign Out',
                  style: kBodyTitleR.copyWith(color: kSecondaryColor),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
