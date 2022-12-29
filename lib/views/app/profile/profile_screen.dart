import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        child: Column(
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
              child: Image.asset('assets/images/avatar.webp'),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Niyas Muhammed',
                style: kHeadTitleB.copyWith(color: kWhite),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/svg/google.svg',
                height: 17,
                width: 17,
              ),
              label: Text(
                'Google Sign Out',
                style: kBodyTitleR.copyWith(color: kSecondaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
