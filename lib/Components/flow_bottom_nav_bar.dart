import 'package:flow/Screens/FlowFindScreen.dart';
import 'package:flow/Screens/FlowHomeScreen.dart';
import 'package:flow/Screens/FlowSavedScreen.dart';
import 'package:flow/Screens/FlowAboutScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlowBottomNavBar extends StatefulWidget {
  @override
  _FlowBottomNavBarState createState() => _FlowBottomNavBarState();
}

class _FlowBottomNavBarState extends State<FlowBottomNavBar> {
  int currentMenuIndex = 0;

  final List<Widget> _selectedMenuOptions = [
    FlowHomeScreen(),
    FlowFindScreen(),
    FlowSavedScreen(),
    FlowAboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: [
          SafeArea(child: _selectedMenuOptions[currentMenuIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(.3),
        currentIndex: currentMenuIndex,
        onTap: (value) {
          currentMenuIndex = value;
          setState(() {});
        },
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            label: ('Home'),
            icon: SvgPicture.asset(
              'Assets/icons/svgs/fi-rr-home.svg',
              color: Colors.black.withOpacity(.3),
            ),
            activeIcon: SvgPicture.asset(
              'Assets/icons/svgs/fi-rr-home.svg',
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Find',
            icon: SvgPicture.asset(
              'Assets/icons/svgs/fi-rr-search.svg',
              color: Colors.black.withOpacity(.3),
            ),
            activeIcon: SvgPicture.asset(
              'Assets/icons/svgs/fi-sr-search.svg',
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Saved',
            icon: SvgPicture.asset(
              'Assets/icons/svgs/fi-rr-heart.svg',
              color: Colors.black.withOpacity(.3),
            ),
            activeIcon: SvgPicture.asset(
              'Assets/icons/svgs/fi-rr-heart.svg',
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: 'About',
            icon: SvgPicture.asset(
              'Assets/icons/svgs/fi-rr-user.svg',
              color: Colors.black.withOpacity(.3),
            ),
            activeIcon: SvgPicture.asset(
              'Assets/icons/svgs/fi-rr-user.svg',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
