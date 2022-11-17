import 'package:flutter/material.dart';
import 'package:stream_app/components/NavigationBarItem/navigation_item.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';
import 'package:stream_app/views/app/discover/discover_screen.dart';
import 'package:stream_app/views/app/home/home_screen.dart';
import 'package:stream_app/views/app/profile/profile_screen.dart';

class HomeNavigation extends StatefulWidget {
  HomeNavigation({Key? key}) : super(key: key);

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [HomeScreen(), DiscoverScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        unselectedItemColor: kGreyLight,
        selectedItemColor: kWhite,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          kNavigationItem(
            icon: 'assets/svg/home.svg',
            title: '',
          ),
          kNavigationItem(icon: 'assets/svg/discover.svg', title: ''),
          kNavigationItem(icon: 'assets/svg/profile.svg', title: ''),
        ],
      ),
    );
  }
}
